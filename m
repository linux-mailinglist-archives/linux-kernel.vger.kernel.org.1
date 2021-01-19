Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5152FBADD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbhASPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:13:43 -0500
Received: from foss.arm.com ([217.140.110.172]:34234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391338AbhASOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:47:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A035D6E;
        Tue, 19 Jan 2021 06:46:31 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587AD3F66E;
        Tue, 19 Jan 2021 06:46:28 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:46:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v4 3/5] kasan: Add report for async mode
Message-ID: <20210119144625.GB2338@C02TD0UTHF1T.local>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-4-vincenzo.frascino@arm.com>
 <20210119130440.GC17369@gaia>
 <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:23:03PM +0000, Vincenzo Frascino wrote:
> On 1/19/21 1:04 PM, Catalin Marinas wrote:
> > On Mon, Jan 18, 2021 at 06:30:31PM +0000, Vincenzo Frascino wrote:

> >> +bool kasan_report_async(unsigned long addr, size_t size,
> >> +			bool is_write, unsigned long ip);
> > 
> > We have no address, no size and no is_write information. Do we have a
> > reason to pass all these arguments here? Not sure what SPARC ADI does
> > but they may not have all this information either. We can pass ip as the
> > point where we checked the TFSR reg but that's about it.
> 
> I kept the interface generic for future development and mainly to start a
> discussion. I do not have a strong opinion either way. If Andrey agrees as well
> I am happy to change it to what you are suggesting in v5.

For now, I think it's preferable that this only has parameters that we
can actually provide. That way it's clearer what's going on in both
callers and callees, and we can always rework the prototype later or add
separate variants of the function that can take additional parameters.

I don't think we even need to use __kasan_report() -- more on that
below.

[...]

> >> @@ -388,11 +388,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> >>  	start_report(&flags);
> >>  
> >>  	print_error_description(&info);
> >> -	if (addr_has_metadata(untagged_addr))
> >> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0))
> >>  		print_tags(get_tag(tagged_addr), info.first_bad_addr);
> >>  	pr_err("\n");
> >>  
> >> -	if (addr_has_metadata(untagged_addr)) {
> >> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0)) {
> >>  		print_address_description(untagged_addr, get_tag(tagged_addr));
> >>  		pr_err("\n");
> >>  		print_memory_metadata(info.first_bad_addr);
> >> @@ -419,6 +419,18 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
> >>  	return ret;
> >>  }
> >>  
> >> +bool kasan_report_async(unsigned long addr, size_t size,
> >> +			bool is_write, unsigned long ip)
> >> +{
> >> +	pr_info("==================================================================\n");
> >> +	pr_info("KASAN: set in asynchronous mode\n");
> >> +	pr_info("KASAN: some information might not be accurate\n");
> >> +	pr_info("KASAN: fault address is ignored\n");
> >> +	pr_info("KASAN: write/read distinction is ignored\n");
> >> +
> >> +	return kasan_report(addr, size, is_write, ip);
> > 
> > So just call kasan_report (0, 0, 0, ip) here.

Given there's no information available, I think it's simpler and
preferable to handle the logging separately, as is done for
kasan_report_invalid_free(). For example, we could do something roughly
like:

void kasan_report_async(void)
{
	unsigned long flags;

	start_report(&flags);
	pr_err("BUG: KASAN: Tag mismatch detected asynchronously\n");
	pr_err("KASAN: no fault information available\n");
	dump_stack();
	end_report(&flags);
}

... which is easier to consume, since there's no misleading output,
avoids complicating the synchronous reporting path, and we could
consider adding information that's only of use for debugging
asynchronous faults here.

Since the callside is logged in the backtrace, we don't even need the
synthetic IP parameter.

Thanks,
Mark.
