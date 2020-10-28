Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0929D9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbgJ1XEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgJ1XBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:01:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:01:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so743414pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YvGrI679j+reo4T3Ga7USOdXrOecTU3RyS3vgrSzWXk=;
        b=H7FiWRcXfNfrmvsjc12PjxNRVeK9QDcIF3rCMUeVYNfkaWV7xPauzmlzXibiMpDXbg
         ep7wsVFYZkXELXhGBCfe6WvrcidxtpKclDOcZVA5z9TmVNNJzEtq9qG/Stg8r0/zcVq9
         qo+6InwIcTvd4haKNaZXjwzEslE53jtfsWr2lM67N+c1Ai6Zzh1RJQOlBV4b0CJ3271A
         FXZVXlF3Kg/KcbiOexPE9vcSUA6hHi61TW3kOoibd4oqsH20Fk8SC/2IJZc7NfFWnkaK
         AV3kJFo4SVAW3gRsQy+klmAXq2YAJ5TSihKa7QWQCja9eZJG3UffM06lXVOHciJy47uT
         LGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YvGrI679j+reo4T3Ga7USOdXrOecTU3RyS3vgrSzWXk=;
        b=f2/6NrpqViMjRUy/z+naQd7L51RxTU7qnahKYxmylSPvQJsRbVmCzStR/QOshAJMOW
         NjZizdt3YuqxCu53Ct2OLDwPxJz2L+bmRSkW+71UwvHIkunBdDcufa3KSspJAN3rkb6v
         4grxhTmruIBIhgS9oRxNjBeaDySLyz1KXmRIEhGOU4RXF8jjeHkg69k/eTpn3dtS/7Az
         BoTESaxpEZlKIedymrFyy+li1YpbMDpQjd3NGNrR1sghebwctWKDBs7eAcTaSoJ/TvOi
         q84sr/ZpMbAkp0fWNAP5tOZd08Fyi2EUEw/X3gyDW2MINBh/noiN1ZKbeo+Vt0GJ40LW
         /Psg==
X-Gm-Message-State: AOAM531inqUXC2smcpwbtC1soaSSVMAECQcBi0MT8oxLwOAuzq1orZNB
        SoYauK9kGJoiPtwe4Vo4uw/fzf99pn9u3DykYj8=
X-Google-Smtp-Source: ABdhPJzysFOFHHV0CQWsbahT2dzy4kUGjRdQ9pQ0x0xRBPWR/tdB5usIZ/qaZGW/kJZViQe+KKfKGQ==
X-Received: by 2002:a63:6701:: with SMTP id b1mr5253731pgc.59.1603867793300;
        Tue, 27 Oct 2020 23:49:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id n6sm4105348pjj.34.2020.10.27.23.49.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:49:52 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:49:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/21] perf arm_spe: Fixup top byte for data virtual
 address
Message-ID: <20201028064946.GF32667@leoy-ThinkPad-X240s>
References: <20201027030917.15404-1-leo.yan@linaro.org>
 <20201027030917.15404-11-leo.yan@linaro.org>
 <dfb599fd-b253-ba94-59c0-a76e5043fbb7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfb599fd-b253-ba94-59c0-a76e5043fbb7@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Tue, Oct 27, 2020 at 03:01:26PM +0000, André Przywara wrote:
> On 27/10/2020 03:09, Leo Yan wrote:
> > To establish a valid address from the address packet payload and finally
> > the address value can be used for parsing data symbol in DSO, current
> > code uses 0xff to replace the tag in the top byte of data virtual
> > address.
> > 
> > So far the code only fixups top byte for the memory layouts with 4KB
> > pages, it misses to support memory layouts with 64KB pages.
> > 
> > This patch adds the conditions for checking bits [55:48] are 0xf0 or
> > 0xfd, if detects the patterns it will fill 0xff into the top byte of the
> > address, also adds comment to explain the fixing up.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    | 24 ++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 776b3e6628bb..e135ac01d94a 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -24,7 +24,7 @@
> >  
> >  static u64 arm_spe_calc_ip(int index, u64 payload)
> >  {
> > -	u64 ns, el;
> > +	u64 ns, el, val;
> >  
> >  	/* Instruction virtual address or Branch target address */
> >  	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
> > @@ -45,8 +45,26 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
> >  		/* Clean tags */
> >  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  
> > -		/* Fill highest byte if bits [48..55] is 0xff */
> > -		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
> > +		/*
> > +		 * Armv8 ARM (ARM DDI 0487F.c), chapter "D10.2.1 Address packet"
> > +		 * defines the data virtual address payload format, the top byte
> > +		 * (bits [63:56]) is assigned as top-byte tag; so we only can
> > +		 * retrieve address value from bits [55:0].
> > +		 *
> > +		 * According to Documentation/arm64/memory.rst, if detects the
> > +		 * specific pattern in bits [55:48] of payload which falls in
> > +		 * the kernel space, should fixup the top byte and this allows
> > +		 * perf tool to parse DSO symbol for data address correctly.
> > +		 *
> > +		 * For this reason, if detects the bits [55:48] is one of
> > +		 * following values, will fill 0xff into the top byte:
> > +		 *
> > +		 *   - 0xff (for most kernel memory regions);
> > +		 *   - 0xf0 (for kernel logical memory map with 64KB pages);
> > +		 *   - 0xfd (for kasan shadow region with 64KB pages).
> > +		 */
> > +		val = SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload);
> > +		if (val == 0xffULL || val == 0xf0ULL || val == 0xfdULL)
> 
> But those values are just the beginning of the region used by the
> kernel, aren't they? So the kernel logical map goes from 0xfff000.. to
> 0xfff7fff..., for instance.

Ouch ...  You are right :)

> But actually I wonder why were are so selective here? Wouldn't it just
> suffice to look at bits [55:52] to be either 0 or F?

I considered to compare bits [55:52] but finally I wanted to use more
accurate comparison.  As you pointed out this is incorrect, I will
change to compare bits [55:52].

Thanks,
Leo
