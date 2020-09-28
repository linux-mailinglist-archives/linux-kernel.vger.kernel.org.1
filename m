Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66E27B193
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgI1QOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgI1QOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:14:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91EEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QoFyP4/0BeNzhhOw+8WeyMy5dH0E+MGYDYPx4SWtxXo=; b=aGZf2FYVdMpZFUCVkYRevW4Ha5
        PpsGHcVopVRa1qnyH4CLRX2c0f0pktcDvfS673HL4NFpnbDUGTbPFfu/eywYF9/F8/O6ZoGh/jRvW
        MTYxvRcnumxDyhEovhFCBHAL5Lfq9hJYg2ZpwdwkuJes+cw4+kpEe28q6Wx+5P1jzrXvzRkxFkZIE
        zqT0/JvPDDeoiwwhmsjfLBksbN9Ykb+qhntaUZxPbxAYqBnI2gocNGf8ifO6rEkEEfgayiuAInVL4
        vBunOLvBKhvdhFk7P21s63IYlWxWLj2nLPMECsIQo5GuM37OHZMcCgO+a6fdoudFbPE99d7MkI85W
        gk1KLt1A==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMvn6-00021B-28; Mon, 28 Sep 2020 16:14:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] compat: move strut compat_iovec out of #ifdef CONFIG_COMPAT
Date:   Mon, 28 Sep 2020 18:14:14 +0200
Message-Id: <20200928161414.642727-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoid annoying ifdefs in iov_iter.c

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

This fixes a build failure with the import_iovec / compat_import_iovec
unification.

 include/linux/compat.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 80b9b8cc1cd405..3e3d2beafed312 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -91,6 +91,11 @@
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* COMPAT_SYSCALL_DEFINEx */
 
+struct compat_iovec {
+	compat_uptr_t	iov_base;
+	compat_size_t	iov_len;
+};
+
 #ifdef CONFIG_COMPAT
 
 #ifndef compat_user_stack_pointer
@@ -248,11 +253,6 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
-struct compat_iovec {
-	compat_uptr_t	iov_base;
-	compat_size_t	iov_len;
-};
-
 struct compat_rlimit {
 	compat_ulong_t	rlim_cur;
 	compat_ulong_t	rlim_max;
-- 
2.28.0

