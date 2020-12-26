Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491F52E2EE2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 18:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLZR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLZR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 12:58:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73CC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 09:57:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so15308698lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 09:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB3TbcX+phhLHqNLVTnsPQIuYLV410SZ/S3x77H/Azk=;
        b=JiLZpPHDeFio2xKaqd4AF6b+AaACUv2JAlVW2TC/2qFFp6T2XByLfEVcoTR8ni+2ir
         VahaBF7tUkyt0AUQJGX/7pPCiMG9x70Kxcco01Hh4iOJRmaJRmVWUdq7UwxeDmLQofJc
         n0wyg+xmy7/jzNvOpKECnfI8lHqRJ9kujirOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB3TbcX+phhLHqNLVTnsPQIuYLV410SZ/S3x77H/Azk=;
        b=Ku0vXFHDAQwldzO+Tm9HvpgJG4mQr/y+Swx9wSNqwfK6QLVCXm7AZHHaQiN4jthGS0
         jpfFEPNHSEIudy3c/lr+u+I/kDCszV52ues4kXRPYrcR++XlQWvP5mKcnrIohESno4RF
         7vxK6BQELgdkG8FThzZSq/0TiHxclOC969BxLHgljj8MBQk2OPAodGZpJGAelyB7gMJd
         ao/2DM5K0o2LAGdYz6pHbEL4S4DUJFsZO3qA1bmfbPn7BTA9pBhdgUHgzo0I7XPCoSgP
         kWi1HpRj+EaRDywkDbkdaAYwg9ycX3Dr1cAXxdJn6I96Crf4nhS2QvGOFwDsa0GjTC3q
         zj6Q==
X-Gm-Message-State: AOAM533KR002kG3cK7hfPS7oxMJaz532cncK5fLt3GXkgrY3fTST8R+N
        9vBQfuNoSqHDDorhx42iAlBTNSTAqF0fZQ==
X-Google-Smtp-Source: ABdhPJwULiMTVz5e4FYoxC5J31NH+aB6cmGjO5WFAIIt23cLAQ1IGUdenoxN9Z5LemlcGZIyJ/2bMw==
X-Received: by 2002:a2e:98d1:: with SMTP id s17mr13850890ljj.308.1609005451392;
        Sat, 26 Dec 2020 09:57:31 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v6sm4731316lfa.200.2020.12.26.09.57.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 09:57:29 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id x20so15265339lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 09:57:29 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr15301778lfr.487.1609005449200;
 Sat, 26 Dec 2020 09:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box>
In-Reply-To: <20201225113157.e7hmluffh56fszfc@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Dec 2020 09:57:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
Message-ID: <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 3:31 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> The new helper next_page() returns a stablized page, so filemap_map_pmd()
> can clearly decide if we should set up a page table or a huge page.

I really like that next_page() abstraction, my only comment is that I
think it should be renamed as "next_stable_page()" or something, and
then this part:

+       if (!page)
+               page = xas_find(xas, end_pgoff);
+       else
+               page = xas_next_entry(xas, end_pgoff);

should be in the caller.

Then just have two helper functions like 'first_map_page()' and
'next_map_page()' which just do

        next_stable_page(xas_find(xas, end_pgoff))

and

        next_stable_page(xas_next_entry(xas, end_pgoff))

respectively.

Because not only does that get rid of the "if (page)" test, I think it
would make things a bit clearer. When I read the patch first, the
initial "next_page()" call confused me.

But maybe I'm just grasping at straws. Even in this format, I think
it's a nice cleanup and makes for more understandable code.

          Linus
