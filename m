Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB42AF775
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKKRkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgKKRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:40:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B291206D9;
        Wed, 11 Nov 2020 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605116413;
        bh=9hcp2jmr5tN+kDYny1x/liXyhLaqh/1ZZx++7sd0jgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ8Ru8cUQ1BaeC2YIxkYJXWgOc4DWwObR/z2TfF8KFLqa3zDjmVsxbLXB1BHI+me6
         uaArfLIAjyfO0p574vcxGysJCRCDs7jN6ZQYRUQItIW5+hq8JeM8JCc4WrcwZJ5ymJ
         GeE9wVX+cekSU5V+rQ6+eUTmSEttgileLKorTXMU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2470C411D1; Wed, 11 Nov 2020 14:40:11 -0300 (-03)
Date:   Wed, 11 Nov 2020 14:40:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "leo.yan@linaro.org" <leo.yan@linaro.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201111174011.GB380127@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111155320.GM6882@arm.com>
 <20201111155826.GN6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111155826.GN6882@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 03:58:27PM +0000, Dave Martin escreveu:
> On Wed, Nov 11, 2020 at 03:53:20PM +0000, Dave Martin wrote:
> > On Wed, Nov 11, 2020 at 07:11:33AM +0000, Leo Yan wrote:
> > > When outputs strings to the decoding buffer with function snprintf(),
> > > SPE decoder needs to detects if any error returns from snprintf() and if
> > > so needs to directly bail out.  If snprintf() returns success, it needs
> > > to update buffer pointer and reduce the buffer length so can continue to
> > > output the next string into the consequent memory space.
> > > 
> > > This complex logics are spreading in the function arm_spe_pkt_desc() so
> > > there has many duplicate codes for handling error detecting, increment
> > > buffer pointer and decrement buffer size.
> > > 
> > > To avoid the duplicate code, this patch introduces a new helper function
> > > arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > > it's used by the caller arm_spe_pkt_desc().
> > > 
> > > This patch also moves the variable 'blen' as the function's local
> > > variable, this allows to remove the unnecessary braces and improve the
> > > readability.
> > > 
> > > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > Mostly looks fine to me now, thought there are a few potentionalu
> > issues -- comments below.
> 
> Hmm, looks like patch 7 anticipated some of my comments here.
> 
> Rather than fixing up patch 6, maybe it would be better to squash these
> patches together after all...  sorry!

I'll take a look and probably do that, as it is what Andre suggests.

- Arnaldo
