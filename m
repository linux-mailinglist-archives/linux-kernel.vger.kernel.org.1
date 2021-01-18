Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33E92FADA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 00:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbhARXHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 18:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbhARXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:06:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:05:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h11so6952889ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNIIO1LfDdwmZD1fpi7N0jsea/5vNdEYtpT955Q+IpQ=;
        b=drSj6qv33myxlpEiC4qESl9upkPKuqyqoxsYjouA8LnGBOHrGhGDU+yzUWoYIBQ/EW
         Vw+PqDmhRrmMKbKD3NJjC2s4mCufYAvRkg10iCDjyl3DO67xFh8I0MQmIKVwvUV0UtyY
         Zgmmhlmak5KGcPDpP2EdVG6kqOH3ZpvPKzfU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNIIO1LfDdwmZD1fpi7N0jsea/5vNdEYtpT955Q+IpQ=;
        b=BqZEVxmSJeo0slvP46rdKfzK5P0Q7rP6WwMZ5xv+2iLxCEgZGTQDOSLJgQUwvSL26J
         U6a9ewQs8qerzi71H4C69CRpzm6k3oYKblDncVbZW9D6zIq/+omjkLpuiQX0WjEDIgN4
         em1pXau4d4lpEYCNyq2J4ltROsDfzE0XTnfamBdtXVahR3PCkdr39p/SwrILefhK8aBy
         d6fcnxiW9EYBuW2dcyMA+rmiqoUExvCH9EGerGaQCmxh9bUVKixWhDGNcFypDiGBU+fE
         Nqlu9Il5Pw5spXNqntjJKIfaBJQhqXXLJzt2PQwUoi0+yplCV0q2arjHhiPdYxHkNenl
         PP0g==
X-Gm-Message-State: AOAM530VYEW8umvZFBlkXZfcwdVRGdnkp/w7DLKm7tcn+6aNAdk/5u2l
        KIlC6KK6mOaClDd0YrO0++j0FKbAdTrc3zpswp27zA==
X-Google-Smtp-Source: ABdhPJx+V+g6QeIGwWzhUdTaPINJzXCGW92jisLbX/hE/5EDswUqplRLtM3WDdR0ifVTp3lT68KVhon1u/BDqH8YlZM=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr1071625ilv.145.1611011156183;
 Mon, 18 Jan 2021 15:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20210118113352.764293297@linuxfoundation.org> <20210118113354.944646657@linuxfoundation.org>
 <20210118224431.GA26685@amd>
In-Reply-To: <20210118224431.GA26685@amd>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 18 Jan 2021 23:05:45 +0000
Message-ID: <CALrw=nEgtxS_SDOP5+T0u6XZ74Hcr451L_d5QdUwDHi7ZaLQ6w@mail.gmail.com>
Subject: Re: [PATCH 5.10 045/152] dm crypt: use GFP_ATOMIC when allocating
 crypto requests from softirq
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:44 PM Pavel Machek <pavel@denx.de> wrote:
>
>
> > Fix this by allocating crypto requests with GFP_ATOMIC mask in
> > interrupt context.
> ...
>
> This one is wrong.
>
>
> > +++ b/drivers/md/dm-crypt.c
> > @@ -1454,13 +1454,16 @@ static int crypt_convert_block_skcipher(
> > -     if (!ctx->r.req)
> > -             ctx->r.req = mempool_alloc(&cc->req_pool, GFP_NOIO);
> > +     if (!ctx->r.req) {
> > +             ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
>
> Good so far. Ugly but good.
>
> > -static void crypt_alloc_req_aead(struct crypt_config *cc,
> > +static int crypt_alloc_req_aead(struct crypt_config *cc,
> >                                struct convert_context *ctx)
> >  {
> > -     if (!ctx->r.req_aead)
> > -             ctx->r.req_aead = mempool_alloc(&cc->req_pool, GFP_NOIO);
> > +     if (!ctx->r.req) {
> > +             ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
> > +             if (!ctx->r.req)
> > +                     return -ENOMEM;
> > +     }
>
> But this one can't be good. We are now allocating different field in
> the structure!

Good catch! Sorry for the copy-paste. It is actually not a big deal,
because this is not a structure, but a union:
as long as the mempool was initialized with the correct size, it
should be no different.

Nevertheless, I'll send the patch to fix the typo.

Regards,
Ignat

>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director:    Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194    Groebenzell, Germany
>
