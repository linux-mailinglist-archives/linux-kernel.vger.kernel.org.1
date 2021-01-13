Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21032F4D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbhAMOXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAMOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:23:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:23:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n16so3726019wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilU2a0/z2icSlVjikMlVFb2BH/BMW95h/+2IlgK09tA=;
        b=mb6J8KGfPGz18jwtpgubLMkATb8/Rkvwe7SvvMpjP59phRqNVcLtJhjhzs6OXZjb6o
         EtLISbBA9zn1CuHoxX08fV9CbHbHyVIYuzR1+qWBbquftXlJkGGcsZoc9ooIxnKxZb6O
         AtcwIwSsZ/OL/jjPQLdmBbO869kuB+hFoVPEeqYTn8AM6A7Z70iojhRX6bB6rT/iqk6m
         KRXaZMpxZO8S7ddTasPh+LF9H+C31ikwzVAuPMBXFZxltyQCk+j41+VrZ73h6K9v3jVK
         XjJjKhlVvoPBD2z05uCwrAIveAcWR1miyJcm2jFf/chrmST7NPzdHnXr9lJ+YtF9UhQI
         o5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilU2a0/z2icSlVjikMlVFb2BH/BMW95h/+2IlgK09tA=;
        b=pxrpCd+n1BMINlazmKfo3xoJSf+2fkJTrhUfh8z6FadSx5XPhNPw6TnaBH4cV1sSPq
         RzPzY07Z/Y/JFcFUdA53PomTjYN5s0G6KQoBOG4klbZrEcxQI5oI55LTPgFLq3Q97EhC
         f7RauOZrwDDvFuaBr/XJvTqQFaMLr6ohJ5S+QESm9eYUIU0r60TxCqVPGqrWFf5LqeEm
         XJ1ZpI9G8xUnRNWVXvBVQ6ECvf4pGBV94+ETb9qku1ptTPlpHL1aHBZ8S+1I7zG4e4L4
         f238ZkBPYoGcA1f3/5W53fzaF4ytGZhGut17MAiH+/qYiPPVKYok2Ye8btNSQeODQoq6
         JDnA==
X-Gm-Message-State: AOAM533po7U3qie/MXGjdGzEBn1EBTdAknBYSA6qKp46GqdFaIXSeahH
        CuopQXiyWAoLz6b4i8yXnUKEbA==
X-Google-Smtp-Source: ABdhPJwYEfPsoLZ1uDpkgIvVI6ossxrBaWbG9yG2QlOmRPbJjc1rM9tB77wRTJPoRpB2XSFVf/bkkA==
X-Received: by 2002:a1c:bc41:: with SMTP id m62mr2484423wmf.46.1610547789081;
        Wed, 13 Jan 2021 06:23:09 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id a62sm2936823wmf.7.2021.01.13.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:23:08 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:23:03 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 13/26] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <X/8CR5eXGGccFjaL@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-14-qperret@google.com>
 <d55643ea391f73a2297f499f3219ba8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55643ea391f73a2297f499f3219ba8a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Wednesday 13 Jan 2021 at 11:33:13 (+0000), Marc Zyngier wrote:
> > +#undef KVM_HYP_CPU_FTR_REG
> > +#define KVM_HYP_CPU_FTR_REG(id, name) \
> > +	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
> > +static const struct __ftr_reg_copy_entry {
> > +	u32			sys_id;
> > +	struct arm64_ftr_reg	*dst;
> 
> Why do we need the whole data structure? Can't we just live with sys_val?

I don't have a use-case for anything else than sys_val, so yes I think I
should be able to simplify. I'll try that for v3.

> 
> > +} hyp_ftr_regs[] = {
> > +	#include <asm/kvm_cpufeature.h>
> > +};
> 
> Can't this be made __initdata?

Good point, that would be nice indeed. Can I use that from outside an
__init function? If not, I'll need to rework the code a bit more, but
that should be simple enough either way.

> > +
> > +static int copy_cpu_ftr_regs(void)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hyp_ftr_regs); i++) {
> > +		ret = copy_ftr_reg(hyp_ftr_regs[i].sys_id, hyp_ftr_regs[i].dst);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * Inits Hyp-mode on all online CPUs
> >   */
> > @@ -1705,6 +1729,13 @@ static int init_hyp_mode(void)
> >  	int cpu;
> >  	int err = 0;
> > 
> > +	/*
> > +	 * Copy the required CPU feature register in their EL2 counterpart
> > +	 */
> > +	err = copy_cpu_ftr_regs();
> > +	if (err)
> > +		return err;
> > +
> 
> Just to keep things together, please move any sysreg manipulation into
> sys_regs.c, most probably into kvm_sys_reg_table_init().

Will do.

Thanks,
Quentin
