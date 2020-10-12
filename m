Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C828C18B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgJLThk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgJLThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:37:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B940C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:37:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602531459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAGBr8RcuoICd4qF7JmAt3GQy9qhOMrKg4+LZEzCs7I=;
        b=em/+enAgv/TMh+3ZDFKKaxCtVfPiQLPgMx8GGm4uGPeRlerT3cvcwHDBBeFcIe1opya7Pw
        gNrUe/kX32EDSTCd4SlUpZBtYbGyMiNPd9sLSwfOX+0TwyhckDi0WtQEUwyhjLJYRVb63t
        4rpaCRH6eGdNzNGltRqldjiVhOn1buTfJYI6l3QTCk7wqvLGt7MKTC449O255p7/OCIVps
        vBhD3QSbXuX7egIcei0QjshLtr/OWbkqjCaYmCNwkWVXEk2RM6vk6VjxHO9j4qqQ0EWngR
        atGFi0cF7IrMDn3TPD4Lcrj3/dW6WfMeZh4vpS/ia6MwhlGRCc7G+iHr2/pn4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602531459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAGBr8RcuoICd4qF7JmAt3GQy9qhOMrKg4+LZEzCs7I=;
        b=tta8OF6ktH1HopKhNPtT0t0oKAT66+2IavD/noxJAULo5Jv30IwUCytC6RfCEuZXUu6S6N
        zsjSeY2VJHB2b6DQ==
To:     Chris Friesen <chris.friesen@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: IRQs in /proc/irq/* that aren't listed in /proc/interrupts?
In-Reply-To: <c74773ba-10ff-ba3a-b144-da5c2a34c74e@windriver.com>
References: <c74773ba-10ff-ba3a-b144-da5c2a34c74e@windriver.com>
Date:   Mon, 12 Oct 2020 21:37:38 +0200
Message-ID: <87wnzvp75p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

On Mon, Oct 12 2020 at 12:40, Chris Friesen wrote:
> On one of my X86-64 systems /proc/interrupts starts with the following 
> interrupts (per-cpu info snipped):
>
>    0:      IR-IO-APIC-edge      timer
>     4:      IR-IO-APIC-edge      serial
>     8:      IR-IO-APIC-edge      rtc0
>     9:      IR-IO-APIC-fasteoi   acpi
>    17:      IR-IO-APIC-fasteoi   ehci_hcd:usb1, hpilo
>
>
> On this same system /proc/irq shows these interrupts:
>
> 0-15, 17
>
> Is there any way to determine what the interrupts are that aren't listed 
> in /proc/interrupts?

They are simply unused.

> Six of them are affined to all CPUs, and I'm trying to affine as many
> interrupts as possible to housekeeping CPUs to free up application
> CPUs for low-latency operations.

Affining unused and therefore disabled interrupts is a pretty pointless
exercise.

Thanks,

        tglx
