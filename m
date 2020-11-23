Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91CF2C04E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgKWLvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:51:01 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37654 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgKWLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:51:00 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA0D9CECCF;
        Mon, 23 Nov 2020 12:58:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btusb: Add the missed release_firmware() in
 btusb_mtk_setup_firmware()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201117025917.168761-1-jingxiangfeng@huawei.com>
Date:   Mon, 23 Nov 2020 12:50:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Mark-YW.Chen@mediatek.com,
        sean.wang@mediatek.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A007F42C-8A60-4E8B-A1D0-72C9DEF0FD69@holtmann.org>
References: <20201117025917.168761-1-jingxiangfeng@huawei.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing,

> btusb_mtk_setup_firmware() misses to call release_firmware() in an error
> path. Jump to err_release_fw to fix it.
> 
> Fixes: f645125711c8 ("Bluetooth: btusb: fix up firmware download sequence")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

