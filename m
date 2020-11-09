Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9522AC2B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgKIRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgKIRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:42:26 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:42:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so8829109pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BvTfF4wxBhLQMbsVUQ/52+F1c9iM5v5fNva5TTlgMnQ=;
        b=ClDS/YMZV1X42HHosQGL3CD5WM/7YzXTiPXE3j4CatoBBMRnad33UuSaycFNLLY7ps
         FdtEdMMz5oO04A83VXzTWnkGRjxBNZ9lLiTEAEZ/hs+Tct0FBIHbfrqOl3D9qqNGjf49
         0DLURRGgLdZfIayMaYhLTxFCj/qCTh00CTeGpHsaG6Si6MnLeIY/Y2aBS1+esz3IgeFm
         GeGlgWct62i4BAdoTiJNUxOY6K3g6QJjtn8joQe8DiX+IsMgvPlL1D/POqBCLSZTBuY6
         bhuI5xwitLvkSGrx5livwxIRLXJXsz6o22ExyQ0h3Rl2oDeNcdCGADjvnpVPuT4wPwVC
         D79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvTfF4wxBhLQMbsVUQ/52+F1c9iM5v5fNva5TTlgMnQ=;
        b=KSI1aY2gD/rcSFsilEhDaaQjCVRYpfDEBDPrlcB1wqzAHId6NclMrrlCA+9BGdG2yf
         XORCLZXtFll2UcXG7K3GiWks684BhtqVIpNyKxzL3uKhvSn+jdAmHctSjUkLH8/gqLxX
         U4JesClF/kcUNJLQg5enTJHp0ET1dpWFzCKKh9Gp75sJ6sAZVufNixsZ4Dk5TY9e9IW9
         r2biVbNqtnzaImPCFFevX9gyB4R3g/gES83UARVn6GF46W9eZFdtweq5bFDs3OtTii6I
         NT3cLfKhbgRBpbtqQXuX4x6DznCq1oMSyHrxaqcWy+C3Ms/kYOFG4vG+MqRS57FDK/Tf
         68Jw==
X-Gm-Message-State: AOAM530plWLRkG01r+FDqsJ2y+eaqqPd0OOn4IpUnUcflxk7lKt5LCwW
        wotqFlLivSI8DfyYwmvJPqkLzQ==
X-Google-Smtp-Source: ABdhPJxd2FX98AYeY8IEDYWzZnNcyJLcHfJudtpXcyP4Mq1QJDAMGzh0Up9Cyl5Q6zZP6pu58RNcgg==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr252000pjf.233.1604943745602;
        Mon, 09 Nov 2020 09:42:25 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n11sm77621pjv.52.2020.11.09.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:42:24 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:42:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/26] coresight: etm4x: Cleanup secure exception
 level masks
Message-ID: <20201109174223.GB3395222@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-19-suzuki.poulose@arm.com>
 <20201105215526.GC3047244@xps15>
 <ec9006a6-b8cf-c1f0-7250-e61d478b76ff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9006a6-b8cf-c1f0-7250-e61d478b76ff@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:40:54AM +0000, Suzuki K Poulose wrote:
> On 11/5/20 9:55 PM, Mathieu Poirier wrote:
> > On Wed, Oct 28, 2020 at 10:09:36PM +0000, Suzuki K Poulose wrote:
> > > We rely on the ETM architecture version to decide whether
> > > Secure EL2 is available on the CPU for excluding the level
> > > for address comparators and viewinst main control register.
> > > We must instead use the TRCDIDR3.EXLEVEL_S field to detect
> > > the supported levels.
> > > 
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++----------
> > >   drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++--
> > >   2 files changed, 7 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index a12d58a04c5d..6e3f9cb7de3f 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -733,7 +733,6 @@ static void etm4_init_arch_data(void *info)
> > >   	 * TRCARCHMAJ, bits[11:8] architecture major versin number
> > >   	 */
> > >   	drvdata->arch = BMVAL(etmidr1, 4, 11);
> > > -	drvdata->config.arch = drvdata->arch;
> > >   	/* maximum size of resources */
> > >   	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> > > @@ -749,6 +748,7 @@ static void etm4_init_arch_data(void *info)
> > >   	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
> > >   	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
> > >   	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
> > > +	drvdata->config.s_ex_level = drvdata->s_ex_level;
> > >   	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
> > >   	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
> > > @@ -920,16 +920,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
> > >   static u64 etm4_get_access_type(struct etmv4_config *config)
> > >   {
> > >   	u64 access_type = etm4_get_ns_access_type(config);
> > > -	u64 s_hyp = (config->arch & 0x0f) >= 0x4 ? ETM_EXLEVEL_S_HYP : 0;
> > > -	/*
> > > -	 * EXLEVEL_S, bits[11:8], don't trace anything happening
> > > -	 * in secure state.
> > > -	 */
> > > -	access_type |= (ETM_EXLEVEL_S_APP	|
> > > -			ETM_EXLEVEL_S_OS	|
> > > -			s_hyp			|
> > > -			ETM_EXLEVEL_S_MON);
> > > +	/* All supported secure ELs are excluded */
> > > +	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
> > >   	return access_type;
> > >   }
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > index e7f6b7b16fb7..2ac4ecb0af61 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > @@ -546,6 +546,8 @@
> > >   /* PowerDown Control Register bits */
> > >   #define TRCPDCR_PU			BIT(3)
> > > +#define TRCACATR_EXLEVEL_SHIFT		8
> > > +
> > >   /* secure state access levels - TRCACATRn */
> > >   #define ETM_EXLEVEL_S_APP		BIT(8)
> > >   #define ETM_EXLEVEL_S_OS		BIT(9)
> > > @@ -615,7 +617,7 @@
> > >    * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
> > >    * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
> > >    * @ext_inp:	External input selection.
> > > - * @arch:	ETM architecture version (for arch dependent config).
> > > + * @s_ex_level: Secure ELs where tracing is supported.
> > >    */
> > >   struct etmv4_config {
> > >   	u32				mode;
> > > @@ -659,7 +661,7 @@ struct etmv4_config {
> > >   	u32				vmid_mask0;
> > >   	u32				vmid_mask1;
> > >   	u32				ext_inp;
> > > -	u8				arch;
> > > +	u8				s_ex_level;
> > 
> > Instead of making s_ex_level redundant I suggest to pass a struct etmv4_drvdata
> > to etm4_get_access_type().
> 
> I had given thought about that. But this is called from different
> places, e.g, etm4_set_comparator_filter() where the drvdata is not
> available. Thus, making that change is quite invasive, going down to
> the call stack. Morever, the config->arch was already redundant (also
> cached in drvdata), mainly due to this reason. We simply replace the
> arch field with the actual supported mask of the ELs for precise
> programming.
>

I also noticed config->arch while looking at this patch.
 
> Please let me know if you would like to make the proposed changes.

The problem with adding s_ex_level to etmv4_config is that we are adding to the
technological debt, i.e the more we add the more have to fix.  The upside with
the status quo is that we don't add to an already extensive patchset.  We can
move forward with the latter but would really like to see both ->arch and
->s_ex_level fixed in a subsequent patchset. 

> 
> Cheers
> Suzuki
> 
> 
> 
> 
> > 
> > More comments to come tomorrow.
> > 
> > Thanks,
> > Mathieu
> > 
> > >   };
> > >   /**
> > > -- 
> > > 2.24.1
> > > 
> 
