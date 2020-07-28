Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDE230745
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgG1KGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgG1KF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:05:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA27C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:05:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so16739683wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=acftKy5haTTez29DldMveP4DByaH/OvKD4GTibGUU4c=;
        b=Rgc3hv+0TiPIPSmJyeuNzphIlAXlhB57Ndn3MyQQjhGIRo7fBOZm0ddElDeMWTuygZ
         dRjmlW9ouLZrHpVmLNTsw5F8YzqPnchsPuj2Cp2NtvtEiUwEwfBSoH4odVJmHnJnGvNj
         ZU7+Jlag9E0ffsFq77QUbAE/vznnG4tQCQ1ivZhMFZdROTfoFMcmOO+b7ZaZB5HMpSv3
         L5dahpKCwrcOQcp5Rq8BJFAWUEBFhMdwLUSSPyF8G+AbkXhzSUhy0ZUZBukxzZr9VFhi
         a9ZertakXO+gT9GioNeRWN6ytFTIETHAcEJBIvBse019ratABWkASFXNxtE3aSY/GN1/
         EZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=acftKy5haTTez29DldMveP4DByaH/OvKD4GTibGUU4c=;
        b=BsUWydoww/snyHsc7SwswyG1RkaBFbCqRT4g5IBQb6+dvVadoATF0XBQiVhJhSttlR
         6N4LmuC/7WisbJP/wGgcXqeiOHt/meZTBaimPbqvgZYS72Lm0ncKuVYCdKe72nbJ8RyZ
         mRQmv+EiVzGVtsgdSvZmrWw2SrJkuTAZV0cb1HXLjDhOnpie6sShZGUb3SWQjKZUN9JW
         W12HyPhaKYcyoTayDMl7Z6uXde9rEcr+YkbJUppcPGMnNF/1o+ZIXTZxQHamVuvKJwSP
         JmPzq2TAqdBTgCdaS7Zgm+YwegaoWXgKP5+qpV96vrMFe3pjUUHqeItqYTdPo5QU3l2h
         sKSA==
X-Gm-Message-State: AOAM531CJzomtLonFHa8brvm6kZDAoUOJtDX3DhItLIWKThP9kOWq4Kf
        zPaS8or2QOZPl3VUBv4ypylpCg==
X-Google-Smtp-Source: ABdhPJwMEO6MXfxPWKVzQyfOwgd+Lnn1mfBFwcsn5n3Aff24Y/ORpbQAQBqKE1qjHnpg35DJaCfWOQ==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr3393238wmb.150.1595930757237;
        Tue, 28 Jul 2020 03:05:57 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id x4sm17668932wru.81.2020.07.28.03.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 03:05:56 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 28 Jul 2020 12:05:55 +0200
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Matt Mackall <mpm@selenic.com>,
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
Message-ID: <20200728100555.GA2074@trex>
References: <20200723084622.31134-1-jorge@foundries.io>
 <20200723084622.31134-2-jorge@foundries.io>
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
 <20200724142305.GA24164@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724142305.GA24164@trex>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/20, Jorge Ramirez-Ortiz, Foundries wrote:
> On 24/07/20, Sumit Garg wrote:
> > On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > >
> > > The current code waits for data to be available before attempting a
> > > second read. However the second read would not be executed as the
> > > while loop exits.
> > >
> > > This fix does not wait if all data has been read and reads a second
> > > time if only partial data was retrieved on the first read.
> > >
> > > This fix also does not attempt to read if not data is requested.
> > 
> > I am not sure how this is possible, can you elaborate?
> 
> currently, if the user sets max 0, get_optee_rng_data will regardless
> issuese a call to the secure world requesting 0 bytes from the RNG
> 
> with this patch, this request is avoided.
> 
> > 
> > >
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  v2: tidy up the while loop to avoid reading when no data is requested
> > >
> > >  drivers/char/hw_random/optee-rng.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> > > index 5bc4700c4dae..a99d82949981 100644
> > > --- a/drivers/char/hw_random/optee-rng.c
> > > +++ b/drivers/char/hw_random/optee-rng.c
> > > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> > >         if (max > MAX_ENTROPY_REQ_SZ)
> > >                 max = MAX_ENTROPY_REQ_SZ;
> > >
> > > -       while (read == 0) {
> > > +       while (read < max) {
> > >                 rng_size = get_optee_rng_data(pvt_data, data, (max - read));
> > >
> > >                 data += rng_size;
> > >                 read += rng_size;
> > >
> > >                 if (wait && pvt_data->data_rate) {
> > > -                       if (timeout-- == 0)
> > > +                       if ((timeout-- == 0) || (read == max))
> > 
> > If read == max, would there be any sleep?
> 
> no but I see no reason why there should be a wait since we already have
> all the data that we need; the msleep is only required when we need to
> wait for the RNG to generate entropy for the number of bytes we are
> requesting. if we are requesting 0 bytes, the entropy is already
> available. at leat this is what makes sense to me.
> 
>

any further comments?

> > 
> > -Sumit
> > 
> > >                                 return read;
> > >                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> > >                 } else {
> > > --
> > > 2.17.1
> > >
