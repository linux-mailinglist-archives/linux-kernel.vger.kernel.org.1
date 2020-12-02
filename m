Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0882CC07A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgLBPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgLBPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:12:23 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C342C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:11:37 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id j13so1133783pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HsmIMcZJpe7tYpMj4NnnC0QPe3wNYiaDnh9WVgHhJ4=;
        b=KQx3tJgz/INomXf3rio23NSDcD9wW4IAJav9Y9BJw53GdaN2o6fOGhlX8MBRbVEX/z
         GJnxX1SOpLw3TBSSXOyjEAGBMPEOzouTPbcvhMI11uEaxagjIn9JnLaNnxPM0y7ywI7W
         QyRN7MldGkgFmPigqQvsujyTvwSL/ZHKPFZbcRmkSH4l6Ffh9hFQWjY9Cuji5JSur0+X
         ghBUvBOcEkEyT+gIijLWQAdyC2cpWZ+DqUClF+JBkuzKgpn/U/kFgHckDgYHw8Gy8AAZ
         rY0WN/jM5PDSXnBHyekvdPvFYlBbw30fsPk/7X9X7VH+CC2mwj44NQzN7se3/lnMuMyV
         SatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HsmIMcZJpe7tYpMj4NnnC0QPe3wNYiaDnh9WVgHhJ4=;
        b=MqUzyJ0sRHzD59G6cgLrP4vv5t/9EVmvTnL9CJ5lLJtVgh+UxeVWBROBtkskuZlywZ
         yvIQ6i1p0GG9ZuCOyI3DPMn4T+SqNo/6hjux8ddIaL1kyMgwlxwd6Wboqkra3OgROjhh
         I7WUag+7o5XmHTsOXfVko8uoTKT/mEumZkEdI2nVDOBN759f9PUAprLdtKwQpNXma08Y
         ncjst+5/sbjEckWjRlPMNH7xn7lEKPcOJ4xBhpEKAL7/u6H+jQGLLXvN8GrNE9wHHMu6
         OT5eDmDFXjKchC4swWSdVd4yHNVq1jjw05nZjHmZBd2C2Pzev4iDN+l/YOHKtt1dQ56J
         MHiQ==
X-Gm-Message-State: AOAM531NtszPGunLCNhRcoYs0pZsX4Zj3ISCjo7AlQ4t2JjuIZOrjpql
        A5RYsyhBP7RRREWDQCI/vXq5AUuhyQsB3zpCBc7S0g==
X-Google-Smtp-Source: ABdhPJzfWUqM7uNDjSRCST7XbyM6pfI51u3tJv0DhofJxxJmpsNwCOQzSTp65YnSwldtwCV6tKI7oV/ks90wuIfKTgE=
X-Received: by 2002:a17:90a:6bc1:: with SMTP id w59mr319106pjj.136.1606921896689;
 Wed, 02 Dec 2020 07:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20201201161632.1234753-1-dja@axtens.net>
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 2 Dec 2020 16:11:25 +0100
Message-ID: <CAAeHK+znbFs6PRQNg0TVAB=diqnzo=uRg8-dFKcKuNUgJ_T2uw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] KASAN for powerpc64 radix
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        bsingharora@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:16 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
>
> This is a significant reworking of the previous versions. Instead of
> the previous approach which supported inline instrumentation, this
> series provides only outline instrumentation.
>
> To get around the problem of accessing the shadow region inside code we run
> with translations off (in 'real mode'), we we restrict checking to when
> translations are enabled. This is done via a new hook in the kasan core and
> by excluding larger quantites of arch code from instrumentation. The upside
> is that we no longer require that you be able to specify the amount of
> physically contiguous memory on the system at compile time. Hopefully this
> is a better trade-off. More details in patch 6.
>
> kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
> nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
> fragile - if any real mode code paths call out to instrumented code, things
> will go boom.
>
> There are 4 failing KUnit tests:
>
> kasan_stack_oob, kasan_alloca_oob_left & kasan_alloca_oob_right - these are
> due to not supporting inline instrumentation.
>
> kasan_global_oob - gcc puts the ASAN init code in a section called
> '.init_array'. Powerpc64 module loading code goes through and _renames_ any
> section beginning with '.init' to begin with '_init' in order to avoid some
> complexities around our 24-bit indirect jumps. This means it renames
> '.init_array' to '_init_array', and the generic module loading code then
> fails to recognise the section as a constructor and thus doesn't run
> it. This hack dates back to 2003 and so I'm not going to try to unpick it
> in this series. (I suspect this may have previously worked if the code
> ended up in .ctors rather than .init_array but I don't keep my old binaries
> around so I have no real way of checking.)

Hi Daniel,

Just FYI: there's a number of KASAN-related patches in the mm tree
right now, so this series will need to be rebased. Onto mm or onto
5.11-rc1 one it's been released.

Thanks!
