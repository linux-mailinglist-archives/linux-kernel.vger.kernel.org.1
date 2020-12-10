Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAC2D4FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgLJAlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLJAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:36:41 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EB4C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:36:00 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so3099809wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoowjq1jthAtfWpi0MYhq4h26LiuoFyZ12DSOAJnPT0=;
        b=XRwPhSfwmOQju2zJrnSz+KuAxip+WEUPZgp8pnS304dhgr/IltVUDJcuJcFtFubr9e
         U8oPTBg5D3D9i10cWZYuznKyvT6zMWw6dkyqkWWXXFd0fHSPkbtpD5CAeu9Tsjn+BnZ7
         ervJZN/wBVFDIr5j0vNeESNHlgVOvCVgtKdzZvvibjkDs83FikVqI6kMA6tFpcIbzTWa
         Rva9nXP5VXnADWcZHk5wW3PE4ZvPns05425G7c8lQZF6yBWKMuyzVQR9nlo6YtwOCU+g
         kdHjWlddY2TrQipIBR2vho3PzrjsB55YmwegBzN0+zTCDSdcWd2JpZTSDHK4VrS3vsNA
         Y2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoowjq1jthAtfWpi0MYhq4h26LiuoFyZ12DSOAJnPT0=;
        b=G8uLBcnvdJG+3s3DpAdeUbuR8PRmNh/UDuAX3MrMU3+y/Doe2+JaJ1FVB2SOGkoy+B
         vZ0n7dpD32/o9TTGKQb9lM0LS5qyzhnJaBkrQNnbP4RJzK7Wfoi0WIt7pI2MkDVxhMqP
         pi6hjI2K2DfsHO3pczS4T3XE9Wx0KiaIE0XlUPEhlJcJoftHdpaF9qCi1VCxXbcnMmmZ
         xbVNO1t1rSR2TVE3HHKdJJzsQaHfX8U3rX7r/wkcJB9/srC8eleApePwaxyT+dXlmsLA
         UXnloyfVgTBrOrHRayikJrcWAhAAot/wFBQEH8XVJRTZz+AeHL1AgWVYcI1SiFgjVxNk
         NmGQ==
X-Gm-Message-State: AOAM533Z4hc0ksm+pKi7rYISM/RQV6SHimILepCS59vVP4SEjb+ya+pq
        CanGDAvYzqhnedlN8HtrujJRFTvS8Ou9WA==
X-Google-Smtp-Source: ABdhPJyqaybobGjryFrt72zrRNiOqfMUX2Q7ykw3QMdYXrT98LLGGh7o6mNI5xuIgMzh4Kj2Tb+UKA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr5348933wmf.58.1607560559422;
        Wed, 09 Dec 2020 16:35:59 -0800 (PST)
Received: from localhost.localdomain (82-132-222-12.dab.02.net. [82.132.222.12])
        by smtp.googlemail.com with ESMTPSA id r2sm6350019wrn.83.2020.12.09.16.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:35:58 -0800 (PST)
From:   Triplehx3 <ginge264@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Triplehx3 <ginge264@gmail.com>
Subject: [PATCH] Staging: ralink-gdma: ralink-gdma: Fix a blank line coding style issue
Date:   Thu, 10 Dec 2020 01:32:28 +0000
Message-Id: <20201210013228.9371-1-ginge264@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a coding style issue as identified by checkpatch.pl

Signed-off-by: Triplehx3 <ginge264@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 655df317d0ee..a6181a167814 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -122,6 +122,7 @@ struct gdma_dma_dev {
 	struct gdma_data *data;
 	void __iomem *base;
 	struct tasklet_struct task;
+
 	volatile unsigned long chan_issued;
 	atomic_t cnt;
 
-- 
2.28.0

