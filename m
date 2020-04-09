Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDD1A2DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 05:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIDMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 23:12:25 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:45098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgDIDMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:12:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8D166181D396F;
        Thu,  9 Apr 2020 03:12:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 93,11,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2110:2196:2197:2198:2199:2200:2201:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:4605:5007:6119:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12257:12291:12295:12296:12297:12438:12555:12740:12895:13095:13161:13229:13439:13618:13894:14181:14659:14721:21080:21212:21221:21433:21451:21505:21627:21660:21740:21741:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: brick58_894f471779363
X-Filterd-Recvd-Size: 4187
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 Apr 2020 03:12:23 +0000 (UTC)
Message-ID: <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 08 Apr 2020 20:10:23 -0700
In-Reply-To: <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-08 at 22:23 +0200, Marion & Christophe JAILLET wrote:
> Le 08/04/2020 à 04:14, Joe Perches a écrit :
> > This works rather better:
> > 
> > Perhaps you could test?
> > ---
> > 
> > v2:
> > 
> > o Avoid pr_cont
> > o Use only last format line if split across multiple lines
> > 
> >   scripts/checkpatch.pl | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index d64c67..f00a6c8 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5673,6 +5673,28 @@ sub process {
> >   			}
> >   		}
> >   
> > +# check for possible missing newlines at the end of common logging functions
> > +		if (defined($stat) &&
> > +		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> > +		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> > +			my $cnt = statement_rawlines($stat);
> > +			my $extracted_string = "";
> > +			for (my $i = 0; $i < $cnt; $i++) {
> > +				next if ($lines[$linenr + $i - 1] !~ /$String\s*[,\)]/);
> > +				$extracted_string = get_quoted_string($lines[$linenr + $i - 1],
> > +								      $rawlines[$linenr + $i - 1]);
> > +				last if ($extracted_string ne "");
> > +			}
> > +			if ($extracted_string ne "" && $extracted_string !~ /\\n"$/) {
> > +				my $herectx = $here . "\n";
> > +				for (my $n = 0; $n < $cnt; $n++) {
> > +					$herectx .=  raw_line($linenr, $n) . "\n";
> > +				}
> > +				WARN("MISSING_FORMAT_NEWLINE",
> > +				     "Possible missing '\\n' at the end of a logging message format string\n" . $herectx);
> > +			}
> > +		}
> > +
> >   # check for logging functions with KERN_<LEVEL>
> >   		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
> >   		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
> > 
> For what I wanted to check and according to the few tests I've made, it 
> looks fine.
> 
> Thank you very much for sharing this much more robust (and working) 
> alternative.
> 
> For what it worth: (i.e. much more tests should be done)
> Tested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Then I think you really haven't tested it very thoroughly.

For instance:

$ git ls-files -- 'drivers/*.[ch]' | \
  xargs ./scripts/checkpatch.pl -f --quiet --no-summary --types=MISSING_FORMAT_NEWLINE

emits many false positives.

Some types of false positives:

o Many of the formats seem to end in a ':' or a ' '
  maybe those should be excluded
   #86: FILE: drivers/android/binder_alloc_selftest.c:86:
   +	pr_err("free seq: ");

   o Split string formats should be excluded better
     as only the first string fragment is checked:
   #1001: FILE: drivers/ata/pata_octeon_cf.c:1001:
   +	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
   +		 is_16bit ? 16 : 8,
   +		 cf_port->is_true_ide ? ", True IDE" : "");

   probably a few others, including a desire to check
   if a pr_cont is below the use within a few lines.

   > Maybe, at least a Suggested-By: would be appreciated.

No worries, when it's cooked, it'll have that.

cheers, Joe

