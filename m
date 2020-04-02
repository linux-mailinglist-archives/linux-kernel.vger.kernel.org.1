Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5648B19CBCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgDBUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 16:43:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:43:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so4717213ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+sg1IKvR7UQ+P+0PCBeB0y4Q0Z6zSnVzKwNNzIYfpI=;
        b=BdX1Y/hZi2MjhDmwunvX3GgwarGy7zBfCrMFBwDkrtrvJ7Dt24JOgvxUi6i0qQnp7t
         paezfz2PsP2dl0MorMvZGKKGypox6m4fxOT6lUKujnk8zz+rs51qD7Va9JFfnTsUPaLr
         m+jfoJ+31JUR6/cYG8huhVA83tz3nLYvzg4RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+sg1IKvR7UQ+P+0PCBeB0y4Q0Z6zSnVzKwNNzIYfpI=;
        b=NDSYIhaSoCCMA/3WvYG9efCR9H0QSEgnNqngLdfnZT6pN9egoEut4F1GAa8RFN+ODe
         XDZoNbb0jRXh3G83qqC+nMcj820FScjaD5ctK7Irhbvt7YyPaIcvCMWtQ04p+T56GATq
         pj36YVxlIi3Zwh3V3R7XZV3pqg1xYuz2GosIYS6IHX066hifftSegpnltQkHXg0fzrCb
         k1IBNJy6AQIbkRykxI6nHjaRHZboKsxZJ4V3gv48Bi5PiGLxsdUlfpYq2IWJ+sh+n4Qd
         yhdb8/yMmVKAQ1x3tDF/Bv0aZlzv6NjIVjAFjq2a3E0Vz+y0ejr6VcxwIRdrGGRqr63/
         pNGQ==
X-Gm-Message-State: AGi0PuYzFuCelCS1NJ8TqpExreqJ9l0C+1p8JJ1WXR5yIAAJtnReGqGx
        PckrMwBCMOpjPf+eNREVtEaZG70a4WY=
X-Google-Smtp-Source: APiQypLoaJSHIYj9i1UvScNSstJnlRy6xSg4wQsGxCr08F15SnAPKaiGryFwhdWeIDZUEQcBvttU+w==
X-Received: by 2002:a05:651c:287:: with SMTP id b7mr3044052ljo.129.1585860215612;
        Thu, 02 Apr 2020 13:43:35 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x14sm4672022lff.65.2020.04.02.13.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:43:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id e7so3950498lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:43:34 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr3320923lfk.30.1585860213940;
 Thu, 02 Apr 2020 13:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
 <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 13:43:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHEOHCf7kAOJOY9bOr9O0CRzxds+8YcXVVGbMZ+7kyXg@mail.gmail.com>
Message-ID: <CAHk-=wjHEOHCf7kAOJOY9bOr9O0CRzxds+8YcXVVGbMZ+7kyXg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.7-rc1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 1:33 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This fixes it but I am not sure if it is proper or not (could be
> problematic if CONFIG_PHYS_ADDR_T_64BIT is set but
> CONFIG_ARCH_DMA_ADDR_T_64BIT is not, not sure if that is possible) so I
> figured I'd report it and let you guys deal with it.

Yeah, no, that patch can't be right.

From your build failure, your configuration has dma_addr_t being a
'long long unsigned int', and map->offset being a resource_size_t is
for just a 'unsigned int'. Casting 'unsigned int *' to 'unsigned long
long *' is not valid.

You'd have to do something like

        dma_addr_t temp;

and pass the address of *that* in, and then assign that to map->offset
(and verify that it fits), I think.

That's kind of what the old code did.

Or alternatively, the 'offset' field should just be of type
'dma_addr_t' instead (see include/drm/drm_legacy.h). But I didn't
check if something else wants it to be a resource_size_t.

                  Linus
