Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583B22997B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgJZUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:10:31 -0400
Received: from foss.arm.com ([217.140.110.172]:51100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgJZUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F8CE1424;
        Mon, 26 Oct 2020 13:10:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE95B3F68F;
        Mon, 26 Oct 2020 13:10:26 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 2/6] firmware: arm_scmi: add SCMIv3.0 Sensors descriptors extensions
Date:   Mon, 26 Oct 2020 20:10:03 +0000
Message-Id: <20201026201007.23591-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026201007.23591-1-cristian.marussi@arm.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new SCMIv3.0 Sensors extensions related to new sensors'
features, like multiple axis and update intervals, while keeping
compatibility with SCMIv2.0 features.
While at that, refactor and simplify all the internal helpers macros and
move struct scmi_sensor_info to use only non-fixed-size typing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- restrict segmented intervals descriptors to single triplet
- add proper usage of scmi_reset_rx_to_maxsz
---
 drivers/firmware/arm_scmi/sensors.c | 391 ++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h       | 219 +++++++++++++++-
 2 files changed, 584 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 6aaff478d032..5a18f8c84bef 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -7,16 +7,21 @@
 
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
 
+#include <linux/bitfield.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
 #include "notify.h"
 
+#define SCMI_MAX_NUM_SENSOR_AXIS	64
+
 enum scmi_sensor_protocol_cmd {
 	SENSOR_DESCRIPTION_GET = 0x3,
 	SENSOR_TRIP_POINT_NOTIFY = 0x4,
 	SENSOR_TRIP_POINT_CONFIG = 0x5,
 	SENSOR_READING_GET = 0x6,
+	SENSOR_AXIS_DESCRIPTION_GET = 0x7,
+	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -28,23 +33,102 @@ struct scmi_msg_resp_sensor_attributes {
 	__le32 reg_size;
 };
 
+/* v3 attributes_low macros */
+#define SUPPORTS_UPDATE_NOTIFY(x)	FIELD_GET(BIT(30), (x))
+#define SENSOR_TSTAMP_EXP(x)		FIELD_GET(GENMASK(14, 10), (x))
+#define SUPPORTS_TIMESTAMP(x)		FIELD_GET(BIT(9), (x))
+#define SUPPORTS_EXTEND_ATTRS(x)	FIELD_GET(BIT(8), (x))
+
+/* v2 attributes_high macros */
+#define SENSOR_UPDATE_BASE(x)		FIELD_GET(GENMASK(31, 27), (x))
+#define SENSOR_UPDATE_SCALE(x)		FIELD_GET(GENMASK(26, 22), (x))
+
+/* v3 attributes_high macros */
+#define SENSOR_AXIS_NUMBER(x)		FIELD_GET(GENMASK(21, 16), (x))
+#define SUPPORTS_AXIS(x)		FIELD_GET(BIT(8), (x))
+
+/* v3 resolution macros */
+#define SENSOR_RES(x)			FIELD_GET(GENMASK(26, 0), (x))
+#define SENSOR_RES_EXP(x)		FIELD_GET(GENMASK(31, 27), (x))
+
+struct scmi_range_attrs_le {
+	__le32 min_range_low;
+	__le32 min_range_high;
+	__le32 max_range_low;
+	__le32 max_range_high;
+};
+
 struct scmi_msg_resp_sensor_description {
 	__le16 num_returned;
 	__le16 num_remaining;
-	struct {
+	struct scmi_sensor_descriptor {
 		__le32 id;
 		__le32 attributes_low;
-#define SUPPORTS_ASYNC_READ(x)	((x) & BIT(31))
-#define NUM_TRIP_POINTS(x)	((x) & 0xff)
+/* Common attributes_low macros */
+#define SUPPORTS_ASYNC_READ(x)		FIELD_GET(BIT(31), (x))
+#define NUM_TRIP_POINTS(x)		FIELD_GET(GENMASK(7, 0), (x))
 		__le32 attributes_high;
-#define SENSOR_TYPE(x)		((x) & 0xff)
-#define SENSOR_SCALE(x)		(((x) >> 11) & 0x1f)
-#define SENSOR_SCALE_SIGN	BIT(4)
-#define SENSOR_SCALE_EXTEND	GENMASK(7, 5)
-#define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
-#define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
-		    u8 name[SCMI_MAX_STR_SIZE];
-	} desc[0];
+/* Common attributes_high macros */
+#define SENSOR_SCALE(x)			FIELD_GET(GENMASK(15, 11), (x))
+#define SENSOR_SCALE_SIGN		BIT(4)
+#define SENSOR_SCALE_EXTEND		GENMASK(31, 5)
+#define SENSOR_TYPE(x)			FIELD_GET(GENMASK(7, 0), (x))
+		u8 name[SCMI_MAX_STR_SIZE];
+		/* only for version > 2.0 */
+		__le32 power;
+		__le32 resolution;
+		struct scmi_range_attrs_le scalar_attrs;
+	} desc[];
+};
+
+/* Sign extend to a full s32 */
+#define	S32_EXT(v)							\
+	({								\
+		int __v = (v);						\
+									\
+		if (__v & SENSOR_SCALE_SIGN)				\
+			__v |= SENSOR_SCALE_EXTEND;			\
+		__v;							\
+	})
+
+#define SCMI_MSG_RESP_SENS_DESCR_BASE_SZ				\
+	(sizeof(struct scmi_sensor_descriptor) -			\
+	  (2 * sizeof(__le32)) - sizeof(struct scmi_range_attrs_le))
+
+struct scmi_msg_sensor_axis_description_get {
+	__le32 id;
+	__le32 axis_desc_index;
+};
+
+struct scmi_msg_resp_sensor_axis_description {
+	__le32 num_axis_flags;
+#define NUM_AXIS_RETURNED(x)		FIELD_GET(GENMASK(5, 0), (x))
+#define NUM_AXIS_REMAINING(x)		FIELD_GET(GENMASK(31, 26), (x))
+	struct scmi_axis_descriptor {
+		__le32 id;
+		__le32 attributes_low;
+		__le32 attributes_high;
+		u8 name[SCMI_MAX_STR_SIZE];
+		__le32 resolution;
+		struct scmi_range_attrs_le attrs;
+	} desc[];
+};
+
+#define SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ				\
+		(sizeof(struct scmi_axis_descriptor) -			\
+		  sizeof(__le32) - sizeof(struct scmi_range_attrs_le))
+
+struct scmi_msg_sensor_list_update_intervals {
+	__le32 id;
+	__le32 index;
+};
+
+struct scmi_msg_resp_sensor_list_update_intervals {
+	__le32 num_intervals_flags;
+#define NUM_INTERVALS_RETURNED(x)	FIELD_GET(GENMASK(11, 0), (x))
+#define SEGMENTED_INTVL_FORMAT(x)	FIELD_GET(BIT(12), (x))
+#define NUM_INTERVALS_REMAINING(x)	FIELD_GET(GENMASK(31, 16), (x))
+	__le32 intervals[];
 };
 
 struct scmi_msg_sensor_trip_point_notify {
@@ -114,6 +198,194 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 	return ret;
 }
 
+static inline void scmi_parse_range_attrs(struct scmi_range_attrs *out,
+					  struct scmi_range_attrs_le *in)
+{
+	out->min_range = get_unaligned_le64((void *)&in->min_range_low);
+	out->max_range = get_unaligned_le64((void *)&in->max_range_low);
+}
+
+static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
+					struct scmi_sensor_info *s)
+{
+	int ret, cnt;
+	u32 desc_index = 0;
+	u16 num_returned, num_remaining;
+	struct scmi_xfer *ti;
+	struct scmi_msg_resp_sensor_list_update_intervals *buf;
+	struct scmi_msg_sensor_list_update_intervals *msg;
+
+	ret = scmi_xfer_get_init(handle, SENSOR_LIST_UPDATE_INTERVALS,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &ti);
+	if (ret)
+		return ret;
+
+	buf = ti->rx.buf;
+	do {
+		u32 flags;
+
+		msg = ti->tx.buf;
+		/* Set the number of sensors to be skipped/already read */
+		msg->id = cpu_to_le32(s->id);
+		msg->index = cpu_to_le32(desc_index);
+
+		ret = scmi_do_xfer(handle, ti);
+		if (ret)
+			break;
+
+		flags = le32_to_cpu(buf->num_intervals_flags);
+		num_returned = NUM_INTERVALS_RETURNED(flags);
+		num_remaining = NUM_INTERVALS_REMAINING(flags);
+
+		/*
+		 * Max intervals is not declared previously anywhere so we
+		 * assume it's returned+remaining.
+		 */
+		if (!s->intervals.count) {
+			s->intervals.segmented = SEGMENTED_INTVL_FORMAT(flags);
+			s->intervals.count = num_returned + num_remaining;
+			/* segmented intervals are reported in one triplet */
+			if (s->intervals.segmented &&
+			    (num_remaining || num_returned != 3)) {
+				dev_err(handle->dev,
+					"Sensor ID:%d advertises an invalid segmented interval (%d)\n",
+					s->id, s->intervals.count);
+				s->intervals.segmented = false;
+				s->intervals.count = 0;
+				ret = -EINVAL;
+				break;
+			}
+			/* Direct allocation when exceeding pre-allocated */
+			if (s->intervals.count >= SCMI_MAX_PREALLOC_POOL) {
+				s->intervals.desc =
+					devm_kcalloc(handle->dev,
+						     s->intervals.count,
+						     sizeof(*s->intervals.desc),
+						     GFP_KERNEL);
+				if (!s->intervals.desc) {
+					s->intervals.segmented = false;
+					s->intervals.count = 0;
+					ret = -ENOMEM;
+					break;
+				}
+			}
+		} else if (desc_index + num_returned > s->intervals.count) {
+			dev_err(handle->dev,
+				"No. of update intervals can't exceed %d\n",
+				s->intervals.count);
+			ret = -EINVAL;
+			break;
+		}
+
+		for (cnt = 0; cnt < num_returned; cnt++)
+			s->intervals.desc[desc_index + cnt] =
+					le32_to_cpu(buf->intervals[cnt]);
+
+		desc_index += num_returned;
+
+		scmi_reset_rx_to_maxsz(handle, ti);
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (num_returned && num_remaining);
+
+	scmi_xfer_put(handle, ti);
+	return ret;
+}
+
+static int scmi_sensor_axis_description(const struct scmi_handle *handle,
+					struct scmi_sensor_info *s)
+{
+	int ret, cnt;
+	u32 desc_index = 0;
+	u16 num_returned, num_remaining;
+	struct scmi_xfer *te;
+	struct scmi_msg_resp_sensor_axis_description *buf;
+	struct scmi_msg_sensor_axis_description_get *msg;
+
+	s->axis = devm_kcalloc(handle->dev, s->num_axis,
+			       sizeof(*s->axis), GFP_KERNEL);
+	if (!s->axis)
+		return -ENOMEM;
+
+	ret = scmi_xfer_get_init(handle, SENSOR_AXIS_DESCRIPTION_GET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &te);
+	if (ret)
+		return ret;
+
+	buf = te->rx.buf;
+	do {
+		u32 flags;
+		struct scmi_axis_descriptor *adesc;
+
+		msg = te->tx.buf;
+		/* Set the number of sensors to be skipped/already read */
+		msg->id = cpu_to_le32(s->id);
+		msg->axis_desc_index = cpu_to_le32(desc_index);
+
+		ret = scmi_do_xfer(handle, te);
+		if (ret)
+			break;
+
+		flags = le32_to_cpu(buf->num_axis_flags);
+		num_returned = NUM_AXIS_RETURNED(flags);
+		num_remaining = NUM_AXIS_REMAINING(flags);
+
+		if (desc_index + num_returned > s->num_axis) {
+			dev_err(handle->dev, "No. of axis can't exceed %d\n",
+				s->num_axis);
+			break;
+		}
+
+		adesc = &buf->desc[0];
+		for (cnt = 0; cnt < num_returned; cnt++) {
+			u32 attrh, attrl;
+			struct scmi_sensor_axis_info *a;
+			size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
+
+			attrl = le32_to_cpu(adesc->attributes_low);
+
+			a = &s->axis[desc_index + cnt];
+
+			a->id = le32_to_cpu(adesc->id);
+			a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
+
+			attrh = le32_to_cpu(adesc->attributes_high);
+			a->scale = S32_EXT(SENSOR_SCALE(attrh));
+			a->type = SENSOR_TYPE(attrh);
+			strlcpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
+
+			if (a->extended_attrs) {
+				unsigned int ares =
+					le32_to_cpu(adesc->resolution);
+
+				a->resolution = SENSOR_RES(ares);
+				a->exponent =
+					S32_EXT(SENSOR_RES_EXP(ares));
+				dsize += sizeof(adesc->resolution);
+
+				scmi_parse_range_attrs(&a->attrs,
+						       &adesc->attrs);
+				dsize += sizeof(adesc->attrs);
+			}
+
+			adesc = (typeof(adesc))((u8 *)adesc + dsize);
+		}
+
+		desc_index += num_returned;
+
+		scmi_reset_rx_to_maxsz(handle, te);
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (num_returned && num_remaining);
+
+	scmi_xfer_put(handle, te);
+	return ret;
+}
+
 static int scmi_sensor_description_get(const struct scmi_handle *handle,
 				       struct sensors_info *si)
 {
@@ -131,9 +403,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	buf = t->rx.buf;
 
 	do {
+		struct scmi_sensor_descriptor *sdesc;
+
 		/* Set the number of sensors to be skipped/already read */
 		put_unaligned_le32(desc_index, t->tx.buf);
-
 		ret = scmi_do_xfer(handle, t);
 		if (ret)
 			break;
@@ -147,22 +420,97 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 			break;
 		}
 
+		sdesc = &buf->desc[0];
 		for (cnt = 0; cnt < num_returned; cnt++) {
 			u32 attrh, attrl;
 			struct scmi_sensor_info *s;
+			size_t dsize = SCMI_MSG_RESP_SENS_DESCR_BASE_SZ;
 
-			attrl = le32_to_cpu(buf->desc[cnt].attributes_low);
-			attrh = le32_to_cpu(buf->desc[cnt].attributes_high);
 			s = &si->sensors[desc_index + cnt];
-			s->id = le32_to_cpu(buf->desc[cnt].id);
-			s->type = SENSOR_TYPE(attrh);
-			s->scale = SENSOR_SCALE(attrh);
-			/* Sign extend to a full s8 */
-			if (s->scale & SENSOR_SCALE_SIGN)
-				s->scale |= SENSOR_SCALE_EXTEND;
+			s->id = le32_to_cpu(sdesc->id);
+
+			attrl = le32_to_cpu(sdesc->attributes_low);
+			/* common bitfields parsing */
 			s->async = SUPPORTS_ASYNC_READ(attrl);
 			s->num_trip_points = NUM_TRIP_POINTS(attrl);
-			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
+			/**
+			 * only v3.0 specific bitfield below.
+			 * Such bitfields are assumed to be zeroed on non
+			 * relevant fw versions...assuming fw not buggy !
+			 */
+			s->update = SUPPORTS_UPDATE_NOTIFY(attrl);
+			s->timestamped = SUPPORTS_TIMESTAMP(attrl);
+			if (s->timestamped)
+				s->tstamp_scale =
+					S32_EXT(SENSOR_TSTAMP_EXP(attrl));
+			s->extended_scalar_attrs =
+				SUPPORTS_EXTEND_ATTRS(attrl);
+
+			attrh = le32_to_cpu(sdesc->attributes_high);
+			/* common bitfields parsing */
+			s->scale = S32_EXT(SENSOR_SCALE(attrh));
+			s->type = SENSOR_TYPE(attrh);
+			/* Use pre-allocated pool wherever possible */
+			s->intervals.desc = s->intervals.prealloc_pool;
+			if (si->version == 0x10000) {
+				s->intervals.segmented = false;
+				s->intervals.count = 1;
+				/*
+				 * Convert SCMIv2.0 update interval format to
+				 * SCMIv3.0 to be used as the common exposed
+				 * descriptor, accessible via common macros.
+				 */
+				s->intervals.desc[0] =
+					(SENSOR_UPDATE_BASE(attrh) << 5) |
+					 SENSOR_UPDATE_SCALE(attrh);
+			} else {
+				/*
+				 * From version v3.0 update intervals are
+				 * retrieved via a dedicated (optional) command.
+				 * Since the command is optional, on error carry
+				 * on without any update interval.
+				 */
+				if (scmi_sensor_update_intervals(handle, s))
+					dev_info(handle->dev,
+						 "Update Intervals not available for sensor ID:%d\n",
+						 s->id);
+			}
+			/**
+			 * only > v2.0 specific bitfield below.
+			 * Such bitfields are assumed to be zeroed on non
+			 * relevant fw versions...assuming fw not buggy !
+			 */
+			s->num_axis = min_t(unsigned int,
+					    SUPPORTS_AXIS(attrh) ?
+					    SENSOR_AXIS_NUMBER(attrh) : 0,
+					    SCMI_MAX_NUM_SENSOR_AXIS);
+			strlcpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
+
+			if (s->extended_scalar_attrs) {
+				s->sensor_power = le32_to_cpu(sdesc->power);
+				dsize += sizeof(sdesc->power);
+				/* Only for sensors reporting scalar values */
+				if (s->num_axis == 0) {
+					unsigned int sres =
+						le32_to_cpu(sdesc->resolution);
+
+					s->resolution = SENSOR_RES(sres);
+					s->exponent =
+						S32_EXT(SENSOR_RES_EXP(sres));
+					dsize += sizeof(sdesc->resolution);
+
+					scmi_parse_range_attrs(&s->scalar_attrs,
+							       &sdesc->scalar_attrs);
+					dsize += sizeof(sdesc->scalar_attrs);
+				}
+			}
+			if (s->num_axis > 0) {
+				ret = scmi_sensor_axis_description(handle, s);
+				if (ret)
+					goto out;
+			}
+
+			sdesc = (typeof(sdesc))((u8 *)sdesc + dsize);
 		}
 
 		desc_index += num_returned;
@@ -174,6 +522,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		 */
 	} while (num_returned && num_remaining);
 
+out:
 	scmi_xfer_put(handle, t);
 	return ret;
 }
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9cd312a1ff92..1f5c52a460bb 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_SCMI_PROTOCOL_H
 #define _LINUX_SCMI_PROTOCOL_H
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/types.h>
@@ -148,26 +149,234 @@ struct scmi_power_ops {
 			 u32 *state);
 };
 
+/**
+ * scmi_range_attrs  - specifies a sensor or axis values' range
+ * @min_range: The minimum value which can be represented by the sensor/axis.
+ * @max_range: The maximum value which can be represented by the sensor/axis.
+ */
+struct scmi_range_attrs {
+	long long min_range;
+	long long max_range;
+};
+
+/**
+ * scmi_sensor_axis_info  - describes one sensor axes
+ * @id: The axes ID.
+ * @type: Axes type. Chosen amongst one of @enum scmi_sensor_class.
+ * @scale: Power-of-10 multiplier applied to the axis unit.
+ * @name: NULL-terminated string representing axes name as advertised by
+ *	  SCMI platform.
+ * @extended_attrs: Flag to indicate the presence of additional extended
+ *		    attributes for this axes.
+ * @resolution: Extended attribute representing the resolution of the axes.
+ *		Set to 0 if not reported by this axes.
+ * @exponent: Extended attribute representing the power-of-10 multiplier that
+ *	      is applied to the resolution field. Set to 0 if not reported by
+ *	      this axes.
+ * @attrs: Extended attributes representing minimum and maximum values
+ *	   measurable by this axes. Set to 0 if not reported by this sensor.
+ */
+struct scmi_sensor_axis_info {
+	unsigned int id;
+	unsigned int type;
+	int scale;
+	char name[SCMI_MAX_STR_SIZE];
+	bool extended_attrs;
+	unsigned int resolution;
+	int exponent;
+	struct scmi_range_attrs attrs;
+};
+
+/**
+ * scmi_sensor_intervals_info  - describes number and type of available update
+ * intervals
+ * @segmented: Flag for segmented intervals' representation. When True there
+ *	       will be exactly 3 intervals in @desc, with each entry
+ *	       representing a member of a segment in this order:
+ *	       {lowest update interval, highest update interval, step size}
+ * @count: Number of intervals described in @desc.
+ * @desc: Array of @count interval descriptor bitmask represented as detailed in
+ *	  the SCMI specification: it can be accessed using the accompanying
+ *	  macros.
+ * @prealloc_pool: A minimal preallocated pool of desc entries used to avoid
+ *		   lesser-than-64-bytes dynamic allocation for small @count
+ *		   values.
+ */
+struct scmi_sensor_intervals_info {
+	bool segmented;
+	unsigned int count;
+	unsigned int *desc;
+#define SCMI_SENS_INTVL_GET_SECS(x)		FIELD_GET(GENMASK(20, 5), (x))
+#define SCMI_SENS_INTVL_GET_EXP(x)					\
+	({								\
+		int __signed_exp = FIELD_GET(GENMASK(4, 0), (x));	\
+									\
+		if (__signed_exp & BIT(4))				\
+			__signed_exp |= GENMASK(31, 5);			\
+		__signed_exp;						\
+	})
+#define SCMI_MAX_PREALLOC_POOL			16
+	unsigned int prealloc_pool[SCMI_MAX_PREALLOC_POOL];
+};
+
+/**
+ * struct scmi_sensor_info - represents information related to one of the
+ * available sensors.
+ * @id: Sensor ID.
+ * @type: Sensor type. Chosen amongst one of @enum scmi_sensor_class.
+ * @scale: Power-of-10 multiplier applied to the sensor unit.
+ * @num_trip_points: Number of maximum configurable trip points.
+ * @async: Flag for asynchronous read support.
+ * @update: Flag for continuouos update notification support.
+ * @timestamped: Flag for timestamped read support.
+ * @tstamp_scale: Power-of-10 multiplier applied to the sensor timestamps to
+ *		  represent it in seconds.
+ * @num_axis: Number of supported axis if any. Reported as 0 for scalar sensors.
+ * @axis: Pointer to an array of @num_axis descriptors.
+ * @intervals: Descriptor of available update intervals.
+ * @sensor_config: A bitmask reporting the current sensor configuration as
+ *		   detailed in the SCMI specification: it can accessed and
+ *		   modified through the accompanying macros.
+ * @name: NULL-terminated string representing sensor name as advertised by
+ *	  SCMI platform.
+ * @extended_scalar_attrs: Flag to indicate the presence of additional extended
+ *			   attributes for this sensor.
+ * @sensor_power: Extended attribute representing the average power
+ *		  consumed by the sensor in microwatts (uW) when it is active.
+ *		  Reported here only for scalar sensors.
+ *		  Set to 0 if not reported by this sensor.
+ * @resolution: Extended attribute representing the resolution of the sensor.
+ *		Set to 0 if not reported by this sensor.
+ * @exponent: Extended attribute representing the power-of-10 multiplier that is
+ *	      applied to the resolution field.
+ *	      Reported here only for scalar sensors.
+ *	      Set to 0 if not reported by this sensor.
+ * @scalar_attrs: Extended attributes representing minimum and maximum
+ *		  measurable values by this sensor.
+ *		  Reported here only for scalar sensors.
+ *		  Set to 0 if not reported by this sensor.
+ */
 struct scmi_sensor_info {
-	u32 id;
-	u8 type;
-	s8 scale;
-	u8 num_trip_points;
+	unsigned int id;
+	unsigned int type;
+	int scale;
+	unsigned int num_trip_points;
 	bool async;
+	bool update;
+	bool timestamped;
+	int tstamp_scale;
+	unsigned int num_axis;
+	struct scmi_sensor_axis_info *axis;
+	struct scmi_sensor_intervals_info intervals;
 	char name[SCMI_MAX_STR_SIZE];
+	bool extended_scalar_attrs;
+	unsigned int sensor_power;
+	unsigned int resolution;
+	int exponent;
+	struct scmi_range_attrs scalar_attrs;
 };
 
 /*
  * Partial list from Distributed Management Task Force (DMTF) specification:
- * DSP0249 (Platform Level Data Model specification)
+ * DSP0248 (Platform Level Data Model for Platform Monitoring and Control
+ * specification)
  */
 enum scmi_sensor_class {
 	NONE = 0x0,
+	UNSPEC = 0x1,
 	TEMPERATURE_C = 0x2,
+	TEMPERATURE_F = 0x3,
+	TEMPERATURE_K = 0x4,
 	VOLTAGE = 0x5,
 	CURRENT = 0x6,
 	POWER = 0x7,
 	ENERGY = 0x8,
+	CHARGE = 0x9,
+	VOLTAMPERE = 0xA,
+	NITS = 0xB,
+	LUMENS = 0xC,
+	LUX = 0xD,
+	CANDELAS = 0xE,
+	KPA = 0xF,
+	PSI = 0x10,
+	NEWTON = 0x11,
+	CFM = 0x12,
+	RPM = 0x13,
+	HERTZ = 0x14,
+	SECS = 0x15,
+	MINS = 0x16,
+	HOURS = 0x17,
+	DAYS = 0x18,
+	WEEKS = 0x19,
+	MILS = 0x1A,
+	INCHES = 0x1B,
+	FEET = 0x1C,
+	CUBIC_INCHES = 0x1D,
+	CUBIC_FEET = 0x1E,
+	METERS = 0x1F,
+	CUBIC_CM = 0x20,
+	CUBIC_METERS = 0x21,
+	LITERS = 0x22,
+	FLUID_OUNCES = 0x23,
+	RADIANS = 0x24,
+	STERADIANS = 0x25,
+	REVOLUTIONS = 0x26,
+	CYCLES = 0x27,
+	GRAVITIES = 0x28,
+	OUNCES = 0x29,
+	POUNDS = 0x2A,
+	FOOT_POUNDS = 0x2B,
+	OUNCE_INCHES = 0x2C,
+	GAUSS = 0x2D,
+	GILBERTS = 0x2E,
+	HENRIES = 0x2F,
+	FARADS = 0x30,
+	OHMS = 0x31,
+	SIEMENS = 0x32,
+	MOLES = 0x33,
+	BECQUERELS = 0x34,
+	PPM = 0x35,
+	DECIBELS = 0x36,
+	DBA = 0x37,
+	DBC = 0x38,
+	GRAYS = 0x39,
+	SIEVERTS = 0x3A,
+	COLOR_TEMP_K = 0x3B,
+	BITS = 0x3C,
+	BYTES = 0x3D,
+	WORDS = 0x3E,
+	DWORDS = 0x3F,
+	QWORDS = 0x40,
+	PERCENTAGE = 0x41,
+	PASCALS = 0x42,
+	COUNTS = 0x43,
+	GRAMS = 0x44,
+	NEWTON_METERS = 0x45,
+	HITS = 0x46,
+	MISSES = 0x47,
+	RETRIES = 0x48,
+	OVERRUNS = 0x49,
+	UNDERRUNS = 0x4A,
+	COLLISIONS = 0x4B,
+	PACKETS = 0x4C,
+	MESSAGES = 0x4D,
+	CHARS = 0x4E,
+	ERRORS = 0x4F,
+	CORRECTED_ERRS = 0x50,
+	UNCORRECTABLE_ERRS = 0x51,
+	SQ_MILS = 0x52,
+	SQ_INCHES = 0x53,
+	SQ_FEET = 0x54,
+	SQ_CM = 0x55,
+	SQ_METERS = 0x56,
+	RADIANS_SEC = 0x57,
+	BPM = 0x58,
+	METERS_SEC_SQUARED = 0x59,
+	METERS_SEC = 0x5A,
+	CUBIC_METERS_SEC = 0x5B,
+	MM_MERCURY = 0x5C,
+	RADIANS_SEC_SQUARED = 0x5D,
+	OEM_UNIT = 0xFF
 };
 
 /**
-- 
2.17.1

