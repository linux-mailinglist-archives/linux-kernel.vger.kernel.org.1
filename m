Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDE2D08D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgLGB0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgLGB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607304293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=sPZMkWPyWVaaTUTdVItsmybqSHRLMaGJkADfcXrdhD0=;
        b=DVSVb9yqOThBr5lyrA4aaIIjqMzsRpgdwZMRa7HWUpenmbyFyJcQpBj+oN9ZhcPot/Fkmb
        1CJYfkXtFCzmDQKK/5YbJfeH1uwyHpe3TQ3ygR6/LPASpkaJpUzn0s1zkyYPVCjbtkrqmb
        pm0ACT3S+6M6yoL8FwuVdtw/3H6Mc/Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-x3T70UaZOaWj5gnvqYVDiQ-1; Sun, 06 Dec 2020 20:24:51 -0500
X-MC-Unique: x3T70UaZOaWj5gnvqYVDiQ-1
Received: by mail-pj1-f71.google.com with SMTP id e21so6685300pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 17:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPZMkWPyWVaaTUTdVItsmybqSHRLMaGJkADfcXrdhD0=;
        b=cS7yFRmTJnE+buI9P5oO1s2abYdyGbIoxBuMyWCLPz6ukmLOo3LHDqp4touYMyyqsq
         Vjs4do4Vw5C5rU3ruNdZv7F73D2jY9vUn29w5PLvmiK0sCLK/2IkDR0DjUY9rUiOYWRj
         nLTajNJ4D024TcRtnRRR88HQpWAx+8dNd5ShcvhIbxLOfYru9BOUwp5E0zGT2SYZxwqg
         9tBY35EFn0PehCbUlG7AejxJWQh+oDDA/6i/TMqpjirqMPh9TRzuzzI05wYiE8BF8pz0
         TwWuwJGKe1WOGO8kmgGycXhmaobwrL907Z1AqegFweF64xX9D2Ew04Q+umSp+TMktXn0
         P50w==
X-Gm-Message-State: AOAM532Sw2YZGAUCVS2+yD0yMdyrwtMj5G5SCf7yTpaPI8r7cLdEMbL8
        1RRQsAWFdDEhjQiVMrPpNvtUNXfzmX0ilyE7hFtUb2NSyJSJq8jlUdJUeFFA//kzywO5FiHZTRB
        Lq/2DSL0meE5BdQYhkKP508Ay
X-Received: by 2002:aa7:8ac1:0:b029:19d:beff:4e0f with SMTP id b1-20020aa78ac10000b029019dbeff4e0fmr12861633pfd.0.1607304290476;
        Sun, 06 Dec 2020 17:24:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy76aU9QSvKxeU7JwVnF91LA80bFL4tQFJSdIYpiOIleO/vCRSKgFZj3awZ33K3hPz8OuLQzQ==
X-Received: by 2002:aa7:8ac1:0:b029:19d:beff:4e0f with SMTP id b1-20020aa78ac10000b029019dbeff4e0fmr12861617pfd.0.1607304290238;
        Sun, 06 Dec 2020 17:24:50 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z13sm8600202pjt.45.2020.12.06.17.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 17:24:49 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 3/3] erofs: simplify try_to_claim_pcluster()
Date:   Mon,  7 Dec 2020 09:23:46 +0800
Message-Id: <20201207012346.2713857-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201207012346.2713857-1-hsiangkao@redhat.com>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify try_to_claim_pcluster() by directly using cmpxchg() here
(the retry loop caused more overhead.) Also, move the chain loop
detection in and rename it to z_erofs_try_to_claim_pcluster().

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 51 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index edd7325570e1..b1b6cd03046f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -298,34 +298,33 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
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
@@ -370,10 +369,8 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
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

