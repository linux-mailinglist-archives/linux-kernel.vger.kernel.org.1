Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B92224818
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 04:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGRCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 22:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:52:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4193C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ULznKBPlWXTOA+zf1n5CkDMDVEkpNikCbcBnHTq70GI=; b=yenpLLdq8M26PgVPIQbGZ0KSgZ
        y8aYE9ppIi1uW5LUOX8Qbq3WHPnoYOim0uGvAuGWDgJLWI5Q9RVl/Z+fkTuAtx/HfBo+UBXj4YDxZ
        loiT4T2jhXo/613SjOrEQekjScCu4F/1HDhKErDcHqwjIvwjm3g0v0eeIjztrjgcdYLCv7L19gwFX
        NwNOrcefD09lsfNcAT/kJxn/Q+1iKX/OPa4Eug0c6CAbY4xE3w8UsN9k9aBXKpn8lOgseVM3gdiOv
        4TmEvq+P5jzuL6+DG5sTto/5Cl9M7j0oqO9zIZS1AK6TAUAaXQqQWyJ5MicZhB6OWWSCzXHMb2C/2
        ccys/yhw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcx5-0006gV-R8; Sat, 18 Jul 2020 02:51:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] frontswap: linux/frontswap.h: drop duplicated word in a
 comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <3af7ed91-ad62-8445-40a4-9e07a64b9523@infradead.org>
Date:   Fri, 17 Jul 2020 19:51:48 -0700
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

Drop the doubled word "in" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/frontswap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/frontswap.h
+++ linux-next-20200714/include/linux/frontswap.h
@@ -10,7 +10,7 @@
 /*
  * Return code to denote that requested number of
  * frontswap pages are unused(moved to page cache).
- * Used in in shmem_unuse and try_to_unuse.
+ * Used in shmem_unuse and try_to_unuse.
  */
 #define FRONTSWAP_PAGES_UNUSED	2
 

