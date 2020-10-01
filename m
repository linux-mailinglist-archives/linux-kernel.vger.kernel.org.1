Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2992328079B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgJATUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:20:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:20:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so5597281lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmc1K3lzPAdgfbevzvqpy3YGAc5ZYOQHBNFHo+BZzTI=;
        b=FdqUAsylA8PZUXOxQvdJbGv3sERGvglYhJHDsvz+5r7hcnH1YZGgAnI1kqN6N3c0h5
         MuJcTdP1ku8xjs45pXuTvzmsKpLWlcKBT+F8YGHll9Zwq8i7oylJC7+gpoOaCa4gRVD+
         zYzAWcYllu6wlY4tzbqSEEJKQ6sjQKbUQPTsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmc1K3lzPAdgfbevzvqpy3YGAc5ZYOQHBNFHo+BZzTI=;
        b=Bm3R7sfQ2OOyXKN+BjPrDbFF8RKCmMsgHjdVPvarekNu/dqeEEqa4RNtLiLT893ok0
         hLWvGf2XAOZCsrjndxKlmMGO2bSHHolGsMORYKb5ithUSuF3GJrNa1Pe99b1e8CqHpxr
         SHwu+RerpWY7MBcRPH6qYAcJUvDqVKKVcNy9Ry1KPRqdpld1y0OMrsyMMT7VaG4IG8du
         viXO37ipdYo6I4IDJtCi9HKZjGV6QEPaNNl2f7EUn6VByj4856BgxnsfyQBu5O7x4bjD
         8xkwSiu7B87wYxDx8a1iWJCT/T90+9vqtmwUrWF0P5uG1T60jNedjSo7tjoYFanf2cam
         JqAA==
X-Gm-Message-State: AOAM532ejvUe14m98t9Kuo20B1OHPsBndqeNh8W34FBvGE4X34ZgeZXh
        K7l0OJUFElAMBfKyij4oaajrqxXKkz1a3w==
X-Google-Smtp-Source: ABdhPJxPiwKjtjZ9HicMPJoJSsRHS4VzKEIddGDpjULprGXCdw9S9hzJOVgJdLn8wfHxhrYn4Bxz+Q==
X-Received: by 2002:a2e:958f:: with SMTP id w15mr3011401ljh.449.1601580015255;
        Thu, 01 Oct 2020 12:20:15 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c9sm659688lfh.204.2020.10.01.12.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 12:20:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c2so5592929ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:20:13 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr3074085ljp.312.1601580013559;
 Thu, 01 Oct 2020 12:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
In-Reply-To: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Oct 2020 12:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
Message-ID: <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported
To:     Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Vlastimil, Roman and the kernel mailing list to the cc.

Vlastimil, Roman - this looks like a slab regression. And while others
have touched slab in this merge window, you guys did so more than
most.. Comments?

On Wed, Sep 30, 2020 at 11:55 PM Bastian Bittorf <bb@npl.de> wrote:
>
> Since 5.9-rc1 i can see false values, booting with qemu (128mb RAM):
>
> / # free
>               total        used        free      shared  buff/cache available
> Mem:         122176 18014398506028288      114848           0 3461024     3568096

that looks like a negative 64-bit number shifted down by 10 bits (bytes -> kB).

> / # cat /proc/meminfo | grep ^V
> VmallocTotal:   34359738367 kB

.. but this part is normal. VMALLOC_TOTAL is the VM space for vmalloc
areas, and it's large on a 64-bit machine.

And afaik, it hasn't changed in a long time.

So I think there's something else confusing 'free'.

I think it's this:

> / # cat /proc/meminfo
> MemAvailable:    3617184 kB
..
> Slab:           10321920 kB
> SReclaimable:    3506176 kB
> SUnreclaim:      6815744 kB

because those slab reclaimable/unreclaimable numbers look completely
bogus. You have more unreclaimable slab space than you have memory.

Hmm. I'm not seeing anything similar. And your config looks sane, with
the main difference I see wrt SLAB being that you have

# CONFIG_SLAB_MERGE_DEFAULT is not set

but there's nothing wrong with that either.

It would be lovely if you could bisect it, but maybe Vlastimil or
Roman will go "Ahh, obviously.."

                 Linus
