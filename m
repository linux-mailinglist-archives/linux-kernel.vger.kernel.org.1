Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47282883E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgJIHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgJIHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:47:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E72CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:47:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m9so7252400qth.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAiaW+93Fl44jRzXXS4wP2VkVubvR/5JY7dN1rt4R24=;
        b=W2/Ti3kYbkEU5RKCfPrBtOvrhfe9cr5iuuAldgjQ7SvTctTZBqQB3etOoQUyfT1pjh
         9uLIyPpE3dMy91CHV8oruvhojOvHgUTEGe0B1p52ndlkMEoY9sf9xwsZ8MwshknuqA4f
         jpAFBR0c47xN5bTpItg86xQwUfhypUtNqWUPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAiaW+93Fl44jRzXXS4wP2VkVubvR/5JY7dN1rt4R24=;
        b=NPk354q9vMnQqVXri7MTcdcRQe8h9ws7PsPXo8jn1eRq6nawPFzVxh9AGgCND2yCiu
         MMHJ49F+O9eRuFMfQvq1H0gd3yPsMis3nD10i6ca3977w+dV0kMjCj/P0HVqefcM1PQg
         4I4GH9UIaRSPv+YF1RJefUGQR2f803RaMWkNAr2J3PkOwTrmRwRdsrieDhOtQ3ptTxyM
         F5N6q6P7npVGAb1dglTmhsIYxnfthvxC3lJjmDnMlePv/COshvFXAcLAvvEcD4PT1ChS
         pzkSQbntBX2uv3proWCWZaCjsZd51I5yK+NQgJ+Uqnx6cGlmq6YN9eisQcPkWRvxBjXB
         h64g==
X-Gm-Message-State: AOAM530SG0j9WpQ8SJPJigo3j5RvIY8OT2s7CrI3dzgW7XtHm0i4J+16
        RMYOvlKrRSvWjRElnj/jAU5/B0xLfIexKKM9BxrwWMtt
X-Google-Smtp-Source: ABdhPJzaS4AsDvCUEmHGRC+WwFuD4vOUEpxsmXwUsmKQfLl5+lxXtC5MeHCenesLqwiwzmORkg0T9r/PACyAmMvdq7A=
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr12339910qtr.385.1602229656436;
 Fri, 09 Oct 2020 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200222235152.242816-1-megous@megous.com> <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
In-Reply-To: <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 9 Oct 2020 07:47:24 +0000
Message-ID: <CACPK8Xd-o+5xA=T12yR6+gxmpvwkqi_VjU10MpsLVzh0e2dKnA@mail.gmail.com>
Subject: Re: [PATCH] drm: aspeed: Fix GENMASK misuse
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Ondrej Jirman <megous@megous.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR ASPEED BMC GFX" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 at 00:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Sun, 23 Feb 2020, at 10:21, Ondrej Jirman wrote:
> > Arguments to GENMASK should be msb >= lsb.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> > I just grepped the whole kernel tree for GENMASK argument order issues,
> > and this is one of the three that popped up. No testing was done.
>
> I think someone's sent a patch previously, and last time it turned into a
> discussion about how the macros aren't actually used and could be
> removed.
>
> Regardless:
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks, I've applied this to drm-misc-next. Apologies for the delay.
