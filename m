Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52051B3463
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDVBQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 21:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDVBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:16:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3CC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:16:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so735909oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZAB7lOGfupOo4knhmJHwegkG6G2R+Ivec9h4JrnPCY=;
        b=TBCmMaM4nW1BKdzeRNHxyhsxN7yHhlFd+e3vnicrWjkCfrdVwe56nyBewfNqYv51hD
         zy0qJLA6SzEhUAWAfa/QwRO5kUXJA7G9q6BlkVdMqU8xGLXwUKql6DzwtadxE0W6JxGG
         3MFKuQSAfouttoL5apcl/QzbuMG44XGeJWvpYK+90ozMgxBEMDjVe0Bbu1yXWwGW6eCo
         HOInPnB8UsZpi67xElpb1e7lCOtrBSMGoR2ld2cq8DxROVmcPh8u/zPoauE3uIDgHvQE
         fAol/uCIZm0f8TpjBO1EcVnELCbSBeDWXcTa5uhsNPkx4kWMyIUHksxPgfRVBctqWHaK
         b42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZAB7lOGfupOo4knhmJHwegkG6G2R+Ivec9h4JrnPCY=;
        b=sTufCroM1zfaZWFxBSJVgy+5BP4ja67kZrZJPESrD24Wk6IsOS9OiO2VitgaNV+bxZ
         Swf6dM1VL9rkhaAoxEovqoYZnZ8Od8pXgc22gA7Oe2pH4qemWDybSzCsYoj23T10WGUC
         c/sTxfuLWtGrFv2asLJa0wuF4umBG5hHSOnGsHXs7SkAHLSZ8j4JJ3bdhtMogpYckEVP
         2QZIb7VPGSkdYoAKIGElj5MdTIyigxWq1P7GMyMzuixzE8XZwcJfFfYFwG7EowGmHNHg
         uJhfVzcd1NChmRbwyok2fFf6ItnrB3YLNtJFvthszevs7HJafXESJe8MBlqvc1mAszmo
         onMQ==
X-Gm-Message-State: AGi0PubtAVG1sRTjLBEyy1OkHvfii2gWE/CG54tSUupW8ug2HW7nt7IL
        Lx78BGhPY7Xk7KlYcNAR8Wbe46ExIUcAlPxL3GBjxg==
X-Google-Smtp-Source: APiQypIzDPILAHh9p+2DyPNQ/95jPeU/YiMoZZ68Ru0vZToWV9S8nIGlpBgVkOZhkoTziFYp8meUCUyRS6+Zk8j7m9o=
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr16604890otr.102.1587518203493;
 Tue, 21 Apr 2020 18:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org> <20200421235836.GA8319@lxhi-065.adit-jv.com>
In-Reply-To: <20200421235836.GA8319@lxhi-065.adit-jv.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 21 Apr 2020 18:16:31 -0700
Message-ID: <CALAqxLXX455P0V0o11scc3-1MHvecnvcUoT=XBcwB+ma7Kyjqg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] driver core: Improve and cleanup driver_deferred_probe_check_state()
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 4:59 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> Hi John,
> Cc: linux-renesas-soc
>
> On Tue, Feb 25, 2020 at 05:08:22AM +0000, John Stultz wrote:
> > This series goal is to improve and cleanup the
> > driver_deferred_probe_check_state() code in the driver core.
> >
> > This series is useful for being able to support modules
> > dependencies which may be loaded by userland, far after
> > late_initcall is done. For instance, this series allows us to
> > successfully use various clk drivers as modules on the db845c
> > board. And without it, those drivers have to be statically built
> > in to work.
> >
> > Since I first sent out this patch, Saravana suggested an
> > alternative approach which also works for our needs, and is a
> > bit simpler:
> >  https://lore.kernel.org/lkml/20200220055250.196456-1-saravanak@google.com/T/#u
> >
> > However, while that patch provides the functionality we need,
> > I still suspect the driver_deferred_probe_check_state() code
> > could benefit from the cleanup in this patch, as the existing
> > logic is somewhat muddy.
> >
> > New in v5:
> > * Reworked the driver_deferred_probe_check_state() logic as
> >   suggested by Saravana to tie the initcall_done checking with
> >   modules being enabled.
> > * Cleanup some comment wording as suggested by Rafael
> > * Try to slightly simplify the regulator logic as suggested by
> >   Bjorn
> >
> > Thanks so much to Bjorn, Saravana and Rafael for their reviews
> > and suggestions! Additional review and feedback is always greatly
> > appreciated!
>
> Building a recent [0] kernel using vanilla arm64 defconfig
> and booting it on H3ULCB, I get buried into backtraces [1].
>
> After reverting this series, up to and including its first commit,
> booting goes back to normal [2].
>
> Any chance to get a fix or at least some hints where to dig into?

Yea. There's two patch sets I have for this. The first quiets down the
warnings(we don't need stack dumps for these):
  https://lore.kernel.org/lkml/20200330202715.86609-1-john.stultz@linaro.org/

The second reverts the default timeout back to 0:
  https://lore.kernel.org/lkml/20200413204253.84991-1-john.stultz@linaro.org/


Let me know if those work for you, or if you're still having trouble
afterwards.  I need to resubmit the set as I'm guessing they've been
overlooked.

thanks
-john
