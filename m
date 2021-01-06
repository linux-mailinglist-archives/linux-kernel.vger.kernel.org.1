Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D12EBFA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAFOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:34:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCDC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:34:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id hk16so1672048pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xG+Aig3uaRFj6+3S+rLCMgLtTBzVQJurKYaoHP2i+Ww=;
        b=NzFc+bZV1qpPy6j4yIBaInX0XaTSlqt6raRR72ykm+Ui4w4dewN1vyAfI2pS7RFWIK
         ETJiVrhHsZa/hhSfQm9JsW9mcwsk5mO2WAr0diNkOuk64EOtEaW+N2CtBWNA0bqtVKeo
         0kMZDWN9JS4ROKqiZRoTXo5ldadEB+osKmYP7xrlwMLjJCx8SpmodoWmDK0rMqUlYvC5
         Pycmd6UcRK5XhOU0LvKnLKqy+fo3jMFLTDwZgydywxZUj0JwpON6e+egZ3C7WqfHyQZH
         6khGzZ/7iI4jsWXgJgwAErdGlKDb31H5yaa2UejmST+LUW+zQ3d2bArPgjaH2L8HAP6x
         qyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xG+Aig3uaRFj6+3S+rLCMgLtTBzVQJurKYaoHP2i+Ww=;
        b=BYVi1Rj5cl2TaRCdSG4dBvmta9k/sonUCyGq+PhFpcGup7foMfxdS76dxbLr8Br4gY
         /SGR1qwAhDxu3IZTWHHgq+0wiBswAHmc1z0DfKWauDolHNiMxe0zkLV8NZihzbH8qy22
         wPpL7ObDE0yIhe6GzgvbWLCmUQqNWKk3xca6dg0VkZeDqrUvSzU3v+gXxxomGZtVnZk+
         LjvOmEhv4M37RAlxczXNAXYDR6yxUXm7k4NiCPgu950Y3nW8NA5pvGPjeWqoZxMbrlYu
         ExpOSNgDMh1s5vmDg+SZI039TZwP1i8998wkTVxQGp1wC8QTpHE73dFHXi2Qxse/6PJA
         zDLA==
X-Gm-Message-State: AOAM532ejtk19tCKjkRNX6EV+qDsvPBxEWYkb1PLy0DYgPLoHCJhRJlj
        bQXiYkHoU3YcgxRjpbo46OwnSKqAwYIj7GEAQfs=
X-Google-Smtp-Source: ABdhPJwWMD0LL5531x/3RTqnQtusY8HCavdf9UARcO7sry0xVZeOm4kVtvDtfJK03bpoFDzwto9SGmZ8JRIGbpCl574=
X-Received: by 2002:a17:90a:49c5:: with SMTP id l5mr4603955pjm.116.1609943648576;
 Wed, 06 Jan 2021 06:34:08 -0800 (PST)
MIME-Version: 1.0
References: <CANCKTBukX33YxVh8uuashC3grRVa1oZBig+-UD90YKgVUgSS=A@mail.gmail.com>
 <20210106093053.tnlncqvcba7qnwnk@bogus>
In-Reply-To: <20210106093053.tnlncqvcba7qnwnk@bogus>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 6 Jan 2021 09:33:57 -0500
Message-ID: <CANCKTBuRQDdrEdNJ7m_+ypfb0_q5wuApfG82uDWuGykqov7TjA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 4:30 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jan 05, 2021 at 01:32:49PM -0500, Jim Quinlan wrote:
>
> [...]
>
> >
> > I don't think that is the case;  the bottom routine,
> > do_wait_for_common(), decrements the x->done after a completion (which
> > does an increment).  Regardless, I think it is prudent to add the
> > reinit patch you've provided below.
> >
>
> Ah right, but I will add that.
>
> > BTW, one thing I could have done was incorporate the timeout value but
> > I thought that since this is the "fast" call we shouldn't be timing
> > out at all.
> >
>
> Agreed, we can add it later. However it is not related to fast call, it is
> more for protection against failure of delivery of interrupt from the platform
> or any firmware responsible IMO.
>
> > > This electronic communication and the information and any files
> > > transmitted with it, or attached to it, are confidential and are intended
> > > solely for the use of the individual or entity to whom it is addressed and
> > > may contain information that is confidential, legally privileged,
> > > protected by privacy laws, or otherwise restricted from disclosure to
> > > anyone else. If you are not the intended recipient or the person
> > > responsible for delivering the e-mail to the intended recipient, you are
> > > hereby notified that any use, copying, distributing, dissemination,
> > > forwarding, printing, or copying of this e-mail is strictly prohibited. If
> > > you received this e-mail in error, please return the e-mail to the sender,
> > > delete it from your computer, and destroy any printed copy of it.
>
> I am assuming this was unintentional and ignoring. If not disregard my
> response. Otherwise you may need to fix your mail server.
Hi Sudeep,
Yes please ignore the above legalize in my email -- our company is
attaching this text to all outgoing emails.  We are working on a
general solution.
Regards,
Jim Quinlan
Broadcom STB
>
> --
> Regards,
> Sudeep
