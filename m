Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBA2EF801
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbhAHTTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAHTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:19:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F6C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:18:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so25419958lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozbpLtkK1xvRTK+jwsC/Xn8VvSovcm0+oA0TWoxuKes=;
        b=REri6ss5W8tvw++tDJHa6Tj2j4DNNmbizybl3TpCOkP38qlwzLJL3iRDH7m/iGR88P
         KKogFPJnAi3XbSxBoOCLhMhQtWw2FK8m1e/Opk5TYu1FtVmOAlVcihIgg0EBhL0EdZGc
         CbwCuj8pEebcxR8ZblMQORCBY38zzkSYAB7gk4WXEIoVwoMBjKLijfznN2jiU5upNMZb
         mphSVuEwfY0CQI1aG0II4jxKl3pd+VdlF705kzvT3hj50Zgu0uc2PyqDJLpEHdfGTu3J
         gDXLVc1budnOYeU9tZLX9zd3zIpC1ToycjGkxxgsCeJ9jVf5DhhwfSaZKi1DqgLzbWFq
         Q8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozbpLtkK1xvRTK+jwsC/Xn8VvSovcm0+oA0TWoxuKes=;
        b=fuvOXhFYHGpuP0LcUVBE6p0kMbjOp2Xb3iPc8oWkkbiik0OSg+Xg37V3jITaCMHTVG
         b4IPqbJSu7aluaHyG7cYTycaM2RwVChzkTM/wJ5Lzw4g+CeHw2ZSx66dZ1oJ2X2EV1nr
         v58ELmeOUT7FgPk7I4vsXYR+z4o++Zfh9SUWagC8ufxByIU9s6rwBymR2/yuv8swYPTs
         V2XulAp1NA/mnSi1qTB1RA7Pv24gpNCrC6rlToomtum0bkcO59aSfLg6FLWFCOIsMANE
         EY+1lGazUShVF78BioCUpAOYkdWZ8OOQgOTFhs8lr0kXyYnVZAbqbcwyG4BSgauqd7ir
         eGrA==
X-Gm-Message-State: AOAM533Mr0y82JoszTScCzqrM7HpmWv0T14Iz3intNs65Xb5+Uhc4TyI
        qgSLVnzocRzynh5rvGLDWMULSbLWX2IWwd5GKnIy4Q==
X-Google-Smtp-Source: ABdhPJxx2DQBiILCuOPqsqJgdHwSJDlbEqnxDQdO81BLoZ6Je4piriGPaWJvYOymof0WkMoIdkFIKsl++hELe3lzdB4=
X-Received: by 2002:a2e:b001:: with SMTP id y1mr2310498ljk.257.1610133523015;
 Fri, 08 Jan 2021 11:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20210108015115.27920-1-john.stultz@linaro.org> <87bldzwr6x.fsf@kernel.org>
In-Reply-To: <87bldzwr6x.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Jan 2021 11:18:32 -0800
Message-ID: <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 4:26 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> John Stultz <john.stultz@linaro.org> writes:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > Just resending this, as discussion died out a bit and I'm not
> > sure how to make further progress. See here for debug data that
> > was requested last time around:
> >   https://lore.kernel.org/lkml/CALAqxLXdnaUfJKx0aN9xWwtfWVjMWigPpy2aqsNj56yvnbU80g@mail.gmail.com/
> >
> > With the current dwc3 code on the HiKey960 we often see the
> > COREIDLE flag get stuck off in __dwc3_gadget_start(), which
> > seems to prevent the reset irq and causes the USB gadget to
> > fail to initialize.
> >
> > We had seen occasional initialization failures with older
> > kernels but with recent 5.x era kernels it seemed to be becoming
> > much more common, so I dug back through some older trees and
> > realized I dropped this quirk from Yu Chen during upstreaming
> > as I couldn't provide a proper rational for it and it didn't
> > seem to be necessary. I now realize I was wrong.
> >
> > After resubmitting the quirk, Thinh Nguyen pointed out that it
> > shouldn't be a quirk at all and it is actually mentioned in the
> > programming guide that it should be done when switching modes
> > in DRD.
> >
> > So, to avoid these !COREIDLE lockups seen on HiKey960, this
> > patch issues GCTL soft reset when switching modes if the
> > controller is in DRD mode.
> >
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> > Cc: Yang Fei <fei.yang@intel.com>
> > Cc: YongQin Liu <yongqin.liu@linaro.org>
> > Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > Cc: Thinh Nguyen <thinhn@synopsys.com>
> > Cc: Jun Li <lijun.kernel@gmail.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Rework to always call the GCTL soft reset in DRD mode,
> >   rather then using a quirk as suggested by Thinh Nguyen
> >
> > v3:
> > * Move GCTL soft reset under the spinlock as suggested by
> >   Thinh Nguyen
>
> Because this is such an invasive change, I would prefer that we get
> Tested-By tags from a good fraction of the users before applying these
> two changes.

I'm happy to reach out to folks to try to get that. Though I'm
wondering if it would be better to put it behind a dts quirk flag, as
originally proposed?
   https://lore.kernel.org/lkml/20201021181803.79650-1-john.stultz@linaro.org/

That way folks can enable it for devices as they need?

Again, I'm not trying to force this in as-is, just mostly sending it
out again for discussion to understand what other approach might work.

thanks
-john
