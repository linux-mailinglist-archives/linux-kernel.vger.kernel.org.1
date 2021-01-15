Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A282F7964
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbhAOMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbhAOMfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:35:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37DA2236FB;
        Fri, 15 Jan 2021 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610714096;
        bh=rSih70okvAofANG/VIkYzxE2fl9zFMm++0vCfDGt0EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOF0UgUmm5MmUwvWVAvlx/yyzJpt8aEvdgfn59Ayy9VAnG9TJyB+Yv5Y6lICUsfws
         AjVsLGtCVqanHGvSuE3E4SlJUimbx5NQtEIdTrRWjPAoNgZO8sBOGdn5K3cBLJLxkd
         Nwa74iLF7eI7pcB05gjGF3s/9r2xoWuVhVLvZhVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.4 43/62] dmaengine: mediatek: mtk-hsdma: Fix a resource leak in the error handling path of the probe function
Date:   Fri, 15 Jan 2021 13:28:05 +0100
Message-Id: <20210115122000.478035318@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115121958.391610178@linuxfoundation.org>
References: <20210115121958.391610178@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 33cbd54dc515cc04b5a603603414222b4bb1448d upstream.

'mtk_hsdma_hw_deinit()' should be called in the error handling path of the
probe function to undo a previous 'mtk_hsdma_hw_init()' call, as already
done in the remove function.

Fixes: 548c4597e984 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20201219124718.182664-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/mediatek/mtk-hsdma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1007,6 +1007,7 @@ static int mtk_hsdma_probe(struct platfo
 	return 0;
 
 err_free:
+	mtk_hsdma_hw_deinit(hsdma);
 	of_dma_controller_free(pdev->dev.of_node);
 err_unregister:
 	dma_async_device_unregister(dd);


