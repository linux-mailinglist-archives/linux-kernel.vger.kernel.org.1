Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11062A4963
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgKCPWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgKCPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:22:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:22:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604416939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWXdxQUJkn6yqnaEePd/GeWBim97AN6dJUIHhqxUnmY=;
        b=nSaC6d6TOLHSOXx6g0vMzDYS4y9VAlyEdFAJr+6aUC2+Gi50dxzPsJNx4N3yVjRvJ1rhmc
        u6Sm5IGA2/uMfW4XTLQ/OEdmNTvrHCaITlEiNOWy1uHoCKve07lHOu2EIzqY2v6CruLm2s
        lwDEIj1B1KLUTwrYYBNK/47Gcm8Unr9DX+sJ14AyrwArYuznnErJhDpCGjtfXcYsXi0QvD
        qW7Sgas+zBcM0sc2Gv4dE4GiN/A4Htd35JsLinhMMUsBO+u4bg+oBRCUspOgCxRrNWzPfH
        LQsdp4gBd06iY/egLBa3Q0fPQs85umQalUVbXaNKt2PrugE4oBr0SL6nACFMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604416939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWXdxQUJkn6yqnaEePd/GeWBim97AN6dJUIHhqxUnmY=;
        b=0TvEaE81Y9EpRiG2BuYjaFKRR6MXbHWdqE0jrhVZHb+oZc+xGW6eXc5ZWMsiISh/JyAqXl
        jNi0sxCRuEZ0c+BQ==
To:     lkp <oliver.sang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [x86/ioapic] b643128b91: Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
In-Reply-To: <20201103143130.GA5804@xsang-OptiPlex-9020>
References: <20201103143130.GA5804@xsang-OptiPlex-9020>
Date:   Tue, 03 Nov 2020 16:22:19 +0100
Message-ID: <871rha31p0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Nov 03 2020 at 22:31, lkp wrote:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: b643128b917ca8f1c8b1e14af64ebdc81147b2d1 ("x86/ioapic: Use irq_find_matching_fwspec() to find remapping irqdomain")
>
> [    3.148819] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    3.154825] DMAR: DRHD: handling fault status reg 2
> [    3.159701] DMAR: [INTR-REMAP] Request device [f0:1f.7] fault index 0 [fault reason 37] Blocked a compatibility format interrupt request
> [    3.173870] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> [    3.182381] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc1-00029-gb643128b917c #1
> [    3.190370] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [    3.198534] Call Trace:
> [    3.200983]  dump_stack+0x57/0x6a
> [    3.204298]  panic+0x102/0x2d2
> [    3.207349]  panic_if_irq_remap.cold+0x5/0x5
> [    3.211613]  check_timer+0x1f6/0x694
> [    3.215184]  ? printk+0x58/0x6f
> [    3.218320]  setup_IO_APIC+0x17b/0x1c3
> [    3.222067]  x86_late_time_init+0x20/0x30
> [    3.226077]  start_kernel+0x40c/0x4c7
> [    3.229734]  secondary_startup_64_no_verify+0xb8/0xbb

It's not reproducing here. Can you please redo the test with
apic=verbose on the kernel command line and provide the full dmesg
output?

Thanks,

        tglx
