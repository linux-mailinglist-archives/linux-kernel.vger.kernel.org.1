Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DE23D6D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 08:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHFGat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFGao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:30:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C53C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:30:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so42815985wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7hHUdnk1IDQGc1aK0+2NyGl5h/bQ6w447e8QIxRtvsM=;
        b=a3uXXNU5nHYpf5Nk8YYQo57sA+TgCQY7SBJSGIVYFyASj7C2yA5yfHMYiAiesyMInA
         FWv5zAVx+1fseoVULhQXPVFPbdEtDWKp7lNfh/DAGaZPApV2U3YA8xqM5vw9/5wzU3+5
         aM7bdmkdsls82jHi0mAjpyJ/Snb8AipbGt2lU8Y4ATuDVfbVetf1lPN2EtUmqstLCRk2
         mr3YsEM1tgjarkNFuCMwYmgl3nPIlJea7B7HTyUilea8YXxgVl+Z9y/dcqseqiSlvCtb
         1T3ejzuo9QC2vhK/kDm+tWVxf2Ba8UyRwfIEbDKQyTfqUJpA87Gu3Q9gy30CUe0ZGLYn
         1RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hHUdnk1IDQGc1aK0+2NyGl5h/bQ6w447e8QIxRtvsM=;
        b=cGQgLcVnmZ2lPh2Sbjkt1JnlyNeBsxv+GyYFKd026Lq5ofHDhlrbPVAyFT1uXhkl8y
         JWDgtAcS1eEduLALkNEFctNqbjaHh4sV/R71J7Ax3v/lMT8sEWFX/D75zW+r98xmSbCE
         ekzZWjmIEy4DPGPctG/ygKp2TMUsNv8x+AjmsBCOTxZ3fQuKCo49iZoFOFeQRuQ+8mVH
         thZo9vqkvyMI/5PndiIwpsUwHkI7AujyzgV5x7M/vb53G8eigcqBtbdoLcHjW4kKzACD
         PeN2Jc6+Kb7PSuO+VXDRGMBlv8BqtXG64ORdd2qebm2rvf2VdNBq/C5zQPnbW+bM3Lst
         OIXQ==
X-Gm-Message-State: AOAM530YsJWJEeinLv48PBQ4mDHmXFtZkOx8bNtB3nadLesXgYyOrdN6
        o2ANP6HHZyKIsakj+pfn8ThKI7/yWeRXPg==
X-Google-Smtp-Source: ABdhPJwI1qZ+jpduIkuKlubpk+fY0cUnJmEtNZRlvzxVhkIaT0sURr5YC6EcuKAe6pMx70Uhp9KMpA==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr5658251wrx.49.1596695442757;
        Wed, 05 Aug 2020 23:30:42 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id o125sm5847821wma.27.2020.08.05.23.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 23:30:42 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 6 Aug 2020 08:30:40 +0200
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
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
Message-ID: <20200806063040.GA27943@trex>
References: <20200723084622.31134-1-jorge@foundries.io>
 <20200723084622.31134-2-jorge@foundries.io>
 <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
 <20200724142305.GA24164@trex>
 <CAFA6WYOGu4DPzd93h-yFLJvLmRH=ZroN70+ZNY6xCOOM+TJOSA@mail.gmail.com>
 <20200805203817.GA12229@trex>
 <CAFA6WYPKGTb6Qj7emETpB9-XXO8vcf6v2ONKD4pt+M9F-=HWbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPKGTb6Qj7emETpB9-XXO8vcf6v2ONKD4pt+M9F-=HWbQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/20, Sumit Garg wrote:
> On Thu, 6 Aug 2020 at 02:08, Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
> >
> > On 05/08/20, Sumit Garg wrote:
> > > Apologies for my delayed response as I was busy with some other tasks
> > > along with holidays.
> >
> > no pb! was just making sure this wasnt falling through some cracks.
> >
> > >
> > > On Fri, 24 Jul 2020 at 19:53, Jorge Ramirez-Ortiz, Foundries
> > > <jorge@foundries.io> wrote:
> > > >
> > > > On 24/07/20, Sumit Garg wrote:
> > > > > On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > > > > >
> > > > > > The current code waits for data to be available before attempting a
> > > > > > second read. However the second read would not be executed as the
> > > > > > while loop exits.
> > > > > >
> > > > > > This fix does not wait if all data has been read and reads a second
> > > > > > time if only partial data was retrieved on the first read.
> > > > > >
> > > > > > This fix also does not attempt to read if not data is requested.
> > > > >
> > > > > I am not sure how this is possible, can you elaborate?
> > > >
> > > > currently, if the user sets max 0, get_optee_rng_data will regardless
> > > > issuese a call to the secure world requesting 0 bytes from the RNG
> > > >
> > >
> > > This case is already handled by core API: rng_dev_read().
> >
> > ah ok good point, you are right
> > but yeah, there is no consequence to the actual patch.
> >
> 
> So, at least you could get rid of the corresponding text from commit message.
> 
> > >
> > > > with this patch, this request is avoided.
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > > > ---
> > > > > >  v2: tidy up the while loop to avoid reading when no data is requested
> > > > > >
> > > > > >  drivers/char/hw_random/optee-rng.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> > > > > > index 5bc4700c4dae..a99d82949981 100644
> > > > > > --- a/drivers/char/hw_random/optee-rng.c
> > > > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > > > @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> > > > > >         if (max > MAX_ENTROPY_REQ_SZ)
> > > > > >                 max = MAX_ENTROPY_REQ_SZ;
> > > > > >
> > > > > > -       while (read == 0) {
> > > > > > +       while (read < max) {
> > > > > >                 rng_size = get_optee_rng_data(pvt_data, data, (max - read));
> > > > > >
> > > > > >                 data += rng_size;
> > > > > >                 read += rng_size;
> > > > > >
> > > > > >                 if (wait && pvt_data->data_rate) {
> > > > > > -                       if (timeout-- == 0)
> > > > > > +                       if ((timeout-- == 0) || (read == max))
> > > > >
> > > > > If read == max, would there be any sleep?
> > > >
> > > > no but I see no reason why there should be a wait since we already have
> > > > all the data that we need; the msleep is only required when we need to
> > > > wait for the RNG to generate entropy for the number of bytes we are
> > > > requesting. if we are requesting 0 bytes, the entropy is already
> > > > available. at leat this is what makes sense to me.
> > > >
> > >
> > > Wouldn't it lead to a call as msleep(0); that means no wait as well?
> >
> > I dont understand: there is no reason to wait if read == max and this
> > patch will not wait: if read == max it calls 'return read'
> >
> > am I misunderstanding your point?
> 
> What I mean is that we shouldn't require this extra check here as
> there wasn't any wait if read == max with existing implementation too.

um, I am getting confused Sumit

with the exisiting implementation (the one we aim to replace), if get_optee_rng_data reads all the values requested on the first call (ie, read = 0) with wait set to true, the call will wait with msleep(0). Which is unnecessary and waits for a jiffy (ie, the call to msleep 0 will schedule a one jiffy timeout interrruptible)

with this alternative implementation, msleep(0) does not get called.

are we in synch?

> 
> -Sumit
> 
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >                                 return read;
> > > > > >                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> > > > > >                 } else {
> > > > > > --
> > > > > > 2.17.1
> > > > > >
