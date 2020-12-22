Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD292E0A02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgLVMY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:24:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53777 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgLVMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:24:27 -0500
Received: from [172.20.10.2] (tmo-113-220.customers.d1-online.com [80.187.113.220])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94327CED20;
        Tue, 22 Dec 2020 13:31:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Remove duplicate newlines from logging
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <45b260bfe6a3d3c11c48e76dd5de7fa40665154c.camel@perches.com>
Date:   Tue, 22 Dec 2020 13:23:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <81334976-F36B-42B9-8687-4D03E394E657@holtmann.org>
References: <45b260bfe6a3d3c11c48e76dd5de7fa40665154c.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

> The bt_dev_<level> macros already append a newline.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> The "No memory" message could be removed as bt_skb_alloc already does
> a dump_stack() on allocation failure.
> 
> drivers/bluetooth/btusb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

