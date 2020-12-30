Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D932E7A17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgL3O5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgL3O5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609340173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w6RH1LM35oC579jEOnaRKqc5ukFlU7LKex1Uzqpw4kk=;
        b=Xd1m2nFIWCtYW00UKhPhQVkLgaH43ShYumSSvuk1YXqksgqKc4Hs3TWvJGKfx+z6smbxpq
        1J8G1F2qu0Zd353eNBSrFZhsd/bVXK9OiMj22habgAPoOlw4uulb8R4rt6gbOxZC1VQxt8
        3Cs/Amv1d1Du3vGenmT0i/NieTx4x14=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-pVQHWRFJPG6dzHcNvFQ4Lw-1; Wed, 30 Dec 2020 09:56:11 -0500
X-MC-Unique: pVQHWRFJPG6dzHcNvFQ4Lw-1
Received: by mail-ot1-f69.google.com with SMTP id 67so11956755otg.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 06:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6RH1LM35oC579jEOnaRKqc5ukFlU7LKex1Uzqpw4kk=;
        b=Z3gu6LO3mv8okyjMq/Bue3nLhz5xSBtBYb6g8e93PNpUS4hS3Cklfwdq31zJ8epN9q
         1mNTyTMZeBO9FX6/f4kjSvbTvYTltzfbiqe4i9xJ/CogvcgJQHRG9VjasTC+lS+jdCrT
         kAmu+bB30USeoAEpIjvlUkGtpgyCPT70RqLC1cyzUxPXUgX0RO6L7ITpGagSPWyNQ2Y9
         0weG4yJJSM+sO4gVjzLcZDSP3DdhRGTqng4IfTUV3FUIj0NmxZj+UrLIW1gswTfDSdwd
         QlkRqPsHRx7fOy9C9gkB2yt6Z8diPuACzNisygg/WNRnsbH72rBpoMtK0/Khi+S3EebY
         VPAA==
X-Gm-Message-State: AOAM532r31ecNKomtqMEbcoMgcsLBBmfCYASEzMN3ilOlrE8TyRgSKWA
        GYpSgxStXjmXUTsKBM4aC28r3AKDcRbAkKMW3xniXHkkjET4vSF1/OOYYk/nxTJhiddRWjUnGir
        RZWDUAzVUQdmnIm1YCr4vUzpS
X-Received: by 2002:aca:c756:: with SMTP id x83mr5236801oif.62.1609340170235;
        Wed, 30 Dec 2020 06:56:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzehqKYiVwDnLNT82AhFABnG8o3yzhpO/4tUUnnXBtpA58sMqTwX+mVIh8VsZNRaXuDA1uLcg==
X-Received: by 2002:aca:c756:: with SMTP id x83mr5236795oif.62.1609340170082;
        Wed, 30 Dec 2020 06:56:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s66sm9182400ooa.37.2020.12.30.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 06:56:09 -0800 (PST)
From:   trix@redhat.com
To:     dwmw2@infradead.org, richard@nod.at, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] jffs2: fix use after free in jffs2_sum_write_data()
Date:   Wed, 30 Dec 2020 06:56:04 -0800
Message-Id: <20201230145604.1586486-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

fs/jffs2/summary.c:794:31: warning: Use of memory after it is freed
                c->summary->sum_list_head = temp->u.next;
                                            ^~~~~~~~~~~~

In jffs2_sum_write_data(), in a loop summary data is handles a node at
a time.  When it has written out the node it is removed the summary list,
and the node is deleted.  In the corner case when a
JFFS2_FEATURE_RWCOMPAT_COPY is seen, a call is made to
jffs2_sum_disable_collecting().  jffs2_sum_disable_collecting() deletes
the whole list which conflicts with the loop's deleting the list by parts.

To preserve the old behavior of stopping the write midway, bail out of
the loop after disabling summary collection.

Fixes: 6171586a7ae5 ("[JFFS2] Correct handling of JFFS2_FEATURE_RWCOMPAT_COPY nodes.")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/jffs2/summary.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index be7c8a6a5748..4fe64519870f 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -783,6 +783,8 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
 					dbg_summary("Writing unknown RWCOMPAT_COPY node type %x\n",
 						    je16_to_cpu(temp->u.nodetype));
 					jffs2_sum_disable_collecting(c->summary);
+					/* The above call removes the list, nothing more to do */
+					goto bail_rwcompat;
 				} else {
 					BUG();	/* unknown node in summary information */
 				}
@@ -794,6 +796,7 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
 
 		c->summary->sum_num--;
 	}
+ bail_rwcompat:
 
 	jffs2_sum_reset_collected(c->summary);
 
-- 
2.27.0

