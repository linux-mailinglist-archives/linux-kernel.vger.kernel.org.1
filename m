Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB391C9AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgEGTVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEGTVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:21:03 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F31E208D6;
        Thu,  7 May 2020 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879263;
        bh=XUSgEf5VZATk0joVHorJH82G4LKTsH9YORMcTuWgJx8=;
        h=Date:From:To:Cc:Subject:From;
        b=Q8PwtStoHbdOuAaPWapaZFjOpEN4+JXmLzJX1OYFdzrC1imgwk06ONtWGz4TkBs83
         n8WkInB+Vxz7lJYZE7bbeGb3a/xoYkT/uMZR4V+6TyRoBGJeE79PwQztKcvR4jwra+
         iI1/rhm+ghX7KpWAd4y9Mv95PZlRAdHXmHLE6t1Q=
Date:   Thu, 7 May 2020 14:25:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Dubov <oakad@yahoo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tifm: Replace zero-length array with flexible-array
Message-ID: <20200507192529.GA16602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/tifm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tifm.h b/include/linux/tifm.h
index 299cbb8c63bb..44073d06710f 100644
--- a/include/linux/tifm.h
+++ b/include/linux/tifm.h
@@ -124,7 +124,7 @@ struct tifm_adapter {
 	int                 (*has_ms_pif)(struct tifm_adapter *fm,
 					  struct tifm_dev *sock);
 
-	struct tifm_dev     *sockets[0];
+	struct tifm_dev     *sockets[];
 };
 
 struct tifm_adapter *tifm_alloc_adapter(unsigned int num_sockets,

