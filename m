Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4320D1EEE7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 01:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFDXu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 19:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgFDXuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:50:25 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E69E20872;
        Thu,  4 Jun 2020 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591314625;
        bh=u+5YnwWFFK5nlG26TpFp3tw/TxQAXscErfxMw11kdHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=12DhJ4j7SA82q006esRWoPp6vOrOhNNpd5/SGsziuuG2nsrgWgRBs8X1fCOmSkiu/
         7hDhu5CTTZDufKWiPU3Qabbm39ZYXLl43tsAqzpsKzd7LoHvD7VRvPzHMjJ8ocV2nC
         N6ttocMm+STaxGGsMhocOjVAwE7tSwTk9UiCCVxE=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: attach IO flags to the missing cases
Date:   Thu,  4 Jun 2020 16:50:23 -0700
Message-Id: <20200604235023.1954-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200604235023.1954-1-jaegeuk@kernel.org>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds more IOs to attach flags.

Fixes: d58f2f658159 ("f2fs: add node_io_flag for bio flags likewise data_io_flag")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2f5293eb5e52a..9d40db50cd65a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -702,6 +702,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);
 
+	__attach_io_flag(fio);
 	bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
@@ -888,6 +889,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		__attach_io_flag(fio);
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
-- 
2.27.0.278.ge193c7cf3a9-goog

