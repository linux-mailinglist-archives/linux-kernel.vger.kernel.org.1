Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF7C2DEB29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgLRVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:35:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53279 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLRVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:35:39 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 435A7CED33;
        Fri, 18 Dec 2020 22:42:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v2 3/4] Bluetooth: btusb: Enable MSFT extension for Intel
 controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201217145149.v2.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
Date:   Fri, 18 Dec 2020 22:34:57 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FDE8B383-FDC5-46ED-8389-89F8B90ED850@holtmann.org>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
 <20201217145149.v2.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miao-chen,

> The Intel JeffersonPeak, HarrisonPeak and CyclonePeak Bluetooth
> controllers support the Microsoft vendor extension and they are using
> 0xFC1E for VsMsftOpCode.
> 
> < HCI Command: Vendor (0x3f|0x001e) plen 1
>        00
>> HCI Event: Command Complete (0x0e) plen 15
>      Vendor (0x3f|0x001e) ncmd 1
>        Status: Success (0x00)
>        00 3f 00 00 00 00 00 00 00 01 50
> 
> The following test step was performed.
> - Boot the test devices with HarrisonPeak and verify INFO print in
> dmesg.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> 
> (no changes since v1)
> 
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

