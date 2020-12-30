Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878A82E7802
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgL3LW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3LW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:22:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB8C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 03:22:10 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i18so14466486ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 03:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oPKzLyyXT4TdO6sFZrA2FFrPyuYED6DhcCJYDeGYf8=;
        b=Funldt0OGOQTB4Mf4OTgXch3onl1uNAjw60IfPpvP392N9oHd0Sv20zAwzP57YO9tF
         VYjDbs0FOfP26sd9+yFfMxeL7XDSz5qU+ua7/1NMwBePz3fPvhVGuwuPDE0ltSyZKNLV
         d6zfELnb9I+J8W+74HCouHfg5vyNpGExUFFcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oPKzLyyXT4TdO6sFZrA2FFrPyuYED6DhcCJYDeGYf8=;
        b=rpv680ulqpnuKoK/LyIR1yJkbGKV2mQ7GDPnRY7o0xjvaIYlIkHKVEC+9qz8tDwgyk
         7UBgK5GrYmveMLGJXs+qN05yKbKacKboaE722nGk2akvnsR+wG45ojhZe5GKWNHmWbjE
         fChu4ovmWyvfxxwzE2QGEJJ2o++lS+qPmzr3yxECA1PsiXr54FuFPkG3OklR3JCTgFeJ
         Dx8KAGkBKSpJCiKj0H2D0A7ikrPMuzHx/TKdt6JruTt7KpMc6UaEj2KFOQuVLv1qruzV
         9laF5y/WtXptL3BF7X3MCgtb02NaDne839eoumxXSaWDAyl5cex1aXtCQyRkrVzidgPl
         Onow==
X-Gm-Message-State: AOAM5312aHFX7JcYKxh8qAR3IFrjBJBxIDqoWjcxXAXZqsdQPWZ2JDKr
        yqHm2sIN80Emlk4VxPqGBZFqSXQ5LN177qrGLts/K643D7btBSgz59w=
X-Google-Smtp-Source: ABdhPJx+Wy/89M+XxyQP1337iMXRcYzY09+IGgpGdQNNhSlJA0ioAsbB3KnOfbLHhUOzoOaeM118/CMR2Ly4YbM2Ql0=
X-Received: by 2002:a6b:700f:: with SMTP id l15mr43085763ioc.22.1609327329832;
 Wed, 30 Dec 2020 03:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20201229225714.1580-1-ignat@cloudflare.com> <20201230073557.2253-1-hdanton@sina.com>
In-Reply-To: <20201230073557.2253-1-hdanton@sina.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 30 Dec 2020 11:21:59 +0000
Message-ID: <CALrw=nHBM++dx1gtWZEgaWGduLqRMOFwfbfZtjLWD-JcpT+=hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm crypt: use GFP_ATOMIC when allocating crypto
 requests from softirq
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        dm-crypt@saout.de, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 7:36 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 29 Dec 2020 22:57:13 +0000
> >
> > Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
>
> Looks like a seperate fix to this commit is needed if what can be found
> at (Subject: [patch 00/12] UBS: Cleanup in_interupt/in_irq/in_atomic() usage)
> https://lore.kernel.org/lkml/20201014145215.518912759@linutronix.de/

I think the above request should be satisfied by device mapper core
code itself rather than individual DM module implementations, as the
execution context in the module is dependent on the underlying block
driver: some block drivers complete requests in task contexts and some
in interrupt - but the underlying block drivers should be transparent
to the modules.

The device mapper core code can pass context information to the
modules if we are to avoid in_*irq() marcos in the code.

> is correct.
>
> > Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Cc: <stable@vger.kernel.org> # v5.9+
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> >  drivers/md/dm-crypt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > index 5f9f9b3a226d..777b5c71a2f7 100644
> > --- a/drivers/md/dm-crypt.c
> > +++ b/drivers/md/dm-crypt.c
> > @@ -1460,7 +1460,7 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
> >       unsigned key_index = ctx->cc_sector & (cc->tfms_count - 1);
> >
> >       if (!ctx->r.req)
> > -             ctx->r.req = mempool_alloc(&cc->req_pool, GFP_NOIO);
> > +             ctx->r.req = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
> >
> >       skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);
> >
> > @@ -1477,7 +1477,7 @@ static void crypt_alloc_req_aead(struct crypt_config *cc,
> >                                struct convert_context *ctx)
> >  {
> >       if (!ctx->r.req_aead)
> > -             ctx->r.req_aead = mempool_alloc(&cc->req_pool, GFP_NOIO);
> > +             ctx->r.req_aead = mempool_alloc(&cc->req_pool, in_interrupt() ? GFP_ATOMIC : GFP_NOIO);
> >
> >       aead_request_set_tfm(ctx->r.req_aead, cc->cipher_tfm.tfms_aead[0]);
> >
> > --
> > 2.20.1
