Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3319DC77
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbgDCRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 13:14:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39272 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:14:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so6433448lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grpj0ioyBlxfvZVIhSHFEGbyw0eKO0PYVgnSLJ1Zi5U=;
        b=USJaYqvnjKaYaTBS/r/rCBpDSvrybarlYMXWDZ4smu5ERFEX76FwO8PSUnqIvXBDHe
         fxU4v99KZWfszXYDthM2Yxwm11W54+ODFUUnSQdz/wdNZcFZpMrve1HEMLaUSB3rdylF
         gxpS2dTMAeiwybUkwx/+2QdK0J9IwYNihRNs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grpj0ioyBlxfvZVIhSHFEGbyw0eKO0PYVgnSLJ1Zi5U=;
        b=SZAimZ6a/fXCtfOLMgAPIslSEWwHd9GSVMSoYBQJt6Y02AyEj5FHz435ZRdjYdDOlh
         VWOYblJbc0K0MJuhTzi26Y4gPUB1PBiUNo62uBQzd1J6xlmL6fSJkGmp9f4OsOBr6JiB
         SXfoo1q/9Nrisvg4VRSdeJFeoXGrcj6pn+6XcVhuFJAxQbXIYnSH+ZpJFTCitQHMi92w
         U37f+PpblQU5VwXAJq3pnXoqbrjR1UM0AW5RgoS257Eg5EEbFLsh+masFX1hex4QNv71
         T0YM9/XmEVKHTExo2VYWufaMzEhxaGOYudFR8HtOup1x0GIgnRG55Gy0Bn0pRpbiBVjr
         1eCQ==
X-Gm-Message-State: AGi0PuZ5RHpQjJvMvCsjMMyxAkWnn7YFHicd3Jq9XXTRkRUDaxGHljYj
        8VsOtc31d0ePgoUF1QtbOmsXZHztqJg=
X-Google-Smtp-Source: APiQypKwIuNsGJZRK/Vi0Z0prN2zXDT4PG9Y1conyF84gflw2V3mWwz1m/GDPqrOng4qUpO0IOl82w==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr6176560lfo.176.1585934092413;
        Fri, 03 Apr 2020 10:14:52 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b16sm6357424lfq.34.2020.04.03.10.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:14:51 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id w145so6431703lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:14:50 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr2379958lfc.31.1585934090257;
 Fri, 03 Apr 2020 10:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86> <20200402215926.30714-1-chris@chris-wilson.co.uk>
 <20200403013420.GA11516@ubuntu-m2-xlarge-x86> <CAKMK7uE9pv23edViQBC=Jy5fQV=-NQTNdk1qi91Z8shpeuL7FA@mail.gmail.com>
In-Reply-To: <CAKMK7uE9pv23edViQBC=Jy5fQV=-NQTNdk1qi91Z8shpeuL7FA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 10:14:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMhCTdx0fDRnNT4doKGYw1BBBei0KcXDZcmtVpk_GvEw@mail.gmail.com>
Message-ID: <CAHk-=whMhCTdx0fDRnNT4doKGYw1BBBei0KcXDZcmtVpk_GvEw@mail.gmail.com>
Subject: Re: [PATCH] drm/legacy: Fix type for drm_local_map.offset
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:29 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
>
> This works too, missed it when replying to Linus
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Linus I guess this one is better, but like I explained it really
> doesn't matter what we do with drm legacy code, it's a horror show
> that should be disabled on all modern distros anyway. We just keep it
> because of "never break old uapi".

Ok, That patch from Chris looks fine to me too.

dma_addr_t and resource_size_t aren't the same, but at least
dma_addr_t should always be the bigger one.

And it does look like nothing else ever takes the address of this
field, so the ones that might want just the resource_size_t part will
at least have enough bits.

So I think Chris' patch is the way to go. I'm assuming I'll get it
through the normal drm tree channels, this doesn't sound _so_ urgent
that I'd need to expedite that patch into my tree and apply it
directly.

Thanks,

               Linus
