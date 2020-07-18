Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E646224827
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 04:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGRCzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgGRCzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:55:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B13C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9XVmt3tMTBJ+DnRqStU6NErngxKBvMZ8OtN1V0XNDpI=; b=h9Dcau0Zju/aBHXacDUS36IT2M
        o11t+ANpxTmOGZ5oQu1nyWgghysUY/ioVIRJRfFXbgctNzEtNHOKhEP29Fza/dRvWrVYZKX5xd7L9
        SqeTv5HUMMrJZS6cnQUzn5ghRbyqkbiYTVBcTUpR5RNby61qWqCheop3ARjC2WQEQgC+AMo6u6lXA
        r3s88QlPq/tj4kK1qB3erQOQrvhp+qEmA3+mVqfSbjOXlNJJN+fOemxnpk4mZhgYQgLmSO+o59YEg
        N7dM+EUHUUoVZ/coKoMi+2O5H2GDHaeJ+b5ibJUE5I633wna8e8lGBppL/9+vd5jY/DR4SPKgBeHW
        cZhNQ7cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwd0C-0006oK-Us; Sat, 18 Jul 2020 02:55:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] clang: linux/compiler-clang.h: drop duplicated word in a
 comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <6a18c301-3505-742f-4dd7-0f38d0e537b9@infradead.org>
Date:   Fri, 17 Jul 2020 19:55:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: clang-built-linux@googlegroups.com
---
 include/linux/compiler-clang.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/compiler-clang.h
+++ linux-next-20200714/include/linux/compiler-clang.h
@@ -40,7 +40,7 @@
 #endif
 
 /*
- * Not all versions of clang implement the the type-generic versions
+ * Not all versions of clang implement the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
  * __has_builtin allowing us to avoid awkward version
  * checks. Unfortunately, we don't know which version of gcc clang

