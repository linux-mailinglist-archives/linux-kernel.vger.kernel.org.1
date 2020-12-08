Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9D2D29BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgLHL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:26:30 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E1C0613D6;
        Tue,  8 Dec 2020 03:25:50 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id t33so15844713ybd.0;
        Tue, 08 Dec 2020 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpQxjEi5D+WZTv1NZRTqv6yPxyq3egFLkFsYc9qfXJY=;
        b=G70TI57kuie5x8hgswKi2E+UO7yVJdfJCuo70tRvSLEFv6f0DgqAVmYyK4rDNXGF1X
         tLBDV8606Veazqdi2ktluSdRY/Ljna2pMT2HMRiP3ZUiBGTmM/SgbxT4QbXwPJkOinlY
         lFKeCB1BnktZF3FLdiuo5+E+vY6odW+1K63jCa6ziqLWwid+jYoYtiBC9wYCJbdP3dQ2
         ho+97Ynb4irGGNb7HHdEzxtDMkl/1Snxxwgg4OlIaFWvLfXtagw8uMfTpm4yE1C9xpbn
         tlQPsg/dAoHD6TlIn077AMbCA7tGlaO9+i7efeOGva4G5Ys8DX8wZQ3vEn3KEjtAXEY/
         tDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpQxjEi5D+WZTv1NZRTqv6yPxyq3egFLkFsYc9qfXJY=;
        b=sELWSFd4mUnfCoqrLtGXHE5MjCPEwvu0nfhu51Tx73kXdIi4k396UjJF99E43+K1OL
         kwNJjQMrpwFy078vZ+GVi4A6jJ5zBWOoYrMq2r9d4i/1k8ZHkac0tx5Lu4pLC5DpFKLT
         /HBI/Qjohu18awtfXl6OsS7vpUBQy545ae+XCPg+IgpDeZLFZIY3jEHbmeA9fBB2jgvg
         K5MQPRqLeznSXLL18ChzquZxIa1DcU07NoXE9U+LcZec0wJ/Gpk/M/2IxQuA3Oi4s1u1
         Z2LgCroWZhkieG7qNvKKXHapjuEVZ4Jj0Xm3vV1l6rccN/M2yZV8GrN3p0VLfnrMKUdQ
         3cpw==
X-Gm-Message-State: AOAM532rsND+9fBAKCYnnI/83GEJjWkxdnS/GS1cCvO+l4GQVs8eO9N8
        c0+N75E4ChG062fWDxwRQgGKo1p1JOuWzSnaeFmfC+55
X-Google-Smtp-Source: ABdhPJzK1NOjqFsx0qyHCehpT1xGgHle1Rkx9Wl4RdQo35e6V+yhZIj8hqQTIvz5bDMkGZcoXNHzPfknfTbqSAgU4f0=
X-Received: by 2002:a25:ab31:: with SMTP id u46mr21111573ybi.179.1607426749542;
 Tue, 08 Dec 2020 03:25:49 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
 <20201208004227.GF3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201208004227.GF3579531@ZenIV.linux.org.uk>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 8 Dec 2020 14:25:38 +0300
Message-ID: <CADxRZqzdME66_xzh565vSOG7=ep0dmF1p3DCNW5VTeggr5LMKw@mail.gmail.com>
Subject: Re: [sparc64] current git kernel networking is broken
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 3:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Dec 08, 2020 at 03:09:47AM +0300, Anatoly Pugachev wrote:
> > Hello!
> >
> > Sorry for the late report, being 5.10-rc7 is out, but current git
> > kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
> > is broken with the networking. It affects my openvpn tunnel and even
> > internet networking.
> >
> > ping to a local ethernet network (i.e. gateway ping) works, but i
> > cannot download files from the internet.
> > openvpn tunnel does not work.
>
> <eyes commit in question>
> <swears>
> Could you check if the following typo fix is sufficient for your
> reproducer?
>
> diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
> index 0c0268e77155..d839956407a7 100644
> --- a/arch/sparc/lib/csum_copy.S
> +++ b/arch/sparc/lib/csum_copy.S
> @@ -71,7 +71,7 @@
>  FUNC_NAME:             /* %o0=src, %o1=dst, %o2=len */
>         LOAD(prefetch, %o0 + 0x000, #n_reads)
>         xor             %o0, %o1, %g1
> -       mov             1, %o3
> +       mov             -1, %o3
>         clr             %o4
>         andcc           %g1, 0x3, %g0
>         bne,pn          %icc, 95f


Thanks Al, this patch fixes networking for me.
