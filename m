Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2942B8797
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgKRWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:15:39 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17869C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:15:39 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t16so4000503oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GN9ZtLqvPN3P61rjrLUOtMJVIzbOZ2Xaz40VhyPGqmk=;
        b=hGi0z4Jr7+u8NK75BICl1n+CWRS3wVqHaN9tjkq35EiPiPmyngQZurxMHZzfR3RWly
         WBvoJXCDs7eHHatUSLLAsnTFdn6fIp3xYskN0gdPhp++F8p1jpmch0yQW5N/8clt40Tt
         uxDfS0eb8VnWXPk9jbeS2t5VGbkm6cBFYLiak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GN9ZtLqvPN3P61rjrLUOtMJVIzbOZ2Xaz40VhyPGqmk=;
        b=oNxvmAi/0XcxZlIb+QNkXGyUv+aTK6guiUMSpEQEbXBFkvK1KCTYl76lmgQ3hBbRe0
         0nBU/uFBqPA/qxHPjpF+8jaf1FRLEWCLnrk7J2inSaFboz5L3yoxOzea95mwGDLFLnaI
         l34MVZ/Y9gZZ7QluGRSsc+00PJw4Y/9bC6C+q5avyb9l2dXDIe4ZUxQVkxlVjH69Sw4u
         3TS/Pwk32rDekqvBtlNH5rwBRJ27M4wldCYbTj+647QILYVDq8+7ZlSibMZ2jdM1aIJF
         jGWh26Vl5R+Xu4X0bpN8u+rBlHp9AUymF7ARfFsd+s3cqCTSvo3d9w7Ci07MWZSiyPGY
         N8cg==
X-Gm-Message-State: AOAM532DYYutfcdtf9In4T2kVUSBhIUaH0yjFkRt4H+dk3FBjWj17pG8
        AOHpH2tlZii7s7UDIDhlGY/MGHZ0FJ0SPYWCSJK5qw==
X-Google-Smtp-Source: ABdhPJxK1ecbSHiRFlGDjudCyBJuhxp+ST5XRMNDeCMoRkeEvKCoak48jQ8NhO0v67V9nsn9PCrOlcucO0wFJEb2BpQ=
X-Received: by 2002:aca:4f14:: with SMTP id d20mr960155oib.14.1605737738452;
 Wed, 18 Nov 2020 14:15:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
 <692820a49ded436591b5fe3a18c68a5e@AcuMS.aculab.com> <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
 <0a10da3d-085f-c7a7-0053-dc1e9ea871ed@suse.de> <f7be660da595411ab60aaa4b76008769@AcuMS.aculab.com>
In-Reply-To: <f7be660da595411ab60aaa4b76008769@AcuMS.aculab.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 18 Nov 2020 23:15:27 +0100
Message-ID: <CAKMK7uFZhVqEzjfHszQ=1KeoRecXSDa0+tdH_rT8yENY9zasyQ@mail.gmail.com>
Subject: Re: Linux 5.10-rc4
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Huang, Ray" <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:01 PM David Laight <David.Laight@aculab.com> wro=
te:
>
> From: Thomas Zimmermann
> > Sent: 18 November 2020 19:37
> >
> > Hi
> >
> > Am 18.11.20 um 19:10 schrieb Linus Torvalds:
> > > On Wed, Nov 18, 2020 at 4:12 AM David Laight <David.Laight@aculab.com=
> wrote:
> > >>
> > >> I've got the 'splat' below during boot.
> > >> This is an 8-core C2758 Atom cpu using the on-board/cpu graphics.
> > >> User space is Ubuntu 20.04.
> > >>
> > >> Additionally the X display has all the colours and alignment slightl=
y
> > >> messed up.
> > >> 5.9.0 was ok.
> > >> I'm just guessing the two issues are related.
> > >
> > > Sounds likely.  But it would be lovely if you could bisect when
> > > exactly the problem(s) started to both verify that, and just to
> > > pinpoint the exact change..
>
> I don't quite understand what 'git bisect' did.
> I was bisecting between v5.9 and v5.10-rc1 but it suddenly started
> generating v5.9.0-rc5+ kernels.

We queue up patches for -rc1 way before the previous kernel is
released, so this is normal.

> The identified commit was 13a8f46d803 drm/ttm: move ghost object created.
> (retyped - hope it is right).
> But the diff to that last 'good' commit is massive.

Yeah that's also normal for non-linear history. If you want to
double-check, re-test the parent of that commit (which is 2ee476f77ffe
("drm/ttm: add a simple assign mem to bo wrapper")), which should
work, and then the bad commit.

Also is this the first bad commit for both the splat and the screen
corruption issues?

> So I don't know if that is anywhere near right.

Thomas guessed it could be a ttm change, you hit one, and it looks
like it could be the culprit. Now I guess it's up to Dave. Also adding
Christian, in case he has an idea.
-Daniel

>
>         David
>
> > >
> > > I'm adding Thomas Zimmermann to the cc, because he did that "drm/ast:
> > > Program display mode in CRTC's atomic_enable" which looks relevant in
> > > that it's right in that call-chain.
> > >
> > > Did some initialization perhaps get overlooked?
> > >
> > > And Dave and Daniel and the drm list cc'd as well..
> > >
> > > Full splat left quoted below for new people and list.
> > >
> > >              Linus
> > >
> > >> [   20.809891] WARNING: CPU: 0 PID: 973 at drivers/gpu/drm/drm_gem_v=
ram_helper.c:284
> > drm_gem_vram_offset+0x35/0x40 [drm_vram_helper]
> >
> > That line is at [1], which comes from
> >
> >   46642a7d4d80 ("drm/vram-helper: don't use ttm bo->offset v4")
> >
> > But the patch was merged in 5.9-rc1, so it's probably something else.
> >
> > We've had a lot of TTM-related changes recently, so my best guess is
> > that it's something in TTM with BO initialization.
> >
> >  From some grepping, it looks like we have to call ttm_bo_mem_space() t=
o
> > fill mm_node (i.e., the pointer that causes the warning). But I cannot
> > find where vram helpers do this. Maybe that's a good starting point.
> >
> > I'm adding the TTM devs to cc.
> >
> > Best regards
> > Thomas
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/drm_gem_vram_h
> > elper.c?h=3Dv5.10-rc4#n284
> >
> >
> > >> [   20.821543] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh=
_rdac scsi_dh_emc scsi_dh_alua
> > ipmi_ssif intel_powerclamp coretemp kvm_intel kvm joydev input_leds ipm=
i_si intel_cstate ipmi_devintf
> > ipmi_msghandler mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tab=
les x_tables autofs4 btrfs
> > blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_me=
mcpy async_pq async_xor
> > async_tx libcrc32c xor raid6_pq raid1 raid0 multipath linear ast drm_vr=
am_helper drm_kms_helper
> > syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm cr=
ct10dif_pclmul crc32_pclmul
> > ghash_clmulni_intel gpio_ich drm aesni_intel hid_generic glue_helper cr=
ypto_simd igb usbhid cryptd
> > ahci i2c_i801 hid libahci i2c_smbus lpc_ich dca i2c_ismt i2c_algo_bit
> > >> [   20.887477] CPU: 0 PID: 973 Comm: gnome-shell Not tainted 5.10.0-=
rc4+ #78
> > >> [   20.894274] Hardware name: Supermicro A1SAi/A1SRi, BIOS 1.1a 08/2=
7/2015
> > >> [   20.900896] RIP: 0010:drm_gem_vram_offset+0x35/0x40 [drm_vram_hel=
per]
> > >> [   20.907342] Code: 00 48 89 e5 85 c0 74 17 48 83 bf 78 01 00 00 00=
 74 18 48 8b 87 80 01 00 00 5d
> > 48 c1 e0 0c c3 0f 0b 48 c7 c0 ed ff ff ff 5d c3 <0f> 0b 31 c0 5d c3 0f =
1f 44 00 00 0f 1f 44 00 00 55
> > 48 8b 87 18 06
> > >> [   20.926100] RSP: 0018:ffff9f59811d3a68 EFLAGS: 00010246
> > >> [   20.931339] RAX: 0000000000000002 RBX: ffff8b46861e20c0 RCX: ffff=
ffffc032d600
> > >> [   20.938479] RDX: ffff8b468f47a000 RSI: ffff8b46861e2000 RDI: ffff=
8b468f9acc00
> > >> [   20.945622] RBP: ffff9f59811d3a68 R08: 0000000000000040 R09: ffff=
8b46864ce288
> > >> [   20.952769] R10: 0000000000000000 R11: 0000000000000001 R12: ffff=
8b468f47a000
> > >> [   20.959915] R13: 0000000000000000 R14: 0000000000000000 R15: ffff=
8b468ad2bf00
> > >> [   20.967057] FS:  00007f5b37ac5cc0(0000) GS:ffff8b49efc00000(0000)=
 knlGS:0000000000000000
> > >> [   20.975149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   20.980904] CR2: 00007f5b3d093f00 CR3: 0000000103438000 CR4: 0000=
0000001006f0
> > >> [   20.988047] Call Trace:
> > >> [   20.990506]  ast_cursor_page_flip+0x22/0x100 [ast]
> > >> [   20.995313]  ast_cursor_plane_helper_atomic_update+0x46/0x70 [ast=
]
> > >> [   21.001524]  drm_atomic_helper_commit_planes+0xbd/0x220 [drm_kms_=
helper]
> > >> [   21.008243]  drm_atomic_helper_commit_tail_rpm+0x3a/0x70 [drm_kms=
_helper]
> > >> [   21.015062]  commit_tail+0x99/0x130 [drm_kms_helper]
> > >> [   21.020050]  drm_atomic_helper_commit+0x123/0x150 [drm_kms_helper=
]
> > >> [   21.026269]  drm_atomic_commit+0x4a/0x50 [drm]
> > >> [   21.030737]  drm_atomic_helper_update_plane+0xe7/0x140 [drm_kms_h=
elper]
> > >> [   21.037384]  __setplane_atomic+0xcc/0x110 [drm]
> > >> [   21.041953]  drm_mode_cursor_universal+0x13e/0x260 [drm]
> > >> [   21.047299]  drm_mode_cursor_common+0xef/0x220 [drm]
> > >> [   21.052287]  ? alloc_set_pte+0x10d/0x6d0
> > >> [   21.056244]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> > >> [   21.061242]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
> > >> [   21.066067]  drm_ioctl_kernel+0xae/0xf0 [drm]
> > >> [   21.070455]  drm_ioctl+0x241/0x3f0 [drm]
> > >> [   21.074415]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> > >> [   21.079401]  __x64_sys_ioctl+0x91/0xc0
> > >> [   21.083167]  do_syscall_64+0x38/0x90
> > >> [   21.086755]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >> [   21.091813] RIP: 0033:0x7f5b3cf1350b
> > >> [   21.095403] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66
> > 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 =
01 c3 48 8b 0d 55 39 0d 00 f7
> > d8 64 89 01 48
> > >> [   21.114154] RSP: 002b:00007ffef1966588 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000010
> > >> [   21.121730] RAX: ffffffffffffffda RBX: 00007ffef19665c0 RCX: 0000=
7f5b3cf1350b
> > >> [   21.128870] RDX: 00007ffef19665c0 RSI: 00000000c02464bb RDI: 0000=
000000000009
> > >> [   21.136013] RBP: 00000000c02464bb R08: 0000000000000040 R09: 0000=
000000000004
> > >> [   21.143157] R10: 0000000000000002 R11: 0000000000000246 R12: 0000=
561ec9d10060
> > >> [   21.150295] R13: 0000000000000009 R14: 0000561eca2cc9a0 R15: 0000=
000000000040
> >
> > --
> > Thomas Zimmermann
> > Graphics Driver Developer
> > SUSE Software Solutions Germany GmbH
> > Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> > (HRB 36809, AG N=C3=BCrnberg)
> > Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
