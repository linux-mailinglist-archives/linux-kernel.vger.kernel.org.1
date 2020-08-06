Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC723D713
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHFG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgHFG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:58:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED3C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:58:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so50561955ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jiAxdAhy44xI/+/AQRE2sQVzFABr4tFigqxJ0w++SSo=;
        b=nYcGaQwWN1KvEfOh4V6Jk2qsZY4XCn6wman7fkG3z+0B7GJCJTcA3vBNG+3Yh+o5Xf
         z99N+ftBbHJWfKRr0XllP6Ve+NhlWoUY7Y5DvHnR/x2M+UxGaCzesVXNyqoin93iDDDS
         Rwfi/q+ib0ySA60qFdU230/FYojWzM6Aoh2Jp+UwWT+mqoq6AUeUet30E8NAC26vYvsY
         LAdg4Zcy8ZZF0S3lN7HUNF9NXfKfVdNk8/RIZd2leW2aBwzeaITX5I0HFDCRBVBP/Zuq
         RVEDqcI3auDGxBNe8k7YtDFltpqq6CCesyLoPpeK3NVrHA765V8GULuHP5UrMZkuI/Dx
         1PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jiAxdAhy44xI/+/AQRE2sQVzFABr4tFigqxJ0w++SSo=;
        b=rwUJgs0Pu4cnJCYNwPj6IvbFqqWM7EuJcfmVHnfb7H3A3W1FxXwD8DWLqptQYYviH/
         vDb4fyvhl2KMUh1R0uTg7KX3c4I0yoyi8Chdwww93f7CC2zChBBFitsujsJ2No5ZWx/w
         m4nfJLg+PoHKh2NP59saj/hmhRureUCMM9mVJr5iswfAG0Nb3Y/lE6ggR2U8nUQWJ+6e
         zFMacVsObXdfvvP9//bm4FylViBV2ASOeJz1YqabyKmGdJfz5tysHaZHsO1Hhak1cxZ+
         3W3TK7fnf2S/NKM6Votm3jhfmXIBieQ1hSHzlYFtIYMDHw3YapW9WIF+X1+uAu/8Zxn3
         d5iQ==
X-Gm-Message-State: AOAM533+2sraullkMbl19SgNecEwh+nfqEBeX37YFYt02ScRK3wGkPnV
        GB14S0SHdrkh6T4y6eLU4gryx2Ni7yl6MfpxwHLGYg==
X-Google-Smtp-Source: ABdhPJx9YdSrUhOSQ2Hd+9Yu4GVO5UeOPj2Yoo3fdfaZao5Jo1szgUE+Vj+/jfz+mPlWrxoD0SoNbXY7XooJO9Hz1gg=
X-Received: by 2002:a05:651c:1293:: with SMTP id 19mr2954610ljc.427.1596697084120;
 Wed, 05 Aug 2020 23:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200723084622.31134-1-jorge@foundries.io> <20200723084622.31134-2-jorge@foundries.io>
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
 <20200724142305.GA24164@trex> <CAFA6WYOGu4DPzd93h-yFLJvLmRH=ZroN70+ZNY6xCOOM+TJOSA@mail.gmail.com>
 <20200805203817.GA12229@trex> <CAFA6WYPKGTb6Qj7emETpB9-XXO8vcf6v2ONKD4pt+M9F-=HWbQ@mail.gmail.com>
 <20200806063040.GA27943@trex>
In-Reply-To: <20200806063040.GA27943@trex>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 6 Aug 2020 12:27:51 +0530
Message-ID: <CAFA6WYMSXGKXx2vM2qcTLpRUugQUphM8Gn5YvPX9fTj3MHvXqQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 12:00, Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 06/08/20, Sumit Garg wrote:
> > On Thu, 6 Aug 2020 at 02:08, Jorge Ramirez-Ortiz, Foundries
> > <jorge@foundries.io> wrote:
> > >
> > > On 05/08/20, Sumit Garg wrote:
> > > > Apologies for my delayed response as I was busy with some other tas=
ks
> > > > along with holidays.
> > >
> > > no pb! was just making sure this wasnt falling through some cracks.
> > >
> > > >
> > > > On Fri, 24 Jul 2020 at 19:53, Jorge Ramirez-Ortiz, Foundries
> > > > <jorge@foundries.io> wrote:
> > > > >
> > > > > On 24/07/20, Sumit Garg wrote:
> > > > > > On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundr=
ies.io> wrote:
> > > > > > >
> > > > > > > The current code waits for data to be available before attemp=
ting a
> > > > > > > second read. However the second read would not be executed as=
 the
> > > > > > > while loop exits.
> > > > > > >
> > > > > > > This fix does not wait if all data has been read and reads a =
second
> > > > > > > time if only partial data was retrieved on the first read.
> > > > > > >
> > > > > > > This fix also does not attempt to read if not data is request=
ed.
> > > > > >
> > > > > > I am not sure how this is possible, can you elaborate?
> > > > >
> > > > > currently, if the user sets max 0, get_optee_rng_data will regard=
less
> > > > > issuese a call to the secure world requesting 0 bytes from the RN=
G
> > > > >
> > > >
> > > > This case is already handled by core API: rng_dev_read().
> > >
> > > ah ok good point, you are right
> > > but yeah, there is no consequence to the actual patch.
> > >
> >
> > So, at least you could get rid of the corresponding text from commit me=
ssage.
> >
> > > >
> > > > > with this patch, this request is avoided.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > > > ---
> > > > > > >  v2: tidy up the while loop to avoid reading when no data is =
requested
> > > > > > >
> > > > > > >  drivers/char/hw_random/optee-rng.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/cha=
r/hw_random/optee-rng.c
> > > > > > > index 5bc4700c4dae..a99d82949981 100644
> > > > > > > --- a/drivers/char/hw_random/optee-rng.c
> > > > > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > > > > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng =
*rng, void *buf, size_t max, bool wait)
> > > > > > >         if (max > MAX_ENTROPY_REQ_SZ)
> > > > > > >                 max =3D MAX_ENTROPY_REQ_SZ;
> > > > > > >
> > > > > > > -       while (read =3D=3D 0) {
> > > > > > > +       while (read < max) {
> > > > > > >                 rng_size =3D get_optee_rng_data(pvt_data, dat=
a, (max - read));
> > > > > > >
> > > > > > >                 data +=3D rng_size;
> > > > > > >                 read +=3D rng_size;
> > > > > > >
> > > > > > >                 if (wait && pvt_data->data_rate) {
> > > > > > > -                       if (timeout-- =3D=3D 0)
> > > > > > > +                       if ((timeout-- =3D=3D 0) || (read =3D=
=3D max))
> > > > > >
> > > > > > If read =3D=3D max, would there be any sleep?
> > > > >
> > > > > no but I see no reason why there should be a wait since we alread=
y have
> > > > > all the data that we need; the msleep is only required when we ne=
ed to
> > > > > wait for the RNG to generate entropy for the number of bytes we a=
re
> > > > > requesting. if we are requesting 0 bytes, the entropy is already
> > > > > available. at leat this is what makes sense to me.
> > > > >
> > > >
> > > > Wouldn't it lead to a call as msleep(0); that means no wait as well=
?
> > >
> > > I dont understand: there is no reason to wait if read =3D=3D max and =
this
> > > patch will not wait: if read =3D=3D max it calls 'return read'
> > >
> > > am I misunderstanding your point?
> >
> > What I mean is that we shouldn't require this extra check here as
> > there wasn't any wait if read =3D=3D max with existing implementation t=
oo.
>
> um, I am getting confused Sumit
>
> with the exisiting implementation (the one we aim to replace), if get_opt=
ee_rng_data reads all the values requested on the first call (ie, read =3D =
0) with wait set to true, the call will wait with msleep(0). Which is unnec=
essary and waits for a jiffy (ie, the call to msleep 0 will schedule a one =
jiffy timeout interrruptible)
>
> with this alternative implementation, msleep(0) does not get called.
>
> are we in synch?

Ah, I see msleep(0) also by default schedules timeout for 1 jiffy. So
we are in sync now. Probably you can clarify this in commit message as
well to avoid confusion.

-Sumit

>
> >
> > -Sumit
> >
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > >
> > > > > > -Sumit
> > > > > >
> > > > > > >                                 return read;
> > > > > > >                         msleep((1000 * (max - read)) / pvt_da=
ta->data_rate);
> > > > > > >                 } else {
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
