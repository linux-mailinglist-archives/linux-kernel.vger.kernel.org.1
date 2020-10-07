Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A6285781
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgJGEVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGEVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:21:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 21:21:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so961810ejg.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBNZtVQQB2KTdNFAhcuch9XxJZhD9YHNjFHMfmNY94s=;
        b=IAtzqnshZSKEtiIEx3/kBic2CZfhf5/w50Z/OJjVK0+RDEdhrzjVzNZZaqGoeOkTZg
         c1K3VeB6RiR6uVngB7hth37dc2V/gtvVklcbHLmT0aGSMqs8zDvZAplv0Vfg/6FFNkts
         qkyacXrYhC658NZhNQrgNwkwuGem15wyoWFv5bEILsdACBl90iga7QekKs8nZ21xx+jr
         +miiB2scgvBloMfrUS1Pg/YQ/bZvlMDDSOCXneEfN/NeAIuYgzf5PAn+4n66WlRP3ReR
         uOYpl/x8+bVMvHXhcYp/LAQWcGB4lHOfg3Be0qhjDsO4SmWE+tTAMt8GiO89iT93w5p2
         gMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBNZtVQQB2KTdNFAhcuch9XxJZhD9YHNjFHMfmNY94s=;
        b=ktS2/1QoUTrRtHJkMMFP1VkVG4vZ//NEqLmBZ/2sY+5mXRdPpPn1eBelhz/whUTX8u
         2qgnCbFErBPZ3hpUBj3flF1nBBfpEWD9MmbA+UDoUgpQom2q1XCUWWoX7veBjq3BVnkX
         ElLEjpOV3TefX1OlPAGH/mjSuxEnw2qDL/+I+wioK2ylorI7KVGw1V1e9+SCiv+p6pO4
         +FLFz1lPSZTKemJ431yWvXBt6JEATkPGPktngD+kbnpumEDpfEReyAtBjG+Q/dNtHtCg
         2zqk4KT+SPtIfdIRH/aMHsfagY2S8qydvrPdCzDF3r7d0I1dRzOpwsnprNTA6/Z4/ewA
         CO+g==
X-Gm-Message-State: AOAM5307scLMLaxwPrthCx4GyoMzeZEWRFlgJX2nv75H7k8YOBrsZqYT
        BlYnRPiH2Bn7sYpl10dmWI91ZNrPcm3xP2N0nC3ktg==
X-Google-Smtp-Source: ABdhPJxdiczbtzfxGozT7L2wA9lT0y/4c98CZNLdrbdeb8WB+XggqqPmqtnlngt+l7qVyRbNLZSVAX1iCA9NPJp9B3c=
X-Received: by 2002:a17:906:86c3:: with SMTP id j3mr1441155ejy.493.1602044466731;
 Tue, 06 Oct 2020 21:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200916041908.66649-1-ebiggers@kernel.org>
In-Reply-To: <20200916041908.66649-1-ebiggers@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 7 Oct 2020 06:20:40 +0200
Message-ID: <CAG48ez3Jv6_SSgxMrzEmx1pY04TnsOXhGVvjt2-14-xe-BjTzA@mail.gmail.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 6:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
> The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> doesn't make sense.  Reseed it from the input_pool instead.

Good catch. (And its purpose is to ensure that entropy from
random_write() is plumbed all the way through such that getrandom()
and friends are guaranteed to actually use that entropy on the next
invocation; and random_write() just puts data into the input pool.)

But actually, looking at the surrounding code, I think there's another
small problem?

> Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index d20ba1b104ca3..a8b9e66f41435 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1973,7 +1973,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>                         return -EPERM;
>                 if (crng_init < 2)
>                         return -ENODATA;
> -               crng_reseed(&primary_crng, NULL);
> +               crng_reseed(&primary_crng, &input_pool);

So now this will pull the data from the input_pool into the
primary_crng, so far so good...

>                 crng_global_init_time = jiffies - 1;

... and this will hopefully cause _extract_crng() to pull from the
primary_crng into crng_node_pool[numa_node_id()] afterwards. Unless
things are going too fast and therefore the jiffies haven't changed
since the last crng_reseed() on the crng_node_pool[numa_node_id()]...
a sequence number would probably be more robust than a timestamp.

And a plain write like this without holding any locks is also questionable.

The easiest way would probably be to make it an atomic_long_t, do
atomic_long_inc() instead of setting crng_global_init_time here, and
check atomic_long_read(...) against a copy stored in the crng_state on
_extract_crng()? And in crng_reseed(), grab the global sequence number
at the start, then do smp_rmb(), and then under the lock do the actual
reseeding and bump ->init_time? Or something like that?

>                 return 0;
>         default:
