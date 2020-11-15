Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB412B39D6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgKOWTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:19:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKOWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:19:36 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605478770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mvUChvQtJDtOXKi7ZSXRCCglC4rht804XBkqEO6iVxA=;
        b=VMG7gFt3BUeFueD23+8iIxeuYxd7F1JGBLNcpa8roF+2pDV6jWVMThCsf3RpnaBmnhRLT+
        Z7Z2OI8Biqk67R0qGVY47TF5fDAe0ku3p12yuNAGnDV1ZrXniDXKLWRduudIZuJDDHe6SU
        yn0j97XPjvC+ghwC8lwdlZuNO00pYpshAarbMU1ev65j5KuiYm3N9VY64YH1mhijKVG31P
        0khETiOZFynZnFxdfy8XUIizif4xX2PdPFuvpFV9RUctIkoLMzCXRgSYApIuZPflnO1lVX
        DLvzujc0ZTjwnWRFiH90Vk8+BJArtuILuwoV13Y1jvy+OcDemQR+4KSr1dg+tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605478770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mvUChvQtJDtOXKi7ZSXRCCglC4rht804XBkqEO6iVxA=;
        b=QMM3KylPKEYAwl/ux+M6btqBIxYn6Yf22Srgcy98kmr8Je7+ct/IFUbxQiq+4/jaC/Rv4U
        M39TAUQU8r8lR0Dw==
To:     Alex Shi <alex.shi@linux.alibaba.com>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] timekeeping: add ts/tk explaination for kernel-doc
In-Reply-To: <1605252275-63652-5-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 23:19:29 +0100
Message-ID: <87361a5klq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:

Subject: timekeeping: add ts/tk explaination for kernel-doc

 Sentence after the colon starts with an uppercase letter.
 s/explaination/explanation/ Please use a spell checker.

Also what is ts/tk? The short log sentence has to be concise and easy to
understand and decribe what the patch does.

> this patch fixed kernel-doc mark incorrection:

'This patch fixed' ?

First of all, sentences start with an uppercase letter, but also please
do:

 # git grep 'This patch' Documentation/process/

and read the paragraph which matches.

>  /**
>   * timekeeping_inject_offset - Adds or subtracts from the current time.
> - * @tv:		pointer to the timespec variable containing the offset
> + * @ts:		pointer to the timespec variable containing the offset

This is _not_ adding documention, it's fixing the wrongly named
parameter.

Thanks,

        tglx


