Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4916F1A8605
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440784AbgDNQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440372AbgDNQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50535221F9;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=flQ66rWLqLJ9tP/xDtQuASEFxj/jeRx5dEzURVCNupI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0JY4DW9t2PKzK1LpWDCW4AhW1GDqNINIMiwomqLyT1rVVNZ4kR45t6n4W80bAwV1
         +YD8udW+6wogJ4b6qNd1fHABzBwHnKQBsXn5nvAe6ML/TXErwq6tzA/Ob2S28hRhEM
         mGB51bHwj54EjaDIXfZtSGyY+ODXdGoe9g2mcIR8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068nT-IZ; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH v2 32/33] futex: get rid of a kernel-docs build warning
Date:   Tue, 14 Apr 2020 18:48:58 +0200
Message-Id: <57788af7889161483e0c97f91c079cfb3986c4b3.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust whitespaces and blank lines in order to get rid of this:

	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/futex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index b59532862bc0..b4b9f960b610 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -486,10 +486,13 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * The key words are stored in @key on success.
  *
  * For shared mappings (when @fshared), the key is:
+ *
  *   ( inode->i_sequence, page->index, offset_within_page )
+ *
  * [ also see get_inode_sequence_number() ]
  *
  * For private mappings (or when !@fshared), the key is:
+ *
  *   ( current->mm, address, 0 )
  *
  * This allows (cross process, where applicable) identification of the futex
-- 
2.25.2

