Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE8284D14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgJFOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82A12220C;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=t45gM+mcpDbpIhRjbW9Zpxht62jX3d9x8Bi3cqTwnL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMGXIwsJKReYrGuE8IXZQnvswFoVHmMkPlnN/xWOLFweyg+s5kMKui3R2EyDy64iG
         Vb0VH9jug1sYe+PTzomkBri7sCkN2ZntQkf1ib+n0P57nb15gnsVI36OA0u3BsD+dm
         PaWjDkbn4JHYGtu9/bbX+ccoRpyU25cqIF0Rjoh8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019GD-KM; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 38/52] docs: block: blk-mq.rst: get rid of :c:type
Date:   Tue,  6 Oct 2020 16:03:35 +0200
Message-Id: <fa7c975d93b5469d875c0584729f8256f7e7998d.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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

