Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52D26331A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgIIQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81FF2224A;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=3KxtUZvOHKiAgK/WciaZ1QFV2+EwOYqo38o2r+Qk3fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dx5xqjFdEG1aeiFpgHF7sSGeYEIqE5ErwYsYZrZBsjQRiLhuwy8P32IVEA4DJxrEk
         FHJYYD/ZJaMOxuu1xAGMk4W6zJyDWswMhIV7+PWZsXPsNAM+rGoG4glsORI4lpgiox
         nwFpm8xIUjQhXjOuPnPRNJ0kxnOcTb82k47ZEBlE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXm-Q8; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] docs: bio: fix a kerneldoc markup
Date:   Wed,  9 Sep 2020 16:10:58 +0200
Message-Id: <1cc3c203d8e954d40030fd0755858c7ac2e890d5.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this warning:

	./block/bio.c:1098: WARNING: Inline emphasis start-string without end-string.

The thing is that *iter is not a valid markup.

That seems to be a typo:
	*iter -> @iter

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ccd3ab549d41..ce9446a7b081 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1093,7 +1093,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * released.
  *
  * The function tries, but does not guarantee, to pin as many pages as
- * fit into the bio, or are requested in *iter, whatever is smaller. If
+ * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-- 
2.26.2

