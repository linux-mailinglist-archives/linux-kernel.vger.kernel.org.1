Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D664C2825F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJCSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 14:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgJCSvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 14:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601751090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PpQx6m8qbEXm3p16DACdfvVJytaY8r/kOwzsRi4ZXfs=;
        b=XZJZNu44jC6f1i4/ie1uyHut0QstRTgTnX2UfgDNYBYCqa8tpQyBNTFSF7Hf0VBbG79YEk
        j32AxLrPVh4le6FdeQxvzea1njU/QhyOg/BdYHx+nGq3GchdRf0ShmVXa2VGGNrFuZIF3m
        /kSwavnTp+AD8w/QA4c22zFm5teFYKg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-GUQVyktyN3yi0bHa6RRlxw-1; Sat, 03 Oct 2020 14:51:29 -0400
X-MC-Unique: GUQVyktyN3yi0bHa6RRlxw-1
Received: by mail-qt1-f200.google.com with SMTP id f4so3625919qta.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 11:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PpQx6m8qbEXm3p16DACdfvVJytaY8r/kOwzsRi4ZXfs=;
        b=aJdeslBeQwVexGFAKUITQz2Cz1hvqI5MydvgJ0oLmnJq/lHARCjH8xNA8AFLhjjUNU
         Zp5gmsiyd3TjNyZSQX+yuRXUKpKa+hZtJXDAd0FtZFxkcw9Nw5D8WtheASJCbeqGcxoF
         nOcc5BAM4w7TSRkJMXstjt/lgt8w1NMFQnUMh3UjMAXlCcQCtPSfalZpE06lH/dXPjNF
         WKV2IT6nwwLw/eJXh8avWtebH41A8l7yxq2D0Hc3gFU/eGu3nUw3csiO80V8fxnblCr4
         69nObTjgPBxMc5zLX1AH4gLqy5Lh2TzEUIu+WIIzZ2dbuI4mcT25ecgZ585Mu9YWur0v
         SM7Q==
X-Gm-Message-State: AOAM532lpkJKzNJ7xwG07W3loFRnbH6VUj79QvvvyS9Novs9bgs4DY+a
        F3qH6MB+wdWUzJuXBrYd8ObIe9HZU83KdbPNi/bNtvSzeq8rdZ3QirDd49/R1j+nU+VKHNlv6E5
        7BMK2uhYcXBSV7W1NROrJ87pg
X-Received: by 2002:ac8:1005:: with SMTP id z5mr7605651qti.130.1601751088989;
        Sat, 03 Oct 2020 11:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycZfecxVOwp4U+Ss1sMQDY8Y7tRC1tEpgXkh9CGlzXlHbe4K/4sKNQWysyQe+dtCjHt3CMzg==
X-Received: by 2002:ac8:1005:: with SMTP id z5mr7605637qti.130.1601751088732;
        Sat, 03 Oct 2020 11:51:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v15sm3731672qkg.108.2020.10.03.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:51:28 -0700 (PDT)
From:   trix@redhat.com
To:     thomas.petazzoni@bootlin.com, davem@davemloft.net, kuba@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        ezequiel.garcia@free-electrons.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: mvneta: fix double free of txq->buf
Date:   Sat,  3 Oct 2020 11:51:21 -0700
Message-Id: <20201003185121.12370-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem:

drivers/net/ethernet/marvell/mvneta.c:3465:2: warning:
  Attempt to free released memory
        kfree(txq->buf);
        ^~~~~~~~~~~~~~~

When mvneta_txq_sw_init() fails to alloc txq->tso_hdrs,
it frees without poisoning txq->buf.  The error is caught
in the mvneta_setup_txqs() caller which handles the error
by cleaning up all of the txqs with a call to
mvneta_txq_sw_deinit which also frees txq->buf.

Since mvneta_txq_sw_deinit is a general cleaner, all of the
partial cleaning in mvneta_txq_sw_deinit()'s error handling
is not needed.

Fixes: 2adb719d74f6 ("net: mvneta: Implement software TSO")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d095718355d3..54b0bf574c05 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3397,24 +3397,15 @@ static int mvneta_txq_sw_init(struct mvneta_port *pp,
 	txq->last_desc = txq->size - 1;
 
 	txq->buf = kmalloc_array(txq->size, sizeof(*txq->buf), GFP_KERNEL);
-	if (!txq->buf) {
-		dma_free_coherent(pp->dev->dev.parent,
-				  txq->size * MVNETA_DESC_ALIGNED_SIZE,
-				  txq->descs, txq->descs_phys);
+	if (!txq->buf)
 		return -ENOMEM;
-	}
 
 	/* Allocate DMA buffers for TSO MAC/IP/TCP headers */
 	txq->tso_hdrs = dma_alloc_coherent(pp->dev->dev.parent,
 					   txq->size * TSO_HEADER_SIZE,
 					   &txq->tso_hdrs_phys, GFP_KERNEL);
-	if (!txq->tso_hdrs) {
-		kfree(txq->buf);
-		dma_free_coherent(pp->dev->dev.parent,
-				  txq->size * MVNETA_DESC_ALIGNED_SIZE,
-				  txq->descs, txq->descs_phys);
+	if (!txq->tso_hdrs)
 		return -ENOMEM;
-	}
 
 	/* Setup XPS mapping */
 	if (txq_number > 1)
-- 
2.18.1

