Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8026E2925FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgJSKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgJSKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:41:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAA6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:41:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so5753398pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SuEDhoJkqZJTj7Ov1JxCpKbJQtXKdi4rudiaNc91CPk=;
        b=sV+ZRnVSAA3TCbr5+o4E+zdAOtqCSZuOgIsYzYym4X2igxk+ywt4cMwpwovtALdgVH
         FHCTZfDUQq04/Q6eWHHFnY+WKNfnnmw7YqcTr0iM8TLAm142vTQM4bhe6P9sR+maUh6c
         6AIeExUlyoAjOBXtu57dy0I+ovV9HB66ZLvk6p/EGD4nEhsLflK7wD+qCMo60PZxdcq4
         T9ubskgwW5RpSk+ZmPv/j9fmuFZugvuJDVagj2eBF9/PBdCSAy2gNwL6OVLjbxtnZDn9
         xHnyRq5yTvSOmGyzM3jzB06E9vRrtSZHzuvnGHCl+Llw9pIhyFsJKxTOg1PzAGoHk4Ue
         9MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SuEDhoJkqZJTj7Ov1JxCpKbJQtXKdi4rudiaNc91CPk=;
        b=hm7hlUWdNJlwVVvPZPEItpJKqfk09o1ZTszLH9CpSj0as/4YOMXzfE2xVli1azkIsB
         nV6ufHNteXs3MeuDkJtH+HlR9MtYQUPXFheXewWIEwwJzXHjpQXo0NpcQ/w9fvY3Iz0L
         xawmBGHaWojFFwS9VZoa8y6Aa00MQKWHqwUT5CkIwx4xHH52QzphZhdaAewb9Ew8yc9z
         ZHVFVVqgc+8YvY/nTMzHhZ5ZGbLmtJERR2sH046R9vlWXxcncQVgBWUfaARmIja9ZQO2
         tKrNhn9vdAtEbA24zwsskUwnvo4SjtJKp8F26cFtO/gXYaooMQgUwx5Ht5FxRRfPNf+Q
         HrnA==
X-Gm-Message-State: AOAM533tneo6bISNBoqey5aG9wG3BY32yxXieMkAsVfrKdeC1zKaesbL
        PaifsOUtE6NyKQi5KFddWDuYDw==
X-Google-Smtp-Source: ABdhPJywR3QEuPX62DL9SYja3y35mo4Od/94mLJEfqPGVLRCbYPB/ZYzGYHkv/4h0y8d6wlQVOls5A==
X-Received: by 2002:a62:2905:0:b029:15b:57ef:3356 with SMTP id p5-20020a6229050000b029015b57ef3356mr13599525pfp.36.1603104081404;
        Mon, 19 Oct 2020 03:41:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id j24sm11009314pjn.9.2020.10.19.03.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 03:41:20 -0700 (PDT)
Date:   Mon, 19 Oct 2020 18:41:15 +0800
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
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v2 07/14] perf arm-spe: Refactor address packet handling
Message-ID: <20201019104115.GA7187@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-8-leo.yan@linaro.org>
 <2e9a9499-4596-2a07-4d44-30e319206c12@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e9a9499-4596-2a07-4d44-30e319206c12@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Mon, Oct 19, 2020 at 10:01:28AM +0100, André Przywara wrote:

[...]

> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index cc18a1e8c212..9d3de163d47c 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -24,36 +24,37 @@
> >  
> >  static u64 arm_spe_calc_ip(int index, u64 payload)
> >  {
> > -	u8 *addr = (u8 *)&payload;
> > -	int ns, el;
> > +	u64 ns, el;
> 
> This (and the "u64 vs. u8[]" changes below) looks like a nice cleanup.
>
> >  	/* Instruction virtual address or Branch target address */
> >  	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
> >  	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
> > -		ns = addr[7] & SPE_ADDR_PKT_NS;
> > -		el = (addr[7] & SPE_ADDR_PKT_EL_MASK) >> SPE_ADDR_PKT_EL_OFFSET;
> > +		ns = payload & SPE_ADDR_PKT_INST_VA_NS;
> > +		el = (payload & SPE_ADDR_PKT_INST_VA_EL_MASK)
> > +			>> SPE_ADDR_PKT_INST_VA_EL_SHIFT;
> 
> So if I see this correctly, this _EL_SHIFT and _EL_MASK are only used
> together, and only to read values, not to construct them.
> So can you fuse them together in the header file below, like:
> 	el = SPE_ADDR_PKT_INST_VA_GET_EL(payload);

Agreed that this is more neat.

> That should help readablity, I guess, while still keeping the actual
> numbers in one place. _SHIFT and _MASK are useful when we use them to
> both extract *and construct* values, but here we only parse the buffer.
> 
> Similar for other places where you just extract bits from a bitfield or
> integer.

Will apply the suggestion crossing the patch set.

Thanks a lot for your reviewing and suggestions.

Leo
