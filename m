Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5342FA4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405784AbhARP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405648AbhARPZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:25:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31EA8206B2;
        Mon, 18 Jan 2021 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610983483;
        bh=xe8zwdAs5oOqIiJX/sypIYB/hScfzOBO8s8ms7b/orw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YUN6F/h0JVIQc690a0hOxEg0P0nkAdEGtCqiDVl75aaLa/DMDTT+1Bp68uS9c55Uq
         zSx7tOiQT3wMxTko6W8AUUP1O2JcnUiFlHJO3ynYz7kP959PXdSHAzObI92S3KK1ZK
         DUad8lfjw/6pr47fst9Xphk7+dOVXahroGzNOuIWU9lmB2SGKtPHsNd7WOYwoQOSiK
         jg6yHJezEb5pQKWu9PP5Ek5o9JJCA9QFLShpW59q8RmfhzkCWgo7a0LePUcN6yd6GW
         UnRrYOqQ+SgjjOwI+BOD7t5W9VNup4/XOrxuF6pf0OiuqOUK7dD3Qv/9IWQfbMBliQ
         v9ein479sfIJw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
In-Reply-To: <20210118134223.GE12316@pengutronix.de>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
Date:   Mon, 18 Jan 2021 17:24:38 +0200
Message-ID: <87r1miuv2h.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Michael Grzeschik <mgr@pengutronix.de> writes:
> On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
>>Add a new driver for supporting Xilinx platforms. This driver is used
>>for some sequence of operations required for Xilinx USB controllers.
>>This driver is also used to choose between PIPE clock coming from SerDes
>>and the Suspend Clock. Before the controller is out of reset, the clock
>>selection should be changed to PIPE clock in order to make the USB
>>controller work. There is a register added in Xilinx USB controller
>>register space for the same.
>
> I tried out this driver with the vanilla kernel on an zynqmp. Without
> this patch the USB-Gadget is already acting buggy. In the gadget mode,
> some iterations of plug/unplug results to an stalled gadget which will
> never come back without a reboot.
>
> With the corresponding code of this driver (reset assert, clk modify,
> reset deassert) in the downstream kernels phy driver we found out it is
> totaly stable. But using this exact glue driver which should do the same
> as the downstream code, the gadget still was buggy the way described
> above.
>
> I suspect the difference lays in the different order of operations.
> While the downstream code is runing the resets inside the phy driver
> which is powered and initialized in the dwc3-core itself. With this glue
> layser approach of this patch the whole phy init is done before even
> touching dwc3-core in any way. It seems not to have the same effect,
> though.
>
> If really the order of operations is limiting us, we probably need
> another solution than this glue layer. Any Ideas?

might be a good idea to collect dwc3 trace events. Can you do that?

-- 
balbi
