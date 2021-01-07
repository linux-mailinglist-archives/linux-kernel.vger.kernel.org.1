Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6382ECBDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbhAGIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:44:14 -0500
Received: from mout01.posteo.de ([185.67.36.65]:40121 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbhAGIoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:44:14 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2CEDB16005C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1610008997; bh=oHvWaW/9ILYAjQezTXmK7N8EHUTV5WutlcDCrTY4GHI=;
        h=Date:From:To:Cc:Subject:From;
        b=Kjzgp2iq1PTUt6khNJ49b1dNIYzpgyDtgN2lBRqUUeRiNK7x6fgrhjVzCFisd5MEJ
         Rfkvx45NAihChOkr7erHnVKtyJp5/GBUzJ4WtbXDpQRVxp2MWOJttTtciyP+3KH6VT
         Oa4bvhphEdCj/BkLDB9UQzso7QiVIz4bLqMLTD2eLEqCgPmL66xlgzOceE+5GID1Am
         mvQqp6W5gN4rbDeQ2Gf2HNppI+U53jVNTXFxYAEngUhD0zQvJ7At1cv322HRQPdz/G
         SRalDvPjp7myAJeWgCYMJhYemjaBqmZAvu+/0i8zaK54LTa4izl6yOmSq45/xB9tVW
         CMSym7e6aPbGg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DBKWR6HRyz6tmN;
        Thu,  7 Jan 2021 09:43:15 +0100 (CET)
Date:   Thu, 7 Jan 2021 09:43:14 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210107094314.4cfd5756@monster.powergraphx.local>
In-Reply-To: <20210106101542.zziwdyhq7arysrsj@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
        <0deae76aec31586da45c316546b12bcc316442ee.1608721968.git.wilken.gottwalt@posteo.net>
        <20210106101542.zziwdyhq7arysrsj@gilmour>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 11:15:42 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Wed, Dec 23, 2020 at 12:35:10PM +0100, Wilken Gottwalt wrote:
> > Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> > most of the sun6i compatible SoCs.
> > 
> > This unit provides at least 32 spinlocks in hardware. The implementation
> > supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> > reading a register and released by writing a 0 to it. This driver
> > supports all 4 spinlock setups, but for now only the first setup (32
> > locks) seem to exist in available devices. This spinlock unit is shared
> > between all ARM cores and the embedded companion core. All of them can
> > take/release a lock with a single cycle operation. It can be used to
> > sync access to devices shared by the ARM cores and the companion core.
> > 
> > There are two ways to check if a lock is taken. The first way is to read
> > a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> > is returned, the caller has to try again. Which means the lock is taken.
> > The second way is to read a 32bit wide status register where every bit
> > represents one of the 32 first locks. According to the datasheets this
> > status register supports only the 32 first locks. This is the reason the
> > first way (lock read/write) approach is used to be able to cover all 256
> > locks in future devices. The driver also reports the amount of supported
> > locks via debugfs.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Does it mean the driver is okay and I only need to fix the bindings
documentation? If so, would you prefer an updated patch set or only the
documentation patch in a new version?

> Thanks!
> Maxime

