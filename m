Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E901D1F143C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgFHINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:13:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47544 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgFHINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:13:23 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id D8119CEC82;
        Mon,  8 Jun 2020 10:23:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Skip serdev wait when no transfer
 is pending
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
Date:   Mon, 8 Jun 2020 10:13:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <140F7A9E-C336-4894-B94A-7ABC687B3EC3@holtmann.org>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> qca_suspend() calls serdev_device_wait_until_sent() regardless of
> whether a transfer is pending. While it does no active harm since
> the function should return immediately it makes the code more
> confusing. Add a flag to track whether a transfer is pending and
> only call serdev_device_wait_until_sent() is needed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> drivers/bluetooth/hci_qca.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

