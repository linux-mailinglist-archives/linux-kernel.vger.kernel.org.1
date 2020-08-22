Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4801324E436
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHVAit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 20:38:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39356 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHVAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 20:38:45 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CDEA20B490D;
        Fri, 21 Aug 2020 17:38:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CDEA20B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598056723;
        bh=1x024vbFSoeKtXP/E5IWzkmZnPo+YBzXbBC68lCFXOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXmMl8ADQv0QeKrIFS/WuoZsyY1tD/bBRL2sqKb0y5Fa3nXVMIHJRLIbHZ7RP7Sut
         /sEYFxF+A1dArqob7KJGJL47wI4vmHnadkz2qMLTo3bXOKOmMjm5WIHpfBFfMavmLX
         73NJ3hltz8bx49ZJWscvCoChks3YVMeFK3IkIeGo=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 2/2] dm-crypt: collect data and submit to DM to measure
Date:   Fri, 21 Aug 2020 17:38:34 -0700
Message-Id: <20200822003834.5696-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822003834.5696-1-tusharsu@linux.microsoft.com>
References: <20200822003834.5696-1-tusharsu@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dm-crypt does not take advantage of IMA measuring
capabilities, and ultimately the benefits of remote attestation.

Measure various dm-crypt constructs by calling various device-mapper
functions - dm_ima_*() that use IMA measuring capabilities. Implement
ima_measure_dm_crypt_data() to measure various dm-crypt constructs.

Ensure that ima_measure_dm_crypt_data() is non intrusive, i.e. failures
in this function and the call-stack below should not affect the core
functionality of dm-crypt.

A demonstrative usage of above functionality on a system:

If the IMA policy contains the following rule:

    measure func=CRITICAL_DATA data_sources=dm-crypt template=ima-buf

and, the following commands are used to setup a crypt target:

 #key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
 #arg="'0 1953125 crypt aes-xts-plain64 "
 #arg="$arg $key 0 "
 #arg="$arg /dev/loop0 0 1 allow_discards'"
 #tgt_name="test-crypt"
 #cmd="dmsetup create $tgt_name --table $arg"
 #eval $cmd

then, the IMA log at
/sys/kernel/security/integrity/ima/ascii_runtime_measurements should
contain the dm-crypt measurements. And, the following IMA log entry
should be added in the IMA log,

 ima-buf sha1:4cbca71967d6b48e13ff5283d8e657899b005f70 
 1597518359:539244018:dm-crypt:add_target
 74695f6e756d5f646973636172645f62696f733d313b7065725f62696f5f646
 174615f73697a653d3830383b646d7265715f73746172743d3136383b74666d
 735f636f756e743d313b6f6e5f6469736b5f7461675f73697a653d303b696e7
 46567726974795f69765f73697a653d303b696e746567726974795f7461675f
 73697a653d303b69765f73697a653d31363b69765f6f66667365743d303b736
 563746f725f73686966743d303b736563746f725f73697a653d3531323b666c
 6167733d323b6369706865725f666c6167733d303b73746172743d303b6b657
 95f6d61635f73697a653d303b6b65795f65787472615f73697a653d303b6b65
 795f70617274733d313b6b65795f73697a653d33323b6369706865725f73747
 2696e673d6165732d7874732d706c61696e36343b6465766963655f6e616d65
 3d3235333a303b

where, the ascii representation of the above data is:

 ti_num_discard_bios=1;per_bio_data_size=808;dmreq_start=168;
 tfms_count=1;on_disk_tag_size=0;integrity_iv_size=0;
 integrity_tag_size=0;iv_size=16;iv_offset=0;sector_shift=0;
 sector_size=512;flags=2;cipher_flags=0;start=0;key_mac_size=0;
 key_extra_size=0;key_parts=1;key_size=32;
 cipher_string=aes-xts-plain64;device_name=253:0;

Some of the above values can be verified using:

 #dmsetup table --showkeys

where, the output of the command should be similar to:

 test-crypt: 0 1953125 crypt aes-xts-plain64
 faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa
 0 7:0 0 1 allow_discards

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm-crypt.c          | 170 +++++++++++++++++++++++++++++++++
 security/integrity/ima/Kconfig |   3 +-
 2 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 000ddfab5ba0..aaca9594ec98 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2465,6 +2465,8 @@ static void crypt_dtr(struct dm_target *ti)
 
 	ti->private = NULL;
 
+	dm_ima_exit_measurements(ti->type);
+
 	if (!cc)
 		return;
 
@@ -2908,6 +2910,166 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	return 0;
 }
 
+#ifdef CONFIG_IMA
+/*
+ * append integer values to dm-crypt specific data
+ * to be measured through IMA
+ */
+static int ima_append_num_values(struct dm_target *ti,
+				 const char *key,
+				 long long num_val)
+{
+	char *num_str = NULL;
+	int length = 0;
+	int r = 0;
+
+	if (!ti || !key) {
+		r = -EINVAL;
+		goto error;
+	}
+
+	length = snprintf(NULL, 0, "%lld", num_val);
+	num_str = kzalloc(length + 1, GFP_KERNEL);
+	if (!num_str) {
+		r = -ENOMEM;
+		goto error;
+	}
+	snprintf(num_str, length + 1, "%lld", num_val);
+	dm_ima_append_measurement_list(ti->type,
+				       key,
+				       (const void *)num_str,
+				       length);
+	kzfree(num_str);
+	return r;
+error:
+	DMERR("appending num values to IMA measurement list failed %d", r);
+	return r;
+}
+/*
+ * Measure dm-crypt specific data through IMA.
+ * It appends all the needed data to the list as a key-val pair using
+ * dm_ima_append_measurement_list() and internal ima_append_num_values(),
+ * and finally measures the list using dm_ima_finalize_and_measure().
+ */
+static void ima_measure_dm_crypt_data(struct dm_target *ti, const char *desc)
+{
+	int r = 0;
+	struct crypt_config *cc = NULL;
+	const char *devname = dm_table_device_name(ti->table);
+
+	if (!ti) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	cc = ti->private;
+
+	if (devname) {
+		dm_ima_append_measurement_list(ti->type,
+					       "device_name",
+					       (const void *)devname,
+					       strlen(devname));
+	}
+
+	if (cc->cipher_string) {
+		dm_ima_append_measurement_list(ti->type,
+					       "cipher_string",
+					       (const void *)cc->cipher_string,
+					       strlen(cc->cipher_string));
+	}
+
+	if (cc->cipher_auth) {
+		dm_ima_append_measurement_list(ti->type,
+					       "cipher_auth",
+					       (const void *)cc->cipher_auth,
+					       strlen(cc->cipher_auth));
+	}
+
+	r = ima_append_num_values(ti, "key_size", cc->key_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "key_parts", cc->key_parts);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "key_extra_size", cc->key_extra_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "key_mac_size", cc->key_mac_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "start", cc->start);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "cipher_flags", cc->cipher_flags);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "flags", cc->flags);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "sector_size", cc->sector_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "sector_shift", cc->sector_shift);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "iv_offset", cc->iv_offset);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "iv_size", cc->iv_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "integrity_tag_size", cc->integrity_tag_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "integrity_iv_size", cc->integrity_iv_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "on_disk_tag_size", cc->on_disk_tag_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "tfms_count", cc->tfms_count);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "dmreq_start", cc->dmreq_start);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "per_bio_data_size", cc->per_bio_data_size);
+	if (r)
+		goto out;
+
+	r = ima_append_num_values(ti, "ti_num_discard_bios",
+			      ti->num_discard_bios);
+	if (r)
+		goto out;
+
+	dm_ima_finalize_and_measure(ti->type, desc, false);
+	return;
+
+out:
+	DMERR("IMA measurement of dm-crypt data failed %d", r);
+
+}
+#else
+static inline void ima_measure_dm_crypt_data(struct dm_target *ti,
+					     const char *desc) {}
+#endif /* CONFIG_IMA */
+
 /*
  * Construct an encryption mapping:
  * <cipher> [<key>|:<key_size>:<user|logon>:<key_description>] <iv_offset> <dev_path> <start>
@@ -3093,6 +3255,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_flush_bios = 1;
 
+	dm_ima_init_measurements(ti->type);
+
+	ima_measure_dm_crypt_data(ti, "add_target");
+
 	return 0;
 
 bad:
@@ -3225,6 +3391,8 @@ static void crypt_postsuspend(struct dm_target *ti)
 	struct crypt_config *cc = ti->private;
 
 	set_bit(DM_CRYPT_SUSPENDED, &cc->flags);
+
+	ima_measure_dm_crypt_data(ti, "post_suspend");
 }
 
 static int crypt_preresume(struct dm_target *ti)
@@ -3244,6 +3412,8 @@ static void crypt_resume(struct dm_target *ti)
 	struct crypt_config *cc = ti->private;
 
 	clear_bit(DM_CRYPT_SUSPENDED, &cc->flags);
+
+	ima_measure_dm_crypt_data(ti, "resume");
 }
 
 /* Message interface
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index bc2adab7bae2..2078db4c16e2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
 
 config IMA_QUEUE_EARLY_BOOT_DATA
 	bool
-	depends on IMA_MEASURE_ASYMMETRIC_KEYS
-	depends on SYSTEM_TRUSTED_KEYRING
+        depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING) || DM_CRYPT
 	default y
 
 config IMA_SECURE_AND_OR_TRUSTED_BOOT
-- 
2.17.1

