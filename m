Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5998119DC7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404050AbgDCRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 13:16:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42835 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:16:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id z5so8006918oth.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lctl7I09zhnrc16vIbyVgC4BJIrPWPpZwMZxngQgQLE=;
        b=RNTWbP11QdyS+t9Dpc7fBrb1h5ml9B4pyvLPEREV4GD6pDlEyfUy15pUiIluTwIhSE
         1T5Ep+MgXgokKnU3mVLwRslwm/lqQdkT4wcoAt0oYDYrtc9ZqOywd7OZ6l4AfDWezX8h
         3FYXVYuXtk+5ima4Qcao7qAvoY8BEYbHOE9u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lctl7I09zhnrc16vIbyVgC4BJIrPWPpZwMZxngQgQLE=;
        b=EdlxGBQNY0mPhT3lq9qaoFmuM2OCqZU6/DkmOfSbG/p2aATDGEj/8AQLrqeH9RHOfG
         fbg51oPc0+bxnMIUrarq+FSgNyTZk97GAI7kO2YrT2mtvGH/Xb14YV3CJXYzR3u11CSa
         CP1vNmrsJ0Pzb1yYAUuBaSmNNRJjquw9iEBFYSP50Ji3Z1FgmShZWHE431brDno2PQZ+
         kPfL1GuRqWVxivzvY5wE17fTQRfdV62l2YX7FJJudVWR2wR0kWrPUQYdF+h9IaUrthc2
         3/H8tCROWMWckid5Y8fZTAh2XpGL6hnHkEd+vk5CAiBdgnETD8G+q4jukIuo/g+qBxN2
         vFeQ==
X-Gm-Message-State: AGi0Pubn61npNetNfD8kc/1wo6dCnX1cxLk5RFMIcEjRt+luWMoNAD4b
        zopcQN2Y8PiXBjxNLuLmfR5wiJDqPW2znxPsWEonrg==
X-Google-Smtp-Source: APiQypI42wdCObMi2MKV6q+o1Ki446LUAAGqvEy2YFRpE56PPW9JAH6jH0LnCpB6Zrh8jSdbQtDCSX4NomVQ2Yn2Ouc=
X-Received: by 2002:a9d:2056:: with SMTP id n80mr7599742ota.281.1585934199272;
 Fri, 03 Apr 2020 10:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86> <20200402215926.30714-1-chris@chris-wilson.co.uk>
 <20200403013420.GA11516@ubuntu-m2-xlarge-x86> <CAKMK7uE9pv23edViQBC=Jy5fQV=-NQTNdk1qi91Z8shpeuL7FA@mail.gmail.com>
 <CAHk-=whMhCTdx0fDRnNT4doKGYw1BBBei0KcXDZcmtVpk_GvEw@mail.gmail.com>
In-Reply-To: <CAHk-=whMhCTdx0fDRnNT4doKGYw1BBBei0KcXDZcmtVpk_GvEw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 3 Apr 2020 19:16:28 +0200
Message-ID: <CAKMK7uE2t=z71dtJitmoKwrrZxgciEDRrNPMQ1FyiLO7s-VKag@mail.gmail.com>
Subject: Re: [PATCH] drm/legacy: Fix type for drm_local_map.offset
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 7:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 3, 2020 at 1:29 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> >
> > This works too, missed it when replying to Linus
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Linus I guess this one is better, but like I explained it really
> > doesn't matter what we do with drm legacy code, it's a horror show
> > that should be disabled on all modern distros anyway. We just keep it
> > because of "never break old uapi".
>
> Ok, That patch from Chris looks fine to me too.
>
> dma_addr_t and resource_size_t aren't the same, but at least
> dma_addr_t should always be the bigger one.
>
> And it does look like nothing else ever takes the address of this
> field, so the ones that might want just the resource_size_t part will
> at least have enough bits.
>
> So I think Chris' patch is the way to go. I'm assuming I'll get it
> through the normal drm tree channels, this doesn't sound _so_ urgent
> that I'd need to expedite that patch into my tree and apply it
> directly.

Ok, sounds good.

Chris can you pls push this to drm-misc-next-fixes? That should be
enough for the pull request train next week.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
