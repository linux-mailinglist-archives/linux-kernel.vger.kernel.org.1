Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4722A202B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgKARKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgKARKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:10:23 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15279C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 09:10:23 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 13so8990297pfy.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAPALz9woSaOZjQ6nussWrzn6BzRYlv9w3abjOFerPc=;
        b=Mvxk0BEtvHxc3IPI0D5AFk1Y+TVNa0x6wNc+C5fa5cejoSnIunkD95Weffgz2pmp5L
         U1SkRulRH8c80zua72YXuWBhkFDquW8A9jqDSs0+iDthDNbjCSLGSgcWKTA1+bKqNsaM
         lbqdAJTjb+6AN1CV64Is0qrrGUb9X+XulOBPmjNWbi3ELPNMI2wCreBj/w+2uXpUu77k
         tJ4gfZ2hO0zr/97A9G60yLuZuvowEthguGJCQ6YJCpYS05QeTwTkmfyByeCI+1fUBRqe
         kQotzFSR50fOnVQqA6zT5MArBROWmMmMfgRlVcWzBuCu4ZgD1JfG3B6Lv6PS883iD28U
         EpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAPALz9woSaOZjQ6nussWrzn6BzRYlv9w3abjOFerPc=;
        b=JlJFshPgh1pIwNXNVJTE195AhTMvSHJRgIjYI5N62RHF9nSRSvgvMnqa24n5K9I0Fn
         m5qrFhtdlcdHZfIWjKRxbS/+cgqEw5O0tS+bBujDHvhw1GGj26Q1mcGRF8gOvh92VDAd
         DYsWgrD6DRRqn/CQI4Gfy9AgunGfG2S52qi+WzQCJn0F0sWDsY87e6oB2z77HBF8w8l9
         YSvb/7pRRHlyx86rn/hYsgJqTFZHK2Zpf8JyybHrveVQgsTJ/gn9Wg0HPw0+9aX1M3oS
         F1/EjPKiT0BE08hZJTovkV51q3gFZe0+ZYVcA8t8dxlZyra6UNc3Ifu5EzEf5ByN8kHh
         0KCA==
X-Gm-Message-State: AOAM530QOtiirmPZ7d3+m4Mc9HmlVg7ig2VEFeeVhdfx1cE4vApsu48T
        vMB8j2NNxM4Uny2M3wL+Y5k=
X-Google-Smtp-Source: ABdhPJzQzXYrEUAadQ1UCo9dpZTj4NhRvwtX3lCPe4NOq/BPHyTsknWFT+I5+BSNHYR8TK6quEGkEg==
X-Received: by 2002:a62:7a8f:0:b029:163:d0b3:ac18 with SMTP id v137-20020a627a8f0000b0290163d0b3ac18mr19302389pfc.9.1604250622425;
        Sun, 01 Nov 2020 09:10:22 -0800 (PST)
Received: from localhost.localdomain ([150.242.63.133])
        by smtp.googlemail.com with ESMTPSA id b185sm10987048pgc.68.2020.11.01.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:10:21 -0800 (PST)
From:   Harshal Chaudhari <harshalchau04@gmail.com>
To:     gregkh@linuxfoundation.org, dragan.cvetic@xilinx.com
Cc:     derek.kiernan@xilinx.com, arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: xilinx-sdfec: remove check for ioctl cmd and argument.
Date:   Sun,  1 Nov 2020 22:39:49 +0530
Message-Id: <20201101170949.18616-1-harshalchau04@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (_IOC_TYPE(cmd) != PP_IOCTL)
        return -ENOTTY;

Invalid ioctl command check normally performs by “default” case.

if (_IOC_DIR(cmd) != _IOC_NONE) {
       argp = (void __user *)arg;
       if (!argp)
             return -EINVAL; }

And for checking ioctl arguments, copy_from_user()/copy_to_user()
checks are enough.

Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 92291292756a..ff104c894b3b 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -944,8 +944,8 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 			     unsigned long data)
 {
 	struct xsdfec_dev *xsdfec;
-	void __user *arg = NULL;
-	int rval = -EINVAL;
+	void __user *arg = (void __user *)data;
+	int rval;
 
 	xsdfec = container_of(fptr->private_data, struct xsdfec_dev, miscdev);
 
@@ -956,16 +956,6 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 		return -EPERM;
 	}
 
-	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
-		return -ENOTTY;
-
-	/* check if ioctl argument is present and valid */
-	if (_IOC_DIR(cmd) != _IOC_NONE) {
-		arg = (void __user *)data;
-		if (!arg)
-			return rval;
-	}
-
 	switch (cmd) {
 	case XSDFEC_START_DEV:
 		rval = xsdfec_start(xsdfec);
@@ -1010,7 +1000,7 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 		rval = xsdfec_is_active(xsdfec, (bool __user *)arg);
 		break;
 	default:
-		/* Should not get here */
+		rval = -ENOTTY;
 		break;
 	}
 	return rval;
-- 
2.17.1

