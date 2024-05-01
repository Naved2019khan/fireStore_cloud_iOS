/* This file was generated by upb_generator from the input file:
 *
 *     envoy/extensions/load_balancing_policies/ring_hash/v3/ring_hash.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/generated_code_support.h"
#include "envoy/extensions/load_balancing_policies/ring_hash/v3/ring_hash.upb_minitable.h"
#include "envoy/extensions/load_balancing_policies/common/v3/common.upb_minitable.h"
#include "google/protobuf/wrappers.upb_minitable.h"
#include "envoy/annotations/deprecation.upb_minitable.h"
#include "udpa/annotations/status.upb_minitable.h"
#include "validate/validate.upb_minitable.h"

// Must be last.
#include "upb/port/def.inc"

static const upb_MiniTableSub envoy_extensions_load_balancing_policies_ring_hash_v3_RingHash_submsgs[5] = {
  {.submsg = &google__protobuf__UInt64Value_msg_init},
  {.submsg = &google__protobuf__UInt64Value_msg_init},
  {.submsg = &google__protobuf__UInt32Value_msg_init},
  {.submsg = &envoy__extensions__load_0balancing_0policies__common__v3__ConsistentHashingLbConfig_msg_init},
  {.submsg = &envoy__extensions__load_0balancing_0policies__common__v3__LocalityLbConfig__LocalityWeightedLbConfig_msg_init},
};

static const upb_MiniTableField envoy_extensions_load_balancing_policies_ring_hash_v3_RingHash__fields[7] = {
  {1, 4, 0, kUpb_NoSub, 5, (int)kUpb_FieldMode_Scalar | (int)kUpb_LabelFlags_IsAlternate | ((int)kUpb_FieldRep_4Byte << kUpb_FieldRep_Shift)},
  {2, UPB_SIZE(8, 16), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {3, UPB_SIZE(12, 24), 2, 1, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {4, UPB_SIZE(16, 8), 0, kUpb_NoSub, 8, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_1Byte << kUpb_FieldRep_Shift)},
  {5, UPB_SIZE(20, 32), 3, 2, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {6, UPB_SIZE(24, 40), 4, 3, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {7, UPB_SIZE(28, 48), 5, 4, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__extensions__load_0balancing_0policies__ring_0hash__v3__RingHash_msg_init = {
  &envoy_extensions_load_balancing_policies_ring_hash_v3_RingHash_submsgs[0],
  &envoy_extensions_load_balancing_policies_ring_hash_v3_RingHash__fields[0],
  UPB_SIZE(32, 56), 7, kUpb_ExtMode_NonExtendable, 7, UPB_FASTTABLE_MASK(56), 0,
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x000400003f000008, &upb_psv4_1bt},
    {0x0010000001000012, &upb_psm_1bt_maxmaxb},
    {0x001800000201001a, &upb_psm_1bt_maxmaxb},
    {0x000800003f000020, &upb_psb1_1bt},
    {0x002000000302002a, &upb_psm_1bt_maxmaxb},
    {0x0028000004030032, &upb_psm_1bt_maxmaxb},
    {0x003000000504003a, &upb_psm_1bt_maxmaxb},
  })
};

static const upb_MiniTable *messages_layout[1] = {
  &envoy__extensions__load_0balancing_0policies__ring_0hash__v3__RingHash_msg_init,
};

const upb_MiniTableFile envoy_extensions_load_balancing_policies_ring_hash_v3_ring_hash_proto_upb_file_layout = {
  messages_layout,
  NULL,
  NULL,
  1,
  0,
  0,
};

#include "upb/port/undef.inc"

