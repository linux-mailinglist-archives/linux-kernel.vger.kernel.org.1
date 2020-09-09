Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC8263499
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIIR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:27:20 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:56254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbgIIR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:27:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E1042181D3039;
        Wed,  9 Sep 2020 17:27:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:196:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1622:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6671:7875:8603:8660:8985:9010:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13007:13148:13161:13229:13230:13255:13439:14181:14659:14721:21080:21324:21433:21451:21627:21740:21811:21939:21990:30003:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: toy26_3d1802a270df
X-Filterd-Recvd-Size: 4200
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 17:27:15 +0000 (UTC)
Message-ID: <ed839e7c9f4e96ee54fc3ab958eeb2ab285f5ba8.camel@perches.com>
Subject: Re: [PATCH] kernel: events: Use scnprintf() in show_pmu_*() instead
 of snprintf()
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 10:27:14 -0700
In-Reply-To: <d0c52cb6-5eb2-8ea0-a1b4-c97f447835f6@linuxfoundation.org>
References: <20200901234930.359126-1-skhan@linuxfoundation.org>
         <87o8mfxxc4.fsf@ashishki-desk.ger.corp.intel.com>
         <d0c52cb6-5eb2-8ea0-a1b4-c97f447835f6@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 10:19 -0600, Shuah Khan wrote:
> On 9/9/20 12:45 AM, Alexander Shishkin wrote:
> > Shuah Khan <skhan@linuxfoundation.org> writes:
> > 
> > > Since snprintf() returns would-be-output size instead of the actual
> > > output size, replace it with scnprintf(), so the nr_addr_filters_show(),
> > > type_show(), and perf_event_mux_interval_ms_show() routines return the
> > > actual size.
> > 
> > Well, firstly they should just be sprintf()s, and secondly, I wouldn't
> > worry about it, because [0].
> 
> scnprintf() or sprinf() could be used.
> 
> > [0] https://marc.info/?l=linux-kernel&m=159874491103969&w=2
> 
> Awesome. Thanks for the pointer. I wasn't aware of this work and
> it takes care of the problem kernel wide. A better way to solve
> the problem.

There is a fairly large, though fairly trivial direct conversion
using a cocci script for 90+% (~5000) of the existing uses of
device and kobject show functions that use any of the sprintf
call family.

https://lore.kernel.org/lkml/c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com/

The other < 10% though require some manual changes.

There are some code blocks where it's possible for a
PAGE_SIZE buffer overrun to occur, though perhaps it's not
ever occurred in practice.

A defect I've seen when looking at the code is to always
output to a presumed PAGE_SIZE buffer even though the
output buffer address has been advanced.

i.e.:

	for (i = 0; i < count; i++)
		buf += scnprintf(buf, PAGE_SIZE, " %u", val[i]);

In actual code: (from drivers/staging/gasket/gasket_core.c)

In this code buf is passed to a helper function without adding
an offset in buf to the argument list and PAGE_SIZE is used for
multiple calls in a for loop in the case statement.

static ssize_t
gasket_write_mappable_regions(char *buf,
			      const struct gasket_driver_desc *driver_desc,
			      int bar_index)
{
	int i;
	ssize_t written;
	ssize_t total_written = 0;
	ulong min_addr, max_addr;
	struct gasket_bar_desc bar_desc =
		driver_desc->bar_descriptions[bar_index];

	if (bar_desc.permissions == GASKET_NOMAP)
		return 0;
	for (i = 0;
	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
	     i++) {
		min_addr = bar_desc.mappable_regions[i].start -
			   driver_desc->legacy_mmap_address_offset;
		max_addr = bar_desc.mappable_regions[i].start -
			   driver_desc->legacy_mmap_address_offset +
			   bar_desc.mappable_regions[i].length_bytes;
		written = scnprintf(buf, PAGE_SIZE - total_written,
				    "0x%08lx-0x%08lx\n", min_addr, max_addr);
		total_written += written;
		buf += written;
	}
	return total_written;
}

...

static ssize_t gasket_sysfs_data_show(struct device *device,
				      struct device_attribute *attr, char *buf)
{
	...
	switch (sysfs_type) {
	...
	case ATTR_USER_MEM_RANGES:
		for (i = 0; i < PCI_STD_NUM_BARS; ++i) {
			current_written =
				gasket_write_mappable_regions(buf, driver_desc,
							      i);
			buf += current_written;
			ret += current_written;
		}
		break;
	...
}


