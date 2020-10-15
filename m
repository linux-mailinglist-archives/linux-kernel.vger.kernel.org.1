Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642328FBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgJOXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJOXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:24:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:24:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602804242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZpjsD3KHkbu3u40WQuxk7HuDmmzUkkbjbmrxpR+6vs=;
        b=KCg+ASCe+Ti1TQdR9omLNwiui/rHtqwnQYf0Nf5YT4AEoles8e5jR1yJccmuKS0HDb3uQZ
        XqUtZixZM02R+vJhr1ssy3XUMAcCYr9S+w8mNwOr+QmhxjecWkqale8MQY+Mw/Xtgia6lk
        JW/F83/qSoaOtqba0WRIqK6DZPP5UC3IWOk1Y+w9KDR7Wa4EWpQiHeSwpjMrIfB7ZQ5Sbf
        McEuTwP2J5KDOJ7dYa4jsnmINlEuAFjiK+/x2JhdtZsySofqZ6kWR759hH87nSakQMGxVi
        8r1HfIgU3Kdhj5hum229eMhUIe5cWoFJc4JaZ3+4v5qcswNKojDVJNs1tV4usw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602804242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZpjsD3KHkbu3u40WQuxk7HuDmmzUkkbjbmrxpR+6vs=;
        b=NOliQRulzNoebXFhM6ChC0YOiRTeIWhB6B2ycCB282A2Pg2M0u55aAx2iSgDTOd5v7QEwj
        5vlRkRkdzp9MK9BA==
To:     Marc Zyngier <maz@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
References: <20201015101222.GA32747@amd> <87imbba7qk.fsf@nanos.tec.linutronix.de> <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org> <20201015171829.GB5636@duo.ucw.cz> <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
Date:   Fri, 16 Oct 2020 01:24:02 +0200
Message-ID: <87d01jul7x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15 2020 at 20:41, Marc Zyngier wrote:
> On 2020-10-15 18:18, Pavel Machek wrote:
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 10a5aff4eecc..db923e0da162 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -81,6 +81,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
>
>   # Generic IRQ IPI support
>   config GENERIC_IRQ_IPI
> +	select IRQ_DOMAIN_HIERARCHY
>   	bool

which makes some of the MIPS GENERIC_IRQ_IPI/IRQ_DOMAIN_HIERARCHY
Kconfig magic in drivers/irqchip/Kconfig obsolete.

Thanks,

        tglx
