Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D55299153
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784339AbgJZPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784330AbgJZPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:42:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B30F223EA;
        Mon, 26 Oct 2020 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726956;
        bh=8zxNZBAeRbUdw6Afzgm/VslFGniJ39IqtKKdnPltv/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CsCfBfJjNMero4wtZLh6oI46/Jc0PUbWnF/HcxV5pcrP1dP8VsKgzMI4o5HcgH/DP
         UP0FRM6mAE7gI9JOAUtz7nSKfzdnndOK7boEpRwW6jrGf0YYKu/1r7+GoOFKHZJJNC
         owX4x4uFggFk6V4e48es5zT9uoBhFGyvO20/4sb8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kX4dm-004N9T-8b; Mon, 26 Oct 2020 15:42:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 15:42:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>, tglx@linutronix.de,
        jason@lakedaemon.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
In-Reply-To: <VE1PR04MB668737DF1DDA6E1007BCA24C8F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
 <31d8971374c261003aee9f4807c8ac8c@kernel.org>
 <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
 <b65acafab54b62a2a22aa942089b8033@kernel.org>
 <VE1PR04MB668737DF1DDA6E1007BCA24C8F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <19b5f5e7bd5e7a41621ecad2239e4bd6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: leoyang.li@nxp.com, linux@rasmusvillemoes.dk, biwen.li@oss.nxp.com, shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, zhiqiang.hou@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 15:06, Leo Li wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: Monday, October 26, 2020 4:23 AM
>> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Cc: Biwen Li (OSS) <biwen.li@oss.nxp.com>; shawnguo@kernel.org;
>> robh+dt@kernel.org; mark.rutland@arm.com; Leo Li <leoyang.li@nxp.com>;
>> Z.q. Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de;
>> jason@lakedaemon.net; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Xiaobo Xie
>> <xiaobo.xie@nxp.com>; linux-arm-kernel@lists.infradead.org; Biwen Li
>> <biwen.li@nxp.com>
>> Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A 
>> external
>> interrupt
>> 
>> On 2020-10-26 09:06, Rasmus Villemoes wrote:
>> > On 26/10/2020 09.44, Marc Zyngier wrote:
>> >> On 2020-10-26 08:01, Biwen Li wrote:
>> >>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>> >>>
>> >>> Add an new IRQ chip declaration for LS1043A and LS1088A
>> >>> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
>> >>> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
>> >>
>> >> Three things:
>> >> - This commit message doesn't describe the bit_reverse change
>> >
>> > Yeah, please elaborate on that, as the RM for 1043 or 1046 doesn't
>> > mention anything about bit reversal for the scfg registers - they
>> > don't seem to have the utter nonsense that is SCFG_SCFGREVCR, but
>> > perhaps, instead of removing it, that has just become a hard-coded
>> > part of the IP.
>> >
>> > Also, IANAL etc., but
>> >
>> >>> +// Copyright 2019-2020 NXP
>> >
>> > really? Seems to be a bit of a stretch.
>> >
>> > At the very least, cc'ing the original author and only person to ever
>> > touch that file would have been appreciated.
>> 
>> Huh. Well spotted. That's definitely not on.
>> NXP people, please talk to your legal department.
> 
> We do have an internal policy to require developer adding/updating NXP
> copyright on non-trivial changes.  I'm not sure if this change should
> be considered trivial, but adding copyright claim on a file without
> prior copyright claims could causing confusion like in this case.

The copyright exists implicitly, and doesn't require a copyright claim
in the file itself. Please talk to your legal department.

> One
> potential solution is to add a more specific description on the NXP
> change together with the copyright claim.  But maybe an easier
> solution is to add Rasmus your Copyright claim first if you are ok
> with it.

That's for Rasmus to decide whether he wants to add such a claim,
given that it exists implicitly. Adding copyright claims for any
odd change you make isn't acceptable either (your changes are already
unambiguously identified in git).

For the time being, I'm not taking any NXP patch carrying additional
copyright update until this is clarified.

         M.
-- 
Jazz is not dead. It just smells funny...
