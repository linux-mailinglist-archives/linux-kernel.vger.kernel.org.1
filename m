Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321DC28CC18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgJMLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgJMLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:00:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF15C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 04:00:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j136so21293387wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WA80PNkrI5C0OQNWClQ/raYkEl8VgDyVTNL1YpNDBQ=;
        b=WVOC2aTpPMXchRQn3hfbZminS4eshLiFulE0QKi7EhDNBaEJkX+sKXPuhyKYHL5elw
         9xDVhp9goIz4QeQm/DU7mWbkwLD99EQdpdO17AhjEw2FGJFQ7+HudYN2goj7L7PDWqNK
         DrFAj3g9FgdvxqnncZQhYTUIdq0YMfnmedSYCKyvZqaYNEE46JKiAIq/bsUYvHoe71xK
         RbWrf7ZwUWhZe3mqD0eYeM6ZCmpqfmGWg9oCQ2cmp0DCEKt2Ny2JKldng4yOSu+hdFuE
         u2+45lmoGfn5WES58TOmR/71j80KhwPvECg54YrSkAzQ+7lk9xfbAqgAshx+qHuiqE4/
         fSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WA80PNkrI5C0OQNWClQ/raYkEl8VgDyVTNL1YpNDBQ=;
        b=uOrjQtmWTWjHpBUg13yFlK2iLOZaTVqYofna/gar/oyRCq5nspr1L0iGCW7gQXZdOE
         1lmcJdkm9V/6x/dGyGNqvwFOD1e2LlbzGrBQlFGJ/sC04fa6fpHasUGhKnM4qV4MJpVO
         3kVIW7xRrrkLWlhUmVriyr8l6tBsUhQFTXXIe/Wx674vQvtqpL78ZBNsZuy9BoFhKkKV
         47Urd6So2ABpZeLOAdWOqDX+6L7P42r9VUXIf1U9OaBYgA87uI9X96Q2bAni9MxpIvHO
         WcOvu0ndbGuHqpUnV4rFT9X1IaRyz4rILxYlDwbpIxR3D6/20FQXOwO1sUDIJLpzuvyT
         S50w==
X-Gm-Message-State: AOAM531PIOPdNT0yxSP3iuvtMrTHcuYyRFd9vwmnmOg7NGpV3MwNM51r
        KclNScb4cR+pJ/viHWrScbQFGDf6u2Ygth0stwo=
X-Google-Smtp-Source: ABdhPJz2Emc612AGRQCJLTyQrTiQtni6Jj8EdvwE6fdWKKt9ZMRSVNmj7ycQo+5/Z3iP7aLNrwJCaI38aCViU8RMat4=
X-Received: by 2002:a7b:c317:: with SMTP id k23mr14424626wmj.44.1602586815306;
 Tue, 13 Oct 2020 04:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
 <20201012190037.GB17643@Asurada-Nvidia> <CAEnQRZBrXNgMDNgQ=dMJfZQpZvdq6sUx2y21_fuk9teRd5UM0Q@mail.gmail.com>
 <CAA+D8AOCR+Hvq9K=LjbaPW0jJB+00nFORahErWyJJJr0LVUq4g@mail.gmail.com>
In-Reply-To: <CAA+D8AOCR+Hvq9K=LjbaPW0jJB+00nFORahErWyJJJr0LVUq4g@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 13 Oct 2020 14:00:03 +0300
Message-ID: <CAEnQRZBbTBtJDLy9XNAFHa0hcuoU3c66kQVKsQR7MTo40NJF7A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 1:49 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> On Tue, Oct 13, 2020 at 6:42 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 12:29 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > Hi Shengjiu,
> > >
> > > On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > > > Add 88200Hz and 176400Hz sample rates support for TX.
> > > > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > >
> > > Probably should put your own Signed-off at the bottom?
> >
> > Hi Shengjiu,
> >
> > Also please keep the original author of the patch. You can change that
> > using git commit --amend --author="Viorel Suman <viorel.suman@nxp.com>".
>
> Actually I combined my commit with viorel suman's commit to one commit,
> not only viorel suman's.

I see. Ok then :)

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
