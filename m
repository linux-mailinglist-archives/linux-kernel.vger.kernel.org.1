Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4916F2B9F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKTBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKTBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:03:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5319C0613CF;
        Thu, 19 Nov 2020 17:03:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 5so3958567plj.8;
        Thu, 19 Nov 2020 17:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7zt9mcXsIDW+980vgQ3Cy0UH+65s4CoUr/DUZ7hl/E=;
        b=F1JjmCJAREfbuy6PVO1YJt5jWLt4B8DfPMHiKtVTGx5EZN0juv84LbUDJqdBx6oNos
         C6S/+9RfEN9/HlD5uAmUuOJDecLoshraZXaLkW7Od93kZlyC1mIhYfJXdq/GVyx8O5R0
         x9ALYq+gYgl9mHtwE1ut+Kytb0rj2YHuC8CiGBshcrLMvuhi6Ax1okTu112MDKJJoLtL
         3zfdiGBcTm59wn7/M6IrsjIFXvIkYcBsJHAVosMFEZ3FhzFAzqQu6IgAmb6N01MtwfzF
         B/q8aTgqNF0/dEgkDBGto+w7XSkdNb2KtiKRUXfF54Shxb8MUWWivXmZ5DEupvONwG7X
         oHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P7zt9mcXsIDW+980vgQ3Cy0UH+65s4CoUr/DUZ7hl/E=;
        b=BlfbtRIC/tCLb6W2eIq7HtmuxU5DwSwoe0ovoamZJoce6CHd1u36UocSpInBKlwJ1j
         taUEz9qezMNPrEh5GJ4r+2JR7SASqBk2E4aQJEptLvGeZdwsDovtMiG76KGB1h5qnEMV
         s+82kZRa5TpJT6rCm/np4zNHXCW6DXg9+m3lJ0iwDpCd+Lv3K0I7jpc87tGtTcrfY9lC
         u1v7MhanCKANEwHGMs7H935S/Vfdt8A2ArMrraG0GkbVCgenS3nbFXXPOY+DPpMbmDBB
         GS7/F3rt0vCfzMVBILNRHuPmKCmLGqmfirFuv6vwUpHv69eMIXuTEosuN2n4niThqkmM
         JlaA==
X-Gm-Message-State: AOAM530Vqi6kCuxdunFU9OmMsWkXUE643bhc6pU3GZAbQt2HBikQPj4Q
        GxMM9zEdGSFUEMhnTIdaLo4=
X-Google-Smtp-Source: ABdhPJy1pAAHTdurNdN8pGcUQcJZZbHWg8a2jpy/Kls4crc0P7AANVyMS7SA5yc5eKK+KH7fjkO6ag==
X-Received: by 2002:a17:902:7288:b029:d9:124:a262 with SMTP id d8-20020a1709027288b02900d90124a262mr11033454pll.44.1605834222281;
        Thu, 19 Nov 2020 17:03:42 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id q14sm1205273pfl.163.2020.11.19.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 17:03:40 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 3/3] hwmon: (occ) Add new temperature sensor type
Date:   Fri, 20 Nov 2020 11:33:15 +1030
Message-Id: <20201120010315.190737-4-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120010315.190737-1-joel@jms.id.au>
References: <20201120010315.190737-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

The latest version of the On-Chip Controller (OCC) has a different
format for the temperature sensor data. Add a new temperature sensor
version to handle this data.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/hwmon/occ/common.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index a71777990d49..7a5e539b567b 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -41,6 +41,14 @@ struct temp_sensor_2 {
 	u8 value;
 } __packed;
 
+struct temp_sensor_10 {
+	u32 sensor_id;
+	u8 fru_type;
+	u8 value;
+	u8 throttle;
+	u8 reserved;
+} __packed;
+
 struct freq_sensor_1 {
 	u16 sensor_id;
 	u16 value;
@@ -307,6 +315,60 @@ static ssize_t occ_show_temp_2(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
 }
 
+static ssize_t occ_show_temp_10(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_10 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_10 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&temp->sensor_id);
+		break;
+	case 1:
+		val = temp->value;
+		if (val == OCC_TEMP_SENSOR_FAULT)
+			return -EREMOTEIO;
+
+		/*
+		 * VRM doesn't return temperature, only alarm bit. This
+		 * attribute maps to tempX_alarm instead of tempX_input for
+		 * VRM
+		 */
+		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
+			/* sensor not ready */
+			if (val == 0)
+				return -EAGAIN;
+
+			val *= 1000;
+		}
+		break;
+	case 2:
+		val = temp->fru_type;
+		break;
+	case 3:
+		val = temp->value == OCC_TEMP_SENSOR_FAULT;
+		break;
+	case 4:
+		val = temp->throttle * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
 static ssize_t occ_show_freq_1(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -745,6 +807,10 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		num_attrs += (sensors->temp.num_sensors * 4);
 		show_temp = occ_show_temp_2;
 		break;
+	case 0x10:
+		num_attrs += (sensors->temp.num_sensors * 5);
+		show_temp = occ_show_temp_10;
+		break;
 	default:
 		sensors->temp.num_sensors = 0;
 	}
@@ -844,6 +910,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
 						     show_temp, NULL, 3, i);
 			attr++;
+
+			if (sensors->temp.version == 0x10) {
+				snprintf(attr->name, sizeof(attr->name),
+					 "temp%d_max", s);
+				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+							     show_temp, NULL,
+							     4, i);
+				attr++;
+			}
 		}
 	}
 
-- 
2.29.2

