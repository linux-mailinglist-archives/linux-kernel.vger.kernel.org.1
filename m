Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC172AC226
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgKIRZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbgKIRZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:25:28 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A92F20E65
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604942727;
        bh=Scrk+dYcvyw3QvjGbYXbog4Z5UIYS746xFpf9H1AN+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cdUx/++hwx2q11nXYmTzOPYTVidzrgNPuaZXRqHtBO45jdyUi/HMxY3sSJhO3kxlP
         QCRsNDwlpg9u/MFz66tsqksZmm4H/8kNzvWcp7itIWm6V7upAuftq4+s5HytY40mHY
         kpMRtiRS1/sgnFr95sRiDsC2MojeNce0RtAfYRGU=
Received: by mail-wr1-f47.google.com with SMTP id 23so9571976wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:25:27 -0800 (PST)
X-Gm-Message-State: AOAM533V2KvsLH3v0Mj4jgD8kbyCm9rkl0x4fmw6nJGMWYw8dKV7gDJT
        j6zZeqdwWdzo9gME0RoxQ9zkv86fHcEcb/dQMQM3Dw==
X-Google-Smtp-Source: ABdhPJw0CYPVPjxWx8zph0Q4nCaIAawN4hKmHbD2IyPPTLfrfzllSPo0Y9UrcU7NlojHiUWbSfGOOf4ixMlMDFQBlcE=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr19060570wrq.70.1604942725626;
 Mon, 09 Nov 2020 09:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20201109112319.264511-1-alexandre.chartre@oracle.com> <20201109112319.264511-2-alexandre.chartre@oracle.com>
In-Reply-To: <20201109112319.264511-2-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 9 Nov 2020 09:25:14 -0800
X-Gmail-Original-Message-ID: <CALCETrWOK-ZjcUKarbTokRxLOd3RmjYjnDhc1mgUeXRVFdGgow@mail.gmail.com>
Message-ID: <CALCETrWOK-ZjcUKarbTokRxLOd3RmjYjnDhc1mgUeXRVFdGgow@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/24] x86/syscall: Add wrapper for invoking syscall function
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander-

You appear to be infected by corporate malware that has inserted the
string "@aserv0122.oracle.com" to the end of all the email addresses
in your to: list.  "luto@kernel.org"@aserv0122.oracle.com, for
example, is not me.  Can you fix this?


On Mon, Nov 9, 2020 at 3:21 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> Add a wrapper function for invoking a syscall function.

This needs some explanation of why.

>
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  arch/x86/entry/common.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 870efeec8bda..d222212908ad 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -35,6 +35,15 @@
>  #include <asm/syscall.h>
>  #include <asm/irq_stack.h>
>
> +static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
> +                                       struct pt_regs *regs)
> +{
> +       if (!sysfunc)
> +               return;

What's this for?

> +
> +       regs->ax = sysfunc(regs);
> +}
> +
