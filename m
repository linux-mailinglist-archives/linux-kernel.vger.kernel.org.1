Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53462AEE29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKKJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:54:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46668 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:54:01 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3426DCECFA;
        Wed, 11 Nov 2020 11:01:08 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [Resend v1] Bluetooth: hci_qca: Enhance retry logic in qca_setup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1605071653-5088-1-git-send-email-bgodavar@codeaurora.org>
Date:   Wed, 11 Nov 2020 10:53:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        seanpaul@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        rjliao@codeaurora.org
Content-Transfer-Encoding: 7bit
Message-Id: <39C5224B-C574-4D19-A6D5-F3CECD1ADB66@holtmann.org>
References: <1605071653-5088-1-git-send-email-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> Currently driver only retries to download FW if FW downloading
> is failed. Sometimes observed command timeout for version request
> command, if this happen on some platforms during boot time, then
> a reboot is needed to turn ON BT. Instead to avoid a reboot, now
> extended retry logic for version request command too.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++----------------
> 1 file changed, 18 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

