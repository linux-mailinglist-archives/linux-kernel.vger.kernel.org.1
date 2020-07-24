Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEFB22CB42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 12:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:44:43 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0976B206F0;
        Fri, 24 Jul 2020 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595609082;
        bh=tOZnq81bwOIIjKc5KjWMgaWw7FrtXyqkuw+2Unf+gww=;
        h=Date:From:To:Cc:Subject:From;
        b=KOyr6BxpkkErwrcJG5iwN6kOyAjSdFTjEV/Rvz4dlwvQe/HuydXNKr4Qs6UWpztvi
         9FqME9MCFZpBbidDHuydwX7en4B6M0PBSWC40joJf1VizHZ+6V8PhsZAYEgxeqq+ke
         5JsSsaxFBNEJQPeJQrO9ZYCQj/Yz35g4DWZYWzTc=
Date:   Fri, 24 Jul 2020 11:50:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] crypto: sa2ul - Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200724165027.GA18496@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in sa_dma_init(). The proper pointer
to be passed as argument to PTR_ERR() is dd->dma_tx.

This bug was detected with the help of Coccinelle.

Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/sa2ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index ebcdffcdb686..5bc099052bd2 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2259,7 +2259,7 @@ static int sa_dma_init(struct sa_crypto_data *dd)
 
 	dd->dma_tx = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_tx)) {
-		if (PTR_ERR(dd->dma_rx1) != -EPROBE_DEFER)
+		if (PTR_ERR(dd->dma_tx) != -EPROBE_DEFER)
 			dev_err(dd->dev, "Unable to request tx DMA channel\n");
 		ret = PTR_ERR(dd->dma_tx);
 		goto err_dma_tx;
-- 
2.27.0

