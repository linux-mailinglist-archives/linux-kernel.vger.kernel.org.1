Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAD277727
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIXQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:47:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:59264 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXQrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:47:55 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6F4377D;
        Thu, 24 Sep 2020 16:47:53 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:47:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin-guide: kernel-parameters: reformat
 "lapic=" boot option
Message-ID: <20200924104751.328cc109@lwn.net>
In-Reply-To: <20200918054739.2523-1-rdunlap@infradead.org>
References: <20200918054739.2523-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 22:47:39 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Reformat "lapic=" to try to make it more understandable and similar
> to the style that is mostly used in this file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20200917.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20200917/Documentation/admin-guide/kernel-parameters.txt
> @@ -2384,9 +2384,10 @@
>  	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
>  			disabled it.
>  
> -	lapic=		[X86,APIC] "notscdeadline" Do not use TSC deadline
> +	lapic=		[X86,APIC] Do not use TSC deadline
>  			value for LAPIC timer one-shot implementation. Default
>  			back to the programmable timer unit in the LAPIC.
> +			Format: notscdeadline

Applied, thanks.

jon
