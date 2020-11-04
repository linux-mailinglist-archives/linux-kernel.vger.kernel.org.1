Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F92A6E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgKDUDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:03:44 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:03:43 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id p7so23508229ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 12:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mm+ybx71OoNeCPgmioebqgOFv7Wp5+Z26oyDo21sJiA=;
        b=zLOxjJ45arUmho3LsbdQkHLOfVxF5fGRevtbQ9ab+1nfw67oaOc5+nZTz9kzdpfvV6
         MJTmdbX1kaZqUrxE9n2dOgU3GNFXTPe0dJgHE+wOLtOUaAbWJmt8/FlFlDkvNX5iI7yX
         6d4Thdy7zV1qCLMn74lqRW34QwBjdLvCiEcNffuyjb0Fu2WNfTexyQvDebYEHKdUQdfo
         JSu4vn33h3JK0SJvqR1B2IybL0rqrJeHHSJ1BnuTteBqOPnGHdMOW2ZRZnf1Th4WFUpX
         CnNBY8FS04QrKNNC8xTK/Pi3H9HP1UvaDRjcolDZr0LwbK0DLcTJjcjveEdubJYZQ+CV
         cOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mm+ybx71OoNeCPgmioebqgOFv7Wp5+Z26oyDo21sJiA=;
        b=JDcFH2J2NUwPLacD8V7X5gXOeID8fl41l3lWvUGoLV/UlO6ZdVmR63RsN1LFw3GuvC
         /zicWdTAmQ8iyO+n1pORpogUJYjO/DmNcO48xmDq88QGTpiun4XvyBTvRyDKDyCc6T/6
         6MK9ny7kst2s5CQwco+BNDAftnzNdBNX2hWU+tfgn4bcyGJiNDj9ElMPWkpCJVsgf+up
         GYo3JtCJUl9qiIAfo7wvszEhsFPV6iVUzv0H3cwIOyzKGCYXusrNvlTU7tGVmjw2OPVJ
         CV9tEiH03achokVv+fQCz33ltUS23KKd0vsJ8XqkhBqN5+uwUryl1PIOaZ1lz6Q/ry6v
         thAg==
X-Gm-Message-State: AOAM533G/VUTA7lciLRfmIwzomJ6VTZlKNpS17IAAoo0UZ7s4OfondVO
        ClphsHYuSU3Xf2R7EwdExDrbcP0X07SQsxE6+/DafH+J0Sw=
X-Google-Smtp-Source: ABdhPJwZytt5PvB4/wrZk6OEXlsnlBlTbXNLz8LEAE5Biwje0bKPpQ4a3U+187kWJ95RAbHTo9zr8Xa+9P2SUCAJ30g=
X-Received: by 2002:a6b:b883:: with SMTP id i125mr18759188iof.131.1604520223267;
 Wed, 04 Nov 2020 12:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
 <20201027175218.1033609-9-mathieu.poirier@linaro.org> <20201104140143.GA30197@ubuntu>
 <20201104173424.GB2893396@xps15> <20201104183904.GA31822@ubuntu>
In-Reply-To: <20201104183904.GA31822@ubuntu>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Nov 2020 13:03:32 -0700
Message-ID: <CANLsYky3RC0PZuYNPMLHzsTytfjp3it6_rWLzSVujgQy49sqDg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] rpmsg: Turn name service into a stand alone driver
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 11:39, Guennadi Liakhovetski
<guennadi.liakhovetski@linux.intel.com> wrote:
>
> On Wed, Nov 04, 2020 at 10:34:24AM -0700, Mathieu Poirier wrote:
> > On Wed, Nov 04, 2020 at 03:01:44PM +0100, Guennadi Liakhovetski wrote:
> > > Hi Mathieu, Arnaud,
> > >
> > > I've tried the patch set with my VirtIO / vhost audio implementation,
> > > in general it worked quite well,
> >
> > Very good - it would be nice if you could add your "Tested-by:" tags.
>
> Sure, I guess it would be better if I reply with both "Tested-by" and
> "Reviewed-by" to your next version?
>

Yes, that will be great.

> Thanks
> Guennadi
>
> > > On Tue, Oct 27, 2020 at 11:52:18AM -0600, Mathieu Poirier wrote:
> > > > From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > > >
> > > > Make the RPMSG name service announcement a stand alone driver so that it
> > > > can be reused by other subsystems.  It is also the first step in making the
> > > > functionatlity transport independent, i.e that is not tied to virtIO.
> > > >
> > > > Co-developed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > > > ---
> > >
> > > [snip]
> > >
> > > > diff --git a/include/linux/rpmsg_ns.h b/include/linux/rpmsg_ns.h
> > > > index bb479f430080..42786bb759b5 100644
> > > > --- a/include/linux/rpmsg_ns.h
> > > > +++ b/include/linux/rpmsg_ns.h
> > > > @@ -39,4 +39,21 @@ enum rpmsg_ns_flags {
> > > >  /* Address 53 is reserved for advertising remote services */
> > > >  #define RPMSG_NS_ADDR                    (53)
> > > >
> > > > +/**
> > > > + * rpmsg_ns_register_device() - register name service device based on rpdev
> > > > + * @rpdev: prepared rpdev to be used for creating endpoints
> > > > + *
> > > > + * This function wraps rpmsg_register_device() preparing the rpdev for use as
> > > > + * basis for the rpmsg name service device.
> > > > + */
> > > > +static inline int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
> > > > +{
> > > > +       strcpy(rpdev->id.name, "rpmsg_ns");
> > >
> > > you need to
> > >
> > > #include <linux/rpmsg.h>
> >
> > Of course yes - I'll simply add the header file.  I plan on having another
> > revision addressing your comments out by the end of the week or early next week.
> >
> > Thanks,
> > Mathieu
> >
> > >
> > > in this file for rpdev definition. Or you could leave this function in
> > > rpmsg_ns.c, then it's enough to forward-declare struct rpdev here.
> > >
> > > Thanks
> > > Guennadi
> > >
> > > > +       rpdev->driver_override = "rpmsg_ns";
> > > > +       rpdev->src = RPMSG_NS_ADDR;
> > > > +       rpdev->dst = RPMSG_NS_ADDR;
> > > > +
> > > > +       return rpmsg_register_device(rpdev);
> > > > +}
> > > > +
> > > >  #endif
> > > > --
> > > > 2.25.1
> > > >
