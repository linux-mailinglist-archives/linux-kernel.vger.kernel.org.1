Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0B27D4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgI2RsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728198AbgI2RsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:48:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601401695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLjQ0rN6KmnUItq2ER6jfhjpvWS6hMbKwqFF/tMKmWg=;
        b=aK6qOtB6fa/EXiWAC9OE0Xrm7SJlCBknb/u3eXDMoJmDrCVSY17pI8ktqdVVbnJUHeOtg/
        qCKEN8BFTisy7hLduInS5RDSFcJas5G+7WI4cNNb0hrP7JK7TDUN36OeIKXIH/3TJmUPfu
        ES1xCIFgVqBpqq5jgDA0IvmMhfl0rjs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-rqPEZSGYNbS2-cwKFrPg0g-1; Tue, 29 Sep 2020 13:48:13 -0400
X-MC-Unique: rqPEZSGYNbS2-cwKFrPg0g-1
Received: by mail-qt1-f199.google.com with SMTP id r22so3613085qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=SLjQ0rN6KmnUItq2ER6jfhjpvWS6hMbKwqFF/tMKmWg=;
        b=A3BynCI3ka3RpHOmdrdKFo8lBhJlI/AQwGkxXiAuYBPZk3ncg60C1+G1SdxYwz50OM
         FceBWxBBAejLqNphkLznZoCSGVC3vi5Pm4EC7OATJ9LuTnornoPXirF8lXmhM7cnyg+C
         xjU10SRaJ0q0aC5vAzTL5FJaGkb/BMFZhAY/QJngNqpBU1t6yY5ShKWGEbsAfxHknR10
         qsKqSrfX/6n9Y838VldgRirk27Z/vcWJqIjZfXonf3RzwPkVVYSXcjPx4IgMLLjNHbDk
         5n0ldRK47ogBO01IE20k+pHYf9fQloDBqOCRFjURdm8T2rwrj2U/bNZSBiNabZCUKWpv
         6tuQ==
X-Gm-Message-State: AOAM533m//mYwg1F5yHnzPYn4A6h4YwumnuFSiHWVDSNe8WYunj258P1
        MM3mWk24mx1I/sYWm35Is7+ZOkEKnQw55mdepM+abrCMxNQmgJi4F/ioVrK6GgJzwthdKs6PqUd
        s7thtluu4j86brj9Q08g8zs3J
X-Received: by 2002:ac8:1b57:: with SMTP id p23mr4500321qtk.180.1601401692778;
        Tue, 29 Sep 2020 10:48:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDi8khABJj1dSyzdi5wQpCFlW4vQgrea5dK3AQJJbNFGbQvR4aQUB8Yf1ylyDkNIfBiCARFA==
X-Received: by 2002:ac8:1b57:: with SMTP id p23mr4500303qtk.180.1601401692444;
        Tue, 29 Sep 2020 10:48:12 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id e58sm487995qtc.92.2020.09.29.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:48:11 -0700 (PDT)
Message-ID: <123dc7e767889fe0f58734cb8b56630c5c0b3aba.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in
 nv50_dp_mode_valid()
From:   Lyude Paul <lyude@redhat.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 29 Sep 2020 13:48:10 -0400
In-Reply-To: <CAKb7UvgL_rV73BqvVoZsagy+_+cnBios1pKazq064D51NdAuqw@mail.gmail.com>
References: <20200922210510.156220-1-lyude@redhat.com>
         <CAKb7UvhAb0wFd9Qi1FGJ=TAYZJ9DYXL6XXMfnG49xEO=a9TuYg@mail.gmail.com>
         <7b10668ee337e531b14705ebecb1f6c1004728d6.camel@redhat.com>
         <CAKb7Uvj++15aEXiLGgSZb37wwzDSRCetVT+trP6JNwhk8n-whA@mail.gmail.com>
         <8bd8ee03f88e7e674e0ea8c6d63d783777cfe414.camel@redhat.com>
         <CAKb7UvgL_rV73BqvVoZsagy+_+cnBios1pKazq064D51NdAuqw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-25 at 19:53 -0400, Ilia Mirkin wrote:
> On Fri, Sep 25, 2020 at 6:08 PM Lyude Paul <lyude@redhat.com> wrote:
> > On Tue, 2020-09-22 at 17:22 -0400, Ilia Mirkin wrote:
> > > On Tue, Sep 22, 2020 at 5:14 PM Lyude Paul <lyude@redhat.com> wrote:
> > > > On Tue, 2020-09-22 at 17:10 -0400, Ilia Mirkin wrote:
> > > > > Can we use 6bpc on arbitrary DP monitors, or is there a capability
> > > > > for
> > > > > it? Maybe only use 6bpc if display_info.bpc == 6 and otherwise use
> > > > > 8?
> > > > 
> > > > I don't think that display_info.bpc actually implies a minimum bpc,
> > > > only a
> > > > maximum bpc iirc (Ville would know the answer to this one). The other
> > > > thing
> > > > to
> > > > note here is that we want to assume the lowest possible bpc here since
> > > > we're
> > > > only concerned if the mode passed to ->mode_valid can be set under
> > > > -any-
> > > > conditions (including those that require lowering the bpc beyond it's
> > > > maximum
> > > > value), so we definitely do want to always use 6bpc here even once we
> > > > get
> > > > support for optimizing the bpc based on the available display
> > > > bandwidth.
> > > 
> > > Yeah, display_info is the max bpc. But would an average monitor
> > > support 6bpc? And if it does, does the current link training code even
> > > try that when display_info.bpc != 6?
> > 
> > So I did confirm that 6bpc support is mandatory for DP, so yes-6 bpc will
> > always
> > work.
> > 
> > But also, your second comment doesn't really apply here. So: to be clear,
> > we're
> > not really concerned here about whether nouveau will actually use 6bpc or
> > not.
> > In truth I'm not actually sure either if we have any code that uses 6bpc
> > (iirc
> > we don't), since we don't current optimize bpc. I think it's very possible
> > for
> > us to use 6bpc for eDP displays if I recall though, but I'm not sure on
> > that.
> > 
> > But that's also not the point of this code. ->mode_valid() is only used in
> > two
> > situations in DRM modesetting: when probing connector modes, and when
> > checking
> > if a mode is valid or not during the atomic check for atomic modesetting.
> > Its
> > purpose is only to reject display modes that are physically impossible to
> > set in
> > hardware due to static hardware constraints. Put another way, we only
> > check the
> > given mode against constraints which will always remain constant
> > regardless of
> > the rest of the display state. An example of a static constraint would be
> > the
> > max pixel clock supported by the hardware, since on sensible hardware this
> > never
> > changes. A dynamic constraint would be something like how much bandwidth
> > is
> > currently unused on an MST topology, since that value is entirely
> > dependent on
> > the rest of the display state.
> > 
> > So - with that said, bpc is technically a dynamic constraint because while
> > a
> > sink and source both likely have their own bpc limits, any bpc which is
> > equal or
> > below that limit can be used depending on what the driver decides - which
> > will
> > be based on the max_bpc property, and additionally for MST displays it
> > will also
> > depend on the available bandwidth on the topology. The only non-dynamic
> > thing
> > about bpc is that at a minimum, it will be 6 - so any mode that doesn't
> > fit on
> > the link with a bpc of 6 is guaranteed to be a mode that we'll never be
> > able to
> > set and therefore want to prune.
> > 
> > So, even if we're not using 6 in the majority of situations, I'm fairly
> > confident it's the right value here. It's also what i915 does as well (and
> > they
> > previously had to fix a bug that was the result of assuming a minimum of
> > 8bpc
> > instead of 6).
> 
> Here's the situation I'm trying to avoid:
> 
> 1. Mode is considered "OK" from a bandwidth perspective @6bpc
> 2. Modesetting logic never tries 6bpc and the modeset fails
> 
> As long as the two bits of logic agree on what is settable, I'm happy.

I gotcha-I guess I was just confused because this is already possible with the
current code we have (and it was also possible before we started adding these
checks into ->mode_valid, which is why I need to get to the max_bpc
thing soon). I guess I'll just use the connector's reported bpc for now until
we add support for that
> 
> Cheers,
> 
>   -ilia
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

