Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C21F142D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgFHILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:11:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38869 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgFHILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:11:36 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C87A3CEC82;
        Mon,  8 Jun 2020 10:21:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/3] Bluetooth: hci_qca: Only remove TX clock vote after
 TX is completed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
Date:   Mon, 8 Jun 2020 10:11:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F3FF2C32-8A7A-4970-AC6A-A20467B560AF@holtmann.org>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> qca_suspend() removes the vote for the UART TX clock after
> writing an IBS sleep request to the serial buffer. This is
> not a good idea since there is no guarantee that the request
> has been sent at this point. Instead remove the vote after
> successfully entering IBS sleep. This also fixes the issue
> of the vote being removed in case of an aborted suspend due
> to a failure of entering IBS sleep.
> 
> Fixes: 41d5b25fed0a0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> drivers/bluetooth/hci_qca.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

