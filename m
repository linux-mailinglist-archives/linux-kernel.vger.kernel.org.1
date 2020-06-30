Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2044320F9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbgF3Qzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Jun 2020 12:55:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43189 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389308AbgF3Qzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:55:31 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8CF1ACECEE;
        Tue, 30 Jun 2020 19:05:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: btusb: USB alternate setting 1 for WBS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200630130940.14339-1-hildawu@realtek.com>
Date:   Tue, 30 Jun 2020 18:55:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <5A548628-4B7E-4E25-A728-B1CD06C28F39@holtmann.org>
References: <20200630130940.14339-1-hildawu@realtek.com>
To:     hildawu@realtek.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilda,

> RTL8822CE supports transparent WBS to apply USB alternate setting 1.
> Add a flag to the device match data to apply alternate setting 1 which
> meet the transfer speed for WBS support.
> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Changes in v2:
> - More descriptive commit log and short description.
> - Use BTUSB_USE_ALT1_FOR_WBS replace BTUSB_WBS_ALT1 for descriptive name.
> - Move alternate setting 1 check into the btusb_probe() function and adjust position of data->isoc for alternate setting check.
> ---
> ---
> drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++--------------
> 1 file changed, 20 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

