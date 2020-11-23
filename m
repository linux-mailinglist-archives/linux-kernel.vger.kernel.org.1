Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8682C04F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgKWLvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 06:51:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48542 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgKWLvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:51:50 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 02097CECCF;
        Mon, 23 Nov 2020 12:58:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btmtksdio: Add the missed release_firmware()
 in mtk_setup_firmware()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201117024332.165771-1-jingxiangfeng@huawei.com>
Date:   Mon, 23 Nov 2020 12:51:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, matthias.bgg@gmail.com,
        Mark-YW.Chen@mediatek.com, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9917F51E-C0C5-45AA-903A-DA3C10398F95@holtmann.org>
References: <20201117024332.165771-1-jingxiangfeng@huawei.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing,

> mtk_setup_firmware() misses to call release_firmware() in an error
> path. Jump to free_fw to fix it.
> 
> Fixes: 737cd06072a7 ("Bluetooth: btmtksdio: fix up firmware download sequence")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
> drivers/bluetooth/btmtksdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

