Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA7286316
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgJGQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgJGQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:03:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21295C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:03:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so1266803pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/YizpSukiZJTtNoLgWG6EzWmeqvv1MxbPNrBeNGsNyg=;
        b=SAJM/mHJTStiuwA/RXNIoEd/I1RF/1l9WpZ5YL41ULWYJBAAyRf4Hb3TS8iEwXAuP9
         RQx2iC/ixOqG0x7N+rNlcXNzqyGtWEaifDz0VEJXVx6hFkBFzXxwLcoHfAwTSEhIPzAS
         kkKb0hPUlzw22XBw3Fxw1empMhbvA/prllVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YizpSukiZJTtNoLgWG6EzWmeqvv1MxbPNrBeNGsNyg=;
        b=AiCG6LHRzkDPqgRg1GQmF1nl+ThYpz7c3qFI+e11Kx89rnIMsrZcrRVEl/k6cdvdDJ
         JaGZirHXTD4O+cUyVLDeGyttr/jj9m7xuIUf7kR/Nd2DtakM4fk6qnW7omlNOJZ79bZc
         v4RVg80wZxNh3VdhIo/fdoZbkL/bTqdvIArJV2BN9MWCUR3EeJ+FwJAU4TNRcALGh3lV
         6iuomx5dvr0+Lz2q14UgTwwbpQWcU44Y2jysRuoq2LSUHVyp6+OrRUht5dWBEVWsBOab
         mFP04ftXRzGiazq20LClkgRjHe4eCTLIQqt/j5rpoY9cuu/gV4f5RRbt5VsGcsob4wJS
         FUJA==
X-Gm-Message-State: AOAM531jp+aVg6Xmevc2GRdtkdJBt3UTBGli/eQYfvQN68vRMjtg47n2
        0WtAAJZylwXfhu8CZR3OMWPUhw==
X-Google-Smtp-Source: ABdhPJyLSpdm6PuJor4MO7EVpKE/G//lyvCubSlxpGwcoiZogSz0nxU/4ZrH3XYR4bO+fXpXRHdiog==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mr3408857pjw.106.1602086619344;
        Wed, 07 Oct 2020 09:03:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id x10sm3659982pfc.88.2020.10.07.09.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 09:03:38 -0700 (PDT)
Date:   Wed, 7 Oct 2020 09:03:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201007160336.GA620323@google.com>
References: <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007010023.GA438733@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:00:23PM -0400, Alan Stern wrote:
> On Tue, Oct 06, 2020 at 12:25:36PM -0700, Matthias Kaehlcke wrote:
> > On Tue, Oct 06, 2020 at 01:15:24PM -0400, Alan Stern wrote:
> > > You don't need a platform device or a new driver to do this.  The code 
> > > can go in the existing hub driver.
> > 
> > Maybe. IIUC currently USB drivers don't support/use suspend_late. Could that
> > be added? It would simplify matters, otherwise all hubs need to know their
> > peers and check in suspend if they are the last hub standing, only then the
> > power can be switched off. It would be simpler if a single instance (e.g. the
> > hub with the DT entries) is in control.
> 
> Adding suspend_late would be a little painful.  But you don't really 
> need it; you just need to make the "master" hub wait for its peer to 
> suspend, which is easy to do.

Ok, I wasn't sure if the hubs suspend asynchronously from each other. If they
do it should indeed not be a problem to have the "master" wait for its peers.

> And hubs would need to know their peers in any case, because you have to
> check if any devices attached to the peer have wakeup enabled.

My concern was about all hubs (including 'secondaries') having to know their
peers and check on each other, in the scenario we are now talking about only
the "master" hub needs to know and check on its peers, which is fine.

> > > Incidentally, the peering information is already present in sysfs, 
> > > although it is associated with a device's port on its upstream hub 
> > > rather than with the device itself.
> > 
> > That might also help the hub driver to determine its peers without needing the
> > 'companion-hubs' property.
> 
> It wouldn't hurt to have that property anyway.  The determination of 
> peer ports doesn't always work right, because it depends on information 
> provided by the firmware and that information isn't always correct.

Good to know, then we should certainly have it.
