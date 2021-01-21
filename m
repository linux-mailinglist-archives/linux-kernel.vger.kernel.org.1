Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5B2FEDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbhAUO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:57:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731676AbhAUO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:56:34 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611240951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YB9hVk6Fcal+rh39pGb7MRaVo83OIPQaewXiOq02wNk=;
        b=oQphxIlNK8AiobSSI8vWH3//MB3DLAfuFnNk7GeLyiwS9kxta/myHhCeNc77KEUVgsWbNM
        ZoE8v9ZdEkLONIsI8CiyJvq338QVJgajU6z1r/wJMqnM4yIIwD3ZxBTMisfjpZSY1e89tW
        IsUQGm/RP9AMOzcSF/8KbsV9eIBelyG7jiM2GzWmzYxiwIrKZjpXUl9jRGrYafhN7TbwYt
        kKqLqtCFQJdM/uZlx8Qyt3DgCiIeC7CblD4A1LGLiB/W7IFz7rGBDVcpKaaxA2QBHom1DD
        qYg8o1z9tXLCPp8tMhuqcfgdBgeU9uSN8nY2qL0OCwaqtH7T/akutXErEaz6yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611240951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YB9hVk6Fcal+rh39pGb7MRaVo83OIPQaewXiOq02wNk=;
        b=TyBUgfsQkdayMMxSBDw++azmAlHU+vYXbLag6zd/HCjItAn273Axm90gMf/XsIWp3XFToE
        j7hXznmMZRIY0MBg==
To:     David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "shenkai \(D\)" <shenkai8@huawei.com>,
        "Schander\, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
In-Reply-To: <8ac72d7b287ed1058b2dec3301578238aff0abdd.camel@infradead.org>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de> <8ac72d7b287ed1058b2dec3301578238aff0abdd.camel@infradead.org>
Date:   Thu, 21 Jan 2021 15:55:51 +0100
Message-ID: <877do65og8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Tue, Jan 19 2021 at 12:12, David Woodhouse wrote:
> On Tue, 2020-12-15 at 22:20 +0100, Thomas Gleixner wrote:
> We've been playing with this a little. There's a proof-of-concept hack
> below; don't look too hard because it's only really for figuring out
> the timing etc.
>
> Basically we ripped out the 'wait' parts of the x86 do_boot_cpu() into
> a separate function do_wait_cpu(). There are four phases to the wait.
>
>  =E2=80=A2 Wait for the AP to turn up in cpu_initialized_mask, set its bi=
t in
>    cpu_callout_mask to allow it to run the AP thread.
>  =E2=80=A2 Wait for it to finish init and show up in cpu_callin_mask.
>  =E2=80=A2 check_tsc_sync_source()
>  =E2=80=A2 Wait for cpu_online(cpu)
>
> There's an EARLY_INIT macro which controls whether the early bringup
> call actually *does* anything, or whether it's left until bringup_cpu()
> as the current code does. It allows a simple comparison of the two.
>
> First we tested under qemu (on a Skylake EC2 c5.metal instance). The
> do_boot_cpu() actually sending the IPIs took ~300k cycles itself.
> Without EARLY_INIT we see timing for the four wait phases along the
> lines of:
>
> [    0.285312] CPU#10 up in     192950,    952898,  60014786,        28 (=
  61160662)
> [    0.288311] CPU#11 up in     181092,    962704,  60010432,        30 (=
  61154258)
> [    0.291312] CPU#12 up in     386080,    970416,  60013956,        28 (=
  61370480)
> [    0.294311] CPU#13 up in     372782,    964506,  60010564,        28 (=
  61347880)
> [    0.297312] CPU#14 up in     389602,    976280,  60013046,        28 (=
  61378956)
> [    0.300312] CPU#15 up in     213132,    968148,  60012138,        28 (=
  61193446)
>
> If we define EARLY_INIT then that first phase of waiting for the CPU
> add itself is fairly much instantaneous, which is precisely what we
> were hoping for. We also seem to save about 300k cycles on the AP
> bringup too. It's just that it *all* pales into insignificance with
> whatever it's doing to synchronise the TSC for 60M cycles.

Yes, that's annoying, but it can be avoided. The host could tell the
guest that the TSC is perfectly synced.

> [    0.338829] CPU#10 up in        600,    689054,  60025522,        28 (=
  60715204)
> [    0.341829] CPU#11 up in        610,    635346,  60019390,        28 (=
  60655374)
> [    0.343829] CPU#12 up in        632,    619352,  60020728,        28 (=
  60640740)
> [    0.346829] CPU#13 up in        602,    514234,  60025402,        26 (=
  60540264)
> [    0.348830] CPU#14 up in        608,    621058,  60025952,        26 (=
  60647644)
> [    0.351829] CPU#15 up in        600,    624690,  60021526,       410 (=
  60647226)
>
> Testing on real hardware has been more interesting and less useful so
> far. We started with the CPUHP_BRINGUP_KICK_CPU state being
> *immediately* before CPUHP_BRINGUP_CPU. On my 28-thread Haswell box,
> that didn't come up at all even without actually *doing* anything in
> the pre-bringup phase. Merely bringing all the AP threads up through
> the various CPUHP_PREPARE_foo stages before actually bringing them
> online, was enough to break it. I have no serial port on this box so we
> haven't get worked out why; I've resorted to putting the
> CPUHP_BRINGUP_KICK_CPU state before CPUHP_WORKQUEUE_PREP instead.

Hrm.

> That lets it boot without the EARLY_INIT at least (so it's basically a
> no-op), and I get these timings. Looks like there's 3-4M cycles to be
> had by the parallel SIPI/INIT, but the *first* thread of each core is
> also taking another 8M cycles and it might be worth doing *those* in
> parallel too. And Thomas I think that waiting for the AP to bring
> itself up is the part you meant was pointlessly differently
> reimplemented across architectures? So the way forward there might be
> to offer a generic CPUHP state for that, for architectures to plug into
> and ditch their own tracking.

Yes. The whole wait for alive and callin and online can be generic.

> When I enabled EARLY_INIT it didn't boot; I need to hook up some box
> with a serial port to make more meaningful progress there, but figured
> it was worth sharing the findings so far.
>
> Here's the hack we're testing with, for reference. It's kind of ugly
> but you can see where it's going. Note that the CMOS mangling for the
> warm reset vector is going to need to be lifted out of the per-cpu
> loop, and done *once* at startup and torn down once in smp_cpus_done.
> Except that it also needs to be done before/after a hotplug cpu up;
> we'll have to come back to that but we've just shifted it to
> native_smp_cpus_done() for testing for now.

Right. It's at least a start.

Thanks,

        tglx


