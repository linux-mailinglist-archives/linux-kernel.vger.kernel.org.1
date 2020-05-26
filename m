Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FA51C9972
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgEGSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGSja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:39:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F37208E4;
        Thu,  7 May 2020 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588876770;
        bh=VeEp+7ElE8l0tzoN6UVq725ChaSk6ssE/a/96+hHjLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Oka4zgLyWhvs9qPh4nStDKAgEnONj2ECf/9F09hkV0Xao548k88iljJT1ngwc+hlE
         U7s/tIitE60gxPtkPxWqqoqUhrkqocDbfN/yU9A7otmD7UtALJmydj1BohZ+Qnvi1D
         rmj63SjbJBhNLxg0G5qBL1SKdI4ZBowWz+yc9siM=
Date:   Thu, 7 May 2020 13:43:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace zero-length array with flexible-array
Message-ID: <20200507184356.GA13448@embeddedor>
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
 security/apparmor/apparmorfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 280741fc0f5f..299994ff9168 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -839,7 +839,7 @@ static ssize_t query_label(char *buf, size_t buf_len,
 struct multi_transaction {
 	struct kref count;
 	ssize_t size;
-	char data[0];
+	char data[];
 };
 
 #define MULTI_TRANSACTION_LIMIT (PAGE_SIZE - sizeof(struct multi_transaction))

