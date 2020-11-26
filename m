Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1F2C539F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbgKZMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgKZMKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:10:32 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243A02087C;
        Thu, 26 Nov 2020 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606392631;
        bh=/rUMWHk4jL3AgeomuslJnALbEWnZK9cStZOEYNQAZgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abqPjQJYcyQl8fJld2cNmRQokEgoJV/VEUx+gdOPWvUpNgCpVdvVm1unGgNKL+BO2
         ekM0VIHE8r2PoDj/9F2+sQi4jqE0dTG33t/xqfjedbjXDDdWy1QKP8UZyN+PeraFBT
         Ozewfky9m+va8XQlSdoxpQ6Lbl0vQw3T7WLTOreE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B14540E29; Thu, 26 Nov 2020 09:10:28 -0300 (-03)
Date:   Thu, 26 Nov 2020 09:10:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/16] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201126121028.GA53384@kernel.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
 <20201125141755.GB16159@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125141755.GB16159@willie-the-truck>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 25, 2020 at 02:17:56PM +0000, Will Deacon escreveu:
> On Thu, Nov 19, 2020 at 11:24:25PM +0800, Leo Yan wrote:
> > This is patch set v9 for refactoring Arm SPE trace decoding and dumping.
> > 
> > According to comments and suggestions from patch set v8, it squashs the
> > two patches into single one: "perf arm-spe: Refactor printing string to
> > buffer" and "perf arm-spe: Consolidate arm_spe_pkt_desc()'s return
> > value".
> > 
> > In the patch 01/16, it renames the function arm_spe_pkt_snprintf() to
> > arm_spe_pkt_out_string(), since the function is not the same semantics
> > with snprintf(), the renaming can avoid confusion.
> > 
> > This patch set is cleanly applied on the top of perf/core branch
> > with commit 29396cd573da ("perf expr: Force encapsulation on
> > expr_id_data").
> > 
> > This patch set has been tested on Hisilicon D06 platform with commands
> > "perf report -D" and "perf script", compared the decoding results
> > between with this patch set and without this patch set, "diff" tool
> > shows the result as expected.
> > 
> > I also manually built the patches for arm/arm64/x86_64 and verfied
> > every single patch can build successfully.
> 
> I'm unable to test this, so I'm please that you can! Anyway, it all looks
> fine from a quick look:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> so I think Arnaldo can pick this up when he's ready.

This is all ARM specific stuff, if you are good with it, I'll do just a
cursory look and apply.

- Arnaldo
