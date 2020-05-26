Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8471C9AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgEGTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgEGTVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:21:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163A521835;
        Thu,  7 May 2020 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879268;
        bh=qh1j1EPgFp9gEO4yUol6TFAoaToJnGzXm0ToAUgd8vA=;
        h=Date:From:To:Cc:Subject:From;
        b=juFTsTqegvq3Bv4Q2LiuA8DtFUy8o/PXwJhVFoG153XAwDnoyikkW75jBlGZ+d+3i
         SXYGKQVIOEPhhnUxU7c8JHjgnxHDcQ5yn74TK1z4ZjBNJ41QTvPbw64yHFwFtQ7lhs
         6NmDIyesKEngYmbeZtxRFwUKpa+PiBIRYDPhtPC0=
Date:   Thu, 7 May 2020 14:25:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: Replace zero-length array with flexible-array
Message-ID: <20200507192535.GA16622@embeddedor>
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
 drivers/soc/ti/knav_qmss.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 038aec352df7..a01eda720bf6 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -67,7 +67,7 @@ struct knav_reg_config {
 	u32		link_ram_size0;
 	u32		link_ram_base1;
 	u32		__pad2[2];
-	u32		starvation[0];
+	u32		starvation[];
 };
 
 struct knav_reg_region {

