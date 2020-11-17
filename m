Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29242B57A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKQDCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKQDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:02:36 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:02:36 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so19167856qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OrFb4zM53elIT7cUSmZjOKhggxTeko72lh8gYsva7hU=;
        b=iU3kKuyvQRxAJ2xeOPjzmOu8Jcu8QJfJocxHmvGc++AIp+Sw7/xgGEvQo9PkL7IkFP
         cdWcbSK/MT+F5maLoEsLzJMRr0l0AYumPN/MnS3EEGJ0GpxGZO5OatPg8zgESabJ442L
         uSTBA0pUo0RCTarpFKrQEIX8cYheEEQMDJwP1Ep43mQT94oC2AjOLFNVf4W8DF8Ms3FT
         Y6+4jq51wy1cLKa+ik2QCaHAEYcZm8UxI3cw7GxFA6jp8y9wYYnaBwADLFqZwySRz6XZ
         J+eO9finfZ6fXsmmyRgDvFPwbM2Tse75go2iIAnH8r0CLqd7cFwZuB0yL4smoarr3tO7
         c2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OrFb4zM53elIT7cUSmZjOKhggxTeko72lh8gYsva7hU=;
        b=HAofltRZL4m9wkMsWvIG5C+HjhOyYuAWM3dshODjDO6l0X6DItsUhKXe/C7CxgOYee
         /HXf0bTdS6cwzfDMAzpUC3C0vmRrBFb61QDr93Z+3+X9ThZaBlRfhZnEyWP7E8SQQYX8
         AtApmzSDtCIqrjcbis7bVlutUQ2/YrZUM4p4CDLYZSLRNWXs5e1PdnrS4shZhI6pxbsp
         PU+Lt+r2p47+yU4M3rNYSuChPIafSaGkt0dZ4rphmF8owTw+0MNKQ+RmFDuShwzR2lHt
         xKsfZN/unu8R+Ki10kekQ3KI3RKlTiZYH0Uyyffnyf243JRtxBdTBTuTUllbd+yFY0lR
         NCOQ==
X-Gm-Message-State: AOAM533+4TVPE3AEz6lRZliZJmOXQE3BkESi2RjAbppSbM6cbYpy8Li4
        9IRYo42hFcQBNuO+bJS/OHs=
X-Google-Smtp-Source: ABdhPJzF6HfIdmdD/B8loBrHQSKslXMtaSiE0xSd3YLxEd32d4j8tZVQ20B35c/cct/Bndyi3mdE+g==
X-Received: by 2002:a37:6854:: with SMTP id d81mr17624635qkc.230.1605582156017;
        Mon, 16 Nov 2020 19:02:36 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id v14sm13948831qkb.15.2020.11.16.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 19:02:35 -0800 (PST)
Date:   Mon, 16 Nov 2020 20:02:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc: fix -Wimplicit-fallthrough
Message-ID: <20201117030234.GC1340689@ubuntu-m3-large-x86>
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116043532.4032932-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 08:35:32PM -0800, Nick Desaulniers wrote:
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. Clang will still warn on cases where there is a
> fallthrough to an immediate break. Add explicit breaks for those cases.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/powerpc/kernel/prom_init.c | 1 +
>  arch/powerpc/kernel/uprobes.c   | 1 +
>  arch/powerpc/perf/imc-pmu.c     | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 38ae5933d917..e9d4eb6144e1 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -355,6 +355,7 @@ static int __init prom_strtobool(const char *s, bool *res)
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> index d200e7df7167..e8a63713e655 100644
> --- a/arch/powerpc/kernel/uprobes.c
> +++ b/arch/powerpc/kernel/uprobes.c
> @@ -141,6 +141,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
>  	case DIE_SSTEP:
>  		if (uprobe_post_sstep_notifier(regs))
>  			return NOTIFY_STOP;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 7b25548ec42b..e106909ff9c3 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1500,6 +1500,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>  		pmu->pmu.stop = trace_imc_event_stop;
>  		pmu->pmu.read = trace_imc_event_read;
>  		pmu->attr_groups[IMC_FORMAT_ATTR] = &trace_imc_format_group;
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
