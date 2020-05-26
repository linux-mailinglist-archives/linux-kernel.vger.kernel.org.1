Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843CA1AD494
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 04:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgDQCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbgDQCks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:40:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:40:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l78so1023079qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=GbLsq3eNz0RhPkanQBBFrRr66hvLaz1YBG3/HwOzWxU=;
        b=Xpp7yTD7jP8DZZhjp+3VvLmWFViMXRgGwL/tLWA5l1J7XuQ312TbIDKOy7dq8KLGHu
         cw+byvGhvqjIQf3ScjqH5GN16bnEMjKFZCLud2Rl9zloH1qjOa3IBRjWAQ1JyRmzRqDQ
         t2SqYg2kNEst3L50rz28j8vBAGg23C0B6O0zNUWqvMoNsGwkxYdD7sSxyfGAF4WM3VOZ
         jeLenVy+4es9nBtDAaVqL3IMyPHV/2kJMJdin/qT/ROfgQjFAUY2IYuORmMKykdjJdsF
         fp3d94+AxrhRV329MwXCpPX5/NfFtTANgnyn4Z1+aCKNj7dV2vjt3TTCS3nC02fx2DZF
         N9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=GbLsq3eNz0RhPkanQBBFrRr66hvLaz1YBG3/HwOzWxU=;
        b=tqgCAJJ75B61H1i6iNTIBlvdW0bvojjgTL2TYJAbBFsCmWy96Qvhw4RfxX8rTy+Jdl
         wu1VtUwZQf1L6bbEyBnpUq4Cjgn6i1M7on6gbKWJZOS9C3TcJWz32Sb0OI1oSX0xEcol
         l3On5Z5r5R3/KTO74UMHTHIq3IInbt4wrjyamMS8puoLiATvc9BBTDLO1IlFZE84yUqi
         DjOTyX+20HjUkFbCStW5M4iDtw+Y2SS05cqNda0PrW8hub7FUm315u3Yde+t6FrLJrsB
         DGWw7luPliiHvt51vXwEAQRekN6qxwAQC1RpeDdiEefNJ2VbS5TCF0X4nfqf9WnQHf+r
         kQvg==
X-Gm-Message-State: AGi0PubWhzWobUQBs11WxUrr8lg2d1MdfjuO4kkjZxMKhTkGvlfUJ3zT
        QGghk5X0Rbzny7XS9uTP7/w2BA==
X-Google-Smtp-Source: APiQypK8TYdwx/USMHjOH1XzRj6r1e2j+LKXgQyM0qE85qw2DADiSMTvFHnp7+redCQ4TwBS6xeNwQ==
X-Received: by 2002:ae9:ddc6:: with SMTP id r189mr1151445qkf.14.1587091247707;
        Thu, 16 Apr 2020 19:40:47 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m83sm10950760qke.117.2020.04.16.19.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 19:40:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Thu, 16 Apr 2020 22:40:46 -0400
Subject: Re: POWER9 crash due to STRICT_KERNEL_RWX (WAS: Re: Linux-next POWER9 NULL pointer NIP...)
Message-Id: <43EE54C0-6F20-4ADD-9948-21F24D90C5E1@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Russell Currey <ruscur@russell.cc>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 16, 2020, at 10:27 PM, Russell Currey <ruscur@russell.cc> wrote:
>=20
> Reverting the patch with the given config will have the same effect as
> STRICT_KERNEL_RWX=3Dn.  Not discounting that it could be a bug on the
> powerpc side (i.e. relocatable kernels with strict RWX on haven't been
> exhaustively tested yet), but we should definitely figure out what's
> going on with this bad access first.

BTW, this bad access only happened once. The overwhelming rest of crashes ar=
e with NULL pointer NIP like below. How can you explain that STRICT_KERNEL_R=
WX=3Dn would also make those NULL NIP disappear if STRICT_KERNEL_RWX is just=
 a messenger?

[  215.281666][T16896] LTP: starting chown04_16
[  215.424203][T18297] BUG: Unable to handle kernel instruction fetch (NULL p=
ointer?)
[  215.424289][T18297] Faulting instruction address: 0x00000000
[  215.424313][T18297] Oops: Kernel access of bad area, sig: 11 [#1]
[  215.424341][T18297] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 DEBU=
G_PAGEALLOC NUMA PowerNV
[  215.424383][T18297] Modules linked in: loop kvm_hv kvm ip_tables x_tables=
 xfs sd_mod bnx2x mdio tg3 ahci libahci libphy libata firmware_class dm_mirr=
or dm_region_hash dm_log dm_mod
[  215.424459][T18297] CPU: 85 PID: 18297 Comm: chown04_16 Tainted: G       =
 W         5.6.0-next-20200405+ #3
[  215.424489][T18297] NIP:  0000000000000000 LR: c00800000fbc0408 CTR: 0000=
000000000000
[  215.424530][T18297] REGS: c000200b8606f990 TRAP: 0400   Tainted: G       =
 W          (5.6.0-next-20200405+)
[  215.424570][T18297] MSR:  9000000040009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:=
 84000248  XER: 20040000
[  215.424619][T18297] CFAR: c00800000fbc64f4 IRQMASK: 0=20
[  215.424619][T18297] GPR00: c0000000006c2238 c000200b8606fc20 c00000000165=
ce00 0000000000000000=20
[  215.424619][T18297] GPR04: c000201a58106400 c000200b8606fcc0 000000005f03=
7e7d ffffffff00013bfb=20
[  215.424619][T18297] GPR08: c000201a58106400 0000000000000000 000000000000=
0000 c000000001652ee0=20
[  215.424619][T18297] GPR12: 0000000000000000 c000201fff69a600 000000000000=
0000 0000000000000000=20
[  215.424619][T18297] GPR16: 0000000000000000 0000000000000000 000000000000=
0000 0000000000000000=20
[  215.424619][T18297] GPR20: 0000000000000000 0000000000000000 000000000000=
0000 0000000000000007=20
[  215.424619][T18297] GPR24: 0000000000000000 0000000000000000 c00800000fbc=
8688 c000200b8606fcc0=20
[  215.424619][T18297] GPR28: 0000000000000000 000000007fffffff c00800000fbc=
0400 c00020068b8c0e70=20
[  215.424914][T18297] NIP [0000000000000000] 0x0
[  215.424953][T18297] LR [c00800000fbc0408] find_free_cb+0x8/0x30 [loop]
find_free_cb at drivers/block/loop.c:2129
[  215.424997][T18297] Call Trace:
[  215.425036][T18297] [c000200b8606fc20] [c0000000006c2290] idr_for_each+0x=
f0/0x170 (unreliable)
[  215.425073][T18297] [c000200b8606fca0] [c00800000fbc2744] loop_lookup.par=
t.2+0x4c/0xb0 [loop]
loop_lookup at drivers/block/loop.c:2144
[  215.425105][T18297] [c000200b8606fce0] [c00800000fbc3558] loop_control_io=
ctl+0x120/0x1d0 [loop]
[  215.425149][T18297] [c000200b8606fd40] [c0000000004eb688] ksys_ioctl+0xd8=
/0x130
[  215.425190][T18297] [c000200b8606fd90] [c0000000004eb708] sys_ioctl+0x28/=
0x40
[  215.425233][T18297] [c000200b8606fdb0] [c00000000003cc30] system_call_exc=
eption+0x110/0x1e0
[  215.425274][T18297] [c000200b8606fe20] [c00000000000c9f0] system_call_com=
mon+0xf0/0x278
[  215.425314][T18297] Instruction dump:
[  215.425338][T18297] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=
 XXXXXXXX XXXXXXXX=20
[  215.425374][T18297] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=
 XXXXXXXX XXXXXXXX=20
[  215.425422][T18297] ---[ end trace ebed248fad431966 ]---
[  215.642114][T18297]=20
[  216.642220][T18297] Kernel panic - not syncing: Fatal exception=
