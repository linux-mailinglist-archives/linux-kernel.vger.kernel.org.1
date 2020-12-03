Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6E2CDE8E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgLCTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgLCTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:14:33 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBFC061A53;
        Thu,  3 Dec 2020 11:13:47 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o5so1982019pgm.10;
        Thu, 03 Dec 2020 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UB64UbUSJb9UjIl1DSmlKznWzh2B71H9tWiWqFm1ZJM=;
        b=BLJbvXwmkwl6XhAADig3fsLHsyb6HK3nyco5RlxSqUtO/djuLDg2Zv4fp9/tJ1kcJQ
         AbDJWNgtt5skMZ6xI6NNCdhq7EIEM1EhiDl6OHz0yK3UUrB1AOOPy8vOcXtT4IeX476D
         xIWMgQGYplVr8dIZuCX3UT73s7pNclmobTjfCPjhkJZGepjrH9QHHob8PBWzLspnn9VN
         n5C+64lIELXL5bTzAaLiKX/FMz8uB38orGaMZAFzoYwb5zDU1tM2vnBhDrnuxeCWmXNY
         iMmPQpjzypj+tL1ZSgmOMW/V+fjyxzS/fby27yU77Gis/+mwrhqmqrkcV5FDr+J+zSuj
         JaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UB64UbUSJb9UjIl1DSmlKznWzh2B71H9tWiWqFm1ZJM=;
        b=i8ZkBaP/SmCaxOJP7DVNEK1uFX8JFAsaEe0iKuAhXqjsnGFe1Ew3zU9CER9gJOoCKh
         AVCclLLn+Qpt0T75/z31hRlyqi1Ywkg4RmDnCXlDYVQzNepaCHU/sD5ouX9lAoZ0l39K
         CPS6HuCq0jk7rM8RbRkVOyzlIMFYQKmg9ztU3wUKfwe0TC5LW7VSuXyBG+Q9cvlLCyE5
         QeRVo7MAbniPEMxYE6vohuJVByyINSRIPBcsN3jRdVohvyJYJYbc5PYfjdqW6YtEKpKo
         MHxuWDDcBk+qIRf23zxVP/u1RYZQIrVLhcmn7hpLI7rWXFARGJplQp/Y8sSfAwAX2xGa
         u8lA==
X-Gm-Message-State: AOAM530Vdv/1W64qYaNaQhgqikOGklfWF3hq9t8AgbrK52doWR+c9CrA
        7z1kNkdECI5PgPizb+LyBrU=
X-Google-Smtp-Source: ABdhPJz9yWlfT7ehjo7zLQpsqHuAuYSbMtbgIPfqsEDwOA98FxlFGKncve4+x3YYqITYx2QyvjGQ5Q==
X-Received: by 2002:a63:1b1d:: with SMTP id b29mr4441309pgb.84.1607022826615;
        Thu, 03 Dec 2020 11:13:46 -0800 (PST)
Received: from adolin ([49.207.211.146])
        by smtp.gmail.com with ESMTPSA id j9sm2455797pfa.58.2020.12.03.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:13:45 -0800 (PST)
Date:   Fri, 4 Dec 2020 00:43:39 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     daniel@ffwll.ch, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: Add setup and testing information
Message-ID: <20201203191339.u5hfwy6ycrrzeb3z@adolin>
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
---
 Documentation/gpu/vkms.rst | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 13bab1d93bb3..d6782174d23f 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -7,6 +7,53 @@
 .. kernel-doc:: drivers/gpu/drm/vkms/vkms_drv.c
    :doc: vkms (Virtual Kernel Modesetting)
 
+SETUP
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
+kernel config file. The following line should be present in the .config
+file in your kernel root::
+
+  CONFIG_DRM_VKMS=m
+
+Compile and build the kernel for the changes to get reflected.
+If your existing config already has VKMS available as a loadable module,
+then there is no need to build the kernel again.
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
+TESTING WITH IGT
+================
+
+The IGT GPU Tools is a test suite used specifically for debugging and
+development of the DRM drivers.
+The IGT Tools can be installed from
+`here <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_ .
+Once you have installed IGT, you can run tests using::
+
+  ./scripts/run-tests.sh -t <name of test>
+
+For example, to test the functionality of the igt_draw library,
+we can run the kms_draw_crc test::
+
+  ./scripts/run-tests.sh -t kms_draw_crc
+
 TODO
 ====
 
-- 
2.25.1

