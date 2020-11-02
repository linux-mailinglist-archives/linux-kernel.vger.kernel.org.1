Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A02A30BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKBRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:01:34 -0500
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:52312 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727438AbgKBRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:01:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 957C3180A8450;
        Mon,  2 Nov 2020 17:01:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2915:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7875:7904:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13141:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:14819:21080:21611:21627:21990:30012:30034:30054:30069:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: drug29_53075a1272b1
X-Filterd-Recvd-Size: 2510
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Nov 2020 17:01:31 +0000 (UTC)
Message-ID: <7309c580def7427769b4c133c5037209d3ecac91.camel@perches.com>
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Nov 2020 09:01:29 -0800
In-Reply-To: <20201102144025.GL27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
         <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
         <20201101204834.GF27442@casper.infradead.org>
         <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
         <20201101211910.GG27442@casper.infradead.org>
         <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
         <20201101220604.GI27442@casper.infradead.org>
         <20201102133343.GA1011963@kroah.com>
         <20201102140836.GJ27442@casper.infradead.org>
         <20201102143259.GA1024551@kroah.com>
         <20201102144025.GL27442@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-02 at 14:40 +0000, Matthew Wilcox wrote:
> For someone who's used to C "strings", it's pretty common to do
> something like:
> 
> 	buf += sprintf(buf, "foo ");
> 	buf += sprintf(buf, "bar ");

It's not equivalent code.

What was actually necessary was using scnprintf which tests the
number of bytes available in the buffer.

The actual equivalent code was something like:

	int used = 0;
	used += scnprintf(buf + used, PAGE_SIZE - used, "foo ");
	used += scnprintf(buf + used, PAGE_SIZE - used, "bar ");
	
> sysfs_emit_at instead wants me to do:
> 
> 	len += sprintf(buf + len, "foo ");
> 	len += sprintf(buf + len, "bar ");
> 
> I don't see how the code I wrote defeats the check.  It checks that the
> buffer never crosses a PAGE_SIZE boundary, which is equivalently safe.

And it'd be required to store the original buf value passed to be
able to return the actual number of bytes emitted when multiple
calls are used.

	return sprintf(buf) - obuf;

This also does and can not verify that buf is originally page aligned.


