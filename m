Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1126BFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIPIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgIPIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:51:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0760208E4;
        Wed, 16 Sep 2020 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600246276;
        bh=KW3/g7BAIMnFaj7E3IiooHnGIsgdMNc+XdCPiC3BoXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/ARG8qnWbc7qqaonuGTy3bo/TX6m7TAs8sJ7sS4zzhHQAKkxMJ2070K0lZRZBdul
         XzL2kFk1B3r22UoC8Uwar9tInxzzgONXRoopwnDmECRNRNWD4hJ0ksvzdKb6WEULXE
         NIil94B1EnH0HaM9uZtgcPijH5SSdCaJi7/FjWSI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIT9l-00CJ8a-WC; Wed, 16 Sep 2020 09:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 09:51:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH 0/6] irqchip: Hybrid probing
In-Reply-To: <20200915211354.GA2469362@bogus>
References: <20200912125148.1271481-1-maz@kernel.org>
 <20200915211354.GA2469362@bogus>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <cd0a52739dcb3b238a1c600d46cad711@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, enric.balletbo@collabora.com, linux@fw-web.de, john.stultz@linaro.org, saravanak@google.com, hanks.chen@mediatek.com, agross@kernel.org, bjorn.andersson@linaro.org, matthias.bgg@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, frowand.list@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 22:13, Rob Herring wrote:
> On Sat, Sep 12, 2020 at 01:51:42PM +0100, Marc Zyngier wrote:
>> A recent attempt at converting a couple of interrupt controllers from
>> early probing to standard platform drivers have badly failed, as it
>> became evident that although an interrupt controller can easily probe
>> late, device drivers for the endpoints connected to it are rarely
>> equipped to deal with probe deferral. Changes were swiftly reverted.
>> 
>> However, there is some value in *optionally* enabling this, if only
>> for development purposes, as there is otherwise a "chicken and egg"
>> problem, and a few people (cc'd) are working on a potential solution.
>> 
>> This short series enables the infrastructure for modular building
>> whilst retaining the usual early probing for monolithic build, and
>> introduces it to the three drivers that were previously made to probe
>> as platform drivers.
> 
> I hardly expected more OF_DECLARE macros when I opened this up. Given
> desires to get rid of them, I don't think adding to it is the way
> forward. That wrapping a platform driver around OF_DECLARE looks pretty
> horrible IMO.

Nobody said it was cute. It's a band aid that allows us to move from the
status-quo that exists today. How would you propose we allow people to
go and start "fixing" drivers if you don't give them the opportunity
to even start trying?

> I browsed some of the discussion around this. It didn't seem like it's
> a large number of drivers that have to be fixed to defer probe
> correctly. Am I missing something?

Well, that was enough drivers for the two platforms that had it enabled
to break horribly, without a way to go back to a working state. Do you
find that acceptable? I don't.

> I'd rather keep the pressure on getting fw_devlink on by default.

So far, fw_devlink breaks everything under the sun, even without modular
irqchips. Most of my systems fail to boot if I enable it. So yes, it
really needs some work. And this series allows this work to happen.

         M.
-- 
Jazz is not dead. It just smells funny...
