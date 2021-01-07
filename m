Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256932ECB3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbhAGHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:54:02 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36045 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbhAGHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:54:00 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B4DE923078;
        Thu,  7 Jan 2021 08:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610005998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRJxPCoYY1H+X4Bfb0nP87rLPUenjBlcO2PCfMDSqRY=;
        b=HLraEko9bHXT/CPT9zsiAhmh2dJbi/vEPDx+ep1UDmjPSuBoDC5UMWpnRDv3gwslzxQD7w
        yOncpYzTaN9shDTqiQV9yb7Ju5/3fgMRpvAkIJIsoj40I8HzShwLijVV0bcSrsTf0g3WSI
        3DJKghXr9WuIraAR/W7eKNRHylvwjwI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 08:53:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rai Harninder <harninder.rai@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix the offset of the reset register
In-Reply-To: <20210107064046.GF28365@dragon>
References: <20201215212622.717-1-michael@walle.cc>
 <20210107064046.GF28365@dragon>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <502fecda4d7f0d85e3417d16748e22f5@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Am 2021-01-07 07:40, schrieb Shawn Guo:
> On Tue, Dec 15, 2020 at 10:26:22PM +0100, Michael Walle wrote:
>> The offset of the reset request register is 0, the absolute address is
>> 0x1e60000. Boards without PSCI support will fail to perform a reset:
>> 
>> [   26.734700] reboot: Restarting system
>> [   27.743259] Unable to restart system
>> [   27.746845] Reboot failed -- System halted
>> 
>> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Out of curiosity, how did you get it fixed with your commit 
> 3f0fb37b22b4
> ("arm64: dts: ls1028a: fix reboot node") in the first place?

I simply must have missed it. There is also a fallback reset method
via the watchdog in the chain, which kicks in if this wasn't successful.
So if you test it, it is easy to think its working although its not.

-michael
