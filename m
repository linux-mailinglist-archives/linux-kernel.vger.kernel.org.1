Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B92DEB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgLRVgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:36:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36756 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:36:08 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 89C84CED31;
        Fri, 18 Dec 2020 22:42:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2 2/4] Bluetooth: btqca: Enable MSFT extension for
 Qualcomm WCN399x
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201217145149.v2.2.I188d99e738b39d9ef36110addbc227837d3c42a7@changeid>
Date:   Fri, 18 Dec 2020 22:35:26 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <01C55220-81F0-40CB-B106-AD934BB9D5CE@holtmann.org>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
 <20201217145149.v2.2.I188d99e738b39d9ef36110addbc227837d3c42a7@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miao-chen,

> The following Qualcomm WCN399x Bluetooth controllers support the
> Microsoft vendor extension and they are using 0xFD70 for VsMsftOpCode.
> -WCN3990
> -WCN3991
> -WCN3998
> 
> < HCI Command: ogf 0x3f, ocf 0x0170, plen 1
>  00
>> HCI Event: 0x0e plen 18
>  01 70 FD 00 00 1F 00 00 00 00 00 00 00 04 4D 53 46 54
> 
> The following test step was performed.
> - Boot the device with WCN3991 and verify INFO print in dmesg.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> 
> (no changes since v1)
> 
> drivers/bluetooth/btqca.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

