Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607551A6962
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgDMQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 12:05:32 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57608 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgDMQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:05:30 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03DG503n017830;
        Tue, 14 Apr 2020 01:05:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03DG503n017830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586793901;
        bh=qdBXTtVXlmfInBglCB4Rk784hZBIzdkmk2OHy9zWc0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZBtq4Uel4kvwvLuoqKV+DGfHfwfnHwwgPnYDE1Bc5lDZTmlEsBGBdYtP0cd5fCbjA
         Y+TRGr0ItNJgqw0IhBwWr39BoBFUxxNUI92XxtuBDUoOvSZkSVucpj34lDVPPG244S
         iaO91hqJA99D5AzX7BXUce5oGIZvQ/MO8HEGWoMg0dr/Vb8ZovnT7l+hnM/bsPHsol
         hPSdpNhwVwKgndNp5AK1Mtpm590qtscdgmzdALJW27i2uS/x+LZw7iPm6le/zgD8vp
         m9IVrAnGx5uDESlnI4sOdqUmyHDqMMf9vgx9JGcewXUdoOoJ5IhCNJqkoFGCNyPsrs
         uxUJKUTj515xQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id h189so5667936vsc.13;
        Mon, 13 Apr 2020 09:05:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuaNqwV6AEewigYB0STXYMTJqzh3aX4U0116B0VttHe75PK1u/4W
        nPWBXAV6WGBDRMoYXqWJ99Yy9jyNtyIxcsLm7BA=
X-Google-Smtp-Source: APiQypL4dw2znwNWubmbI3gALnJloVgNJyOQijQgQpbjdpbED+7UPbrhQzZ1L78areRXcF3hBEv+ZsbVQTNcvMp405w=
X-Received: by 2002:a67:fa11:: with SMTP id i17mr13152238vsq.155.1586793900135;
 Mon, 13 Apr 2020 09:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200413014743.16353-1-masahiroy@kernel.org> <ef8addd0-81bb-249f-7d8f-dfa7fc032085@deltatee.com>
In-Reply-To: <ef8addd0-81bb-249f-7d8f-dfa7fc032085@deltatee.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Apr 2020 01:04:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmbFOtsBAO2y_s9_y90UGCjXWrd-Es9mOUjgrfCELqmA@mail.gmail.com>
Message-ID: <CAK7LNAQmbFOtsBAO2y_s9_y90UGCjXWrd-Es9mOUjgrfCELqmA@mail.gmail.com>
Subject: Re: [PATCH] sh: fix build error in mm/init.c
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:43 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-04-12 7:47 p.m., Masahiro Yamada wrote:
> > The closing parenthesis is missing.
> >
> > Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Oh, oops, I thought I compile checked all the arches. Must have been a
> last minute change. I'm also surprised the kbuild robot didn't catch this.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Andrew, can this be squashed into the existing patch?


The offending commit is already in Linus' tree.

I was also surprised that no bot or human
complained about this breakage before it was merged.



-- 
Best Regards
Masahiro Yamada
