Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70741C99B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEGSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:48:36 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FF521BE5;
        Thu,  7 May 2020 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877315;
        bh=eVID7GhEbcf0/8Q5jvZMrtErhyUthXxPmrIJvJbk/+0=;
        h=Date:From:To:Cc:Subject:From;
        b=oGR62nntwkq79FCOWn7nFoj1c0oW3WjNOnphBMx4Dq82vtNhdigMNzMmLyQFKEC83
         A0ZA+AbFawVcm9ae2RIV9vD6RbaS17vFxeyDGH+RbBTdnEKlmiLAfrz2jskEv5bsuF
         6mfzbK2eQ9T3AzL1Kjk8CeWEw057BF+M6M44vK6w=
Date:   Thu, 7 May 2020 13:53:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: Replace zero-length array with flexible-array
Message-ID: <20200507185301.GA14333@embeddedor>
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
 include/linux/fsl/bestcomm/bestcomm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fsl/bestcomm/bestcomm.h b/include/linux/fsl/bestcomm/bestcomm.h
index a0e2e6b19b57..154e541ce57e 100644
--- a/include/linux/fsl/bestcomm/bestcomm.h
+++ b/include/linux/fsl/bestcomm/bestcomm.h
@@ -27,7 +27,7 @@
  */
 struct bcom_bd {
 	u32	status;
-	u32	data[0];	/* variable payload size */
+	u32	data[];	/* variable payload size */
 };
 
 /* ======================================================================== */

