Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8E28CD97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgJMMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD033223BE;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=t45gM+mcpDbpIhRjbW9Zpxht62jX3d9x8Bi3cqTwnL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCgZmZBxgLCu3fdDZnpzDgBmy6nqCFTaMTZPRgNnjJM3vy66WHen1L7nn5bygSQ1e
         WIgNm/3YUj56EXbbRylRa0pxYBbD5YkyNLF0M7zEKf38QZChHkMsFM4Mqsah8srY0S
         a1Bl//yaEc2nIjNTLUbqdNJLz7MZsRYh/5b8EPAM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUv-OV; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 38/80] docs: block: blk-mq.rst: get rid of :c:type
Date:   Tue, 13 Oct 2020 13:53:53 +0200
Message-Id: <85f98f7db048f519941cc13ebf023bd698418041.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :c:type macros are not used properly there, as reported
by Sphinx 3:

	./Documentation/block/blk-mq.rst:112: WARNING: Unparseable C cross-reference: 'hctx->dispatch'
	Invalid C declaration: Expected end of definition. [error at 4]
	  hctx->dispatch
	  ----^

Also, they won't be generating any cross references.

So, replace them by a literal markup.

Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/block/blk-mq.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index 86a632af02b0..a980d23af48c 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -110,9 +110,9 @@ block layer removes requests from the associated software queues and tries to
 dispatch to the hardware.
 
 If it's not possible to send the requests directly to hardware, they will be
-added to a linked list (:c:type:`hctx->dispatch`) of requests. Then,
+added to a linked list (``hctx->dispatch``) of requests. Then,
 next time the block layer runs a queue, it will send the requests laying at the
-:c:type:`dispatch` list first, to ensure a fairness dispatch with those
+``dispatch`` list first, to ensure a fairness dispatch with those
 requests that were ready to be sent first. The number of hardware queues
 depends on the number of hardware contexts supported by the hardware and its
 device driver, but it will not be more than the number of cores of the system.
-- 
2.26.2

