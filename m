Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664342AF171
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgKKND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:03:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84433C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:03:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id s13so2247799wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdgP6+ZmS9XKah/BF5cKI8FqYLe6KBfyjX/IEuvicQk=;
        b=Sd1vuoKU1AAoYkRoYQHxPEIrxpuhnPYf6Jliv3HEtBhI373IsM55sSjF/1PlobkLkW
         SxhGOo+oyAGlcN0kEMK14apG+X1On5FFrOy26nZhrqCtJNnnHhs+zNwpB1QjAr9fxQ60
         ulwdOIk3Cg6pW/Z5fHxdnoAEddVYu7JHHMCEAoqBTZugKX/R+QpchiECxxBoGjH1oyCX
         BD50o7vNtJFgFReaBuCHNnGAbz8EXlNJ5P6fFLhjeJFRPJlGMjBO7eI8UcPbUj45Nt51
         s3yJhAm0LM8vaTZmzbaz654XgbC7HJOzzwOJQbnR/Pr73PQiiqVUjmE2rEppd6OAtCOc
         GVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdgP6+ZmS9XKah/BF5cKI8FqYLe6KBfyjX/IEuvicQk=;
        b=U2Jav5CIyEdMiyHk0kxKczKjG0aQE5yhu+HshtNvYnV4WDT0Gb4b/LrCZu5Fmhi68u
         DLrr94Oe8xhO3czTevgoGEHoN2+03rN9NRe/RGefQHD97ygwlhHCSQd8gTxP8+6QEgtx
         9JGW/ytXs8AnX6IVqZbMj/BUpA+emH3GEE7qMBqpfZpyUOt5dI3m0fLtIFjMpA2PdBIS
         I97p9hTOIv/OwjShHDBfRJobF2/nnxZNeTX50nAGVMusFmBW5MPUZfjCFwl4QVgUmd01
         D9XkbotP3SAIU+Q8QgFiENWkY5vHws1g4a3G638b8HqnfohiO/zI50UMLR/KCQY38Wea
         0/Uw==
X-Gm-Message-State: AOAM532jCiejyYYVcZLLA7qbvyOKISipCtRgbLA9u0cOk3NGR8HY5YvJ
        3WE0iCHIl+a4CMtEERe44tLiuw==
X-Google-Smtp-Source: ABdhPJzCms/R+/q5OstGcy7wJvxHU5hys4N0pivVj2UMObHaYOBFmyNaXLuMbMjj6xXFcRuzEIMErw==
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr4008787wmf.136.1605099804930;
        Wed, 11 Nov 2020 05:03:24 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:2595:ed05:1717:fe6e])
        by smtp.gmail.com with ESMTPSA id g138sm2508752wme.39.2020.11.11.05.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:03:23 -0800 (PST)
Date:   Wed, 11 Nov 2020 13:03:21 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 07/24] kvm: arm64: Create nVHE copy of cpu_logical_map
Message-ID: <20201111130321.qalrzfabdonrwvsz@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-8-dbrazdil@google.com>
 <d473fd26e5314f2407b70242488f33de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d473fd26e5314f2407b70242488f33de@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/*
> > + * nVHE copy of data structures tracking available CPU cores.
> > + * Only entries for CPUs that were online at KVM init are populated.
> > + * Other CPUs should not be allowed to boot because their features were
> > + * not checked against the finalized system capabilities.
> > + */
> > +u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1]
> > = INVALID_HWID };
> 
> I'm not sure what __ro_after_init means once we get S2 isolation.

It is stretching the definition of 'init' a bit, I know, but I don't see what
your worry is about S2? The intention is to mark this read-only for .hyp.text
at runtime. With S2, the host won't be able to write to it after KVM init.
Obviously that's currently not the case.

One thing we might change in the future is marking it RW for some initial
setup in a HVC handler, then marking it RO for the rest of uptime.

> 
> > +
> > +u64 cpu_logical_map(int cpu)
> 
> nit: is there any reason why "cpu" cannot be unsigned? The thought
> of a negative CPU number makes me shiver...

Same here. That's how it's defined in kernel proper, so I went with that.

> 
> > +{
> > +	if (cpu < 0 || cpu >= ARRAY_SIZE(__cpu_logical_map))
> > +		hyp_panic();
> > +
> > +	return __cpu_logical_map[cpu];
> > +}
> > +
> >  unsigned long __hyp_per_cpu_offset(unsigned int cpu)
> >  {
> >  	unsigned long *cpu_base_array;
> 
> Overall, this patch would make more sense closer it its use case
> (in patch 19). I also don't understand why this lives in percpu.c...

I didn't think it called for adding another C file for this. How about we
rename this file to smp.c? Would that make sense for both?
