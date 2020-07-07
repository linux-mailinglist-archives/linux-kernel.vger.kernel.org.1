Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C985217520
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGGR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgGGR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:29:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D7C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:29:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so20315079pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFm0zZsEee0jyOpcffZkH1BBWPUeyZACVROnx5BmvFo=;
        b=aQ/vxe3ywvqhq7YhSCKxmIKhYaHRQV/lAb0Ay3c3hWSBBVyWq+D/OHnRFO8RNeQtRg
         2k//7Epb+Gf4F5KD/StYT7UInpD5GLuyr8RaAU5jBdE3mfl2F0hNn3gYounrtwMBPGFs
         /rpq/eVGdY4Pz88MPR5amU68PTfCRQRDua2/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFm0zZsEee0jyOpcffZkH1BBWPUeyZACVROnx5BmvFo=;
        b=aua+2mrj3P3uUYy5LL+P12Ikke2Q3YGi+GvB1lwz2vQSyaE6RtZwsI8dye+jzftyPh
         ql7sxDi/z3+znNVL0yCnj+a4s3SqlQfjYT9AtoQE3vcFZF0lqx2sTpF+6deiQ+fqTqdV
         U0XFw9dqgMPHpkUzTRXrfB5NiGDkpRG2A0t2dC+OqY0Ii0uCB+S7wAfTCcA3EQ0M7Y0v
         aPSFBdRz3a2lSCI0NYaZw1hg6miVF18G26E0a1vmcbSnNP3pWhvGX+qWMn+gHqgICwbx
         H9TY4EvhjurUujHrPwZm8T5f8gjRT+dXxMnZY+xb3iUPUCBqMlaz8N9bgGTHSV5evEjX
         JUww==
X-Gm-Message-State: AOAM533Ku2izD7qfMz7Ec3SpH/IRZf+mllmLNOt9Rc++j/6QHZ9VKrXV
        RlYorhzkTATGhNmrWN/Tr5fNPw==
X-Google-Smtp-Source: ABdhPJzs7CUdSj1Gwg62L4bJ94/aaSFpSOiduFOUy+QsKRQ9yrQ+xhNyo9VbVBvbbbAX6udNlEsTZA==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr50324326pfm.28.1594142940088;
        Tue, 07 Jul 2020 10:29:00 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id e15sm1414285pgt.17.2020.07.07.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:28:59 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v5 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
Date:   Tue,  7 Jul 2020 10:28:44 -0700
Message-Id: <20200707102823.v5.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200707172845.4177903-1-abhishekpandit@chromium.org>
References: <20200707172845.4177903-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Udev rules that depend on the power/wakeup attribute don't get triggered
correctly if device_set_wakeup_capable is called after the device is
created. This can happen for several reasons (driver sets wakeup after
device is created, wakeup is changed on parent device, etc) and it seems
reasonable to emit a changed event when adding or removing attributes on
the device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v5:
- Ignore return from kobject_uevent when adding to sysfs

Changes in v4:
- Fix warning where returning from void and tested on device

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 24d25cf8ab1487..c7b24812523c9e 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* sysfs entries for device PM */
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
 #include <linux/pm_qos.h>
@@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 
 int wakeup_sysfs_add(struct device *dev)
 {
-	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+
+	if (!ret)
+		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+
+	return ret;
 }
 
 void wakeup_sysfs_remove(struct device *dev)
 {
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 int pm_qos_sysfs_add_resume_latency(struct device *dev)
-- 
2.27.0.212.ge8ba1cc988-goog

