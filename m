Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4127B2359A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHBSCd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Aug 2020 14:02:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60382 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:02:31 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 29119CED31;
        Sun,  2 Aug 2020 20:12:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_ldisc/hci_serdev: Cancel init work
 before unregistering
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200801162956.22610-2-samuel@sholland.org>
Date:   Sun, 2 Aug 2020 20:02:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <33FE7F8B-3467-4BC6-B74C-CA7835A4E9CF@holtmann.org>
References: <20200801162956.22610-1-samuel@sholland.org>
 <20200801162956.22610-2-samuel@sholland.org>
To:     Samuel Holland <samuel@sholland.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

> If hci_uart_tty_close() or hci_uart_unregister_device() is called while
> hu->init_ready is scheduled, hci_register_dev() could be called after
> the hci_uart is torn down. Avoid this by ensuring the work is complete
> or canceled before checking the HCI_UART_REGISTERED flag.
> 
> Fixes: 9f2aee848fe6 ("Bluetooth: Add delayed init sequence support for UART controllers")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> drivers/bluetooth/hci_ldisc.c  | 1 +
> drivers/bluetooth/hci_serdev.c | 2 ++
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

