Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADE1C99D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgEGSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:51:18 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4772495A;
        Thu,  7 May 2020 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877478;
        bh=L0VEbUO8P2KzD3taHO1ZE9aaps2D2j4hy8aw9xAbqsc=;
        h=Date:From:To:Cc:Subject:From;
        b=aOXCmE3NDqY39CeeqSZiYnHO2I1LxTNnvYPimYpid5Yo0qbFLbwcWEwTaSC23759l
         4LHz1c8rqUQw6xE3H+79rIh8ucFOc468Z7dr3tznt21qobwh0FZ+bMK0QelUZ68uKx
         cyoHrfCcuLXYA2DJK4AoZju2vb8dAhEpdM33zZ3k=
Date:   Thu, 7 May 2020 13:55:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ibft: Replace zero-length array with flexible-array
Message-ID: <20200507185544.GA14695@embeddedor>
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
 drivers/firmware/iscsi_ibft.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 96758b71a8db..7127a04bca19 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -104,7 +104,7 @@ struct ibft_control {
 	u16 tgt0_off;
 	u16 nic1_off;
 	u16 tgt1_off;
-	u16 expansion[0];
+	u16 expansion[];
 } __attribute__((__packed__));
 
 struct ibft_initiator {

