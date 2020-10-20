Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CF28CD38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgJML5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbgJMLyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:47 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 508B02250F;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=L0MoMDTN62qRhpslEEZOFn0QRHyIMGhLOJw+1iFPJ6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgsYgqGIm1fbuEqoShM4CkmBLbcRIPXpsJY90QAEPgyfe2DBVut/FiQXsiSBILyig
         jlO0Zno4C9COsE5QobThFdLO3ZABaQba5TypOb5q2BLfoC4Bukma6xRaVpsmSGGeoq
         aaMGTJHTFlXr1ohANdhP61OGUmTW5g18TDFtw8ZI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CW1-Da; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 60/80] block: bio: fix a warning at the kernel-doc markups
Date:   Tue, 13 Oct 2020 13:54:15 +0200
Message-Id: <6335319667220b747c06494f3a229598c51b24e7.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
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
index e865ea55b9f9..cee87a9ff799 100644
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

