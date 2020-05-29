Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16AA1E7C21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgE2Llm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 May 2020 07:41:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55870 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2Llm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:41:42 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5BCECCECD3;
        Fri, 29 May 2020 13:51:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: btmtkuart: Improve exception handling in
 btmtuart_probe()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200529022726.917826-1-hslester96@gmail.com>
Date:   Fri, 29 May 2020 13:41:40 +0200
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <73E264F7-E38D-4E25-A78F-DC13A89B00A0@holtmann.org>
References: <20200529022726.917826-1-hslester96@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuhong,

> Calls of the functions clk_disable_unprepare() and hci_free_dev()
> were missing for the exception handling.
> Thus add the missed function calls together with corresponding
> jump targets.
> 
> Fixes: 055825614c6b ("Bluetooth: btmtkuart: add an implementation for clock osc property")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>  - Modify description.
>  - Add fixes tag.
> 
> drivers/bluetooth/btmtkuart.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

