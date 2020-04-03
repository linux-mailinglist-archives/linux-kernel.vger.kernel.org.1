Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8519D059
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgDCGk3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Apr 2020 02:40:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49558 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:40:28 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3EE6DCECF9;
        Fri,  3 Apr 2020 08:50:00 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] bluetooth: hci_bcm: respect IRQ polarity from DT
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
Date:   Fri, 3 Apr 2020 08:40:26 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BF9B8C1D-063C-4CD0-BB6C-E28099F10366@holtmann.org>
References: <d01cfc2df21f016ef6c790e1ed8f3ed933cf5ad3.1585831987.git.mirq-linux@rere.qmqm.pl>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> The IRQ polarity is be configured in bcm_setup_sleep(). Make the
> configured value match what is in the DeviceTree.
> 
> Cc: stable@vger.kernel.org
> Fixes: f25a96c8eb46 ("Bluetooth: hci_bcm: enable IRQ capability from devicetree")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> drivers/bluetooth/hci_bcm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

