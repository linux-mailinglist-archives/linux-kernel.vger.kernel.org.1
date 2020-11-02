Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57D02A23BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 05:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgKBEI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 23:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgKBEI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 23:08:27 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D9C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 20:08:26 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s89so10574980ybi.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 20:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwCqBfz/Y22tP+YuC1T++cKp6qmSNMH46Zmcr0s1r/M=;
        b=ADE/wXoyzbGZ6X+b3akmxd7gm0LDq07hdeXmVwDvYWH0e1WSiMVQdl2LonhvVl/ubu
         ozqHQTI00q6jtfyyOl66WjvYIN1jNJlXfhB1fEaygGtDW6iixVUuwzWknLDVEXiAxEpQ
         5K6imofDqrwyWaPNWcRDjYIMNwgrC5cCwQkxeJo+82ER4oJLWyDGLLuvSm7ADG8+IN6c
         uogsab963+EFOBj36DbMjmZDO2HFz+4Ys2JCy23L3W+Jbw5Hki0h25sxp0IFGuLjFzQq
         0SD2NJhtJgEjVOFceE9oCNNlBJcUogeqKm7iKmq2be1dooAOFzYYYm4f+qI8G7rb1qbT
         kmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwCqBfz/Y22tP+YuC1T++cKp6qmSNMH46Zmcr0s1r/M=;
        b=RXDy6P3xqwXUSKKq/f90qD0kMXUXnImgFXL7UkVnL2DSN3Kb3VKhDqE25qDo7CCrLn
         1oJfuCrvi18Fz5MnRcLAtKVry8dmglF1cZxHrSgvt6Uhhf3By7Lyb1HSOvjIkLvC833x
         DA4/U4EGi+29wQ+NYhrkeliqchGFWeABJR071wMRVTo8hLtLB1LvO6dvqSeFXaKM09z9
         4Gmcqm8KySL76Klsek7YO8mbvyTifSgaIOOpQlixeZQ2kN7CXtiCr3l8+cLWrjsOoQL3
         zL/BQWPdqX6rnGIGs4j+VimzbRDh/TCl0fh97QLhcIlqUAUbd3pe3+7MPBaJ03hTwi5K
         945Q==
X-Gm-Message-State: AOAM532kivkndIvXL7u7GcTCSz1YfcM37bRkxQwdBo9DCcEeB1ADDv4e
        cBX+hAOuiddfdnS99RqLYBHqe+tOI3ePGTdNPVcCqg==
X-Google-Smtp-Source: ABdhPJyPXcr1jTPB1wavZcXpiD6Okp5/6sZTctT9kOFYwx19KO65LtrSvPqJgI0LhghhZ2Vuzqi6foOBwNnfCHFY4jE=
X-Received: by 2002:a25:b8a:: with SMTP id 132mr18438278ybl.88.1604290105857;
 Sun, 01 Nov 2020 20:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20201101220845.2391858-1-adelva@google.com> <20201102033848.GA1861@gondor.apana.org.au>
In-Reply-To: <20201102033848.GA1861@gondor.apana.org.au>
From:   Alistair Delva <adelva@google.com>
Date:   Sun, 1 Nov 2020 20:08:14 -0800
Message-ID: <CANDihLEjyuDD6aKVweoB4=CtUYCgiZqT8HHG1yY1VgUp74CPRQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm/compat: Remove use of kmalloc_track_caller
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, kernel-team@android.com,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 7:39 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Sun, Nov 01, 2020 at 02:08:45PM -0800, Alistair Delva wrote:
> > The __kmalloc_track_caller symbol is not exported if SLUB/SLOB are
> > enabled instead of SLAB, which breaks the build on such configs when
> > CONFIG_XFRM_USER_COMPAT=m.
> >
> > ERROR: "__kmalloc_track_caller" [net/xfrm/xfrm_compat.ko] undefined!
>
> Is this with a recent kernel? Because they should be exported:
>
> commit fd7cb5753ef49964ea9db5121c3fc9a4ec21ed8e
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Mon Mar 23 15:49:00 2020 +0100
>
>     mm/sl[uo]b: export __kmalloc_track(_node)_caller

Whoops, you're right - I confused two allmodconfig issues when
backporting. Sorry for the noise.

> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
