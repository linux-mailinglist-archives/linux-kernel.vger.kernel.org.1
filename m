Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBC2747F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:07:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E82C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:07:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so18099667wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6y72uZ7YdWD1XXfQ+XTc3NqqPVXw5bQyVkymr14fQGQ=;
        b=CRd63rpNjyrzDcmAXaGmKY+nIczGjjMJGpL77E2ju9oloTgn2/h43kyf7RWLd6TSb1
         drxGmpeR76PV5D4kIrtMak0BTXiG5QqFMzjzRfQlbfXHW05r/mynwAVi8WOU7EzJz668
         1OQ4vm0VTMoo+qE1KCxXK/ZC2MaA+0D0xpWJECvrWvULe4ay+hp8jpleCDlSQl6ynXDm
         hdn5fKFjis/9QrlFTJZ65bXGTQnbSyH4tgejSXC753c+nYjHnfeoxaGtt5vIr7zmYhnN
         eQl+KORPu/uRAmRcXz71wLELsQ70yI9fMXN5m2dnfT3ZLENatNSfDyQyWqxnCJ+hp3Lj
         Jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6y72uZ7YdWD1XXfQ+XTc3NqqPVXw5bQyVkymr14fQGQ=;
        b=RQi6xGKxvA/RV+rjvl6gAdFvfBu1ePaFRWcYMppQ6nbiimcvTRo1FFbgVHB/LzEUl9
         gV5vQoyzJbg7gc5RRFLevC1/nQ+lbEpbSdyu5dEKz1KROh0OjDLJFiMKMu5dFHyrEkrW
         zRb1f1ZRDE51uAGByVuV01Gxa6mgv+t8pDgLna/RTR7kiZP1OQg162+T01BciWyadRXe
         bM8la7/z8NkUVMECrAuqRv6+LC//z5pTHq896GUAsJJq35EF+WRtPqB5u25c1JoHkz1F
         +xHLwqQaChAAFq8NEAbhkbKzztXuybRN6BXJfjXNUsKphha7l2hqklsJ4EDLoJkHBCAi
         8uGA==
X-Gm-Message-State: AOAM5329EZyGRjnOcTH4ynsCu+QsZMbP/L6ZVhsg0II+063zzjLlz/8R
        vE0gUZZtGDfozGtnQaZkRAqc1Q==
X-Google-Smtp-Source: ABdhPJwZPTozi74qAG3/aClHpnw3RnRnKS0i65Quxl7eR1kjuVfhlagjStYPlzzSrntMUCfignnPpQ==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr6822937wrs.107.1600798067242;
        Tue, 22 Sep 2020 11:07:47 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:55c2:2cdf:ff31:96a3])
        by smtp.gmail.com with ESMTPSA id e1sm28558820wrp.49.2020.09.22.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:07:46 -0700 (PDT)
Date:   Tue, 22 Sep 2020 19:07:45 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/11] kvm: arm64: Duplicate
 arm64_ssbd_callback_required for nVHE hyp
Message-ID: <20200922180745.m6bjgjzz6cwercgf@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-8-dbrazdil@google.com>
 <20200918115911.GB31096@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918115911.GB31096@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  		u64 *ptr;
> >  
> > -		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
> > +		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
> >  		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
> >  		if (err)
> >  			return err;
> > +
> > +		/* Copy value from kernel to hyp. */
> > +		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
> 
> Hmm. Is this correct for late arriving CPUs, where we don't know whether
> a callback is required at the point we do the copy?
> 
> That sounds fiddly to resolve, but this _might_ all be moot because I'm
> about to post a series that allows us to remove the hyp mapping of this
> variable entirely. So leave this for now, but maybe stick a comment in
> that it doesn't work for late cpus.

Ah, good point. I'll move the value copy at the end of cpu_init_hyp_mode().
It must be known at that point. And if your series gets rid of this completely,
even better.
