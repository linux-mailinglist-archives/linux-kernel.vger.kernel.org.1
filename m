Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3841C9A40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgEGTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:01:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D743A2083B;
        Thu,  7 May 2020 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878072;
        bh=nahneUqYpBDA+fIQmeNNoV4oxPN2jOZllVzWp4NDAEw=;
        h=Date:From:To:Cc:Subject:From;
        b=E87V8uf6OHPsAIuN0PgNMbYm2YBnJAR3V3SWVZro8R9X5W/GrpQljQxHHVCaUNAqs
         F4vdb5SqOpD+wx3uQmifzKWahD8IWCoT4hJCNS16PkuM7zC29rbzwFJJylHgy2YdUF
         uzjjYTju2ipP+Q7naAugPQjBFvN12vH/Yodx6hOc=
Date:   Thu, 7 May 2020 14:05:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pcdp: Replace zero-length array with flexible-array
Message-ID: <20200507190538.GA15601@embeddedor>
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
 drivers/firmware/pcdp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/pcdp.h b/drivers/firmware/pcdp.h
index ce75d1da9e84..e02540571c52 100644
--- a/drivers/firmware/pcdp.h
+++ b/drivers/firmware/pcdp.h
@@ -103,6 +103,6 @@ struct pcdp {
 	u8			creator_id[4];
 	u32			creator_rev;
 	u32			num_uarts;
-	struct pcdp_uart	uart[0];	/* actual size is num_uarts */
+	struct pcdp_uart	uart[];	/* actual size is num_uarts */
 	/* remainder of table is pcdp_device structures */
 } __attribute__((packed));

