Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53126333E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgIIRAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEEC221EE;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=bDug0htbPkTs/pWzV7NVGwmuxDPdL8W15RowRtsr554=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQv2sxO0Zsye0NXp8e8i/m2mlH4a/zBs+UbaZSmg8+GubGmhR4KlcQOT59f3DDPaz
         oCTHkIrIM+nOM/RxTwixwrDYTBps0kQqlESbc5dIUPSB5xWI1Tr86xIBy3x8DXdV90
         oKr7jCzvLsLIOxTd6lm+o83rg6E7JZtAWq83pHm8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXK-Ha; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] block: bio: fix a warning at the kernel-doc markups
Date:   Wed,  9 Sep 2020 16:10:49 +0200
Message-Id: <73fb7b91726f95ba038fbff025bdecdc8faaf204.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using "@bio's parent" causes the following waring:
	./block/bio.c:10: WARNING: Inline emphasis start-string without end-string.

The main problem here is that this would be converted into:

	**bio**'s parent

By kernel-doc, which is not a valid notation. It would be
possible to use, instead, this kernel-doc markup:

	``bio's`` parent

Yet, here, is probably simpler to just use an altenative language:

	the parent of @bio

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..ccd3ab549d41 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -327,7 +327,7 @@ static void bio_chain_endio(struct bio *bio)
 /**
  * bio_chain - chain bio completions
  * @bio: the target bio
- * @parent: the @bio's parent bio
+ * @parent: the parent bio of @bio
  *
  * The caller won't have a bi_end_io called when @bio completes - instead,
  * @parent's bi_end_io won't be called until both @parent and @bio have
-- 
2.26.2

