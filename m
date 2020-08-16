Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B272459DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgHPWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHPWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:25:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F9C061786;
        Sun, 16 Aug 2020 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XIifC/ioWLaGpjm93KaooL2kfflJK3etI8ZyvZX/N+M=; b=jWaJCEjlOzSoo4R3a6gZaDn0do
        KQIxnhQOsz+OIABUU/xoxm+KefUgG0IB0dkOPN16toztN9P73LkCYIcj+BxbXES5csKhIwgc++Nbg
        pwcah1eWYtR21RSURd0OMOEY637+ph4jjNqCh3TXtZpXolpsdyLzpYaYSow4G//ZZHY15c2MarA+t
        2QnUeMGTK0gkmy+JMLOq7UZ7K7E5b/RitzVbrszREN+5FHPG15njagSMScWhLhuJDgFfmOJ48F8//
        CMRgIpnxneiPfUY296FOX3ecNckLwyAtdIcj0lgi1aWTtlRrScJLTbEViPfg2ZuKvw5zZRQJTxjgu
        s3185uHg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7R5g-0002Nl-TS; Sun, 16 Aug 2020 22:25:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: blk-mq.c: fix @at_head kernel-doc warning
Date:   Sun, 16 Aug 2020 15:25:19 -0700
Message-Id: <20200816222519.313-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a new kernel-doc warning in block/blk-mq.c:

../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'

Fixes: 105663f73e71 ("blk-mq: Document functions for sending request")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: André Almeida <andrealmeid@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-mq.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-59-rc1.orig/block/blk-mq.c
+++ lnx-59-rc1/block/blk-mq.c
@@ -1834,6 +1834,7 @@ void __blk_mq_insert_request(struct blk_
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
+ * @at_head: true if the request should be inserted at the head of the list.
  * @run_queue: If we should run the hardware queue after inserting the request.
  *
  * Should only be used carefully, when the caller knows we want to
