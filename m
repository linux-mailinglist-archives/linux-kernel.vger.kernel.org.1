Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC882ADAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgKJPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:54:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:54:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605023671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+j2J0q4f7pGXHuaYvQJsN9zzvfyTS5aD7HaP1XEVR9s=;
        b=1JEbC31S+z+VlopTohizfUQ/nPmRKdJRVU24caP9181aXRDCMEpr8q4p4fuZXNWIQTxiwz
        3W+c85GyqyGUQ/YT1m7GjAVcdE3SV9gKxN1W6cSwtf6nQIjpuWYe2AeHRgLrhgg8WRG0kl
        5UV1aLNGI0/1Jr25RS6yOq+BNvfhIVdOIWSh4rwjBqqPFF3TGlsXclI4hKOxGL6k3wB14x
        HSzvkHjTxw2tL3D0atJrlImkjOv4tMR1afH1KecMZWqIuf3rSXbLVjmxp7EKmXCKTmSF+T
        SmR2LBSbyIZIHj94H0twGD5Nehyvfz3b04rqyrU3w1siDnSprOCVEMK/RndyJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605023671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+j2J0q4f7pGXHuaYvQJsN9zzvfyTS5aD7HaP1XEVR9s=;
        b=c+YlZ+v9EdMhdyKW9Dg5ddkNst4Mdc4NXVqGesKRXGq2VuGkP6LfgKndCHOIvq5KSeZX89
        KGs7LOt+j4MyeCDQ==
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
Date:   Tue, 10 Nov 2020 16:54:30 +0100
Message-ID: <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 08:55, Tom Lendacky wrote:
> On 11/10/20 8:34 AM, Thomas Gleixner wrote:
> I was about to send the dmesg output when I saw this. A quick test with
> this change resolves the boot issue, thanks!

/me feels stupid

> I'm still seeing the warning at arch/x86/kernel/apic/apic.c:2527, but I'll
> start a separate thread on that.

Can you please provide the backtrace?

Thanks,

        tglx
