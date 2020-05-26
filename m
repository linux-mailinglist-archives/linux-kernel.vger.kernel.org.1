Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7801ADCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgDQMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730483AbgDQMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:00:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F4FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:00:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v7so2085836qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T2wajJMzRjlVLFNFLH6U/p7e0hksFro3MqILk7gjdLI=;
        b=maxX+3L3pZMUp47LQZsJnveVlhVA0Ut4EFPZacXIZzVyZkmGWOHdPHM2vKlQWwOoCC
         TCExHx0m6w3Z8BGACt73XggspkOO2iIL8wwcYo34wWUa25AfbUmlrFuOjN4G5Yp7w8s4
         PkgFyqHz7C9JEZIdFmuZJxTwGv0n0e2yHf+nq2VTxvOG00HYsbPGVaH4a1KyQYTMqgyG
         UAiXH29Dvk8Dnbzh7c5yjx6le4h+L4+qzvJRQLTgRufmfhVq7YeCzWHLQ9173JmmBsH0
         e70qAdrDRmpBJMSmTypnV8n4rhW9yLTx6fJUAm0Dg2eSxj9kdWGu415Vb+BJzOLBSe4i
         U+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T2wajJMzRjlVLFNFLH6U/p7e0hksFro3MqILk7gjdLI=;
        b=JRZztvjK4ZKj6S/VYZ64MwoejAy6vxcdhdQbd6pW1zz6JX6C+uC0tCTFBa8uAyOBtx
         6BzHJaCBdvv2H/VjPoMwqY7OWO5Det+R1tKVK7ZG9o33U+CdYLXNxM+NkklMXcprR0uz
         yKaszIrKsu2aP3XTx5If+A5ChIpdT3uhkUT8/UuJVHkE4XX1p6weRVJwtQMXU8NwCJdy
         S+6Z9wvb4IJn8V1n+uQjLTACSStqi+NKz9pL83Eb+7JsQ39O33nQnyfDjQ7A4XTtxaN8
         KqILFRXvitC0CuoD+7WMYIBjaoY9P35oD0DROh13wLHn023s+ItB61obWrlASWjsUY1j
         OBEA==
X-Gm-Message-State: AGi0Pua9z75DeUdZfdu1aey1GAK1wpaLrf8X6CSl7pKE78QDDYBJv3WT
        E7U8h0ZZgR/UuPgTa507cWpRSQ==
X-Google-Smtp-Source: APiQypIcW8TyE2+7Ufbl23uSYy5jYo8QhH0mYVuYTrUnWf2yNx02d3vpdm0uWtEbvSI/yGgkkZT11w==
X-Received: by 2002:a05:620a:103b:: with SMTP id a27mr2671414qkk.16.1587124852348;
        Fri, 17 Apr 2020 05:00:52 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o13sm5654046qke.77.2020.04.17.05.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 05:00:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: POWER9 crash due to STRICT_KERNEL_RWX (WAS: Re: Linux-next POWER9
 NULL pointer NIP...)
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1587106774.1oa2whm69m.naveen@linux.ibm.com>
Date:   Fri, 17 Apr 2020 08:00:50 -0400
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE9427F0-9C10-438B-8E57-3F1BF1834B9A@lca.pw>
References: <15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw>
 <87eeszlb6u.fsf@mpe.ellerman.id.au>
 <0675B22E-8F32-432C-9378-FDE159DD1729@lca.pw>
 <20200407093054.3eb23e45@gandalf.local.home>
 <EA9F9A54-87BC-477A-BE8A-7D53F80C5223@lca.pw>
 <20200409101413.35d9c72d@gandalf.local.home>
 <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw>
 <161662E3-5D9C-4C15-919C-CFEFE4CC35CB@lca.pw>
 <69F0448F-CA5B-497D-B8AF-2848175B9477@lca.pw>
 <1587106774.1oa2whm69m.naveen@linux.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2020, at 3:01 AM, Naveen N. Rao =
<naveen.n.rao@linux.ibm.com> wrote:
>=20
> Hi Qian,
>=20
> Qian Cai wrote:
>> OK, reverted the commit,
>> c55d7b5e6426 (=E2=80=9Cpowerpc: Remove STRICT_KERNEL_RWX =
incompatibility with RELOCATABLE=E2=80=9D)
>> or set STRICT_KERNEL_RWX=3Dn fixed the crash below and also mentioned =
in this thread,
>> =
https://lore.kernel.org/lkml/15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw/
>=20
> Do you see any errors logged in dmesg when you see the crash?  =
STRICT_KERNEL_RWX changes how patch_instruction() works, so it would be =
interesting to see if there are any ftrace-related errors thrown before =
the crash.

Yes, looks like there is a warning right after,

echo function > /sys/kernel/debug/tracing/current_tracer
echo nop > /sys/kernel/debug/tracing/current_tracer

and just before the crash,

[ T3454] ftrace-powerpc: Unexpected call sequence at 00000000de85f044: =
48003d1d 7c0802a6
[   56.870472][ T3454] ------------[ cut here ]------------
[   56.870500][ T3454] WARNING: CPU: 52 PID: 3454 at =
kernel/trace/ftrace.c:2026 ftrace_bug+0x104/0x310
[   56.870527][ T3454] Modules linked in: kvm_hv kvm ses enclosure =
scsi_transport_sas ip_tables x_tables xfs sd_mod i40e firmware_class =
aacraid dm_mirror dm_region_hash dm_log dm_mod
[   56.870592][ T3454] CPU: 52 PID: 3454 Comm: nip.sh Not tainted =
5.7.0-rc1-next-20200416 #4
[   56.870627][ T3454] NIP:  c0000000002a3ae4 LR: c0000000002a47fc CTR: =
c0000000002436f0
[   56.870661][ T3454] REGS: c00000069a9ef710 TRAP: 0700   Not tainted  =
(5.7.0-rc1-next-20200416)
[   56.870697][ T3454] MSR:  900000000282b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28228222  XER: 00000000
[   56.870748][ T3454] CFAR: c0000000002a3a2c IRQMASK: 0=20
[   56.870748][ T3454] GPR00: c0000000002a47fc c00000069a9ef9a0 =
c0000000012f9000 ffffffffffffffea=20
[   56.870748][ T3454] GPR04: c0002004e2160438 c0000007fedf0ad8 =
00000000614ca19d 0000000000000007=20
[   56.870748][ T3454] GPR08: 0000000000000003 0000000000000000 =
0000000000000000 0000000000000002=20
[   56.870748][ T3454] GPR12: 0000000000004000 c0000007fffd5600 =
0000000040000000 0000000139ae9798=20
[   56.870748][ T3454] GPR16: 0000000139ae9724 0000000139a86968 =
0000000139a1f230 0000000139aed568=20
[   56.870748][ T3454] GPR20: 00000001402af8b0 0000000000000009 =
0000000139a996e8 00007fffc9186d94=20
[   56.870748][ T3454] GPR24: 0000000000000000 c00000069a9efc00 =
c00000000132cd00 c00000069a9efc40=20
[   56.870748][ T3454] GPR28: c0000000011c29e8 0000000000000001 =
c0002004e2160438 c008000009321a64=20
[   56.870969][ T3454] NIP [c0000000002a3ae4] ftrace_bug+0x104/0x310
ftrace_bug at kernel/trace/ftrace.c:2026
[   56.870995][ T3454] LR [c0000000002a47fc] =
ftrace_modify_all_code+0x16c/0x210
ftrace_modify_all_code at kernel/trace/ftrace.c:2672
[   56.871034][ T3454] Call Trace:
[   56.871057][ T3454] [c00000069a9ef9a0] [4bffff899a9efa00] =
0x4bffff899a9efa00 (unreliable)
[   56.871086][ T3454] [c00000069a9efa20] [c0000000002a47fc] =
ftrace_modify_all_code+0x16c/0x210
[   56.871125][ T3454] [c00000069a9efa50] [c000000000061b68] =
arch_ftrace_update_code+0x18/0x30
[   56.871162][ T3454] [c00000069a9efa70] [c0000000002a49c4] =
ftrace_run_update_code+0x44/0xc0
[   56.871199][ T3454] [c00000069a9efaa0] [c0000000002aa3c8] =
ftrace_startup+0xe8/0x1b0
[   56.871236][ T3454] [c00000069a9efae0] [c0000000002aa4e0] =
register_ftrace_function+0x50/0xc0
[   56.871275][ T3454] [c00000069a9efb10] [c0000000002d0468] =
function_trace_init+0x98/0xd0
[   56.871312][ T3454] [c00000069a9efb40] [c0000000002c75c0] =
tracing_set_tracer+0x350/0x640
[   56.871349][ T3454] [c00000069a9efbe0] [c0000000002c7a90] =
tracing_set_trace_write+0x1e0/0x370
[   56.871388][ T3454] [c00000069a9efd00] [c00000000052094c] =
__vfs_write+0x3c/0x70
[   56.871424][ T3454] [c00000069a9efd20] [c000000000523d4c] =
vfs_write+0xcc/0x200
[   56.871461][ T3454] [c00000069a9efd70] [c0000000005240ec] =
ksys_write+0x7c/0x140
[   56.871498][ T3454] [c00000069a9efdc0] [c000000000038a94] =
system_call_exception+0x114/0x1e0
[   56.871535][ T3454] [c00000069a9efe20] [c00000000000c870] =
system_call_common+0xf0/0x278
[   56.871570][ T3454] Instruction dump:
[   56.871592][ T3454] 7d908120 4e800020 60000000 2b890001 409effd4 =
3c62ff8b 38631958 4bf4491d=20
[   56.871639][ T3454] 60000000 4bffffc0 60000000 fba10068 <0fe00000> =
39000001 3ce20003 3d22fed7=20
[   56.871685][ T3454] irq event stamp: 95388
[   56.871708][ T3454] hardirqs last  enabled at (95387): =
[<c0000000001e4f94>] console_unlock+0x6a4/0x950
[   56.871746][ T3454] hardirqs last disabled at (95388): =
[<c00000000000960c>] program_check_common_virt+0x2bc/0x310
[   56.871785][ T3454] softirqs last  enabled at (91222): =
[<c000000000a213c8>] __do_softirq+0x658/0x8d8
[   56.871823][ T3454] softirqs last disabled at (91215): =
[<c00000000011b40c>] irq_exit+0x16c/0x1d0
[   56.871859][ T3454] ---[ end trace 48f8445450a4e206 ]---
[   56.871907][ T3454] ftrace failed to modify=20
[   56.871913][ T3454] [<c008000009321a64>] =
show_sas_rphy_phy_identifier+0xc/0x60 [scsi_transport_sas]
show_sas_rphy_phy_identifier at drivers/scsi/scsi_transport_sas.c:1221
[   56.871969][ T3454]  actual:   1d:3d:00:48
[   56.871996][ T3454] Setting ftrace call site to call ftrace function
[   56.872020][ T3454] ftrace record flags: 80000001
[   56.872054][ T3454]  (1) =20
[   56.872054][ T3454]  expected tramp: c000000000061fac=
