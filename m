Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2A2AF598
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgKKP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:58:35 -0500
Received: from foss.arm.com ([217.140.110.172]:56982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgKKP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:58:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB1A7101E;
        Wed, 11 Nov 2020 07:58:32 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0233F6CF;
        Wed, 11 Nov 2020 07:58:30 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:58:27 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201111155826.GN6882@arm.com>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111155320.GM6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111155320.GM6882@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:53:20PM +0000, Dave Martin wrote:
> On Wed, Nov 11, 2020 at 07:11:33AM +0000, Leo Yan wrote:
> > When outputs strings to the decoding buffer with function snprintf(),
> > SPE decoder needs to detects if any error returns from snprintf() and if
> > so needs to directly bail out.  If snprintf() returns success, it needs
> > to update buffer pointer and reduce the buffer length so can continue to
> > output the next string into the consequent memory space.
> > 
> > This complex logics are spreading in the function arm_spe_pkt_desc() so
> > there has many duplicate codes for handling error detecting, increment
> > buffer pointer and decrement buffer size.
> > 
> > To avoid the duplicate code, this patch introduces a new helper function
> > arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > it's used by the caller arm_spe_pkt_desc().
> > 
> > This patch also moves the variable 'blen' as the function's local
> > variable, this allows to remove the unnecessary braces and improve the
> > readability.
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> Mostly looks fine to me now, thought there are a few potentionalu
> issues -- comments below.

Hmm, looks like patch 7 anticipated some of my comments here.

Rather than fixing up patch 6, maybe it would be better to squash these
patches together after all...  sorry!

[...]

Cheers
---Dave
