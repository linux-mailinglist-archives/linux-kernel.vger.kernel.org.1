Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF66B2516B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 12:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgHYKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 06:36:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgHYKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:36:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598351780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6WdDwr7pWfjm7IsVLumrHh9ko/TrrrmcQVTz/8dLfE=;
        b=OzDcARDyf9mt+xCboRP3C/F4D3JItGfFkuhickmkdbhAjgnRhXMc97IIkmeDSZmr9J1lWN
        hPXjydc6/9XxLnUcwg2ZXGj0CvDuvsYi7HvemYGyZrBsAK+7fXJz7N9JMyrpObLffC+72q
        StPOxcMwH7ptYNQ4/hsCZwrqbG+iz/A0XKT+iANidf+/8d4xIrxwlwJz7DS5s0SP2VphBD
        G2y/XoBjInMkLHyfkX1hUTZ/coTIsf4j4lIQJyniPy6ATBrr6LNt9y83EEA3jDVddYQEpn
        SawkgU8xXX4vtK6unAtJrGJIA5t2+u0Au0RLLz3DfTFkMz62C7NtNFIf9J8pDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598351780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6WdDwr7pWfjm7IsVLumrHh9ko/TrrrmcQVTz/8dLfE=;
        b=/6hQZtenFwzkcP7aAzWrdAKw8clTV11fxpNg7LDs3Hlu2H7rYWmvkBCKd/zZ3327BHlro+
        DUU5ePG78ZGElZCQ==
To:     Wang Long <w@laoqinren.net>
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, w@laoqinren.net
Subject: Re: [PATCH] timer: use raw_spin_unlock_irqrestore and raw_spin_lock_irqsave instead of raw_spin_{lock|unlock}
In-Reply-To: <1597892357-1349-1-git-send-email-w@laoqinren.net>
References: <1597892357-1349-1-git-send-email-w@laoqinren.net>
Date:   Tue, 25 Aug 2020 12:36:20 +0200
Message-ID: <877dtn57x7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang,

On Thu, Aug 20 2020 at 10:59, Wang Long wrote:
> The code in (1)(2) lock the base with raw_spin_lock_irqsave(&base->lock, flag),
> if base != new_base,  the code in (3) unlock the old base, the code in (4) lock the
> new base. at the end of the function(5), use raw_spin_unlock_irqrestore(&base->lock, flags);
> to unlock the new_base.
>
> Consider the following situation:
>
> 	CPU0					CPU1
> base = lock_timer_base(timer, &flags);								(1)(2)
> raw_spin_unlock(&base->lock);									(3)
> base = new_base;
> 					raw_spin_lock(&base->lock);				(4)
> 					raw_spin_unlock_irqrestore(&base->lock, flags);		(5)
>
> The flags save from CPU0, and restore to CPU1. Is this wrong?

Completely wrong. This code switches the per CPU base pointer of the
timer and does not migrate the task to a different CPU. The execution
stays on the same CPU and keeps interrupts disabled accross the whole
code sequence.

> we encountered a kernel panic, and we suspect that it is the
> problem. How about the following patch to fix.

It does not fix anything. It just adds pointless overhead.

Thanks,

        tglx
