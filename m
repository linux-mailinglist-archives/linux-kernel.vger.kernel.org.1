Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0F29949D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788906AbgJZR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:58:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42193 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782367AbgJZR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:58:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id t22so5091366plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7x6I87gAC9xvdMA8/xgooissCxMzszxa0RkbWyw6hB4=;
        b=udPLBiKRzopNzVEN4HaoEnB2q5A+8XhiYVHfoMBoTleM9m+IL2+Ufzbc6rExR5uCCB
         s22ivYrIYpyrmK53nSVEf2DfOiKndD7QV+XP9D4dIgWrdAXePiason3y15YU65Vw6icA
         KqnoI23rdTk7HO7yNu2h9bfcxSRoaYnadDfA5oxWHFXm8yh0PEHj3Xz1YGEAzsaH1hEF
         UN6u4vjiz8E3fMNoZA7tlSyiAXxDjc6sD5SSuSz3+hhJkAllMieDzum6Yofxh0UGP61N
         tKqq52xjRz3JizMLgFtjNdSPJYocUylNNBHdUBmkuR/KQcDaVIueQF3+fsv3MkAQAcBf
         /3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7x6I87gAC9xvdMA8/xgooissCxMzszxa0RkbWyw6hB4=;
        b=FbUPZ63cWYam5KTsH20/rCmPGxbfbPNXF8R954mXakhgSCI1HNCQV8vels1ZObG6D8
         1Ki0sDIbdcRH+aDxYTPRbzO7zrQrTXv2Uq3KMD0pMmiR9q0TLFSK/7xcahXQM4TPCbno
         W7rc/x02QI6ZFwmRzSA+k4Fiw9jnDuXcJ/x2zIU+lUxU3r7qlzGosHmTEWLg+OHGV1Uo
         DkfuiATqq3px2U2xlzMAX4+j50+hcfwivHd/4UngRISd30MRq39x5j6gAiQhXWMT8cWu
         /tEdDiTx8A7biNLkTY6KZCPqzPCcHvatrDSyZ6AmSGtEdD2rxFo13oiyAxCZmTj725ij
         F3Pw==
X-Gm-Message-State: AOAM531xsaZL9/Fw6nHqVdmzYvmhuB+xIJKNn/wMkE5yDGjKJWFgxL8p
        prh1JUR2umklq/EFTkBIUaz1
X-Google-Smtp-Source: ABdhPJxorBhGf3L1PmYRHh4xbOyaOA/4Oy7aKXmiw4zw/MdyjAkOMU3yiJcy4KJEY8BRyiAJNspM/A==
X-Received: by 2002:a17:902:26c:b029:d6:83c:9486 with SMTP id 99-20020a170902026cb02900d6083c9486mr9673144plc.85.1603735081495;
        Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
Received: from localhost.localdomain ([116.68.74.56])
        by smtp.gmail.com with ESMTPSA id o65sm11583088pga.42.2020.10.26.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:58:01 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     johan@kernel.org
Cc:     ribalda@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kbuild@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, vaishnav@beagleboard.org
Subject: [RFC PATCH 2/5] file2alias: Support for serdev devices
Date:   Mon, 26 Oct 2020 23:27:15 +0530
Message-Id: <20201026175718.965773-3-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026175718.965773-1-vaishnav@beagleboard.org>
References: <20201026175718.965773-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows file2alias to generate the proper module headers to
support serdev modalias drivers.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 27007c18e754..732cd03e911d 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -152,6 +152,9 @@ int main(void)
 	DEVID_FIELD(i3c_device_id, part_id);
 	DEVID_FIELD(i3c_device_id, extra_info);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2417dd1dee33..540fee036d9d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -947,6 +947,15 @@ static int do_spi_entry(const char *filename, void *symval,
 	return 1;
 }
 
+static int do_serdev_entry(const char *filename, void *symval,
+			   char *alias)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+	sprintf(alias, SERDEV_MODULE_PREFIX "%s", *name);
+
+	return 1;
+}
+
 static const struct dmifield {
 	const char *prefix;
 	int field;
@@ -1420,6 +1429,7 @@ static const struct devtable devtable[] = {
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
 	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
+	{"serdev", SIZE_serdev_device_id, do_serdev_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
 	{"platform", SIZE_platform_device_id, do_platform_entry},
-- 
2.25.1

