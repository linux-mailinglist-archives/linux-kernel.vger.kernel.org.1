Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438D2201905
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgFSRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbgFSRDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:03:19 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729BE20707;
        Fri, 19 Jun 2020 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592586198;
        bh=L17dXPmuNlCLuhUupfHZeKfAGhXDukgs88cXcfbXs0c=;
        h=Date:From:To:Cc:Subject:From;
        b=sc5f8P516WieS+1vxXmn/W06s7vLO4x+wv4jTbrH7xr5ooBJ4Fox0NvduzeJlT891
         bzSmv6CvUf/aL+VXd+nb+eXWl3qoUWgIrBxj6wyJgV3naThzZ84LV6s93W8yq8QO1v
         bFJDpOfdAQXbS+RTeZKOsCXRwxkK61Wpo/Sfinfs=
Date:   Fri, 19 Jun 2020 12:08:43 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] rapidio: rio_mport_cdev: Use struct_size() helper
Message-ID: <20200619170843.GA24923@embeddedor>
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

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 451608e960a1..3abbba8c2b5b 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1710,8 +1710,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 	if (rval & RIO_PEF_SWITCH) {
 		rio_mport_read_config_32(mport, destid, hopcount,
 					 RIO_SWP_INFO_CAR, &swpinfo);
-		size += (RIO_GET_TOTAL_PORTS(swpinfo) *
-			 sizeof(rswitch->nextdev[0])) + sizeof(*rswitch);
+		size += struct_size(rswitch, nextdev, RIO_GET_TOTAL_PORTS(swpinfo));
 	}
 
 	rdev = kzalloc(size, GFP_KERNEL);
-- 
2.27.0

