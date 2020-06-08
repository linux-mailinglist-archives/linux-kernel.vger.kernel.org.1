Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5661F142A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgFHIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:09:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38793 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgFHIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:09:48 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id B07F3CEC82;
        Mon,  8 Jun 2020 10:19:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Simplify determination of serial
 clock on/off state from votes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200606095259.1.I0683ea838b69285993c176396349b084562b4e19@changeid>
Date:   Mon, 8 Jun 2020 10:09:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CE71EC88-E49F-4EA6-AB19-7DED9E0A8E0B@holtmann.org>
References: <20200606095259.1.I0683ea838b69285993c176396349b084562b4e19@changeid>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The serial clocks should be on when there is a vote for at least one
> of the clocks (RX or TX), and off when there is no 'on' vote. The
> current logic to determine the combined state is a bit redundant
> in the code paths for different types of votes, use a single
> statement in the common path instead.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> drivers/bluetooth/hci_qca.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

