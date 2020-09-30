Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7296A27F61C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgI3Xof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgI3Xoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:44:34 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF8520B1F;
        Wed, 30 Sep 2020 23:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601509474;
        bh=wy1S+CEsPYRcZucMXpXSbWzScAiwavtiJrL6dVOZauo=;
        h=From:To:Cc:Subject:Date:From;
        b=Yd7XInGG9w3IjDFxtTiSqiZwOFZFUb+dnuPgSQScs+5WuPjzYtHYQbVx9aKhCJB4u
         uQS7PR5zXixkPE2L1krMVUZs/TCdlO5sR6m7tCetKZyenBgRkrTXUaaojqhWwRq9TO
         kr4HDuApFhv8PWeAZivwacQzcthQU17r+ElNCAeY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH] scripts/spelling.txt: fix malformed entry
Date:   Wed, 30 Sep 2020 16:43:59 -0700
Message-Id: <20200930234359.255295-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

One of the entries has three fields "mistake||correction||correction"
rather than the expected two fields "mistake||correction".  Fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 scripts/spelling.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681e7e2a..feb2efaaa5e6 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -589,7 +589,7 @@ explictly||explicitly
 expresion||expression
 exprimental||experimental
 extened||extended
-exteneded||extended||extended
+exteneded||extended
 extensability||extensibility
 extention||extension
 extenstion||extension
-- 
2.28.0

