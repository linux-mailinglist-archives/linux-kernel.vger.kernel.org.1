Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8182D285A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgLHKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgLHKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607421602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=rBR2sHYHwldgTu0PFeX3ECPbcilHKiXAcu7mwUOdVL4=;
        b=cxTOoAHSXW3zzYJodXHNqtCHrbXc5YMKSZfBVTd4PBvunejQViOtZn2iHcCnN+J7W4V4GG
        ifG6joKtfCnnvyiYuB3VPM8gROzDIkP6Pu21XSksdLjhY4WoLE48Lat0HO+obQC77qMTRB
        Ry1KprQePKypHxugL03YG7EoFDrN1nY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-2O_es8Y4MrGlvnxW1XHs7A-1; Tue, 08 Dec 2020 05:00:00 -0500
X-MC-Unique: 2O_es8Y4MrGlvnxW1XHs7A-1
Received: by mail-pl1-f198.google.com with SMTP id a17so6624247pls.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBR2sHYHwldgTu0PFeX3ECPbcilHKiXAcu7mwUOdVL4=;
        b=TVhBXaOlv4vG+1+kJBCtjG7TfCGE+D+sYPy0avEBBJR8iO8kXQJY/hhZ/qYBWanmVw
         ku6tQ7D7zckDYNqlTR0aHXBIebe4ay4DreYKBwofslaDyZT0h/zsbKOKZ8sS3lLpDRg/
         STSM/w9gIudSSp/BNJB6LhH0dOd9Xr/Snju29Jy1FW5PHyUej/NSIW8H/2hz1qS3sxf+
         WjvZCq/IeH2AGLV6cz6UU1i3+N2GAfrTpUGqQqhj8AUq8uuynsB6bxPz2ecywXGdlBYZ
         nQUy1s37yygECUCwb/fszVb2f0fdzRLYv56L7I34NjfFq2T+Y9ZuRHr+fAp0SeeDAbSW
         9JoQ==
X-Gm-Message-State: AOAM531TcbQ0r4XNj2VYOBeGuRu7ArsCvzsDHkTTeFGgcktoPbu58gjy
        ZH9JSV5j7vGLLe2GrfR2pzA2k3pW24ir8SiW8ar3yOUoBvan7DRReFYY0wtlIabpIavL4J3/27h
        C0Ed2SgJvmLHLnSzYGwHzmBCS
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr3484685pjo.59.1607421597408;
        Tue, 08 Dec 2020 01:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUumzd5COLJTL8qWXa47ZR2o6FPrRYsjhJoPO1IK0VWghEiCF9KhowSLpTE7f5VVk6OdLSJQ==
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr3484674pjo.59.1607421597228;
        Tue, 08 Dec 2020 01:59:57 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z7sm11529018pfq.193.2020.12.08.01.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:59:56 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v3 3/3] erofs: simplify try_to_claim_pcluster()
Date:   Tue,  8 Dec 2020 17:58:34 +0800
Message-Id: <20201208095834.3133565-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201208095834.3133565-1-hsiangkao@redhat.com>
References: <20201208095834.3133565-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify try_to_claim_pcluster() by directly using cmpxchg() here
(the retry loop caused more overhead.) Also, move the chain loop
detection in and rename it to z_erofs_try_to_claim_pcluster().

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 51 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 37fee144f0e7..777790038bc9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -292,34 +292,33 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	return ret ? 0 : -EAGAIN;
 }
 
-static enum z_erofs_collectmode
-try_to_claim_pcluster(struct z_erofs_pcluster *pcl,
-		      z_erofs_next_pcluster_t *owned_head)
+static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
 {
-	/* let's claim these following types of pclusters */
-retry:
-	if (pcl->next == Z_EROFS_PCLUSTER_NIL) {
-		/* type 1, nil pcluster */
-		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
-			    *owned_head) != Z_EROFS_PCLUSTER_NIL)
-			goto retry;
+	struct z_erofs_pcluster *pcl = clt->pcl;
+	z_erofs_next_pcluster_t *owned_head = &clt->owned_head;
 
+	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
+	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
+		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
 		*owned_head = &pcl->next;
-		/* lucky, I am the followee :) */
-		return COLLECT_PRIMARY_FOLLOWED;
-	} else if (pcl->next == Z_EROFS_PCLUSTER_TAIL) {
-		/*
-		 * type 2, link to the end of a existing open chain,
-		 * be careful that its submission itself is governed
-		 * by the original owned chain.
-		 */
-		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-			    *owned_head) != Z_EROFS_PCLUSTER_TAIL)
-			goto retry;
+		/* so we can attach this pcluster to our submission chain. */
+		clt->mode = COLLECT_PRIMARY_FOLLOWED;
+		return;
+	}
+
+	/*
+	 * type 2, link to the end of an existing open chain, be careful
+	 * that its submission is controlled by the original attached chain.
+	 */
+	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
 		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		return COLLECT_PRIMARY_HOOKED;
+		clt->mode = COLLECT_PRIMARY_HOOKED;
+		clt->tailpcl = NULL;
+		return;
 	}
-	return COLLECT_PRIMARY;	/* :( better luck next time */
+	/* type 3, it belongs to a chain, but it isn't the end of the chain */
+	clt->mode = COLLECT_PRIMARY;
 }
 
 static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
@@ -364,10 +363,8 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		clt->tailpcl = pcl;
-	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
-	/* clean tailpcl if the current owned_head is Z_EROFS_PCLUSTER_TAIL */
-	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		clt->tailpcl = NULL;
+
+	z_erofs_try_to_claim_pcluster(clt);
 	clt->cl = cl;
 	return 0;
 }
-- 
2.18.4

