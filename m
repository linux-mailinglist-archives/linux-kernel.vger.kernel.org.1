Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F739232817
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgG2X37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 19:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgG2X37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:29:59 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DEE2074B;
        Wed, 29 Jul 2020 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596065399;
        bh=soaioZgmViIAvQ3rjdV72K2mdvV/ewVmzrvk4+FNNvQ=;
        h=Date:From:To:Cc:Subject:From;
        b=wu1SMnukBBPBn8HMW/u+hp0BFMgBXRPznml6diVqbdIVBHqzrLbPyEN+dCAueapNT
         ZeEvU+pBqx387i+B/iR4/iGreTgL/KhuhKXHAAINrgvTByQjvbt/HHLoIWrBrYfXlL
         X6Hm4Z1S6OYfR202P1tL/2WgbCaPxbEFfDE/UEzE=
Date:   Wed, 29 Jul 2020 18:35:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: wfx: Use flex_array_size() helper in memcpy()
Message-ID: <20200729233557.GA17693@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer
overflows, while at the same time makes it explicitly clear that
we are dealing with a flexible array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/wfx/hif_tx_mib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_tx_mib.c b/drivers/staging/wfx/hif_tx_mib.c
index 1689cb42acc0..05f1e1e98af9 100644
--- a/drivers/staging/wfx/hif_tx_mib.c
+++ b/drivers/staging/wfx/hif_tx_mib.c
@@ -113,7 +113,7 @@ int hif_set_beacon_filter_table(struct wfx_vif *wvif, int tbl_len,
 	if (!val)
 		return -ENOMEM;
 	val->num_of_info_elmts = cpu_to_le32(tbl_len);
-	memcpy(val->ie_table, tbl, tbl_len * sizeof(*tbl));
+	memcpy(val->ie_table, tbl, flex_array_size(val, ie_table, tbl_len));
 	ret = hif_write_mib(wvif->wdev, wvif->id,
 			    HIF_MIB_ID_BEACON_FILTER_TABLE, val, buf_len);
 	kfree(val);
-- 
2.27.0

