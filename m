Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B382C4205
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgKYOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbgKYOSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:18:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D2B206D9;
        Wed, 25 Nov 2020 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313883;
        bh=vfuMr1GX34MA8Nxr+S5nYqXXfoBNK8HjoqQ+R6uEnQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXKJWyQQOsMgEyfyWgOmFs34DrkGhYCRSk+D9xBH/UVUFeGyDDhhdYdkTz4khVJs3
         fRUpXKRU6thCD4jfUJiZ09uubOFzX3pPOXgN7QQFafmPtdU0BDZaJFclmSWUZVYqmA
         cRP0YT48Gz3fOHXDh4DHnN9gVOJL3Tuj0ut/0dEc=
Date:   Wed, 25 Nov 2020 14:17:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201125141755.GB16159@willie-the-truck>
References: <20201119152441.6972-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:24:25PM +0800, Leo Yan wrote:
> This is patch set v9 for refactoring Arm SPE trace decoding and dumping.
> 
> According to comments and suggestions from patch set v8, it squashs the
> two patches into single one: "perf arm-spe: Refactor printing string to
> buffer" and "perf arm-spe: Consolidate arm_spe_pkt_desc()'s return
> value".
> 
> In the patch 01/16, it renames the function arm_spe_pkt_snprintf() to
> arm_spe_pkt_out_string(), since the function is not the same semantics
> with snprintf(), the renaming can avoid confusion.
> 
> This patch set is cleanly applied on the top of perf/core branch
> with commit 29396cd573da ("perf expr: Force encapsulation on
> expr_id_data").
> 
> This patch set has been tested on Hisilicon D06 platform with commands
> "perf report -D" and "perf script", compared the decoding results
> between with this patch set and without this patch set, "diff" tool
> shows the result as expected.
> 
> I also manually built the patches for arm/arm64/x86_64 and verfied
> every single patch can build successfully.

I'm unable to test this, so I'm please that you can! Anyway, it all looks
fine from a quick look:

Acked-by: Will Deacon <will@kernel.org>

so I think Arnaldo can pick this up when he's ready.

Cheers,

Will
