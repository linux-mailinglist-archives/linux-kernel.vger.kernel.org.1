Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1814D2686E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgINIKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgINIHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:07:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207A621741;
        Mon, 14 Sep 2020 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600070841;
        bh=8HLVqcrLG24LuHbkAerPTQlw7HGp9Xhi3CkEHteC6U8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+iLm9eLgiRzVhpqk9kNorxbFjjeOXf8Mg57Fyp4p9gW4dSuQTecjc20OxujMXBeE
         mIeZzLE/WAOAeub4pXI+VKZS7m/GquV4gSOjM6DTYtscsQlXwX7crWenL1bW9hdvj0
         BSGOElDGxHOTrhs4Bbr98McHRDj0h1XEYsJ8QHWU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHjWB-00BcgG-0P; Mon, 14 Sep 2020 09:07:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 09:07:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
In-Reply-To: <20200914070227.GA4491@BV030612LT>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
 <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
 <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
 <20200914070227.GA4491@BV030612LT>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <b9053e939dea2b67ba9804aec1a110f5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.ciocaltea@gmail.com, robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, afaerber@suse.de, parthiban@linumiz.com, sravanhome@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, pn@denx.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cristian,

On 2020-09-14 08:02, Cristian Ciocaltea wrote:
> Hi Marc,
> 
> On Fri, Sep 11, 2020 at 05:22:41PM +0100, Marc Zyngier wrote:
>> On 2020-09-08 09:20, Cristian Ciocaltea wrote:
>> > This interrupt controller is found in the Actions Semi Owl SoCs (S500,
>> > S700 and S900) and provides support for handling up to 3 external
>> > interrupt lines.
>> >
>> > Each line can be independently configured as interrupt and triggers on
>> > either of the edges or either of the levels. Additionally, each line
>> > can also be masked individually.
>> >
>> > The patch is based on the work started by Parthiban Nallathambi:
>> > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
>> >
>> > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> > [cristi: optimized DT, various fixes/cleanups/improvements]
>> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
>> 
>> Who is the author of these patches? If this is a co-development, 
>> please
>> use the relevant tags. Otherwise, the author of the patch must come as
>> the first SoB.
> 
> I took the authorship for the driver patch, as mentioned in the cover
> letter. So, if I understand correctly, my SoB should be moved on top 
> and
> I assume I also need to drop the related comment line.

Not quite. Please look at Documentation/process/submitting-patches.rst.

If Parthiban and Saravanan haven't authored anything in this patch,
then drop them from the SoB list. If they have contributed to the
patch (which I expect), then their SoB must be preceded by their own
Co-developed-by: tag. To sum it up, it probably should look like:

Co-developed-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Co-developed-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

This is of course an assumption, and you should check it with the
individuals above.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
