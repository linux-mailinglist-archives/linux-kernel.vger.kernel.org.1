Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67C71A4907
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJRgq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Apr 2020 13:36:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38400 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:36:45 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 40251CED0F;
        Fri, 10 Apr 2020 19:46:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/1] Bluetooth: btrtl: Add support for RTL8761B
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200410145420.108868-2-sztsian@gmail.com>
Date:   Fri, 10 Apr 2020 19:36:44 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, icenowy@aosc.io
Content-Transfer-Encoding: 8BIT
Message-Id: <5CD9EBAA-44A6-4DFF-870E-4F862FB7A60E@holtmann.org>
References: <20200410145420.108868-1-sztsian@gmail.com>
 <20200410145420.108868-2-sztsian@gmail.com>
To:     sztsian@gmail.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zamir,

> Add new compatible device RTL8761B.
> 
> Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
> ---
> drivers/bluetooth/btrtl.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)

can you also please include the content of /sys/kernel/debug/usb/devices for this device in the commit message.

And if you run btmon before plugging it in, I like to see what LE Features of Bluetooth 5.0 this dongle really offers.

Regards

Marcel

