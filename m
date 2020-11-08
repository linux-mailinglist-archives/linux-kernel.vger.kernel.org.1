Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1D62AAA85
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgKHKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:13:57 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 02:13:57 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r186so4442922pgr.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 02:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Niz+n261DImQVhhgmrvxBvs3fMRh5BLrTtRcyzJ80Bw=;
        b=aTQ3AEh3hzdobPVrIItbRf3WnmhfxueZJjSyVP/5IiRP0mvL+DlhLQxoE/lB4Gx44u
         Yqk9EyHB/8b5Qahn+jN9DJeH1Z4wdTE0VieCAszVsQBDkcEtXk6pKKhfrXUUPGOGQmbn
         lLKgv39NLqBdI5Xeuo24zIqXuUnbLnxABfZBGNztMo7vEhY8BsqRLwBca8RSEwrVSTkI
         uVgplPnLDHAxlosRSpzPiU0cDl/H6RE+NY26X2ArY9KxWLMSQE2LUAxp1WATy651oaaf
         3TQhwCJRIS6M+EYKlbBYZyU8c9SdN3E0x+1EcJ7gvgJzPeBBuVeOxzX+m/wSEPuxwcSM
         DXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Niz+n261DImQVhhgmrvxBvs3fMRh5BLrTtRcyzJ80Bw=;
        b=E+iPagHiePlETseUB0woQJ6wEIzo5WDTVwODqJDN75WrddK/aDCjWk39ZTd6d0N0R7
         lF0Oo97sJiqe5GGheuNWGGpYeUgLnJ9xFR38/9IOV3O8dB1qUvAygMlpqACRI3PGzUeA
         dJzNAjmEErFlYM+paikYIkC4z2a9aw+h6DvJDi2b0yCojItlaWE2A2z3nzC5538jB4C0
         wXVWWhjMEGTgdQJsRL3ki/Bt1qGpqkdNCDHZV6KgjK4dYzNrlgtlTvozqByx75gFh6W/
         kOpiBtcHAe9uSU/paZrTwUbOPvbzPmFO6+5AhPg7ScaCrBMQ/4ThqkCPCOOm1Lo5qGO4
         cu7A==
X-Gm-Message-State: AOAM533LtsEkFFV9mXbBXLljgl5k93JeBd6vBohRiFgUOk1c0XdE1HVg
        OkA5ctbG4PANQ2L4AT18Xfo+qPAgqds=
X-Google-Smtp-Source: ABdhPJx6IRspSUFI/tX90nuGn0travXG9LJOr8Y6JAgcUS+o7nrKnLo94IhP7sZYteJXkY13qkeuvw==
X-Received: by 2002:a63:2b4f:: with SMTP id r76mr8520949pgr.194.1604830436723;
        Sun, 08 Nov 2020 02:13:56 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id a184sm7900538pfa.86.2020.11.08.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 02:13:56 -0800 (PST)
Date:   Sun, 8 Nov 2020 15:43:51 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/vc4: replace idr_init() by idr_init_base()
Message-ID: <20201108101351.GA41922@localhost>
References: <20201105202135.GA145111@localhost>
 <CADaigPXM8NAZFAydXwcZt7ie_aK1aO8C=jqssA375sCMgU_gHw@mail.gmail.com>
 <20201106105249.zvyd36shfec24lzn@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106105249.zvyd36shfec24lzn@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:52:49AM +0100, Maxime Ripard wrote:
> On Thu, Nov 05, 2020 at 01:24:14PM -0800, Eric Anholt wrote:
> > On Thu, Nov 5, 2020 at 12:21 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > >
> > > idr_init() uses base 0 which is an invalid identifier for this driver.
> > > The idr_alloc for this driver uses VC4_PERFMONID_MIN as start value for
> > > ID range and it is #defined to 1. The new function idr_init_base allows
> > > IDR to set the ID lookup from base 1. This avoids all lookups that
> > > otherwise starts from 0 since 0 is always unused / available.
> > >
> > > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> > >
> > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > ---
> > > Changes since v1:
> > >    - Change suggested by Eric Anholt
> > >      1. Use VC4_PERFMONID_MIN instead of magic number 1
> > >
> > >  drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> > > index f4aa75efd16b..18abc06335c1 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> > > @@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
> > >  void vc4_perfmon_open_file(struct vc4_file *vc4file)
> > >  {
> > >         mutex_init(&vc4file->perfmon.lock);
> > > -       idr_init(&vc4file->perfmon.idr);
> > > +       idr_init_base(&vc4file->perfmon.idr, VC4_PERFMONID_MIN);
> > >  }
> > >
> > >  static int vc4_perfmon_idr_del(int id, void *elem, void *data)
> > > --
> > > 2.25.1
> > 
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > 
> > hopefully Maxime can apply it.
> 
> Applied, thanks!

Thank you all. Appreciate your time.

./drv

> Maxime


