Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C072CF5DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgLDUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:53:32 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D43AC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:52:52 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so4253234pgi.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mEQ3gaJd3KfpSvV/0MrjNCIinjXitvVhyYq2m08x7tc=;
        b=p+ejBgzwka3GdfEbq0flsr0H61NROkaSqa1wJSCx4+pQEnP23hmeAFw6Rvp+MFHtwi
         FkSycYYQrVwe2ll3VhU8tc8Rnq50QjDE+/2ZGWdT/SaTUR2sjwzhS/O8bnalTGcAK1w7
         7EZ2iIzrC4UH8nIh2er8iXjvFUCCwndXjQKBeeIxwmfr2cHANL8D4qC4qmX6u9/LdvjL
         yZqmCyV1J+ZwVp9CNFZAs7NGZO3WPZ8LFE2iWeHDjvuB2EWReG5THuVU4mphJFgqabAH
         hecFVEa2uaKrKWi4ZnLQ58fy9qs621Bwhebp/UY3okwK0Zflr1P6B0/myx0P/m+7rOZ/
         8zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mEQ3gaJd3KfpSvV/0MrjNCIinjXitvVhyYq2m08x7tc=;
        b=ZpwxMvHtidYhkzpPrSUk+FX/ak3gBfFQWcbzTaMGq73MpW+Gf1+QUHExnTrKytxxnN
         FKYb1/oXBCST3p40WRt8H+lb0ISgx2YO0wdU/A9NJlfBLEC4aaHWIqoYD5IHpqG3rYbX
         5pLFzw1yGIHS373+xP8ZlTho5bW4rmfczlV7xAG9tmdJf96tmNyS0U7MwMUVFCm3IRfh
         dj+LK43qlcF9CAYDOyzTWUjrymqLNFr2j3vgWNMqRg7fw6rZqRRjaDZ7BnZy5PMBN5+G
         FwTFTGp17hWtiKxsfoKDSt1OCGFCkeyxM4IAAzy7ER7mgKDUiqbYHgXTxv3sR+4Mdr46
         KATA==
X-Gm-Message-State: AOAM532ZIJ7w3lIVbjRwXoOlHYMWon6J0tb8LZoIZA9wmMlV7ltwavGp
        sUQq4Nt/sYKsPbOb3nQHJgfELw0t4gz0Hg==
X-Google-Smtp-Source: ABdhPJz1YNWf1cUhfxs0vZ1szsy9kJtssRa8C6k15YY6jMKerbGOq0bjLzQaz1sJjfPTsclGBocHcw==
X-Received: by 2002:a62:2ac2:0:b029:18c:25ff:d68 with SMTP id q185-20020a622ac20000b029018c25ff0d68mr5581084pfq.64.1607115171887;
        Fri, 04 Dec 2020 12:52:51 -0800 (PST)
Received: from [192.168.1.9] ([122.164.27.91])
        by smtp.gmail.com with ESMTPSA id o132sm5861837pfg.100.2020.12.04.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:52:51 -0800 (PST)
Message-ID: <b5bd7b0924bd239eb8d6557e10eead8bb2b939a5.camel@rajagiritech.edu.in>
Subject: Re: BUG: KASAN lib/test_kasan.c
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Sat, 05 Dec 2020 02:22:47 +0530
In-Reply-To: <CANpmjNMCiCf9w34duqGpQ90=qB4QGnRR8Xny+wOVf=2WG=JVoA@mail.gmail.com>
References: <dc46ab93e6b08fa6168591c7f6345b9dc91a81bb.camel@rajagiritech.edu.in>
         <CANpmjNMCiCf9w34duqGpQ90=qB4QGnRR8Xny+wOVf=2WG=JVoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-04 at 21:29 +0100, Marco Elver wrote:
> On Fri, 4 Dec 2020 at 19:56, Jeffrin Jose T
> <jeffrin@rajagiritech.edu.in> wrote:
> > hello,
> > 
> >  detected   KASAN   BUG
> > 
> > [ related information ]
> > 
> > -------------------x-------------------x------------------------>
> > [   43.616259] BUG: KASAN: vmalloc-out-of-bounds in
> > vmalloc_oob+0x146/0x2c0
> > 
> > (gdb) l *vmalloc_oob+0x146/0x2c0
> > 0xffffffff81b8b0b0 is in vmalloc_oob (lib/test_kasan.c:764).
> 
> This is the KASAN test. It's a feature, not a bug. ;-)
> 
> > 759             kfree_sensitive(ptr);
> > 760             KUNIT_EXPECT_KASAN_FAIL(test,
> > kfree_sensitive(ptr));
> > 761     }
> > 762
> > 763     static void vmalloc_oob(struct kunit *test)
> > 764     {
> > 765             void *area;
> > 766
> > 767             if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > 768                     kunit_info(test, "CONFIG_KASAN_VMALLOC is
> > not
> > enabled.");
> > (gdb) l *vmalloc_oob+0x146
> > 0xffffffff81b8b1f6 is in vmalloc_oob (lib/test_kasan.c:779).
> > 774              * The MMU will catch that and crash us.
> > 775              */
> > 776             area = vmalloc(3000);
> > 777             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, area);
> > 778
> > 779             KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char
> > *)area)[3100]);
> > 780             vfree(area);
> > 781     }
> > 782
> > 783     static struct kunit_case kasan_kunit_test_cases[] = {
> > ----------------x-----------------------------x--------------------
> > >
> > 
> > Reported by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> 
> Which CI system is reporting these?
> 
> If you look, this is the KASAN test, and the report is very much
> intended since it's testing KASAN. Please blacklist the KASAN test
> (and any other tests testing debugging tools).
> 
> Thanks,
> -- Marco

gdb session was started by me.  (gdb ./vmlinux)

portion from dmesg output is as follows
--------------------x------------------------x-------------------------
-->
[   43.616259] BUG: KASAN: vmalloc-out-of-bounds in
vmalloc_oob+0x146/0x2c0
[   43.630470] Read of size 1 at addr ffffc9000006ec1c by task
kunit_try_catch/193

[   43.659055] CPU: 2 PID: 193 Comm: kunit_try_catch Tainted: G    B  
5.10.0-rc6+ #10
[   43.659070] Hardware name: ASUSTeK COMPUTER INC. VivoBook 15_ASUS
Laptop X507UAR/X507UAR, BIOS X507UAR.203 05/31/2018
[   43.659080] Call Trace:
[   43.659105]  dump_stack+0x119/0x179
[   43.659131]  print_address_description.constprop.0+0x1c/0x210
[   43.659163]  ? vmalloc_oob+0x146/0x2c0
[   43.659185]  kasan_report.cold+0x1f/0x37
[   43.659210]  ? vmalloc_oob+0x146/0x2c0
[   43.659234]  vmalloc_oob+0x146/0x2c0
[   43.659259]  ? kasan_global_oob+0x280/0x280
[   43.659287]  ? kunit_fail_assert_format+0xa0/0xa0
[   43.659313]  ? lock_release+0xb2/0x730
[   43.659334]  ? __kthread_parkme+0xa1/0x120
[   43.659356]  ? lock_acquired+0xb4/0x5b0
[   43.659379]  ? lock_downgrade+0x3d0/0x3d0
[   43.659403]  ? lock_contended+0x6e0/0x6e0
[   43.659423]  ? do_raw_spin_lock+0x1b0/0x1b0
[   43.659447]  ? io_schedule_timeout+0xb0/0xb0
[   43.659467]  ? static_obj+0x31/0x80
[   43.659492]  ? lockdep_hardirqs_on_prepare+0xe/0x240
[   43.659517]  ? memcg_accounted_kmem_cache+0x1b0/0x1b0
[   43.659542]  kunit_try_run_case+0xa6/0x150
[   43.659567]  ? kunit_catch_run_case+0x170/0x170
[   43.659591]  ? kunit_try_catch_throw+0x40/0x40
[   43.659617]  kunit_generic_run_threadfn_adapter+0x2e/0x50
[   43.659637]  kthread+0x232/0x260
[   43.659659]  ? __kthread_bind_mask+0x90/0x90
[   43.659684]  ret_from_fork+0x22/0x30


[   43.686511] Memory state around the buggy address:
[   43.700445]  ffffc9000006eb00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[   43.714559]  ffffc9000006eb80: 00 00 00 00 00 00 00 f8 f8 f8 f8 f8
f8 f8 f8 f8
[   43.728725] >ffffc9000006ec00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8 f8
[   43.742808]                             ^
[   43.757156]  ffffc9000006ec80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8 f8
[   43.771845]  ffffc9000006ed00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8 f8
[   43.785957]
==================================================================

-------------------x-----------------------------x---------------------
---------->


-- 
software engineer
rajagiri school of engineering and technology - autonomous


