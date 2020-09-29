Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A3927BFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgI2ImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI2ImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:42:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94716C061755;
        Tue, 29 Sep 2020 01:42:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so13822843ejf.6;
        Tue, 29 Sep 2020 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lMOqo3ypO/SZ3oHUy6euRnuasGkm67DC6ZbiwUFwB8M=;
        b=C9E4mLgNTPQm8NqaAoz6itH7ufzLLW2Afp390W5SRJ4Rdbl7etn2wAbpam4yITVwLD
         F6FwrUs08Nvzo3Mfl42l34qKUnxrHpNoeI4tuU4Rh5fdZSfPxUztwLF3B8mRIf+EFyTV
         Bw1kXUFQm0WiVqzUhAXpob85WyYHYrBekAyw4cYZeVFKbNMVv3Lb2xSuVqe13M3RxfjP
         KdrELuR5PtKXB6MbMdbyIvZpTiEB14c8DNlnX3V1U7sPu/om8bscAIW+QwD0756G5JJb
         3SL0nmILrDsE4MXwsMmLjKYUtJWrj6PUmyZB5LLwrM1DZ4kB+fPrk7jWxb/T3ePyRn8t
         njcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lMOqo3ypO/SZ3oHUy6euRnuasGkm67DC6ZbiwUFwB8M=;
        b=e0UM7bIITYZ/g+6JKGoZKdz8GJHATTiFn/GuvOovr67E7mEfaY6LAoQAOf6+LECzyK
         IK8QR8lx7mxCPiBxPxuaKqqEwMExhX0XMVPJHhZ0TKOd/uBbU4QxP4JNxSX85lbCJtgE
         F5SAkJlVBCFhVVLAAZmtWw02jAlWUP1YMiJXhfAbnM9YNJszqKsaEj1qWRwY7ixTCtxC
         R15mDY4YiE7mWczbmZ6XsMRHopT89KDNXWzbLPdAp4B0osi2vLklEbrJlecrcjcYCbhY
         /zyeK2KNe7kepp7bukbepvVwKd9o4JR+NtYqJJLlU0lyf/EDFZfXye9sUacMjNWK1pTL
         v6wQ==
X-Gm-Message-State: AOAM531WJWeQpcii1E5gk22yz3M4BmqlTm+FbrJ+ngpmoYe4x8qeiMTq
        Ukb1n1p+J4SDkoXxSEIiea8=
X-Google-Smtp-Source: ABdhPJzGWfoP9r1EYK/PGbfUWz5nDplWzfMQE+vmcmMJK3RNsVSeyNcSHA23E0BLUDmcdQqqkuVHYg==
X-Received: by 2002:a17:906:f755:: with SMTP id jp21mr326002ejb.97.1601368938287;
        Tue, 29 Sep 2020 01:42:18 -0700 (PDT)
Received: from felia ([2001:16b8:2d89:9100:6c4a:28e4:c658:86f9])
        by smtp.gmail.com with ESMTPSA id u9sm4528036eje.119.2020.09.29.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:42:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 29 Sep 2020 10:42:15 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] x86/mm: drop superfluous initialization
In-Reply-To: <1d376c1f-2f14-5c29-671e-ca59853fa4a4@intel.com>
Message-ID: <alpine.DEB.2.21.2009291034160.17656@felia>
References: <20200928100004.25674-1-lukas.bulwahn@gmail.com> <1d376c1f-2f14-5c29-671e-ca59853fa4a4@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Sep 2020, Dave Hansen wrote:

> On 9/28/20 3:00 AM, Lukas Bulwahn wrote:
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index c7a47603537f..5632f02146ca 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -609,7 +609,7 @@ static void __init memory_map_top_down(unsigned long map_start,
> >  	step_size = PMD_SIZE;
> >  	max_pfn_mapped = 0; /* will get exact value next */
> >  	min_pfn_mapped = real_end >> PAGE_SHIFT;
> > -	last_start = start = real_end;
> > +	last_start = real_end;
> 
> Thanks for finding this.
> 
> This becomes even more obviously correct if we just move the 'start'
> declaration into the while() loop.  If we do that, it puts the three
> assignment locations right next to the definition, and its trivial to
> spot that the initialization was not missed:
> 
>         while (last_start > map_start) {
> 		unsigned long start;
> 
>                 if (last_start > step_size) {
>                         start = round_down(last_start - 1, step_size);
>                         if (start < map_start)
>                                 start = map_start;
>                 } else
>                         start = map_start;
> 		...
>

Agree, this point is simply a question of style:

Shall local variables be defined as "local" as possible or simply 
consistently at the beginning of each function?

If there are no strong opinions of style, I would just keep this patch 
as-is.

> Either way, your patch looks correct to me:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

Thanks for the Ack.

Lukas
