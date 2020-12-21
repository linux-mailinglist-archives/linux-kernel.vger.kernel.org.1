Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC672DFE50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgLUQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:58:05 -0500
Received: from ms.lwn.net ([45.79.88.28]:47528 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgLUQ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:58:05 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4471E9B2;
        Mon, 21 Dec 2020 16:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4471E9B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608569842; bh=y+LeEnY3wYV0Xy8bEcN54eRe1k8P31EyjMlS2lo8U9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0UZSJo44xC3/8eKVPz/KfSO1oHcv8uc/Zi5IVAR1X685UYWZq0lLIYEq8C0WVcFU
         tdcDNmb+yw2pXD6eHvlVuLrY9BveP6Kgl7XRjbWxrrxsd1Y/wOBOXSRR0IxlFV3Bm8
         gzdH3/k93FPT1fg6MmROR8yNLGEUL+HGD2E7sjbgW6SqPpXfK21u8nK+ucJHQsERVY
         qP044pchW1H2uR+RP/HCrtiaauSThafS2ToA3XeYcNMsUb9wbGX+1sUJ5bvU7SXNHL
         oeISrZeFA3kEYMaqw2zOMRkpfAa3Vcws48sQ7DVPDXdzSvwrReqCIucW4o6hDtBbur
         F64yHt7MXlHHg==
Date:   Mon, 21 Dec 2020 09:57:21 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mingzhe Yang <cainiao666999@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, David.Laight@aculab.com
Subject: Re: [PATCH] Documentation: x86: update the thread_info's position
Message-ID: <20201221095721.6bebfb28@lwn.net>
In-Reply-To: <1607144496-10635-1-git-send-email-cainiao666999@gmail.com>
References: <1607144496-10635-1-git-send-email-cainiao666999@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Dec 2020 13:01:36 +0800
Mingzhe Yang <cainiao666999@gmail.com> wrote:

> Prior to kernel 4.9 the thread_info structure was at the bottom of
> the kernel stack. kernel 4.9 moved it into the task_struct.
> 
> See commits c65eacb ("sched/core: Allow putting thread_info into
> task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
> and 883d50f ("scripts/gdb: fix get_thread_info").
> 
> Signed-off-by: Mingzhe Yang <cainiao666999@gmail.com>
> ---
>  Documentation/x86/kernel-stacks.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
> index 6b0bcf0..e9097f3 100644
> --- a/Documentation/x86/kernel-stacks.rst
> +++ b/Documentation/x86/kernel-stacks.rst
> @@ -15,7 +15,8 @@ Like all other architectures, x86_64 has a kernel stack for every
>  active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
>  These stacks contain useful data as long as a thread is alive or a
>  zombie. While the thread is in user space the kernel stack is empty
> -except for the thread_info structure at the bottom.
> +except for the thread_info structure at the bottom (since kernel 4.9,
> +the thread_info structure has been moved into task_struct).

So this has been sitting in my inbox for a bit, sorry.  This seems worth
fixing, but is this the correct fix?  The documentation should reflect the
current kernel, rather than what once was with a "(it's not actually that
way anymore)" note.  Is the kernel stack truly empty now?  If so we should
just say that; otherwise say what's lurking there in current kernels.

Thanks,

jon
