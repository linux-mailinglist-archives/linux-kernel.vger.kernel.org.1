Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC12303BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgG1HRs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Jul 2020 03:17:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53580 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG1HRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:17:48 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id A4312CECCE;
        Tue, 28 Jul 2020 09:27:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_serdev: Only unregister device if it
 was registered
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200721103652.2.I8a2fdad30d42399fa5afc15d66b460d1738c3946@changeid>
Date:   Tue, 28 Jul 2020 09:17:46 +0200
Cc:     Ian Molton <ian@mnementh.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1D8C4C03-727F-4CC4-9FC9-6355A6C778FC@holtmann.org>
References: <20200721103652.1.Idbc7eddf1f24f750a8bbcbc8e06743736ae3be31@changeid>
 <20200721103652.2.I8a2fdad30d42399fa5afc15d66b460d1738c3946@changeid>
To:     Nicolas Boichat <drinkcat@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> We should not call hci_unregister_dev if the device was not
> successfully registered.
> 
> Fixes: c34dc3bfa7642fd ("Bluetooth: hci_serdev: Introduce hci_uart_unregister_device()")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> ---
> 
> drivers/bluetooth/hci_serdev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

