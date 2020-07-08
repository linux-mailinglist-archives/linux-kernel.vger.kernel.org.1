Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CB21946E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 01:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGHXkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgGHXkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:40:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6154C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:40:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so173023qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4PTp29U09bBo7Lu4mXNnRRUq7S8vPBuFkBdJI6sHus=;
        b=OF77syHXcChzkEUs9+BXgXSMwR+t9jCMThFrfbzfZ8mPDG8ZkTNSRve3ok6gtHomro
         es/mzdU4UysFHM2uMMrlumrIe1BwnlfTylxQuLiPUgxYNS4EtuzocS02fWNwaDF2pJrR
         N0GaAZ11AdR/x8QVwjRq62IkDCPufE+hNzo7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4PTp29U09bBo7Lu4mXNnRRUq7S8vPBuFkBdJI6sHus=;
        b=V5hvX4ANFq1rLc9MlusNqLiHbJQiaU5cauEfmioxBTEUlXztMhDKGa7/zgbPkLiqjd
         dpvKnAiDA/G9H/wnSlvRS+5fBq29OoGRzyKxjzZGpJ/WjmGfo2rcq0juldrHCY0nmNLG
         nFBfCQbT32kYACqyZvZFfy93PSe6suqP+0zzlEQRAmr17KtTZp1Uz5eoWS+epU8NZE+G
         vb9L8TavD3FF1ocdaIwixKHh1seGcZczoh4JHT4oz2ypy2eWLld4lZRtu6WlgnhWXnpc
         apo7Q5Mgq91Zj1YgCFACmKDLqIzpcvsDmyFUMt0HUVna+YYBHqoKZx3HqrhdoNqMneH7
         r3RA==
X-Gm-Message-State: AOAM53141r7Kp6HYQ6DMYYSdBtlyb3THqH6G21arY8xweZrjWstSNNZz
        Z+pZBkBQDy2eVhS98sZ6UMq4kxMbN4Q=
X-Google-Smtp-Source: ABdhPJy5xELOp9RBxiCD9LlONYiv6y8YrttvOzfeaMTBwoI8b/g9k8osXhFnEjGpR1MsNy2AXWgkSw==
X-Received: by 2002:a05:620a:1305:: with SMTP id o5mr53226293qkj.59.1594251601727;
        Wed, 08 Jul 2020 16:40:01 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id l1sm1541841qtk.18.2020.07.08.16.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:40:00 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id e11so158803qkm.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:39:59 -0700 (PDT)
X-Received: by 2002:a37:9384:: with SMTP id v126mr58569207qkd.279.1594251599031;
 Wed, 08 Jul 2020 16:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
 <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com> <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 8 Jul 2020 16:39:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
Message-ID: <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Keep track of which interrupts fired, don't poll them
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 4:14 PM Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Jul 8, 2020 at 4:03 PM Brian Norris <briannorris@chromium.org> wrote:
> > If I'm reading correctly, you're removing the only remaining use of
> > 'per_ce_irq'. Should we kill the field entirely?
>
> Ah, you are indeed correct!  I hadn't noticed that.  Unless I hear
> otherwise, I'll send a v2 tomorrow that removes the field entirely.

A healthy middle ground might put that in a patch 2, so it's easily
dropped if desired. *shrug*

> > Or perhaps we should
> > leave some kind of WARN_ON() (BUG_ON()?) if this function is called
> > erroneously with per_ce_irq==true? But I suppose this driver is full
> > of landmines if the CE API is used incorrectly.
>
> Yeah, I originally had a WARN_ON() here and then took it out because
> it seemed like extra overhead and, as you said, someone writing the
> code has to know how the API works already I think.  ...but I'll add
> it back in if people want.

I believe WARN_ON() and friends have a built-in unlikely(), so it
shouldn't have much overhead. But I don't really mind either way.

> > Do you need to clear this map if the interface goes down or if there's
> > a firmware crash? Right now, I don't think there's a guarantee that
> > we'll run through a NAPI poll in those cases, which is the only place
> > you clear the map, and if the hardware/firmware has been reset, the
> > state map is probably not valid.
>
> Seems like a good idea.  Is the right place at the start of
> ath10k_snoc_hif_start()?

Either there or in .power_down()/.power_up(). I think either would be
equally correct, but I'm not entirely sure if the semantic difference
is meaningful for this.

Brian
