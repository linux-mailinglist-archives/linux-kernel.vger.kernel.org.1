Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57F1AD4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgDQDQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 23:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729424AbgDQDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:16:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF50C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:16:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o19so1090306qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mmiRhLSgoBPBHj7I2PNtG4RAL93NE1eTfGw/ElzRpC0=;
        b=seP3xgW80J2xsnzfiZz/bnFi7mmKnjsd4J7y0L3IwJfiC+HxX3HV1wkxCY59lsH384
         N1NirLpMsZCVULR1EMxI5F3JKk1Ws95iCd1yOYXYfM6IAGKTU1823IWwSqWerQG0KAPa
         SLKXsTzOk2h2KbpeoPYOAF6SLZfXnOF0tE86WEwyG+vk+we2CYGfWV7Yanm9UhRJ1NWJ
         Ll+OIcr3YtsmAYgoctscgT6eDR4cM8aP6iNSj+vv3jT4giE+jqx6ChFpjzST9BjJaVL4
         yy/57JkzWjBDZLXnoXY5DD8XfNHk2CwjefW9kJ98JA8JP64i8dtBkjWk/+OhMzS0zIlw
         SE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mmiRhLSgoBPBHj7I2PNtG4RAL93NE1eTfGw/ElzRpC0=;
        b=Y4+Cf0LmYxzoph4DvTgmG/OwWJU8xY2xcpy8VXCkuH2B5k9YlbxaUToNp8OUBAEnwQ
         151xJm8eANzygATnS5h2Xwh4sw3wUd03C1y+AevYZd1e/p7b2MktinH208VeAUzHdcpO
         j5Ea/sdmrx5bcI28/FCPAkVD5V6NODa/kpUlehwQArxIyqNLuaW8WYl7a5bJQdheET1f
         1npFLOLMtlQOR12ioIee+NVWiAJhWfBAf0Z1N55JLAYKbyVpN/qmXvNIi6BLLeq/wQUk
         pJVx5U13sALcJ/RCWesesW5+A8zsqRzVNDD3GN1W/VGghHTk5HzuGYN9bV3EjWg8d2tC
         dIiQ==
X-Gm-Message-State: AGi0Pub68zgKs22mdwkBJSkd21D0FQEt5hssaUrlnruJ/gftOQZpn6tM
        kF+q5Wk6nJFyAgzICSbgG7J8pQ==
X-Google-Smtp-Source: APiQypI5WJaQ8L18F8pdusM/+qYVZYsUWzYJ1EaBbndy+w0UTMBsmHg9L+InbSaRvIABDzPhdUJcng==
X-Received: by 2002:a37:ac6:: with SMTP id 189mr1299092qkk.60.1587093404242;
        Thu, 16 Apr 2020 20:16:44 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b10sm16445282qtj.30.2020.04.16.20.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 20:16:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: POWER9 crash due to STRICT_KERNEL_RWX (WAS: Re: Linux-next POWER9
 NULL pointer NIP...)
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <fec2e755ea20e15dc5b6fee6c856562aa42872bd.camel@russell.cc>
Date:   Thu, 16 Apr 2020 23:16:42 -0400
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1C4ABE6-ED26-43B2-9A50-90E4224117A5@lca.pw>
References: <43EE54C0-6F20-4ADD-9948-21F24D90C5E1@lca.pw>
 <fec2e755ea20e15dc5b6fee6c856562aa42872bd.camel@russell.cc>
To:     Russell Currey <ruscur@russell.cc>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 16, 2020, at 10:46 PM, Russell Currey <ruscur@russell.cc> =
wrote:
>=20
> On Thu, 2020-04-16 at 22:40 -0400, Qian Cai wrote:
>>> On Apr 16, 2020, at 10:27 PM, Russell Currey <ruscur@russell.cc>
>>> wrote:
>>>=20
>>> Reverting the patch with the given config will have the same effect
>>> as
>>> STRICT_KERNEL_RWX=3Dn.  Not discounting that it could be a bug on =
the
>>> powerpc side (i.e. relocatable kernels with strict RWX on haven't
>>> been
>>> exhaustively tested yet), but we should definitely figure out
>>> what's
>>> going on with this bad access first.
>>=20
>> BTW, this bad access only happened once. The overwhelming rest of
>> crashes are with NULL pointer NIP like below. How can you explain
>> that STRICT_KERNEL_RWX=3Dn would also make those NULL NIP disappear =
if
>> STRICT_KERNEL_RWX is just a messenger?
>=20
> What happens if you test with STRICT_KERNEL_RWX=3Dy and RELOCATABLE=3Dn,=

> reverting my patch?  This would give us an idea of whether it's
> something broken recently or if there's something else going on.

I don=E2=80=99t know what did you mean by reverting your patch because =
that combination
can be tested as-is. Anyway, it could take a long time to reproduce, so =
I=E2=80=99ll keep it
running for up to 12-hour to confirm it could not really crash.

>=20
>>=20
>> [  215.281666][T16896] LTP: starting chown04_16
>> [  215.424203][T18297] BUG: Unable to handle kernel instruction fetch
>> (NULL pointer?)
>> [  215.424289][T18297] Faulting instruction address: 0x00000000
>> [  215.424313][T18297] Oops: Kernel access of bad area, sig: 11 [#1]
>> [  215.424341][T18297] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256=

>> DEBUG_PAGEALLOC NUMA PowerNV
>> [  215.424383][T18297] Modules linked in: loop kvm_hv kvm ip_tables
>> x_tables xfs sd_mod bnx2x mdio tg3 ahci libahci libphy libata
>> firmware_class dm_mirror dm_region_hash dm_log dm_mod
>> [  215.424459][T18297] CPU: 85 PID: 18297 Comm: chown04_16 Tainted:
>> G        W         5.6.0-next-20200405+ #3
>> [  215.424489][T18297] NIP:  0000000000000000 LR: c00800000fbc0408
>> CTR: 0000000000000000
>> [  215.424530][T18297] REGS: c000200b8606f990 TRAP: 0400   Tainted:
>> G        W          (5.6.0-next-20200405+)
>> [  215.424570][T18297] MSR:  9000000040009033
>> <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 84000248  XER: 20040000
>> [  215.424619][T18297] CFAR: c00800000fbc64f4 IRQMASK: 0=20
>> [  215.424619][T18297] GPR00: c0000000006c2238 c000200b8606fc20
>> c00000000165ce00 0000000000000000=20
>> [  215.424619][T18297] GPR04: c000201a58106400 c000200b8606fcc0
>> 000000005f037e7d ffffffff00013bfb=20
>> [  215.424619][T18297] GPR08: c000201a58106400 0000000000000000
>> 0000000000000000 c000000001652ee0=20
>> [  215.424619][T18297] GPR12: 0000000000000000 c000201fff69a600
>> 0000000000000000 0000000000000000=20
>> [  215.424619][T18297] GPR16: 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000000=20
>> [  215.424619][T18297] GPR20: 0000000000000000 0000000000000000
>> 0000000000000000 0000000000000007=20
>> [  215.424619][T18297] GPR24: 0000000000000000 0000000000000000
>> c00800000fbc8688 c000200b8606fcc0=20
>> [  215.424619][T18297] GPR28: 0000000000000000 000000007fffffff
>> c00800000fbc0400 c00020068b8c0e70=20
>> [  215.424914][T18297] NIP [0000000000000000] 0x0
>> [  215.424953][T18297] LR [c00800000fbc0408] find_free_cb+0x8/0x30
>> [loop]
>> find_free_cb at drivers/block/loop.c:2129
>> [  215.424997][T18297] Call Trace:
>> [  215.425036][T18297] [c000200b8606fc20] [c0000000006c2290]
>> idr_for_each+0xf0/0x170 (unreliable)
>> [  215.425073][T18297] [c000200b8606fca0] [c00800000fbc2744]
>> loop_lookup.part.2+0x4c/0xb0 [loop]
>> loop_lookup at drivers/block/loop.c:2144
>> [  215.425105][T18297] [c000200b8606fce0] [c00800000fbc3558]
>> loop_control_ioctl+0x120/0x1d0 [loop]
>> [  215.425149][T18297] [c000200b8606fd40] [c0000000004eb688]
>> ksys_ioctl+0xd8/0x130
>> [  215.425190][T18297] [c000200b8606fd90] [c0000000004eb708]
>> sys_ioctl+0x28/0x40
>> [  215.425233][T18297] [c000200b8606fdb0] [c00000000003cc30]
>> system_call_exception+0x110/0x1e0
>> [  215.425274][T18297] [c000200b8606fe20] [c00000000000c9f0]
>> system_call_common+0xf0/0x278
>> [  215.425314][T18297] Instruction dump:
>> [  215.425338][T18297] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> XXXXXXXX XXXXXXXX XXXXXXXX=20
>> [  215.425374][T18297] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> XXXXXXXX XXXXXXXX XXXXXXXX=20
>> [  215.425422][T18297] ---[ end trace ebed248fad431966 ]---
>> [  215.642114][T18297]=20
>> [  216.642220][T18297] Kernel panic - not syncing: Fatal exception

