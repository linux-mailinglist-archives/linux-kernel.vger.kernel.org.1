Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04B2A6E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgKDTg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgKDTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:51 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0882DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e2so3441995wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPvcFV2vZX3BfpwLdpFbtIG9Ju+bls9tsXWTt3HrK/g=;
        b=ZkJ59XyrGFsm8wxeQrl3HsF8bvRavqa9TcCwKRRC+A3Iblhrs+H/fu4IS3oFIGJqfS
         OzW07o34gLevDQXsLuVEGfOC2GB58EJCnecQxY8b2bSukJw7BxACQykXf3I7+O1vAtrN
         RTLBipYC+OgFwKyH7tSlnkDU3apn95+lJmFpRzChAErlRojUp9tTVSsRCoZAN/xfIw2q
         RHBBj+jMFTF08GOvSX8moUbqpEGpUZedX2XJSS71TbqGaIq94+v1dexFtrP8Ej3zdRpO
         8O2Z05hULFK56eGgzSBfsy2swRdzFB+bKeukwRN2tnZgKOAVK0qq+cvB8XIwAmDnEjUl
         6iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPvcFV2vZX3BfpwLdpFbtIG9Ju+bls9tsXWTt3HrK/g=;
        b=A86dlB6W3ru5tFoiX7FlQJZYVHmXZmVTav1375BShjgfyNhjf/6aIbu3UHTRXv1UVO
         8a5v7neZdZiTnw6yO4r62KOGQoP7PhMx4oAPsZhB/NOR0WZF5w9QkrlnP4xByXBsVzL7
         MpggS3GFeaxE0r32VuYtubOtIKOC12rbdKmgpMmDYlXtx8S9POi/0DEMeWcOPGUnLtw+
         FPqIwVNr/tpcl5ZUhUg9H3ZbNyhKq1nC3n+L4HAFP0eSUE3QGv/CVN3TENpn9RX8I9Kc
         C8jKwMzhvpVRdk43IEtPkNB6dzZ5X3kAkvtUwcH00ob1wXNI4/CiN+ye7MZU6ohZ2LA5
         rW6A==
X-Gm-Message-State: AOAM532BP3yvcYv/RYMKz8a2E2sVe56Z9I48BOjZhQ5enlIriGaXCInA
        7oeiyZMVNChOg4El8WPKKZ1ExA==
X-Google-Smtp-Source: ABdhPJzk7h+VyfQ7/yEkHviJKZg4+fgpI9N3x+YzTJJIHBdmfUJM3SMsFNaOPt4yOr/N9x2kLDD6wA==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr6136829wmi.2.1604518609655;
        Wed, 04 Nov 2020 11:36:49 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, paulkf@microgate.com
Subject: [PATCH 35/36] tty: synclink: Mark disposable variables as __always_unused
Date:   Wed,  4 Nov 2020 19:35:48 +0000
Message-Id: <20201104193549.4026187-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/synclink.c: In function ‘usc_reset’:
 drivers/tty/synclink.c:5571:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
 drivers/tty/synclink.c: In function ‘mgsl_load_pci_memory’:
 drivers/tty/synclink.c:7267:16: warning: variable ‘Dummy’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/synclink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index c8324d58ef564..8ed64b1e7c378 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -5568,7 +5568,7 @@ static void usc_load_txfifo( struct mgsl_struct *info )
 static void usc_reset( struct mgsl_struct *info )
 {
 	int i;
-	u32 readval;
+	u32 __always_unused readval;
 
 	/* Set BIT30 of Misc Control Register */
 	/* (Local Control Register 0x50) to force reset of USC. */
@@ -7264,7 +7264,7 @@ static void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr,
 
 	unsigned short Intervalcount = count / PCI_LOAD_INTERVAL;
 	unsigned short Index;
-	unsigned long Dummy;
+	unsigned long __always_unused Dummy;
 
 	for ( Index = 0 ; Index < Intervalcount ; Index++ )
 	{
-- 
2.25.1

