Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F92D49C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgLITF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbgLITFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:05:40 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147EC061794;
        Wed,  9 Dec 2020 11:05:00 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id fh13so1400588pjb.0;
        Wed, 09 Dec 2020 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/UsojO3YT4ojgGWZWe9AgdTF40UliX8euFAjdhHI+5E=;
        b=D548r6tfjRjuqddyZqi6fpDGFfJXK5WSIO8Ho5JrZxdYuYRITJ+sRRWwNqN3IUalMq
         rmtgctzQ3zUpEv7Wc38JbJfD9xNy64wqd6UkGHOa0nJ8qu4Nanz6oAllOcvWjOJ5/e1z
         p8tRiEuqY6EGV+1AZaT78ZX/AHDess2iD6mo0PJa6wb36pcA5Zv2/gNZvLKxJYf5lHnn
         c1Q+VZGJtercgP3c2Sl3bWSSzfwCEOExRjDsEXoHUqtmxhGQcbGcmYxXCa3LhxxJ117u
         VUUmBiiOaCZUTdO29sNKlzdHIayKqtdIgd/i+txlYmADMT8RzpcwtYjtjstnyjzwdcOt
         mbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/UsojO3YT4ojgGWZWe9AgdTF40UliX8euFAjdhHI+5E=;
        b=PBQRNWOOPL7tgDFIAD9TZm9u9Z2sv3e+m2yI+aF/0QbvZ2JT+XDOK9YA84MloMECOL
         BOy0C509o/PzaVGqIIm+VmyqTMh7Hr8HzQihBfl83CdsCyWJ4SRzXuc1gMB2Mjo+Tg+/
         Q6l4ygslxyLPf2kAbeK4Xp63XvrMwlZuSUli8xCZS+LSA/gl+zQCjyRF2Nl+rCdF8FjQ
         LWE61EVgL5E3+zp2R3Dm34NOsTl8/ac1Hgo3IAIbeClNdIBLqC6JiNzyPckAkLpwkDSo
         DlqxCo1eqxTMF88BKLubepEq54UheEjDgHtu0C7lzP9NALkopYwoQYKL1UNqMvaXmlD4
         d5mA==
X-Gm-Message-State: AOAM5319NpxGxYKP0zkgzjEjtHdcmyorlf56CYqhlX49uF7Dhazi0VAU
        m+OPcNDQ2Ki0YUUM6Wf6nME=
X-Google-Smtp-Source: ABdhPJynKIt47cLvQOMnEdiyWNtUNdbLfIaDC7GfpGEwNNwF7mRz6z1XwWljvTc8ahnUQTGmtPnFjw==
X-Received: by 2002:a17:902:b582:b029:d6:6008:264d with SMTP id a2-20020a170902b582b02900d66008264dmr3494207pls.80.1607540700315;
        Wed, 09 Dec 2020 11:05:00 -0800 (PST)
Received: from adolin ([49.207.194.238])
        by smtp.gmail.com with ESMTPSA id g16sm3177829pfb.201.2020.12.09.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:04:59 -0800 (PST)
Date:   Thu, 10 Dec 2020 00:34:53 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     daniel@ffwll.ch, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/vkms: Add setup and testing information
Message-ID: <20201209190453.c6kp5winikr55n3i@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the vkms documentation to contain steps to:

 - setup the vkms driver
 - run tests using igt

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
___
Changes in v2:
 - Change heading to title case (Daniel)
 - Add examples to run tests directly (Daniel)
 - Add examples to run subtests (Melissa)

Changes in v3:
 - Add example using run-tests.sh script(Daniel)
---
 Documentation/gpu/vkms.rst | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13bab1d93bb3..9e030c74a82e 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -7,6 +7,76 @@
 .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
    :doc: vkms (Virtual Kernel Modesetting)
 
+Setup
+=====
+
+The VKMS driver can be setup with the following steps:
+
+To check if VKMS is loaded, run::
+
+  lsmod | grep vkms
+
+This should list the VKMS driver. If no output is obtained, then
+you need to enable and/or load the VKMS driver.
+Ensure that the VKMS driver has been set as a loadable module in your
+kernel config file. Do::
+
+  make nconfig
+
+  Go to `Device Drivers> Graphics support`
+
+  Enable `Virtual KMS (EXPERIMENTAL)`
+
+Compile and build the kernel for the changes to get reflected.
+Now, to load the driver, use::
+
+  sudo modprobe vkms
+
+On running the lsmod command now, the VKMS driver will appear listed.
+You can also observe the driver being loaded in the dmesg logs.
+
+To disable the driver, use ::
+
+  sudo modprobe -r vkms
+
+Testing With IGT
+================
+
+The IGT GPU Tools is a test suite used specifically for debugging and
+development of the DRM drivers.
+The IGT Tools can be installed from
+`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
+
+The tests need to be run without a compositor, so you need to switch to text
+only mode. You can do this by::
+
+  sudo systemctl isolate multi-user.target
+
+To return to graphical mode, do::
+
+  sudo systemctl isolate graphical.target
+
+Once you are in text only mode, you can run tests using the --device switch
+or IGT_DEVICE variable to specify the device filter for the driver we want
+to test. IGT_DEVICE can also be used with the run-test.sh script to run the
+tests for a specific driver::
+
+  sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/<name of test>
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t <name of test>
+
+For example, to test the functionality of the writeback library,
+we can run the kms_writeback test::
+
+  sudo ./build/tests/kms_writeback --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_writeback
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./scripts/run-tests.sh -t kms_writeback
+
+You can also run subtests if you do not want to run the entire test::
+
+  sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
+
 TODO
 ====
 
-- 
2.25.1

