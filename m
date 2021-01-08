Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CFB2EF286
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbhAHM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbhAHM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:26:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6883238E8;
        Fri,  8 Jan 2021 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610108764;
        bh=3Sa0Em/ZGPisFrTI0JuPpmbH+3oTgWsFlEcpdO59oS8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qyx1l48in8phi8u4p3epf4fMVj9EEB5cY1iQCjRDu5dQ8LxYlbALOHVMMX8KCBeIU
         qo+nog0IEIN7Vm6a4PABDK9qHTxV+ows8rK6AzqiMYqgsxap4K6dmdtT9N2NGi5ZqH
         wRmUBVHzvoT4abdlq4hwsjTDLMqNtio8WgA77sq0FQ9QH8vraKvUOeHWTuw+zrNbJI
         rDb7NBgqPlhCGWTFPRZRVM3FQZkv4DXr8nFrQYi0RcEZ8CwnF2vxaJ/McFD6hgadnp
         +lHNY00eypdJqXRAI/XiV/U9TN7R8l15Qwtpl2oRdM3/KsW+a2PrXatyde2hgvyNvy
         CwoCeWRB3Dj1Q==
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
In-Reply-To: <20210108015115.27920-1-john.stultz@linaro.org>
References: <20210108015115.27920-1-john.stultz@linaro.org>
Date:   Fri, 08 Jan 2021 14:25:58 +0200
Message-ID: <87bldzwr6x.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

John Stultz <john.stultz@linaro.org> writes:
> From: Yu Chen <chenyu56@huawei.com>
>
> Just resending this, as discussion died out a bit and I'm not
> sure how to make further progress. See here for debug data that
> was requested last time around:
>   https://lore.kernel.org/lkml/CALAqxLXdnaUfJKx0aN9xWwtfWVjMWigPpy2aqsNj56yvnbU80g@mail.gmail.com/
>
> With the current dwc3 code on the HiKey960 we often see the
> COREIDLE flag get stuck off in __dwc3_gadget_start(), which
> seems to prevent the reset irq and causes the USB gadget to
> fail to initialize.
>
> We had seen occasional initialization failures with older
> kernels but with recent 5.x era kernels it seemed to be becoming
> much more common, so I dug back through some older trees and
> realized I dropped this quirk from Yu Chen during upstreaming
> as I couldn't provide a proper rational for it and it didn't
> seem to be necessary. I now realize I was wrong.
>
> After resubmitting the quirk, Thinh Nguyen pointed out that it
> shouldn't be a quirk at all and it is actually mentioned in the
> programming guide that it should be done when switching modes
> in DRD.
>
> So, to avoid these !COREIDLE lockups seen on HiKey960, this
> patch issues GCTL soft reset when switching modes if the
> controller is in DRD mode.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> Cc: Yang Fei <fei.yang@intel.com>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Cc: Thinh Nguyen <thinhn@synopsys.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Rework to always call the GCTL soft reset in DRD mode,
>   rather then using a quirk as suggested by Thinh Nguyen
>
> v3:
> * Move GCTL soft reset under the spinlock as suggested by
>   Thinh Nguyen

Because this is such an invasive change, I would prefer that we get
Tested-By tags from a good fraction of the users before applying these
two changes.

-- 
balbi
