Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA3282EED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgJECo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgJECo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:44:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC9C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 19:44:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so2566312pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gb3wgZey/nhsUecQI0AK4E4FVf7KdU6hAxj0QQpUtZo=;
        b=ChzSdbai67Qi4PgOp3i2KgxrVOLTQeiAORiKr5YQ4egkY/X8Skdh+hMj/XPSJ1jvLS
         6xeRixitvxivStC+vCD4eo2KB+PPkQP3nkKPsUKyafzcw4vpkeTyUjCfKnskJGY4ci/G
         dgxyCfNfHOru/RQUr2cd3Pg7kfiwbCHjNqALY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gb3wgZey/nhsUecQI0AK4E4FVf7KdU6hAxj0QQpUtZo=;
        b=sQRqQuRmdDuWUUV0tIow1aLJF4kwVGPK2SyPG1E1HWG75QljSHD72qi4Yb2+yTmFGe
         Rb1+vVqMpd4U138YqJFiwgT4YFJYT5GFXiUQYboZG9pQ8sV/63R4JhjZOGiDJQReEZqU
         kxm5doZ4eLxCLnL8JPoPE7ubUt/D81EipHyun2bAk0SrT5yXwadl9SdcEAnP2mOgVp+C
         yi0upedUOJUjLVYqZG8Y7AwlMFYXr6Z4GKoyVC/DTgvdLGNrt8iJ9dhgD3ph8U174IJF
         bqHpF8fpJNjXJLsbYKg9jRpImWSBg9vzOLp9FfRmyUl+0F2//seNgyISZVLz1p/VvCBj
         prOw==
X-Gm-Message-State: AOAM531tQbD2PBftVSLHxforeU8chloYpxLNxs0+LwbRsq70ul81NJqy
        rAktY1TGalvgzhKSL44djb9DYw==
X-Google-Smtp-Source: ABdhPJxuY76yHrON3z58BIX8r/cD0A+mO0MomIEAZVJmWe2JaRCoyuG+FKkz3vVRLizjdpgxmxvVXg==
X-Received: by 2002:a63:165b:: with SMTP id 27mr12021369pgw.197.1601865894675;
        Sun, 04 Oct 2020 19:44:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm8782814pgl.67.2020.10.04.19.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:44:53 -0700 (PDT)
Date:   Sun, 4 Oct 2020 19:44:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <202010041944.7FEE22407B@keescook>
References: <20200914132249.40c88461@canb.auug.org.au>
 <202010031451.ABC49D88@keescook>
 <20201004102437.12fb0442@canb.auug.org.au>
 <202010040125.B5AD5B757@keescook>
 <20201004210018.5bbc6126@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004210018.5bbc6126@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 09:00:18PM +1100, Stephen Rothwell wrote:
> Hi Kees,
> 
> On Sun, 4 Oct 2020 01:27:01 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> > I assume CONFIG_CONSTRUCTORS is enabled for your build (it should be for
> 
> yes, indeed.
> 
> > allmodconfig). Does this patch fix it? (I'm kind of blindly guessing
> > based on my understanding of where this could be coming from...)
> > 
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e1843976754a..22f14956214a 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -701,6 +701,7 @@
> >  #ifdef CONFIG_CONSTRUCTORS
> >  #define KERNEL_CTORS()	. = ALIGN(8);			   \
> >  			__ctors_start = .;		   \
> > +			KEEP(*(SORT(.ctors.*)))		   \
> >  			KEEP(*(.ctors))			   \
> >  			KEEP(*(SORT(.init_array.*)))	   \
> >  			KEEP(*(.init_array))		   \
> 
> And that makes the messages go away.

Okay then! Thanks for testing. :) I'm not sure why the ppc-hosted
compiler generates those. Regardless, I'll send a proper patch...

-- 
Kees Cook
