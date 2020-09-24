Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C1E27650F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIXAcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:32:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17AFC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 17:32:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lo4so2036947ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 17:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtwYXGQkpq+Yk8qjqli0UbUeSkPLKz4tv7RHWzD0qJ4=;
        b=MRS9GP1t++tnQd0tz9PUK2hZ/dZQEGQG1BzMIgwbZ5lC1xS8d7JyLFkMlHc8cQILin
         5zStqFqRxzDRNJAHshHV6kMgrhUeHXnBbPqBbZmEIvZehT8hBMDgmtk/f6p4U+8L8kRr
         jd7V7U/H/7vEc/mh7mTvvSPr1S7cSt8MAQavgShpVdpHcVGjijzg/DVuvRpNRcYp81Lf
         N+tqJWIGG6FxOK9scMzJn6I6SkNLPKY3tg2GNHoD10YzdO2h+wJtQ4WzL3ErCig+moPU
         peZQmZE0x2K+2VS+ax1MCEjeFC0gfZi3ZN9i43M8yMjbm/Plfcs4w2/5/yvMDTbzRuzC
         snag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtwYXGQkpq+Yk8qjqli0UbUeSkPLKz4tv7RHWzD0qJ4=;
        b=Jz9RmSUZWM+PwHQAQwyPVgWgMW9ZwLBqE9fBz1ui3oBwhI2udCF89NgqByD11uUt18
         xx93wke4RmQKO6Ds1izFeu3bQ84fi+Y3I2PMIpjfqKa65IHT48LRsUwosRER7nv+ma+i
         GOQlKWRNNZipXnHYJ9RCFf03CvROBmNIxR0cvJFbp6GOlydiISPUD3VBJwUtACLuG4D6
         1+wuPRVZpR5aFgQT1E167ZgnYSvhXUiI7j+ihE7HOhYr39FDeygmMW9FmhhH4V6ZhDKV
         KgKtI9wQ4swLuMIP7KRVqgPCeuGlO4MdV7Ls0rDcqd54bWPUhkcarfzKgTZxNUzF3ASU
         ilCw==
X-Gm-Message-State: AOAM531ivkqAUaBfRL5qsHPs/3HUMuM8k1WzrElVwrCpKc6edcr83GRw
        hkg53VGg4Tw8/aTXLyypRu0a4h1Ttmr/xrTO3rkhIgz2A4fgOIPY
X-Google-Smtp-Source: ABdhPJx0BY84RQayqeOfmTmTESZ7c2LfLpLBLePBDBBpSP1iq6PQVjJV7lS4/7YXHQebdRPrgJ0rWAlUmzPoTFPRYDA=
X-Received: by 2002:a17:906:fb8f:: with SMTP id lr15mr2112420ejb.25.1600907530408;
 Wed, 23 Sep 2020 17:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <c41149a8-211e-390b-af1d-d5eee690fecb@linux.alibaba.com> <f9ae9d60-8cdd-c3a8-d6f9-6f84be29c2ea@linux.alibaba.com>
In-Reply-To: <f9ae9d60-8cdd-c3a8-d6f9-6f84be29c2ea@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 23 Sep 2020 17:31:58 -0700
Message-ID: <CAHbLzkqkK2qqsUznZvOteCRA1C2dhZq-bXAPdWcwO1_0ihRYeg@mail.gmail.com>
Subject: Re: a bug on 5.9-rc6
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the same problem as
https://lore.kernel.org/linux-mm/a46e9bbef2ed4e17778f5615e818526ef848d791.c=
amel@redhat.com/


On Wed, Sep 23, 2020 at 5:24 PM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
> =E5=9C=A8 2020/9/22 =E4=B8=8B=E5=8D=8810:03, Alex Shi =E5=86=99=E9=81=93:
> >
> > I just found a bug on recent upstream kernel on my x86 box.
> >       325d0eab4f31 Merge branch 'akpm' (patches from Andrew)
> > The last good kernel I known is 5.9-rc2.
>
>
> This bug still exist on 5.9-rc6.
>
> I found it in doing stress kernel build on swapping, while run
> kernel selftest's vmtest like:
>         for ((i=3D0;i<8000;i++)); do ./run_vmtests ; sleep 1; done
>
> It take time.
> I will try to do bisect when things down in hands.
>
> Thanks
> Alex
> >
> > Thanks
> > Alex
> >
> > Linux aliy8 5.9.0-rc5-00156-g325d0eab4f31 #88 SMP PREEMPT Mon Sep 21 08=
:48:19 CST 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> >  1841.488609] BUG: Bad page state in process userfaultfd  pfn:1a7d7
> > [ 1841.494930] page:00000000ec5d2f1e refcount:0 mapcount:0 mapping:0000=
000000000000 index:0x7fd6181a6 pfn:0x1a7d7
> > [ 1841.505080] flags: 0xfffffc0080004(uptodate|swapbacked)
> > [ 1841.510427] raw: 000fffffc0080004 dead000000000100 dead000000000122 =
0000000000000000
> > [ 1841.518318] raw: 00000007fd6181a6 0000000000000000 00000000ffffffff =
0000000000000000
> > [ 1841.526207] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) se=
t
> > [ 1841.532775] Modules linked in: loop xt_addrtype br_netfilter xt_CHEC=
KSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ipt_REJECT nf_reject_ipv4 tun b=
ridge stp llc overlay ebtable_filter ebtables ip6table_filter ip6_tables ip=
table_filter dm_mirror dm_region_hash dm_log dm_mod ipmi_ssif intel_rapl_ms=
r intel_rapl_common x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass c=
rct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper cr=
ypto_simd cryptd pcspkr i2c_i801 joydev i2c_smbus mei_me mei ipmi_si ipmi_d=
evintf ipmi_msghandler ip_tables ext4 mbcache jbd2 crc32c_intel drm_vram_he=
lper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_h=
elper ttm drm ahci libahci libata virtio_net net_failover failover
> > [ 1841.603813] CPU: 0 PID: 26221 Comm: userfaultfd Kdump: loaded Tainte=
d: G S  B   W         5.9.0-rc5-00156-g325d0eab4f31 #88
> > [ 1841.615080] Hardware name: Alibaba X-Dragon CN 01/20G4B, BIOS 1ALSP0=
17 04/09/2019
> > [ 1841.622701] Call Trace:
> > [ 1841.625280]  dump_stack+0x8d/0xc0
> > [ 1841.628726]  bad_page.cold.130+0x63/0x93
> > [ 1841.632776]  free_pcp_prepare+0x20b/0x250
> > [ 1841.636908]  free_unref_page+0x18/0x90
> > [ 1841.640780]  wp_page_copy+0x2cd/0x5d0
> > [ 1841.644569]  __handle_mm_fault+0x791/0x7a0
> > [ 1841.648790]  ? handle_mm_fault+0x4b/0x3f0
> > [ 1841.652925]  handle_mm_fault+0x16f/0x3f0
> > [ 1841.656968]  exc_page_fault+0x3cb/0x6a0
> > [ 1841.660920]  ? asm_exc_page_fault+0x8/0x30
> > [ 1841.665131]  asm_exc_page_fault+0x1e/0x30
> > [ 1841.669259] RIP: 0033:0x7fd625da6d5d
> > [ 1841.672957] Code: 00 00 89 77 10 89 f2 49 8d 70 16 4c 89 c7 81 e2 80=
 00 00 00 e9 04 6c 00 00 0f 1f 40 00 81 e6 80 00 00 00 bf 01 00 00 00 31 c0=
 <f0> 41 0f b1 38 0f 85 24 01 00 00 64 8b 04 25 d0 02 00 00 41 89 40
> > [ 1841.691889] RSP: 002b:00007fd6147b2e58 EFLAGS: 00010246
> > [ 1841.697239] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
0000027da
> > [ 1841.704497] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000001
> > [ 1841.711759] RBP: 00007fd6147b2f10 R08: 00007fd6181a6000 R09: 00007fd=
6147b2eb0
> > [ 1841.719028] R10: 000000000000000f R11: 0000000000000206 R12: 0000000=
000000000
> > [ 1841.726286] R13: 0000000001001000 R14: 0000000000000000 R15: 00007fd=
6147b3700
> >
>
