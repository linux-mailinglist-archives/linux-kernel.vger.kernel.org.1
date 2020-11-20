Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261952BB41A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbgKTSkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731562AbgKTSkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:16 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D082242B;
        Fri, 20 Nov 2020 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897616;
        bh=wudRPP+wqVsv4+yGObzaOuxmgZG9U6wManSiQKXTp9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk9MEjo79V+BzFEhe/4/27YbZZSwG2D/amMJ2qUK3ttuSO2YOcj1P3+2Hy/2cNjog
         fyWLNx8xun49tk4kv9GB3BCP4uWJMQ0+fvjcA5qB7gRUuuuBtJqGvdT6a+3yoyO+bS
         svMmEQpIOaG+AZ99G/il4YGp9fCcdu94aY1xppW4=
Date:   Fri, 20 Nov 2020 12:40:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 132/141] ubi: Fix fall-through warnings for Clang
Message-ID: <f0e64930fe514c59ff2354b1c17f1341e70366c6.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough pseudo-keyword instead of letting the
code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e85b04e9716b..75b6e98db775 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1353,6 +1353,7 @@ static int bytes_str_to_int(const char *str)
 		result *= 1024;
 		if (endp[1] == 'i' && endp[2] == 'B')
 			endp += 2;
+		fallthrough;
 	case '\0':
 		break;
 	default:
-- 
2.27.0

