Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96179287C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgJHTPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgJHTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4366C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 12:15:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dn5so6943635edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfZfZnaERkqPGB2gGvHnDF9tWhylzGCwvN0kr160d3o=;
        b=EU3IvPZT1qrarikUHrvLKAxBGi3bVKJs0zCSZlivvI6umTuzeH4Wvdmad20HGIqsjp
         gzhFpLD9thpIBdRIhY+D4YGrpLSSySZkS2KDuuvmpT0YaFHE259gf8BLBo3oTIiY2Yv/
         ye/GJnVVhgy5RozPa4nO0EA/PpFrkyapQ8wFgmT8Ggh0g9z8/uX98SnXSPZRL7Gw/7II
         Fb+sekakOy/Bd5nkEluPT0I2WBptg8Cqzq+3vRMOHKcMI04zj/J5aKTaOiyTTFhFu5Bg
         KnrklRQL9VteQbPeTa35T7QEYo30iWp53uP8Z3oVLd/RHZJ49N5CaKz5tyEsqHHzJD5g
         VOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfZfZnaERkqPGB2gGvHnDF9tWhylzGCwvN0kr160d3o=;
        b=DlrfRv3ykTCeI6bGnFnKnSfcz0M+lJzTZsWHLgCrgY36TQRvTOHfOVw1Phtbj+zINI
         mjOlcebXw5EV7oggA9S55/wo44FvvdEpkNA6E4R63pk/ycIZFxd+Fxu1FTx1ot2ZDa07
         /EwOJBj7kHUAZfI5L+BQ92hrB1ItnxgGy46PpnjIXn/NkcFgfdU9LoRjuhhFsRLpeSSc
         842n5BeuNufuKO1w/BKcNBOYd6+z4Y6YSN782JRXzYmaJ1Zd9izxhL27GsMPdHpRUJcR
         FmRLBDp/wgSZVls8MIjh7VIapVIzTzWgD122kL6+Pw0CuaCMTsUmK1zSeLi2dQZZxcqj
         tRDg==
X-Gm-Message-State: AOAM532jmQq/CDgpjcEN2pUxjfk2OzFrO4e3uz2VFdUI+N6pSZXDLQqz
        aXVcu+QZPPZzzUxCbsY/CgDCdOVWyAHtJZyjj5QYBw==
X-Google-Smtp-Source: ABdhPJyFBlN7boUQCesb35wLUZR3ZBS6yJ+NQq18F8P2ms8O/FcyKZgkHVXpn/LRi65HGJKo/6aCP+dzJHDcLp6c2D0=
X-Received: by 2002:aa7:dd01:: with SMTP id i1mr10907549edv.84.1602184508070;
 Thu, 08 Oct 2020 12:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <f7ac4874-9c6c-4f41-653b-b5a664bfc843@canonical.com> <CAG48ez1i9pTYihJAd8sXC5BdP+5fLO-mcqDU1TdA2C3bKTXYCw@mail.gmail.com>
In-Reply-To: <CAG48ez1i9pTYihJAd8sXC5BdP+5fLO-mcqDU1TdA2C3bKTXYCw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 21:14:42 +0200
Message-ID: <CAG48ez0pLGtc6_NPcYa0nVPexrSOJvfKgArgY6OT4AXS5tOF4A@mail.gmail.com>
Subject: Re: io_uring: process task work in io_uring_register()
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 9:13 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Oct 8, 2020 at 8:24 PM Colin Ian King <colin.king@canonical.com> wrote:
> > Static analysis with Coverity has detected a "dead-code" issue with the
> > following commit:
> >
> > commit af9c1a44f8dee7a958e07977f24ba40e3c770987
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Sep 24 13:32:18 2020 -0600
> >
> >     io_uring: process task work in io_uring_register()
> >
> > The analysis is as follows:
> >
> > 9513                do {
> > 9514                        ret =
> > wait_for_completion_interruptible(&ctx->ref_comp);
> >
> > cond_const: Condition ret, taking false branch. Now the value of ret is
> > equal to 0.
>
> Does this mean Coverity is claiming that
> wait_for_completion_interruptible() can't return non-zero values? If
> so, can you figure out why Coverity thinks that? If that was true,
> it'd sound like a core kernel bug, rather than a uring issue...

Ah, nevermind, I missed the part where we only break out of the loop
if ret==0... sorry for the noise, ignore me.
