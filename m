Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041E01E9C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 05:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgFADmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 23:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgFADmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:42:00 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04645C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:41:59 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id k18so631233ybm.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYmBlz5UTewvMo6VU7zofeZb2KwsJcE+c5rzEdcDxAs=;
        b=TNGRzCS1pVr/YFvfdNCKPdt1UNOXloplCFlL8JiwhG880Op453GRDwDjrwSB17N5rY
         SL0Bq08xdeW+wGuyQmAnUPJe8/z16qEGO9oG5PcSqKySJyqiuWCQUQPePgg2qAT6OjDd
         FmCwqnWlAiWIxcCev45E1PDw3lzSgsI7pTf9qoCqRDpDVY7H7XHP+r9RISD3aeRIILQ+
         2s45+RwemqIAmA3Rdxr285xYiKGYuASRCgKh66HZ4y9ucVd79na1q1eU+myW85sl5NGL
         USY/cGKx15a6PlPLklngEWs1ynzK5GbJhi1wj7A15z2UgfF6ZYbo9ciC2cZHIz7c8tL1
         uClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYmBlz5UTewvMo6VU7zofeZb2KwsJcE+c5rzEdcDxAs=;
        b=irsYtDoEJtum3hz6gFUGTx6QSIMBp0+asXS2XHgQTTeux+BHRjOqbiZhK3bRIl5r62
         onKtlHlDgyOw3Ex1wquHVZmnXdiO3GcOuc/ChAOfiaQza21gdP7/DYXPXEKlNGsJ8s9W
         FUklF3QvXa/QnCKsktMsgODIs7hszWUlI1W00R5xb9ul+0YA5jbKCk+bAiKELsiD3lhL
         9G7Ant4O8d8RQFsuXCOW5Ol2AgWDugKUKAFVMs7PLhrL7OPf9ERwysb79pTw+0lL3X3t
         L063ncQGGoKVsOcXkAEei0smSf7cXxNLxdn63kML5B3LAzgB+jbqXD9b+MEm4o9LNpP5
         Kjow==
X-Gm-Message-State: AOAM530wJWFiYjQOtP+9t9boyYZZ78SgPvw90jywRgabIVQG2htvmxJx
        dQAx3Gjg/ZxqTxsvyl3RHQiny4ne/2ntBIWxN0I=
X-Google-Smtp-Source: ABdhPJySmAErk26rEvDftoaHaCg1eBbzZB3s3cyagkr2yK8Ypc9yi/+QiwUHA42lTGn9VL0ushxpCL1O8VZURDrHLm4=
X-Received: by 2002:a25:8b02:: with SMTP id i2mr30981552ybl.283.1590982919170;
 Sun, 31 May 2020 20:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200529080042.6082-1-dinghao.liu@zju.edu.cn> <CACAvsv73wZK_pKk4TDHaTeBUqxYHvK0KhLQBgPC8Be_VviY2jg@mail.gmail.com>
 <6a65a5b1.dd4b7.1726deaea0a.Coremail.dinghao.liu@zju.edu.cn> <CACAvsv5kcUC_kOfMPxqY-irSAexmhm=WKO8Vk=wTZWdsbaartw@mail.gmail.com>
In-Reply-To: <CACAvsv5kcUC_kOfMPxqY-irSAexmhm=WKO8Vk=wTZWdsbaartw@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 1 Jun 2020 13:41:48 +1000
Message-ID: <CACAvsv5t2gWDae_8b0-fH9e8fzgmxfiUtZTPeFuhmKXDFAmvGw@mail.gmail.com>
Subject: Re: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in gm20b_clk_new
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 at 13:37, Ben Skeggs <skeggsb@gmail.com> wrote:
>
> On Mon, 1 Jun 2020 at 13:27, <dinghao.liu@zju.edu.cn> wrote:
> >
> >
> > Hi Ben,
> >
> > > > When gk20a_clk_ctor() returns an error code, pointer "clk"
> > > > should be released. It's the same when gm20b_clk_new()
> > > > returns from elsewhere following this call.
> > > This shouldn't be necessary.  If a subdev constructor fails, and
> > > returns a pointer, the core will call the destructor to clean things
> > > up.
> > >
> >
> > I'm not familiar with the behavior of the caller of gm20b_clk_new().
> > If the subdev constructor fails, the core will check the pointer
> > (here is "pclk"), then it's ok and there is no bug (Do you mean
> > this?). If the core executes error handling code only according to
> > the error code, there may be a memory leak bug (the caller cannot
> > know if -ENOMEM comes from the failure of kzalloc or gk20a_clk_ctor).
> > If the core always calls the destructor as long as the constructor
> > fails (even if the kzalloc fails), we may have a double free bug.
> >
> > Would you like to give a more detailed explanation about the behavior
> > of the core?
> If there's *any* error, it'll check the pointer, if it's non-NULL,
> it'll call the destructor.  If kzalloc() fails, the pointer will be
> NULL, there's no double-free bug.  *every* subdev is written this way
> to avoid duplicating cleanup logic.
Actually, gm20b_clk_new_speedo0() may have a bug here if kzalloc()
fails as it doesn't overwrite the previous pointer from
gm20b_clk_new().  That whole ctor() sequence is written a little
strangely.

>
> Ben.
> >
> > Regards,
> > Dinghao
