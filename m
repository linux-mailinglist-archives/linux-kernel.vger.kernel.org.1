Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5382D345E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgLHUiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgLHUiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:38:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B339C0613D6;
        Tue,  8 Dec 2020 12:37:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id p4so9140246pfg.0;
        Tue, 08 Dec 2020 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SNP2rIe8G2wxSnafh8FU2upaNSqmof5AJ943Uuvz4dw=;
        b=HbROMcQcEmaR8A4+xfeZsLCwM8PcwhFYL64MOP8sPCwZYfO84rS56Flo0/gYv3iWTp
         f61DePhePPUaXs5yxlei68P3PNm+cxJRgO3zsUAj+tIIjntTt/EjDn7aziJCJd760xQ0
         jSDHPNRGSvFcbV8+WdHg812j7Kl3hBhGaKW1poyVWvcYS3iygzwbBZpjg4ATXN9SxFpu
         07h++o+NxI+HvnILG33JWlJcXADXWCO6NT2vapgGq9MNxbzyHeEwMUWLp2aL7SpjoWuu
         cviLNPkFAS8Pf4+a1bkDsKFcVnSMsvfmKq7YrRix8DvnbAq4JMNhnQXRjZP9HBriDjjg
         GNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SNP2rIe8G2wxSnafh8FU2upaNSqmof5AJ943Uuvz4dw=;
        b=TXZcaMUH6t0zvxF2OP70XTFv3XOGOkgEIoc7u1LvujCG0XbGgPgA/isJdzqViuA+GL
         MY1RY+N6vVLmuBfIKfLI3lGD+tuEeGRKUYSo3cEHT8vgcALvq/O180S4E6dLCCGjU1zt
         fKgBmXW6pyvoJxxVsvHNwpzz1HQcSwE7L8+JAsAptp7d75PStkOrptuukcHMr0z8C3L9
         y8brUdig2sUW3s/URJW111U0vk3k8SwuyAPNKn1sqqYmLIx/8vSjJsQzKQIGVPpgfI9u
         6XLd/gEdU628asM8ynRqAeV4D+kDOVJXCofCKRk1dXcNs6fdj6DuQ8eGPKZRN2i1Dos/
         CsxQ==
X-Gm-Message-State: AOAM531Oh32gLQbRKh2WFQzXBuck9/O3R69ozzDAHcsCaPXZSGKjhA2Z
        J6oiOk1ICybs8+lGmfyKu9g=
X-Google-Smtp-Source: ABdhPJwj1BKNN6Nnq1qFVujF0F6c5iG63I40szpF99JYVx692OKwFWWi3UWVFiwRINbA//tv34X6Pg==
X-Received: by 2002:a17:90a:ab0f:: with SMTP id m15mr5019026pjq.222.1607459862734;
        Tue, 08 Dec 2020 12:37:42 -0800 (PST)
Received: from adolin ([49.207.194.238])
        by smtp.gmail.com with ESMTPSA id f21sm17153448pgk.18.2020.12.08.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:37:42 -0800 (PST)
Date:   Wed, 9 Dec 2020 02:07:35 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     daniel@ffwll.ch, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/vkms: Add setup and testing information
Message-ID: <20201208203735.ukqrgjmlntbvxc7e@adolin>
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
---
 Documentation/gpu/vkms.rst | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13bab1d93bb3..d6739fbbe503 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -7,6 +7,73 @@
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
+to test::
+
+  sudo ./build/tests/<name of test> --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/<name of test>
+
+For example, to test the functionality of the writeback library,
+we can run the kms_writeback test::
+
+  sudo ./build/tests/kms_writeback --device "sys:/sys/devices/platform/vkms"
+  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_writeback
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

