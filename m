Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC12DD5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgLQRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgLQRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:20:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:19:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n3so3551900pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqG0k+jCqT0D0K6VSo69IHtVHy5DvpZgj89oR520Yfs=;
        b=HX4SkuQgllzAsI4iiZzX21sCvZ6itMWDyNYbbQZhepawRyno+gGWARmCdz6c6ybtbB
         3VVI7xruZzGLRvG+t7k8/v5vrQMapXbsAHQ2+mvp6WZaORlWT7GJcJJfbXKCgSXoWw2n
         sD2PDbTZpPQr19kOuxvMa3kIjH7TQjoWLNqwB/OWWjceEhMmHbI8tCQbONDbccMXbToB
         HqhA3vUwKrOlIE46AJw9HEq6MEFbsTBLuBYP5eLLGgrM60zx8hFQgiAuK2IeJYdBQKhu
         4zRVAuTQz5R0zevCieJLbzsFhDsQ7AYEFKhPXrZVuc8lX11pSs3NVe2PaISyDt/qvFUy
         g6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqG0k+jCqT0D0K6VSo69IHtVHy5DvpZgj89oR520Yfs=;
        b=MyFF5DN6s8cAvP0NqBNKYm//Ps9bvgHeXASirdFTyZXbgsv/8mVySdNICUR5bAyQCL
         uH0G7ukUHlkGnr3itVFRESVJQsJ7fForfykSTaaXsxXieiy7NPac+v21qmcryG50D5Zs
         NA0V8hsq0PZv5+dYZBn8mdqrnGBlsDbpDAn3/fQYCN1MtmHhpH6Grq0OSnyRSGcLVN8O
         N8YpmOEMVBr+N9wgAog/LfWxcUrGTzHM0QFUtzXJAxSrqXBwhp7rxHKg/9nF0hHEs8of
         msrrfj945P+/hu/adUt6Vqb6pDD4Krn4K4FoB5vvg52eLgNXeagvZ0V6+Ap63l2GLRlU
         MZiw==
X-Gm-Message-State: AOAM530U/Lf359TvH5ufD7UOjHBD7w1veguTQKlfYX5J18HaVP04ZeF4
        IS/VBptqVVrDeAHBepWctkqftw==
X-Google-Smtp-Source: ABdhPJwzSpfEZ1PTWVRJ2fKTyX1PB2jyBPuBVfmfD5vKIocQtdrOxC/jmDnqpdAljGKWm+YZnF18JA==
X-Received: by 2002:a17:902:8643:b029:da:d5f9:28f6 with SMTP id y3-20020a1709028643b02900dad5f928f6mr358658plt.8.1608225560286;
        Thu, 17 Dec 2020 09:19:20 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id jx4sm5373885pjb.24.2020.12.17.09.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 09:19:19 -0800 (PST)
Date:   Thu, 17 Dec 2020 09:19:13 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc
 handling
Message-ID: <X9uTESe5n3ApvnOD@google.com>
References: <20201217010409.3675060-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217010409.3675060-1-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020, Peter Gonda wrote:
> 
> The IN and OUT immediate instructions only use an 8-bit immediate. The
> current VC handler uses the entire 32-bit immediate value. These
> instructions only set the first bytes.
> 
> Tested with a loop back port with "outb %0,$0xe0". Before the port seen
> by KVM was 0xffffffffffffffe0 instead of 0xe0. After the correct port
> was seen by KVM and the guests loop back OUT then IN were equal.
> 
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> 
> 
> ---
>  arch/x86/kernel/sev-es-shared.c | 8 ++++++--
>  drivers/Makefile                | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> index 7d04b356d44d..6c790377c55c 100644
> --- a/arch/x86/kernel/sev-es-shared.c
> +++ b/arch/x86/kernel/sev-es-shared.c
> @@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
>  	case 0xe4:
>  	case 0xe5:
>  		*exitinfo |= IOIO_TYPE_IN;
> -		*exitinfo |= (u64)insn->immediate.value << 16;
> +		*exitinfo |= insn->immediate.bytes[0] << 16;

Can't we just drop the explicit cast to u64?  Or explicitly cast to u8?  Doesn't
really matter, but poking into the backing bytes feels a bit backwards.

>  		break;
>  
>  	/* OUT immediate opcodes */
>  	case 0xe6:
>  	case 0xe7:
>  		*exitinfo |= IOIO_TYPE_OUT;
> -		*exitinfo |= (u64)insn->immediate.value << 16;
> +		*exitinfo |= insn->immediate.bytes[0] << 16;
>  		break;
