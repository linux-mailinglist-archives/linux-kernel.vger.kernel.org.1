Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74F2D5640
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbgLJJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbgLJJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:11:17 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D80C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:10:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d3so3934972wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpyrZoiER+zCyF8HpO4UqQSTTSh7Jr5N+k2TvNlAzgU=;
        b=MdJK2mD0l5uJdJbu/Gswmd44hgf/kn4QbbPenS4LG2YlN0FZKzmobhEGnsvppCzkMe
         JNif/+N1s8wdRobYG4fzbMU59eWsIvDcKEvusa6XrpaSss3VEU6SgEL3gJJe2VELmNod
         Zyvvin3G/OZYABNwpkmkk/4c9Ab6kKccURqsllox09sOtyzkkcleFvV1wTrMhIapBCMR
         vHQliQU/r58TM+8s0MOri49Iu3aRBD2EDJxMF0K+5aPJRHLeBXIwk52VMzGnkz8UqTNJ
         delWzmILv001ksWWpNtbg9DANsL9TxKAG3QLCPDF3Br+C+D7j7qQsDgENkDZbFndw/Y3
         GfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpyrZoiER+zCyF8HpO4UqQSTTSh7Jr5N+k2TvNlAzgU=;
        b=PEMHZtFkUxBIchC2ngvFQ92rawjeneBbc+I8TIJlcUy6d+B2vb3xUNfSY9qk8MN1pB
         fsT8w1PxJb4QC6nywrU5zFWA62GLFE3K+AEMHpR7ifr8H4MqVQMF7C0D7dGIXW7UTuNl
         1J2llC/1w4hgBEjVpUVYLtz6yLH8lfW8FUB+BLbOU2bJ9KfnrLIuW8laDR9yuiJawtJm
         9UzRwPI/ChMzn3Ib+3riumlVzm5IfgYRbdbVGLLr6RGLsznZ98qozvU+UXw2P/3NtDqQ
         6QC6sjQJT+vP7ya6A9AuHTijx641oExEua8V9B35AAKtMNTxvraZSQNrDX97P+4NkYVu
         +M6A==
X-Gm-Message-State: AOAM533LKrpaO9sXgrL9kXx+iGWTmaQ4iVRCYLRu8O7FvI7hv9omIkb7
        CrOXhwucefyGMLvVtTXzrow=
X-Google-Smtp-Source: ABdhPJzMuh6P7mMx5+wD+cRni0VZSIG4oEfWDELzQSfTATTz8yGsl58hrQH76IYKHUA8L2bu2mwrMA==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr7270501wml.31.1607591435630;
        Thu, 10 Dec 2020 01:10:35 -0800 (PST)
Received: from localhost.localdomain (82-132-223-245.dab.02.net. [82.132.223.245])
        by smtp.googlemail.com with ESMTPSA id r16sm9123935wrx.36.2020.12.10.01.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 01:10:35 -0800 (PST)
From:   Chris Bloomfield <ginge264@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chris Bloomfield <ginge264@gmail.com>
Subject: [PATCH] Staging: ralink-gdma: ralink-gdma: Fix a blank line coding style issue
Date:   Thu, 10 Dec 2020 10:06:57 +0000
Message-Id: <20201210100657.22562-1-ginge264@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a coding style issue as identified by checkpatch.pl

Signed-off-by: Chris Bloomfield <ginge264@gmail.com>
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

