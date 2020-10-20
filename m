Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4329334B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbgJTCtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgJTCtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:49:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC04C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 19:49:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so301274pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Frk7zgU5/nDcK1Z9WL1wdRxPp+yWRhCSNMyOmTrl8PY=;
        b=zpRr5UoRWSvjmprmWBZHrLiG1GLGZ+zG2glyaEWNFLPw0Idq34SL3dj3kUsVzSBhW+
         0wqzhaEfwIQr8fE4LxOwLxc/+Ggu9g3MfbU+JZwfASC1/J7CJx/skmxUJ6DOoaI/jpmh
         nSjaicbvvSUV/g6adebTKYK7UGUay6guAhODark6OBEoJDHLz1iV4LYaS9MFXH0HjIsE
         YXH5rpVMsRmsjQx8+nmz85kOI5aRoSUr0G2JfhIDHXgT6Tw196uri9XT2K2vhDeXSqvI
         jNXPCW1q7p7t6Pg3oSw6fvaDXoLwBb1zGXlbPgGJahEfIeEALnafh+5mhMkplC51Van+
         sgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Frk7zgU5/nDcK1Z9WL1wdRxPp+yWRhCSNMyOmTrl8PY=;
        b=T8MULdD3fIblUiEODMRH3RpwhPsgU+rczdMTqS2+SIpiqJ7liG/6dXmWLp3nyKVBdJ
         0jnWrhGHz7dpBJPLuFWtFzKUcoIx+XcfnFZkct7oir4itGMtO7WhTxiaN63q+AolLHj4
         tcNBvuAFoXsn4sW01O2T96jPlDU80pHsLmwmKYB2op4GOe1Dr+l3Sff9ee61p1jvd9JA
         44Q+eLmTkGFyo+66i5zhPYnNLurz4xValU8UtW9/BYWVAWOJxWt85meEWQKdWz/fnBA7
         e1rify2fYySSd293IEonAgM18a3yfHxQgHxCOO2KjzK94ilswbWvo/nuYPd6tV/3S8dM
         by0g==
X-Gm-Message-State: AOAM5337HR4c0BlMCGk5dVTA7wg0PwD5AHF2jvuifnGGCBdgMyt9X9jb
        7Hujv4SRRm1xh6hnw/IPV3VdLg==
X-Google-Smtp-Source: ABdhPJylloWIkQPbnl9qWtNs60y8ZC1K1x4M6S1IEEkcrCijD4iBjDovdVHH/pxpGsgui8Nb/BwnVQ==
X-Received: by 2002:a63:4765:: with SMTP id w37mr837073pgk.332.1603162172004;
        Mon, 19 Oct 2020 19:49:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id k78sm291823pfd.194.2020.10.19.19.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 19:49:31 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:49:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, kan.liang@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201020024925.GB13630@leoy-ThinkPad-X240s>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <20201009093750.GD29594@willie-the-truck>
 <20201009095300.GI2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009095300.GI2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:53:00AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 10:37:51AM +0100, Will Deacon wrote:
> > On Fri, Oct 09, 2020 at 11:09:27AM +0200, Peter Zijlstra wrote:
> 
> > > Patch 4 makes it all far worse by exposing it to pretty much everybody.
> > > 
> > > Now, I think we can fix at least the user mappings with the below delta,
> > > but if archs are using non-page-table MMU sizes we'll need arch helpers.
> > > 
> > > ARM64 is in that last boat.
> > > 
> > > Will, can you live with the below, if not, what would you like to do,
> > > make the entire function __weak so that you can override it, or hook
> > > into it somewhere?
> > 
> > Hmm, so I don't think we currently have any PMUs that set 'data->addr'
> > on arm64, in which case maybe none of this currently matters for us.
> > 
> > However, I must admit that I couldn't figure out exactly what gets exposed
> > to userspace when the backend drivers don't look at the sample_type or
> > do anything with the addr field.
> 
> Patch 4:
> 
>   https://lkml.kernel.org/r/20201001135749.2804-5-kan.liang@linux.intel.com
> 
> is the one that exposes this to everybody with perf support. It will
> then report the page-size for the code address (SAMPLE_IP).

I can see there have another potentail customer to use page-size is
Arm SPE, but Arm SPE is hardware trace based sample but not interrupt
based sample.  For this case, I think this patch set cannot be
directly applied to the AUX trace data.

Thanks,
Leo
