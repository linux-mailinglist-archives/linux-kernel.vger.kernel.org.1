Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34722C7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGXOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:23:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6ABC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:23:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so8108307wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfDJT8aMj8+QexuTYXjin9MXJVQvAj2SdRwLGyVwnJY=;
        b=te8ZOk+rj17Vw6j6a4LQ+3Sm3/VFJ3xcY8mFqfSulGryTbUh9UbJJEY1Nnc0M3yMko
         kXZ/rnVfnUD2H9LEuoJswc8OyE3ItkcIRPMQCOoCuMmkjEde1QuIJw/0o6nNJE8+jypF
         fe9nj/nMM4n3fQ8WrMZbfN5anoIomvLoE/0JoNzYabOnIdKIanyEdzC0I68oZmah29lq
         dmsooZk+iqmlmgE0/SgXzxW61UTLJhZEkpyc/mL4TWchxFZJEEOXKI2lRp7fp5AFExTr
         y9+S66UxsVlJi5Pddt5O5y3tMj/kkL5KsrOCLPG0ynRSwc6M16rGIYjoFvzna/msZYkc
         BQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfDJT8aMj8+QexuTYXjin9MXJVQvAj2SdRwLGyVwnJY=;
        b=sqxGcF01UF8wttYULBXHXrAQC55wwrmJJftoZWv/zSqpvXuX7D1vq63ZPPRGp/FTV+
         0tJ6Vt1R/q0+2okvqZU6L1z2bJTFHt1qMG71E5GvrA1KLO0lbs5OODQwYNsJ6mPxFlG4
         kAtmk+Ly5kt2eGWhCswmC0h5O4W3pZtb1PhQHmAVEWfNhg1oteJ/+12GrgO5+kRI+AH4
         hRoMCF27Dl+efladPJgSMp5xknCNw/ByVRYMbeXZApiBkgYuGoNeW0GS+7EY6yNzBKAv
         7ii3BCGEpZtJeiDzEAO3uauxmYYefzSrLwGEzQ0sqvwGzwn2nR3g9Zls5psaPaGmE2kF
         FGCQ==
X-Gm-Message-State: AOAM532GhEY+0Ns068HdX23j7myqpcwQHILhzMo4dft2AW/7jy2GQdAY
        NjlVwfChtXxFGZg/8P15UpQ40s8q6Gt5hQ==
X-Google-Smtp-Source: ABdhPJx8gwWAeG6Nv5miCrI5rzpwQEUt+1LIAdyE6uPfvsPe2Kk7hluobi63TvjUaNOPT9X2VL0+2w==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr675410wmf.0.1595600587179;
        Fri, 24 Jul 2020 07:23:07 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id g145sm11515101wmg.23.2020.07.24.07.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 07:23:06 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Fri, 24 Jul 2020 16:23:05 +0200
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, ricardo@foundries.io,
        Michael Scott <mike@foundries.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        op-tee@lists.trustedfirmware.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
Message-ID: <20200724142305.GA24164@trex>
References: <20200723084622.31134-1-jorge@foundries.io>
 <20200723084622.31134-2-jorge@foundries.io>
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/20, Sumit Garg wrote:
> On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> >
> > The current code waits for data to be available before attempting a
> > second read. However the second read would not be executed as the
> > while loop exits.
> >
> > This fix does not wait if all data has been read and reads a second
> > time if only partial data was retrieved on the first read.
> >
> > This fix also does not attempt to read if not data is requested.
> 
> I am not sure how this is possible, can you elaborate?

currently, if the user sets max 0, get_optee_rng_data will regardless
issuese a call to the secure world requesting 0 bytes from the RNG

with this patch, this request is avoided.

> 
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  v2: tidy up the while loop to avoid reading when no data is requested
> >
> >  drivers/char/hw_random/optee-rng.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> > index 5bc4700c4dae..a99d82949981 100644
> > --- a/drivers/char/hw_random/optee-rng.c
> > +++ b/drivers/char/hw_random/optee-rng.c
> > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> >         if (max > MAX_ENTROPY_REQ_SZ)
> >                 max = MAX_ENTROPY_REQ_SZ;
> >
> > -       while (read == 0) {
> > +       while (read < max) {
> >                 rng_size = get_optee_rng_data(pvt_data, data, (max - read));
> >
> >                 data += rng_size;
> >                 read += rng_size;
> >
> >                 if (wait && pvt_data->data_rate) {
> > -                       if (timeout-- == 0)
> > +                       if ((timeout-- == 0) || (read == max))
> 
> If read == max, would there be any sleep?

no but I see no reason why there should be a wait since we already have
all the data that we need; the msleep is only required when we need to
wait for the RNG to generate entropy for the number of bytes we are
requesting. if we are requesting 0 bytes, the entropy is already
available. at leat this is what makes sense to me.


> 
> -Sumit
> 
> >                                 return read;
> >                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> >                 } else {
> > --
> > 2.17.1
> >
