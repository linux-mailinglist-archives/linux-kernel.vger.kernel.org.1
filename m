Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD52956C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895390AbgJVD2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443830AbgJVD2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:28:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE08C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:28:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so218830pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lF0uRgfPgmDTY4E7k34qUb8SbRtEgKBfMs4QnQYXjn0=;
        b=m2a4Af1rPKhuhsRmHXM/ej2Rx1gOYHJ36WcIZ4YcMnUImzjSqddU6vSA/rAADXIypl
         AhRnacAPINf8WzkjOatfSpZSEy/+YEtmhxntcIHJQbQkxflMcCDpX97IyI4dw2Swbls5
         PLFQEzCZzB8f4gP8X1+TPf4sw5ZRPtAADGON8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lF0uRgfPgmDTY4E7k34qUb8SbRtEgKBfMs4QnQYXjn0=;
        b=DpdSYj3MYnzK03uEmcxETLraMupU4hEDy03/g85vjppLWv8ExQ3+eS9NB5SQ9pGAE2
         a/IwdXiT1xyrGitUwzkwadj1iyuadVyzfsBQaF2YjAyaAMp+VE7G6aZIDZAO/us/6EgK
         R0hN0CewiNjRvz8VoMnTpnvqxPge7vjtutiAeUl2nn7Ec+wWycCzv83zDv2mwYge0YUd
         6bv0EwL7eBABqvhIUO4CrnNvqQteffbF05Kk70wWc9V4F4vTdwHfMahjAxZnVDdatwF6
         agbVNWx6DKZHQ1Yt/T4dWD9XArzfqwCoDoUQHRr2v5KqPx2c8cnc6P70t8ls0Metza2/
         PhEw==
X-Gm-Message-State: AOAM531c41kBA/DBgsu8LHhUal2PqSDk9XrdMGmG6CzvxPajMFXy24MJ
        VIlPwtiWjfVBDzMrbIgOewvbmA==
X-Google-Smtp-Source: ABdhPJwAXXcHPGI6092DVP7q5AfazfRWgTsyEKakNIbZc3DBuX3+qqFmOrA22+ZullX2mg2Sxd06Gw==
X-Received: by 2002:a17:902:bb8c:b029:d2:2503:e458 with SMTP id m12-20020a170902bb8cb02900d22503e458mr729191pls.18.1603337328342;
        Wed, 21 Oct 2020 20:28:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16sm171892pgm.38.2020.10.21.20.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:28:47 -0700 (PDT)
Date:   Wed, 21 Oct 2020 20:28:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
Message-ID: <202010212028.32E8A5EF9B@keescook>
References: <20201021225737.739-1-digetx@gmail.com>
 <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
> 22.10.2020 02:40, Kees Cook пишет:
> > On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> >> The vfp_kmode_exception() function now is unreachable using relative
> >> branching in THUMB2 kernel configuration, resulting in a "relocation
> >> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
> >> linker error. Let's use long jump in order to fix the issue.
> > 
> > Eek. Is this with gcc or clang?
> 
> GCC 9.3.0
> 
> >> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
> > 
> > Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
> > That commit may have implicitly moved the location of .vfp11_veneer,
> > though I thought I had chosen the correct position.
> 
> I re-checked that the fixes tag is correct.
> 
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  arch/arm/vfp/vfphw.S | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> >> index 4fcff9f59947..6e2b29f0c48d 100644
> >> --- a/arch/arm/vfp/vfphw.S
> >> +++ b/arch/arm/vfp/vfphw.S
> >> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> >>  	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
> >>  	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
> >>  	teq	r3, #USR_MODE
> >> -	bne	vfp_kmode_exception	@ Returns through lr
> >> +	ldr	r1, =vfp_kmode_exception
> >> +	bxne	r1			@ Returns through lr
> >>  
> >>  	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
> >>  	DBGSTR1	"fpexc %08x", r1
> > 
> > This seems like a workaround though? I suspect the vfp11_veneer needs
> > moving?
> > 
> 
> I don't know where it needs to be moved. Please feel free to make a
> patch if you have a better idea, I'll be glad to test it.

I might have just been distracted by the common "vfp" prefix. It's
possible that the text section shuffling just ended up being very large,
so probably this patch is right then!

-- 
Kees Cook
