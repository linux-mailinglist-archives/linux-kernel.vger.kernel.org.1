Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9F2ADCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKJRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:33:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF39C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:33:06 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so6821998pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9zVnfWT/kePcxqOhf68I33NqWXFBDGvppNuEI4E5rYE=;
        b=MVfI/mI1n13XgDpXTRyKhljXo8trbSF0QGncs1VQDJW5qSNAad78ZBG85LcQL+gSeL
         /7cNmB9wC0DWkehgP14dTeRQBWfUQ7FuccWAvvxgj/KsQPQQpQ2BDoPiePLCe2aFUrz5
         PzmWtSQBYC7OsgXeHMoGyO0mQI4/15gYwzUT2dv1Emnj6xadhyxbtnhYzWrUDnnRHDT9
         1Kf2YQC2rD/XchXkfXxItC4k4twwKXyx5//Um9820CK4hR2RrOB/jIahojm+La/R8+/C
         TrEOZAyfQNJc8FhO+3dMVULCHdwbJqkwKk3E8ZsXj6vgx7gkBr3gFq6JWUeRRJsgIfuJ
         fxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zVnfWT/kePcxqOhf68I33NqWXFBDGvppNuEI4E5rYE=;
        b=t0VUkR3VReMTQ8wkoWiZxgb1qtS7Ke/GywxyhriN2ACr98zEB2MPcRQo4ByOp3rf84
         6AACGb3Yb7p8VJUy9RGu12yaK115EKbQbrxui7VvsoOAlcmNjLSkCLotDeSKazfaKXOE
         kywx4iQrv1g1zt98M9rUN1zcmQY97Tntm0DRZ9T3I3D/ETxKSXkZPtq6p+L1ZecTVsvy
         IfyAW2/nBZMHS4BbDSWSgInYmmovaKmLTgZxoyr/lphjWQ9OL7UC45hAPmLh2yVZBKFJ
         ye8N2mBBTl+/LicREGOXI6ZDxgBlshLV61g8RI3QWfliDPnDlKGZLjOdfFPmjaLztg4v
         B/Rg==
X-Gm-Message-State: AOAM531mz6Juk4O9EwxdH9qm84gKcjdeS/jSfMkmV/R+JU5EZx63Nfeb
        qAKQ6hVMMHDmbWIuqurTgQ1rIA==
X-Google-Smtp-Source: ABdhPJwmURK0sc0CDRd2x1IAF7JwRoZnVW/EZTlDgU4Sy9WN8JL7rqAKRlETwpJr5KQCIFPdEoVcgg==
X-Received: by 2002:a17:902:a402:b029:d6:e257:c71a with SMTP id p2-20020a170902a402b02900d6e257c71amr17088228plq.49.1605029586070;
        Tue, 10 Nov 2020 09:33:06 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 199sm14528906pgg.18.2020.11.10.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:33:05 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:33:03 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/26] coresight: etm4x: Detect system instructions
 support
Message-ID: <20201110173303.GB3429138@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-25-suzuki.poulose@arm.com>
 <20201109202205.GB3396611@xps15>
 <b4a4bd73-00c5-a921-3f01-7100d2a0edf8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a4bd73-00c5-a921-3f01-7100d2a0edf8@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:31:42AM +0000, Suzuki K Poulose wrote:
> On 11/9/20 8:22 PM, Mathieu Poirier wrote:
> > On Wed, Oct 28, 2020 at 10:09:42PM +0000, Suzuki K Poulose wrote:
> > > ETM v4.4 onwards adds support for system instruction access
> > > to the ETM. Detect the support on an ETM and switch to using the
> > > mode when available.
> > > 
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
> > >   1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index 4bc2f15b6332..dc537b5612eb 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -675,6 +675,37 @@ static const struct coresight_ops etm4_cs_ops = {
> > >   	.source_ops	= &etm4_source_ops,
> > >   };
> > > +static inline bool cpu_supports_sysreg_trace(void)
> > > +{
> > > +	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> > > +
> > > +	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
> > 
> > I would do:
> > 
> >          return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) == 1;
> > 
> > Because any other value than '1' are reserved.
> 
> Correct. However, this is something we follow for all ID features
> in the arm64 kernel and is clarified in the Arm ARM (ARM DDI 0487F.a) :
> 
> "D13.1.3 Principles of the ID scheme for fields in ID registers"
> 
> Which guarantees that a (field  > n) implies, everything that field == n
> is implied. (Well there are exceptions listed in the section, but
> TRACEVER is not one of those). So this should cover an old kernel
> running on a future CPU, using the features that it understands.
> (See feature_matches() in arch/arm64/kernel/cpufeature.c, which is
> the fundamental logic to detect a feature).
> 

While I haven't found anything conclusive in cpufeature.c, the documentation is
clear on the fact that versions are incremental and build on top of previous
ones.  We can proceed with the current implementation. 

> Please let me know if you're OK with the justification.
> 
> Thanks for the review.
> 
> Suzuki
