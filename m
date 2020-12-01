Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC12CA00F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbgLAKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgLAKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:39:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4611C0613D3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 02:38:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606819120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAJpgh0xPGzhJvQ0+pFj3lmJw3smGNAzIhNqMHD8rYM=;
        b=a+NZicZbm2aLhKp9Sso4PkLgGDijDyFn2ZJhC8d3Yy9tUAevDyij4/8k5OkR401FuqtIQ5
        AQr+ROpumRw1uq+ag1znbjN2cAD5d5C4CsCUS3HuhbvWrMKr91iwLJRt5wSiyYkNJIY0cA
        EQVXScyZxIVVoy34IUZ8LCUQNRHFpNX9uqhDwelVNz+hHnSPVGZUyXsWSCt4Tgt+7xtVgt
        cuLg0T7kHXFwjtS/u3mvz7/ivnzsmWe7+U3JSEZrwjZ+QqznCAPOsMTOKtVqVolKFZ6FiK
        h3Fz2M5eXroXWWf7xkyMUrQIcAyVvCWBWqgGAmjd+ft45+xVXJrU7uBQJpwBiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606819120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAJpgh0xPGzhJvQ0+pFj3lmJw3smGNAzIhNqMHD8rYM=;
        b=oRM0teRZ/JMiEtUq601w0JwWIPbALRcbxCyxX29dI4GIzoG1C2gIqIot2AufqbKJDC00ss
        K2Odx+vPrpZP79Aw==
To:     =?utf-8?Q?Lauren=C8=9Biu?= Nicola <lnicola@dend.ro>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
In-Reply-To: <69841ea6-5998-46ca-8e49-3e9ee65fc8b1@www.fastmail.com>
References: <20201126074734.12664-1-lnicola@dend.ro> <875z5rk68z.fsf@nanos.tec.linutronix.de> <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com> <87lfeiiy10.fsf@nanos.tec.linutronix.de> <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com> <87tut6h10u.fsf@nanos.tec.linutronix.de> <69841ea6-5998-46ca-8e49-3e9ee65fc8b1@www.fastmail.com>
Date:   Tue, 01 Dec 2020 11:38:39 +0100
Message-ID: <87o8jdhkuo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 10:18, Lauren=C8=9Biu Nicola wrote:
> On Tue, Dec 1, 2020, at 01:34, Thomas Gleixner wrote:
>> Just for completeness sake. Can you provide the line in /proc/interrupts
>> for irq 7 on that machine?
>
>
>   55:          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0          0          0         =
 0          0          0          0          0          0          0       =
   0          0          0          0          0          0  IR-PCI-MSI 262=
5543-edge      xhci_hcd
>

IRQ 55 !=3D IRQ 7. I really meant IRQ 7.

Thanks,

        tglx

