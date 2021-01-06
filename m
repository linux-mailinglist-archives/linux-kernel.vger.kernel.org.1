Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEE2EBABA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAFHvC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 02:51:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41965 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbhAFHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:51:02 -0500
Received: from marcel-macbook.holtmann.net (p5b3d23d0.dip0.t-ipconnect.de [91.61.35.208])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9FFDECED13;
        Wed,  6 Jan 2021 08:57:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix memleak in qca_controller_memdump
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210102054755.21069-1-dinghao.liu@zju.edu.cn>
Date:   Wed, 6 Jan 2021 08:50:19 +0100
Cc:     kjlu@umn.edu, Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F86FD5AB-6432-4712-AB52-3151F798599E@holtmann.org>
References: <20210102054755.21069-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

> When __le32_to_cpu() fails, qca_memdump should be freed
> just like when vmalloc() fails.
> 
> Fixes: d841502c79e3f ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> drivers/bluetooth/hci_qca.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been to bluetooth-next tree.

Regards

Marcel

