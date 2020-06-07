Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0317D1F101B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgFGWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 18:07:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A9C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 15:07:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so15513134qka.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ue9rbka2wsdJVpgp4GYSMJwY63/qK2N44P1t8AIamgQ=;
        b=furMMj/3yOm2OL4MwyggYAGP/AU5KJe30Md9AOmftaOVct9F26p7sMolEAiQaTYCCs
         AD+FxyyCMoLANQHfumhj9ZsnBHpmiufpdn+A8E+gMbw+j5R9d6RUABxn2IZ688IZxAuF
         iW+nIN81UmcLuf5kZoCJx3g1wURu8nRxK+Wopgjya4RWxYDMd+ZbsGTNh/SLMquW8CBn
         SFKmGSntGfrHVghJPqR0Da/gsXmUfAA4j/ZOU20kA0MiGUKr1ZyUVs0bmbO8fsl3L8V5
         ivUacjGBAJpdmEKL1wwlZLLZWjqdVzukDey39RYGH+6hi9XF02MPmefGYSBXdBjtTRp7
         nLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ue9rbka2wsdJVpgp4GYSMJwY63/qK2N44P1t8AIamgQ=;
        b=mOAnMDMyCjVB4Q291ddxZqgHyDBGuJBUsAAg+iHax5pkJr+dEo/Rx4Lo+VzxeCnazb
         +VLqr/Wg5eyQJI6zMDWwi5r8ymHLsKHrChlHmOc0Qd9XUQWVh+To2I5tSAW0vGO56QSA
         hFig3U3zmzHfvTf+uWIXASH8F8ZlaYApq1te582PqRgeNLYRDWOahuUf+c5YgTgCrP+C
         J80Pkqfjg4ZNK1rawuu03jwJfyf+GX3WbYPcrF+eAU1Bh5hPDeDbKWhXL7dI1uvL2OrT
         kTkMvsFRY4dvtL4BIO8mIpUw9hPwha7VN6nwWRrZaYXYP4rN9QzMPrPughetwHdTJlF7
         Y7vQ==
X-Gm-Message-State: AOAM5307Ys7Wt2op42Gp9L2XVx/zmXH3ViZSfP3iMedNPKjW0sXADGH2
        wCxncNMF/AJxai7/qe32jQ==
X-Google-Smtp-Source: ABdhPJzmIkzkR/JPRnONr6EaKB4mkHcWFbBPseQqnX5rmgqQGUu/tbA4QUO4PB/VSQOgcvVo9XihYg==
X-Received: by 2002:a37:bfc1:: with SMTP id p184mr19789441qkf.207.1591567661926;
        Sun, 07 Jun 2020 15:07:41 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id l9sm5564021qki.90.2020.06.07.15.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 15:07:41 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     iamkeyur96@gmail.com
Subject: [PATCH v2] fs: ocfs2: fix spelling mistake and grammar
Date:   Sun,  7 Jun 2020 18:07:16 -0400
Message-Id: <20200607220716.101243-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607212115.99278-1-iamkeyur96@gmail.com>
References: <20200607212115.99278-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./ocfs2/mmap.c:65: bebongs ==> belongs

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 fs/ocfs2/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 3a44e461828a..39a77e903fdf 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 	last_index = (size - 1) >> PAGE_SHIFT;
 
 	/*
-	 * There are cases that lead to the page no longer bebongs to the
+	 * There are cases that lead to the page no longer belonging to the
 	 * mapping.
 	 * 1) pagecache truncates locally due to memory pressure.
 	 * 2) pagecache truncates when another is taking EX lock against 
-- 
2.26.2

