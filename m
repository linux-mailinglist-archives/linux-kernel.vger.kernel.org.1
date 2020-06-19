Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F92002CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgFSHgX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Jun 2020 03:36:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40484 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:36:23 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 61F19CECF3;
        Fri, 19 Jun 2020 09:46:13 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: fix up firmware download sequence
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
Date:   Fri, 19 Jun 2020 09:36:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1450856E-36E2-4B49-A23A-7BE94669856E@holtmann.org>
References: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
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
> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
> Co-developed-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)

the patch doesn’t apply to bluetooth-next tree.

Regards

Marcel

