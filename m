Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD677296582
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370422AbgJVTqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509801AbgJVTqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:46:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF9EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:46:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m128so3028335oig.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgurfa7uICYHznbYitBbS6zGK9tKnDPl24+Alzk+UmQ=;
        b=FM94cPUKChGVwwWOMYxWmIJ/1Ul4AgBCkn/JIlx6hX/J7MUeinFbyfcH29zLOsc843
         r6Vx+tpf1c2ttbzWGH9WujJtf4Z1OjWSGBby21tKao0FCms/SdOxuDjpweBK74j3USZy
         gOvefG+9LGgDDYcJwuy4ln8ZW2r3z3W8ge5+95uv1LgYG0RrPuQuDujKnmPN4NuLOsZ5
         u067ybT7gerl6qTwJCoyRdAv4RtpbGlMCC6bYp1/gS5OtFcuZdF0orkaLLE2T/9jYAjC
         cbX1Vt1C7DWCswvCQGA7/6fCwhfbRiG6hvLwJObjTZ1H2C6GmNuIj40p3NP0Nxa9t+34
         AIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgurfa7uICYHznbYitBbS6zGK9tKnDPl24+Alzk+UmQ=;
        b=dLXZZVNPow/ZaIghFxWD0o28uMMu95sxZ/VX7/g4Abycv7i7Dd5+JF0PfiybU8KK7u
         U1IYPnSSamHR2RQu10+AEvAdNyUx1Ws7KN/TzwsFQKjw+8onrVadKw7S6VayCSRJL6kG
         s6fVf7E4OUrX/RSmghFXE/OwQGxWxizZcW5N+KE9YfTdCcSfxmvbIG4rLn+4mQDn8xmc
         fd7AInWd2vQJnyR/jcnej8Xhqo2uRUmtoQnmOh8cqbg+SMGyFimgjuu4hW9gcddsCbOf
         pt8/f8P0XMi1Dyv5ydoe8ZabZus1IYGlbsU8UkcmP8jh8OPqpUEUC27mb7+YRfXjsRoE
         zWTA==
X-Gm-Message-State: AOAM530yZ8nhDoqkeZMACsxhtV1JYBN5u99aU1l4rv6YUOH+t0zp0m/Z
        wC4uhlc2O0+MAL1zwDkcazE9AL7CPQqW37kKNXPssw==
X-Google-Smtp-Source: ABdhPJx8TU5XO8TepLmgowcR1Vknk2GNJt4tiyC0sb/EV0k/yaNXW+BtZPWwTk16D8+OrrLR0rAFpqzL08yIRKF2tk8=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2439299oia.169.1603395989572;
 Thu, 22 Oct 2020 12:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201021224619.20796-1-john.stultz@linaro.org> <87y2jyelv6.fsf@kernel.org>
In-Reply-To: <87y2jyelv6.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 22 Oct 2020 12:46:18 -0700
Message-ID: <CALAqxLXxG1oHvUhBtu9doc78EwFo2kj=vfk_GDaR760ae+0YBQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
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
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:55 AM Felipe Balbi <balbi@kernel.org> wrote:
> John Stultz <john.stultz@linaro.org> writes:
> > From: Yu Chen <chenyu56@huawei.com>
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
>
> This keeps coming back every few years. It has never been necessary so
> far. Why is it necessary now?

Sorry, I'm not totally sure I've got all the context here. If you mean
with regards to the HiKey960, it's because the HiKey960 had a somewhat
complicated vendor patch stack that others and I had been carrying
along and trying to upstream slowly over the last few years.  Since
that process of upstreaming required lots of rework, the patch set
changed over time fixing a number of issues and in this case (by
dropping the quirk) introducing others.

The usb functionality on the board was never perfect.  As I said in
the patch, we saw initialization issues *very* rarely with older
kernels - which I suspected was due to the oddball mux/hub driver that
had to be deeply reworked - so the issue was easy to overlook, except
the frequency of it had grown to be quite noticeable. So now that all
but the dts bits are upstream, I've been trying to spend occasional
free cycles figuring out what's wrong.

That's when I figured out it was the quirk fix I dropped.  But the
good news is so far with it I've not hit any initialization issues
(over a few hundred reboots).

> The only thing we need to do is verify
> which registers are shadowed between host and peripheral roles and cache
> only those registers.

Sorry, could you explain this a bit more? Again, I don't have access
to the hardware docs, so I'm just working with the source and any
vendor patches I can find.

> A full soft reset will take a while and is likely to create other
> issues.

I'm also fine with going back to the quirk approach if you think that
would be lower risk to other devices?

thanks
-john
