Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C325F085
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIFUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIFUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:34:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF16FC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 13:34:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i26so15332204ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1u31zWVb/xtq4zWR8IqXITU9cST43X1jVmMQ6Khtjc=;
        b=AAEd7uDisMvj4IWWY6cwd8eKB+Uv8KPC+pbb5PxuYD1RHISfNs+aPzznszKIKHBqoK
         bJsnaBlytKPe8VEi7sCD0zvUhBp9pNeAlGklp2wW3TG/fSLPVxRfqPmvADw8h0FhmCNM
         vJ7He/a/9u+mkXEuu2fw4WwhGfjCXRvkmnxoYVgcx6GD9bkY5yVmgzcQWbZOcXHb2Nxp
         C7ag1TinV+RKEGX3W1p+1gprj4db+2JWvMw1T2uF5rYDTAtM+g2GrHWyI2sCNTYwCEuH
         j859J70xtr6YNFWUZ549ZzRwA92/bXuOuZAKCT6y2jRX7+RpcuzylfAj2mXOotcmr922
         vjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1u31zWVb/xtq4zWR8IqXITU9cST43X1jVmMQ6Khtjc=;
        b=QV9yzGoUWCOXTPlG7Kj4D63fGdYiv9qnEszO9iougwJRhfauhIBahp20XORNb9uaMv
         vONaX8tAAfEuiLf87RR5QyCjY2A01BQ5dDrNCB58z/A8deErV9twXxqlbke8e+1Wk/sT
         uyYcjCbhPX3gQi48s9JGpEJXJBOYCVn4KLtzSuzjwviGEIBAVOy1cabojveQSTUpmbcs
         plILOsgpyMyUJyo7ooAaG/kdZP+ajEABUTlz819OMwS9OKIDcepmC/BXtRAKmssxiOUo
         Ay3+iWh5m4+riXBPovHm6ZjB4RB6rd8V+VwjC8v7xvnomz9KQJqfHRyW7HBVv2B4kWuQ
         mJxg==
X-Gm-Message-State: AOAM5330ddn7itGP2pv0kYxtA3ulnhprHcohuoLNUNKoLqj/hfm7j7Uk
        9KJFgzZlZDMTbcKgAiBvR5dgrQdmg9IENV0vEZ1b5d/FS/Y=
X-Google-Smtp-Source: ABdhPJxAue3rsrq47sfL7omIfmy8aw6NF/OD0xZvrgtLITJBii6+t2OQIFBK3GPcND0H6OJvig0iUSQasoRFiOHwlPM=
X-Received: by 2002:a17:906:813:: with SMTP id e19mr17716996ejd.101.1599424435566;
 Sun, 06 Sep 2020 13:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
 <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
In-Reply-To: <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 7 Sep 2020 06:33:43 +1000
Message-ID: <CAPM=9tzOBOAiMXP+59x_n1Spsk4gz1cGjfnyXQj2deHaiRhSFg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.9-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 at 05:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Sep 3, 2020 at 8:53 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Not much going on this week, nouveau has a display hw bug workaround,
> > amdgpu has some PM fixes and CIK regression fixes, one single radeon
> > PLL fix, and a couple of i915 display fixes.
>
> Any movement on the i915 relocation issue? I've only seen the one
> report for the 64-bit case, but clearly there was more going on than
> just the missing page table flush on 32-bit..

I'm going to pull in the reverts this week I think, Intel are changing
some part of their patchflows to me, but the 5.10 queue had to revert
some stuff in this area for other reasons, so I'd like to sanely get
those into 5.9 as well.

Dave.
