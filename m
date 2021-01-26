Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76EA30436E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404682AbhAZQKh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 11:10:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43135 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404348AbhAZQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:10:24 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1D647CECEE;
        Tue, 26 Jan 2021 17:17:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v5] Bluetooth: btrtl: Enable WBS for the specific Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210126100038.1278-1-max.chou@realtek.com>
Date:   Tue, 26 Jan 2021 17:09:38 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>,
        Hilda Wu <hildawu@realtek.com>, kidman@realtek.com,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        josephsih@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5293C931-4C34-4060-BA12-3BACEDBB2D19@holtmann.org>
References: <20210126100038.1278-1-max.chou@realtek.com>
To:     max.chou@realtek.com
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

> By this change, it will enable WBS supported on the specific Realtek BT
> devices, such as RTL8822C and RTL8852A.
> In the future, it's able to maintain what the Realtek devices support WBS
> here.
> 
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> ---
> change in v5
> -remove the extra space between "enum" and "btrtl_chip_id"
> ---
> drivers/bluetooth/btrtl.c | 29 +++++++++++++++++++++++------
> 1 file changed, 23 insertions(+), 6 deletions(-)

  CC      drivers/bluetooth/btrtl.o
drivers/bluetooth/btrtl.c: In function ‘btrtl_setup_realtek’:
drivers/bluetooth/btrtl.c:754:1: warning: label ‘done’ defined but not used [-Wunused-label]
  754 | done:
      | ^~~~

Regards

Marcel

