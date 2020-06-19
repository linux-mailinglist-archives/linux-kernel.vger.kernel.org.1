Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF2201944
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgFSRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFSRTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:19:50 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5A4214DB;
        Fri, 19 Jun 2020 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592587190;
        bh=UU6h0Ye5eIxC7LueL8AYqU7mot8kZdliXuGlk2DiP0M=;
        h=Date:From:To:Cc:Subject:From;
        b=GQsI0Q9wfEmvoWW++btFeKUl2SOze4JhxLrZzB+AsI5xJbGQ1jIiIB9uz8bgTpIgX
         3V323vrb5AYbd5Tck7ypW7k/c+jmZ+6NNbR7WfG4gqUWXlM2iHLPuOKRGTTrc9yjJm
         w3lRufpR1bq40Hx3cVfje8OIkRoEJfCFN7sL9/cs=
Date:   Fri, 19 Jun 2020 12:25:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] NTB: Use struct_size() helper in devm_kzalloc()
Message-ID: <20200619172514.GA1074@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _struct_size_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ntb/test/ntb_msi_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 99d826ed9c34..7095ecd6223a 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -319,7 +319,6 @@ static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
 static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 {
 	struct ntb_msit_ctx *nm;
-	size_t struct_size;
 	int peers;
 	int ret;
 
@@ -352,9 +351,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 		return ret;
 	}
 
-	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
-
-	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
+	nm = devm_kzalloc(&ntb->dev, struct_size(nm, peers, peers), GFP_KERNEL);
 	if (!nm)
 		return -ENOMEM;
 
-- 
2.27.0

