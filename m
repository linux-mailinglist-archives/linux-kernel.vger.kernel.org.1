Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3012C8C24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgK3SGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgK3SGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:06:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE67206F9;
        Mon, 30 Nov 2020 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606759553;
        bh=LEf4/GBSUYi7Yxi/3jEzeug3u/5guDqeKo5QtUgX5Zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UaDyV4fDfovSb5djP8oXgSWijVIa5cTZ2WVLoOCv0Djh+GjSJ+hv0t14d7H7Y84jN
         fPokKr9+9sRZBny9lPeTiZXhFuh38GE9qYbkLuqnDWO+td2WaFdth/diOn7pkRrTvE
         /1Vi6Dk6sqIb8ztmoTT9GFddL1CuHFooHHBdt2Xs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjnYd-00Em4N-Ff; Mon, 30 Nov 2020 18:05:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 18:05:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
In-Reply-To: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rongwei.wang@linux.alibaba.com, catalin.marinas@arm.com, will@kernel.org, bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com, geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org, michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-30 17:48, Rongwei Wang wrote:

> The interfaces of this module is same as MSR module in user space, and 
> to solve
> the problem that ARM platform has no similar MSR module. Using this 
> interface,
> we did some pressure tests to test the stability and security of MSR 
> driver. The
> test results show that the driver will not cause system panic if 
> various
> illegal values and multithreading concurrent access are passed through 
> the
> interface.

It would certainly help if you described what problem you are trying
to solve here. In general, giving userspace access to random system
registers is a pretty bad idea.

Are you trying to validate a CPU? a hypervisor? Or is it just a fun way
to check how many things you can poke before something catches fire?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
