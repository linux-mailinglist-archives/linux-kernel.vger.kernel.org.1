Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C3284A67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJFKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:40:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 03:40:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g7so12425975iov.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3N9Ir7AwETZEYchp6O5ROGzFeY+LkYxOP/aeOce9GY8=;
        b=v+ZGeZ7ngyPegpBtGP1U2YITv72KRHzHV6PqheZNf8Y3YxEZNsnLwajHcN/CXZ38Lh
         mMaO6lcc/ZrdYxHyUgeO5KpjijiSRTsv8SLRtlc42foWQlAFCL4UV7RDSKM9Q1e6zEff
         O94qzK0TtuU1KTH8s22KhnmcQkUoVkRv5I3izSmOGJt1ujb1Seq9SpGPmDBYilYdw/If
         k76OPrsW80P6LhCC5WziIuJhvAoEpmH7jPnbDAwzpjhVKHVj06oXiD4J68wHI5JyDusk
         QrmAXtDBOH4/jUK9IcGMmF2nK+UwK0uDcHuzJ5ZgdnT94qc1HUWxLLjimShmXCX4cDUB
         1wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N9Ir7AwETZEYchp6O5ROGzFeY+LkYxOP/aeOce9GY8=;
        b=uYKJpq5lbvie2TQnKdPFY8cNo10Vh3MTCXaTm9gRjsCqAEHz2Jj1bqQ+TRxSCYJ/QF
         QCeOGnCUwKNPf8vQHQd6m0ew4mlEijC4sZVtbrzUtpWdr+ORbftO+ylgRLuaJ25MGBsS
         K+tIlgNe7K3dch+VUmd+8PxSycRRam9TzJwcybEq/EEjydRsGP4YWCDBexBMy0R9GePK
         f4GaSJ4ORvzt7rHuLVmOEVOAhtqUMvlIPWpsUUvhz5QobmB6PMrZJj1V44L8LVwTEN+x
         mL4rMep2RfOrbDmb+6YKaUWsPLyxkAy4BBUBBNWruhR4gMADNFb2LnyVpvQ6in0wcGoI
         MxrQ==
X-Gm-Message-State: AOAM530Wa8WSMJ6CJi/1v7c6VYhVs/bwQmFAFqM/1ztmnTHdW8xSVRDS
        gg6p7e/rPfYbxuXQOYtbDs4PI1smCD5Uw1abcVBCCA==
X-Google-Smtp-Source: ABdhPJwhWTs3O+CaMcTl2EcNuJJ0tMcq1w56Ab0TiptOxR/LXZbuDey/kFa6PIxz/rK0QBXSvabwU0Mp7qQPUkac7Gw=
X-Received: by 2002:a02:6952:: with SMTP id e79mr597608jac.24.1601980811726;
 Tue, 06 Oct 2020 03:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200924124526.17365-1-brgl@bgdev.pl>
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 6 Oct 2020 12:40:00 +0200
Message-ID: <CAMRc=Mcwyy7N7xFRv8BcJiGcmhKb8Ed3YYXHOX9C=uxb+VNKNw@mail.gmail.com>
Subject: Re: [PATCH 00/12] samples: configfs: refactor the configfs sample code
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 2:45 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Over at the GPIO sub-system we have a testing module (gpio-mockup) which
> uses module params to instantiate simulated GPIO chips and debugfs to
> control them. We want to switch to a more stable interface using configfs
> to instantiate chips and sysfs to control them.
>
> For that we need the feature that's well defined in the docs but currently
> unimplemented - committable items. I started working on this but it won't
> be ready for this release cycle.
>
> In the meantime I also refactored the configfs samples a bit as I'll be
> adding sample code for committable items. I thought that it won't hurt
> to send the refactoring patches now for v5.10 so here it is. No logical
> changes really, mostly just code quality and removing usage of deprecated
> functions.
>
> Bartosz Golaszewski (12):
>   MAINTAINERS: add the sample directory to the configfs entry
>   samples: configfs: order includes alphabetically
>   samples: configfs: remove redundant newlines
>   samples: configfs: drop unnecessary ternary operators
>   samples: configfs: improve alignment of broken lines
>   samples: configfs: fix alignment in item struct
>   samples: configfs: replace simple_strtoul() with kstrtoint()
>   samples: configfs: don't reinitialize variables which are already
>     zeroed
>   samples: configfs: prefer sizeof(*var) to sizeof(struct var_type)
>   samples: configfs: consolidate local variables of the same type
>   samples: configfs: don't use spaces before tabs
>   samples: configfs: prefer pr_err() over bare printk(KERN_ERR
>
>  MAINTAINERS                        |  1 +
>  samples/configfs/configfs_sample.c | 78 +++++++++++-------------------
>  2 files changed, 29 insertions(+), 50 deletions(-)
>
> --
> 2.17.1
>

Hi Joel, Christoph,

Any comments on this? Can this still go into v5.10?

Bartosz
