Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D52841FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgJEVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgJEVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:16:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5CC0613CE;
        Mon,  5 Oct 2020 14:16:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d500e8a8b27a6c9dedad.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:e8a8:b27a:6c9d:edad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D75051EC043F;
        Mon,  5 Oct 2020 23:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601932605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dE3g1QnWgOyBwTq45i2ttuO0EC2fpZHAT0HKDBoHGUA=;
        b=QVnZNjf3hbhaQZ4AgwqcSctRmixErRDP8UYZ9c7E0CdGyUxAFaEGdF7NPj1DCG6VPV78oM
        dmThDG3RA38hv75xuh/Zphl/Meg3RhkNrcXmf2LeT0K41ziD5b86YzEYYllLdaSKq3+MIz
        JpTr1D7F/pW6mDjsFTDXN3+Xwzm8sZk=
Date:   Mon, 5 Oct 2020 23:16:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 03/13] x86/platform/uv: Adjust references in UV kernel
 modules
Message-ID: <20201005211611.GK21151@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-4-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005203929.148656-4-mike.travis@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 03:39:19PM -0500, Mike Travis wrote:
> Make a small symbol change (is_uv() ==> is_uv_sys()) to accommodate a
> change in the uv_mmrs.h file (is_uv() is the new arch selector function).
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  drivers/misc/sgi-xp/xp.h            | 8 ++++----
>  drivers/misc/sgi-xp/xp_main.c       | 4 ++--
>  drivers/misc/sgi-xp/xp_uv.c         | 6 ++++--
>  drivers/misc/sgi-xp/xpc_main.c      | 6 +++---
>  drivers/misc/sgi-xp/xpc_partition.c | 2 +-
>  drivers/misc/sgi-xp/xpnet.c         | 2 +-
>  6 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
> index 06469b12aced..0af267baf031 100644
> --- a/drivers/misc/sgi-xp/xp.h
> +++ b/drivers/misc/sgi-xp/xp.h
> @@ -17,11 +17,11 @@
>  
>  #if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
>  #include <asm/uv/uv.h>
> -#define is_uv()		is_uv_system()
> +#define is_uv_sys()		is_uv_system()

Do I see it correctly that you can simply use is_uv_system() directly
instead of this macro indirection?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
