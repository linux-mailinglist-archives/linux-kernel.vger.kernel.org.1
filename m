Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D82959C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509150AbgJVIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442415AbgJVIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:00:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C11C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gEjo3gaplCCICB0+z5wPT9FO9VvQS9bisDhXZFIkj70=; b=OQv7du17GyKxVqA01gO0GhhqVA
        11Nr/98AwqvDJkiseaFeoERSoO+KRUdycn36E0vKs1r3gusvuH5nbzrVTc8jadr7OvmTawEHf3BW3
        zgOvoY6wEYMF+Z8iY4TT5UoE/qK2/qxA0ekYMWJrz0/9zCI5D+Cgi9dvmn+N5UDWwMbEKEmb6a4Th
        Bjg966I0M2dwZR/h0I4J1C6zVc7mf4I8L4mZHC8HhVV2TEQlFWzC1JWkQ3o+thN36A2HsOW/tv0zY
        KqQMgxPzZgLvVt+nFFy9f5po89X2VAX0TzdgE+3L67D1TGmAB4nFUJO5Rzg6lT6MnCXO48E9rxI6I
        8URtpSzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVVW0-0004R8-7N; Thu, 22 Oct 2020 08:00:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73A0E30377D;
        Thu, 22 Oct 2020 10:00:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52CF221463180; Thu, 22 Oct 2020 10:00:03 +0200 (CEST)
Date:   Thu, 22 Oct 2020 10:00:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, jolsa@redhat.com, mingo@elte.hu,
        irogers@google.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/x86/intel: make anythread filter support conditional
Message-ID: <20201022080003.GR2628@hirez.programming.kicks-ass.net>
References: <20201021211612.2026234-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021211612.2026234-1-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:16:12PM -0700, Stephane Eranian wrote:
> Starting with Arch Perfmon v5, the anythread filter on generic counters may be
> deprecated. The current kernel was exporting the any filter without checking.
> On Icelake, it means you could do cpu/event=0x3c,any/ even though the filter
> does not exist. This patch corrects the problem by relying on the CPUID 0xa leaf
> function to determine if anythread is supported or not as described in the
> Intel SDM Vol3b 18.2.5.1 AnyThread Deprecation section.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/intel/core.c      | 20 ++++++++++++++++++++
>  arch/x86/events/perf_event.h      |  1 +
>  arch/x86/include/asm/perf_event.h |  4 +++-
>  arch/x86/kvm/cpuid.c              |  4 +++-
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f1926e9f2143..65bf649048a6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4220,6 +4220,16 @@ static struct attribute *intel_arch3_formats_attr[] = {
>  	NULL,
>  };
>  
> +static struct attribute *intel_arch5_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_umask.attr,
> +	&format_attr_edge.attr,
> +	&format_attr_pc.attr,
> +	&format_attr_inv.attr,
> +	&format_attr_cmask.attr,
> +	NULL,
> +};

Instead of adding yet another (which is an exact duplicate of the
existing intel_arch_formats_attr BTW), can't we clean this up and use
is_visible() as 'demanded' by GregKH and done by Jiri here:

  3d5672735b23 ("perf/x86: Add is_visible attribute_group callback for base events")
  b7c9b3927337 ("perf/x86/intel: Use ->is_visible callback for default group")
  baa0c83363c7 ("perf/x86: Use the new pmu::update_attrs attribute group")

And only have "any" visible for v3,v4
