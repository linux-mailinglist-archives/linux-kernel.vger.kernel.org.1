Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF62018FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgFSQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 12:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbgFSQ7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:59:21 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C28420707;
        Fri, 19 Jun 2020 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592585960;
        bh=CMw8A9DYhmJPy04eBNnq+q3NH05G8jtcTOXbCiZ1daU=;
        h=Date:From:To:Cc:Subject:From;
        b=aZ4Gbm8onMoTwXIEA3XpWzxhRUjx3iGxNolRNmFriaN1OXeKRbeRreeU1ek6XYKq0
         2Ake0Jjo2xOZlw4ysIYclVcDMMwPIg0SRlKIIdPIQJG/tgHZwmgW7Nve5+vPbkIOk8
         4sRolR2jjYhR5m3k18K4SxnmD6jSAO26QYhSbEqA=
Date:   Fri, 19 Jun 2020 12:04:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] rapidio: Use struct_size() helper
Message-ID: <20200619170445.GA22641@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the pointer variable type is
changed but the corresponding sizeof that is passed as argument is not.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/rapidio/rio-scan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index eb8ed28533f8..19b0c33f4a62 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -330,7 +330,7 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 	size_t size;
 	u32 swpinfo = 0;
 
-	size = sizeof(struct rio_dev);
+	size = sizeof(*rdev);
 	if (rio_mport_read_config_32(port, destid, hopcount,
 				     RIO_PEF_CAR, &result))
 		return NULL;
@@ -338,10 +338,8 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 	if (result & (RIO_PEF_SWITCH | RIO_PEF_MULTIPORT)) {
 		rio_mport_read_config_32(port, destid, hopcount,
 					 RIO_SWP_INFO_CAR, &swpinfo);
-		if (result & RIO_PEF_SWITCH) {
-			size += (RIO_GET_TOTAL_PORTS(swpinfo) *
-				sizeof(rswitch->nextdev[0])) + sizeof(*rswitch);
-		}
+		if (result & RIO_PEF_SWITCH)
+			size += struct_size(rswitch, nextdev, RIO_GET_TOTAL_PORTS(swpinfo));
 	}
 
 	rdev = kzalloc(size, GFP_KERNEL);
-- 
2.27.0

