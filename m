Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC51DA98B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 06:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgETE64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 00:58:56 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:50388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgETE64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:58:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 87EE1181D330D;
        Wed, 20 May 2020 04:58:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3872:3873:3874:4321:4605:5007:6120:7875:7903:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:19904:19999:21080:21324:21451:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bee40_1b05ed926d13
X-Filterd-Recvd-Size: 2756
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2020 04:58:54 +0000 (UTC)
Message-ID: <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 19 May 2020 21:58:53 -0700
In-Reply-To: <20200520044127.GB938@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200520044127.GB938@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 13:41 +0900, Sergey Senozhatsky wrote:
> On (20/05/19 12:42), Joe Perches wrote:
> > +static void __init print_cmdline(char *line)
> > +{
> > +#ifdef CONFIG_PRINTK
> > +	const char *prefix = "Kernel command line";
> > +	size_t len = strlen(line);
> > +
> > +	while (len > PRINTK_LOG_LINE_MAX) {
> > +		char *pos = line;
> > +		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
> > +		char saved_char;
> > +		/* Find last space char within the maximum line length */
> > +		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
> > +		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
> 
> Don't you need to also count in the 'prefix' length?

yup.

> > +			last_pos = pos;
> > +		}
> > +		saved_char = line[last_pos - line];
> > +		line[last_pos - line] = 0;
> > +		pr_notice("%s: %s\n", prefix, line);
> > +		prefix = "Kernel command line (continued)";
> > +		line[last_pos - line] = saved_char;
> > +		len -= pos - line;
> > +		line += pos - line;
> > +	}
> > +
> > +	pr_notice("%s: %s\n", prefix, line);
> > +#endif
> > +}
> 
> I like this in general. And I agree that we better handle this
> externally, on the printk() caller side, so that printk() will
> still have sane limits and won't print a 1G string for example.
> 
> I wonder if we need to export PRINTK_LOG_LINE_MAX.

I think a #define works well enough.(

>  Maybe we can
> use here something rather random and much shorter instead. E.g.
> 256 chars. Hmm. How 

	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)

would work.

> many crash/monitoring tools can get confused
> by multiple "Kernel command line" prefixes?

I doubt any as it's an init only function.


