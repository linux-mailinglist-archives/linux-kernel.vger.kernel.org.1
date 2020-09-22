Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F006B274B12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIVVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:22:35 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39838 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:22:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id 7so11176545vsp.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNfsE0e5j0sjDrSbMU06dsnlI5tq+95f3KQ29B+CI20=;
        b=BqOwgo+2yTe5WmvoceJmxnno9DA9xCYr9jnSqK9yDlvM1ofqt0mi22pQUmZsHOeC8G
         HctoXzyZJhxRmN5/GEp0Vo/pldJlYxCmywgrfRrJuhWlFrAMjWGsqmqrHCZqV7RoBy/V
         /EGopSpkIcK8K0zCkqADjyX6Jyh513Wq5k4Bv6rfj/T4IURKKq1xwvad2WstsHcovtMY
         uA4vMdWqRmuqEnL/EMlCvbp+1AstGe9opWYLtXtxt3rEvpOztQgnLA3cr1XEWK/1jdYs
         EXsS23yJIwA/b/9Bm1XWzJkPzoP/8kic+1r8RK6bjcpTsBybTtcTvZQ3qQlSrHXzSxsj
         RIow==
X-Gm-Message-State: AOAM533YN3RAC7jtwHDXBTWpWgUigWoLf8nwVGKPIKsRw7BLJyRswCB0
        AvNqhWZ+Li8gaqrS5D8IWohX5ut/Z+ZXS7s8OzkyDnHppZw=
X-Google-Smtp-Source: ABdhPJzNRd7B2R7QiAPHviF5QusJT5P0Eo+vC2zhxf2IS/6iuwUDz7oG9NnbchSGGWa7yTlgf9ajqRRNHPP4xJEzJMU=
X-Received: by 2002:a67:6954:: with SMTP id e81mr5330189vsc.0.1600809754259;
 Tue, 22 Sep 2020 14:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200922210510.156220-1-lyude@redhat.com> <CAKb7UvhAb0wFd9Qi1FGJ=TAYZJ9DYXL6XXMfnG49xEO=a9TuYg@mail.gmail.com>
 <7b10668ee337e531b14705ebecb1f6c1004728d6.camel@redhat.com>
In-Reply-To: <7b10668ee337e531b14705ebecb1f6c1004728d6.camel@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 22 Sep 2020 17:22:23 -0400
Message-ID: <CAKb7Uvj++15aEXiLGgSZb37wwzDSRCetVT+trP6JNwhk8n-whA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in nv50_dp_mode_valid()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 5:14 PM Lyude Paul <lyude@redhat.com> wrote:
>
> On Tue, 2020-09-22 at 17:10 -0400, Ilia Mirkin wrote:
> > Can we use 6bpc on arbitrary DP monitors, or is there a capability for
> > it? Maybe only use 6bpc if display_info.bpc == 6 and otherwise use 8?
>
> I don't think that display_info.bpc actually implies a minimum bpc, only a
> maximum bpc iirc (Ville would know the answer to this one). The other thing to
> note here is that we want to assume the lowest possible bpc here since we're
> only concerned if the mode passed to ->mode_valid can be set under -any-
> conditions (including those that require lowering the bpc beyond it's maximum
> value), so we definitely do want to always use 6bpc here even once we get
> support for optimizing the bpc based on the available display bandwidth.

Yeah, display_info is the max bpc. But would an average monitor
support 6bpc? And if it does, does the current link training code even
try that when display_info.bpc != 6?

  -ilia
