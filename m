Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E72052A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgFWMif convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Jun 2020 08:38:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44919 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732586AbgFWMib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:38:31 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9D8A7CECC5;
        Tue, 23 Jun 2020 14:48:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: fix up firmware download
 sequence
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7d835850c16e07d1346c763900cc8c880182f497.1592588740.git.sean.wang@mediatek.com>
Date:   Tue, 23 Jun 2020 14:38:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7CFF55F1-E90E-49A6-9787-C4279FF538B2@holtmann.org>
References: <7d835850c16e07d1346c763900cc8c880182f497.1592588740.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Data RAM on the device have to be powered on before starting to download
> the firmware.
> 
> v1->v2:
> 	rebased to bluetooth-next
> 
> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
> Co-developed-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

