Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8901F88DE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFNNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 09:06:48 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:37648 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgFNNGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:06:48 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 049F91B59A6;
        Sun, 14 Jun 2020 13:06:44 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] MAINTAINERS: move *@vger.kernel.org from M: to L:
Date:   Sun, 14 Jun 2020 15:05:49 +0200
Message-Id: <20200614130549.19309-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..86e9276ddb1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8995,8 +8995,6 @@ F:	drivers/net/ethernet/sgi/ioc3-eth.c
 IOMAP FILESYSTEM LIBRARY
 M:	Christoph Hellwig <hch@infradead.org>
 M:	Darrick J. Wong <darrick.wong@oracle.com>
-M:	linux-xfs@vger.kernel.org
-M:	linux-fsdevel@vger.kernel.org
 L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
@@ -13570,7 +13568,7 @@ F:	arch/mips/include/asm/mach-pistachio/
 F:	arch/mips/pistachio/
 
 PKTCDVD DRIVER
-M:	linux-block@vger.kernel.org
+L:	linux-block@vger.kernel.org
 S:	Orphan
 F:	drivers/block/pktcdvd.c
 F:	include/linux/pktcdvd.h
@@ -18799,7 +18797,6 @@ F:	drivers/xen/*swiotlb*
 
 XFS FILESYSTEM
 M:	Darrick J. Wong <darrick.wong@oracle.com>
-M:	linux-xfs@vger.kernel.org
 L:	linux-xfs@vger.kernel.org
 S:	Supported
 W:	http://xfs.org/
-- 
2.27.0

