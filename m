Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A23D6B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 08:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHFGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgHFGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:12:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:12:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so14958869ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lg769i6ESd9+yFvgCTcrA71u1CCKdaazplbdD339OQ=;
        b=qqCb6gaszZMEF69Qou9EINe7FP2GiyFrcwvuWpDSf6gXUV3uKkERKD2LVJh2bWO5z3
         B1/dhoPl6Vec8dngb4dype3A9Ip5Npb6bKRGF8Avp8c742h7Yzdv9cw6/t5cKzMKE4aR
         aCUJc0kJcNIKefeCfEk2uGxaRiTf8O48UNEQIeIFrLL8zbGOEDkT7R5BmupXn6+v1yDV
         q4fpIBuYjsVuJiz4aVQr1OADiTZEPMYTlzmcbLJvdQC6P8rgIpiUg9bleMamjf7zGtIf
         iLIrwNepo9C1bne0Db1xpp6CIgLH9yALqo5MPRJ3PYZ3+wgdJxYjMDtFvnWrkxTOPjQI
         TtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lg769i6ESd9+yFvgCTcrA71u1CCKdaazplbdD339OQ=;
        b=cL2gYaqSHBCfG5m5RqxVyoezpnsOXutamAlRxZ6PaVvYi1JNLQUEHCTnbbc5mVJfwz
         NXAkJtyEb/MKKPMk9wQe55+GKYryz8hCJ1dsOPfsPno2QVe3ZmxfQoo9UWVMxmCpKZwS
         oOifwR+Jz2Y2M60ZosusQ8L+vLp2onNZCPushXv0GHoLlPKfsiapGhQZn5QGvCGBYDT1
         g0CNK6fa9s+LpMKb1n2KI4fIeNAkVz7KKkkR58znhTsvP+tJ8InhfehXMjRWUFHy3LfY
         ddi6Yb8ozuTzwNErn6pxWGmVbFNDPBWJMdOewFI+cmnAjlhY1sMuVIiKlqkA3nG4dCwy
         Dkcg==
X-Gm-Message-State: AOAM532dedmWS6PnQAZOc3V/UPaWGIX4xpfm61vUqyQZbyXGLJYu+byZ
        kpYtigo0xwyzQWdzvxUT+O8U66Yj6g9YWgLb87qmxQ==
X-Google-Smtp-Source: ABdhPJyGyvjKik9oGhRsGgM1zYd8Ds5ektvkg6IwcuaviG+0omujPqq7qpYNXSAFvYQ3PAYyJa9UnraLn57anHQWdUs=
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr2784456ljo.256.1596694324935;
 Wed, 05 Aug 2020 23:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200723084622.31134-1-jorge@foundries.io> <20200723084622.31134-2-jorge@foundries.io>
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
 <20200724142305.GA24164@trex> <CAFA6WYOGu4DPzd93h-yFLJvLmRH=ZroN70+ZNY6xCOOM+TJOSA@mail.gmail.com>
 <20200805203817.GA12229@trex>
In-Reply-To: <20200805203817.GA12229@trex>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 6 Aug 2020 11:41:53 +0530
Message-ID: <CAFA6WYPKGTb6Qj7emETpB9-XXO8vcf6v2ONKD4pt+M9F-=HWbQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, ricardo@foundries.io,
        Michael Scott <mike@foundries.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        op-tee@lists.trustedfirmware.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 02:08, Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 05/08/20, Sumit Garg wrote:
> > Apologies for my delayed response as I was busy with some other tasks
> > along with holidays.
>
> no pb! was just making sure this wasnt falling through some cracks.
>
> >
> > On Fri, 24 Jul 2020 at 19:53, Jorge Ramirez-Ortiz, Foundries
> > <jorge@foundries.io> wrote:
> > >
> > > On 24/07/20, Sumit Garg wrote:
> > > > On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > > > >
> > > > > The current code waits for data to be available before attempting a
> > > > > second read. However the second read would not be executed as the
> > > > > while loop exits.
> > > > >
> > > > > This fix does not wait if all data has been read and reads a second
> > > > > time if only partial data was retrieved on the first read.
> > > > >
> > > > > This fix also does not attempt to read if not data is requested.
> > > >
> > > > I am not sure how this is possible, can you elaborate?
> > >
> > > currently, if the user sets max 0, get_optee_rng_data will regardless
> > > issuese a call to the secure world requesting 0 bytes from the RNG
> > >
> >
> > This case is already handled by core API: rng_dev_read().
>
> ah ok good point, you are right
> but yeah, there is no consequence to the actual patch.
>

So, at least you could get rid of the corresponding text from commit message.

> >
> > > with this patch, this request is avoided.
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > ---
> > > > >  v2: tidy up the while loop to avoid reading when no data is requested
> > > > >
> > > > >  drivers/char/hw_random/optee-rng.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> > > > > index 5bc4700c4dae..a99d82949981 100644
> > > > > --- a/drivers/char/hw_random/optee-rng.c
> > > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> > > > >         if (max > MAX_ENTROPY_REQ_SZ)
> > > > >                 max = MAX_ENTROPY_REQ_SZ;
> > > > >
> > > > > -       while (read == 0) {
> > > > > +       while (read < max) {
> > > > >                 rng_size = get_optee_rng_data(pvt_data, data, (max - read));
> > > > >
> > > > >                 data += rng_size;
> > > > >                 read += rng_size;
> > > > >
> > > > >                 if (wait && pvt_data->data_rate) {
> > > > > -                       if (timeout-- == 0)
> > > > > +                       if ((timeout-- == 0) || (read == max))
> > > >
> > > > If read == max, would there be any sleep?
> > >
> > > no but I see no reason why there should be a wait since we already have
> > > all the data that we need; the msleep is only required when we need to
> > > wait for the RNG to generate entropy for the number of bytes we are
> > > requesting. if we are requesting 0 bytes, the entropy is already
> > > available. at leat this is what makes sense to me.
> > >
> >
> > Wouldn't it lead to a call as msleep(0); that means no wait as well?
>
> I dont understand: there is no reason to wait if read == max and this
> patch will not wait: if read == max it calls 'return read'
>
> am I misunderstanding your point?

What I mean is that we shouldn't require this extra check here as
there wasn't any wait if read == max with existing implementation too.

-Sumit

>
> >
> > -Sumit
> >
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >                                 return read;
> > > > >                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> > > > >                 } else {
> > > > > --
> > > > > 2.17.1
> > > > >
