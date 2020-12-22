Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480D32E0548
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLVEJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:09:05 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:35924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgLVEJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:09:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CFC35837F24C;
        Tue, 22 Dec 2020 04:08:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2828:2919:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3874:4321:4605:5007:7875:7903:7904:8603:8957:9010:9040:9121:10004:10848:11026:11232:11233:11473:11658:11783:11889:11914:12043:12291:12297:12438:12555:12683:12740:12895:13255:13439:13894:14181:14659:14721:21080:21212:21221:21324:21627:30003:30030:30034:30054:30062:30070:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sky76_34051c32745d
X-Filterd-Recvd-Size: 5338
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Dec 2020 04:08:22 +0000 (UTC)
Message-ID: <93a470c7631d2607e7b2a12e9cc5d8e930911989.camel@perches.com>
Subject: Re: [PATCH] checkpatch: make the line length warnings match the
 coding style document
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, apw@canonical.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Dec 2020 20:08:20 -0800
In-Reply-To: <4898c0c03d370a23b1b98ddabb72e70ec8d430fa.camel@perches.com>
References: <20201210082251.2717564-1-hch@lst.de>
         <c3f1d9de2e5a61588f64e69a1309968d84a2dd12.camel@perches.com>
         <20201210200930.GB7338@casper.infradead.org>
         <4898c0c03d370a23b1b98ddabb72e70ec8d430fa.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 13:27 -0800, Joe Perches wrote:
> On Thu, 2020-12-10 at 20:09 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 10, 2020 at 12:05:04PM -0800, Joe Perches wrote:
> > > Also, given the ever increasing average identifier length, strict
> > > adherence to 80 columns is sometimes just not possible without silly
> > > visual gymnastics.  The kernel now has quite a lot of 30+ character
> > > length function names, constants, and structs.
> > 
> > maybe checkpatch should warn for identifiers that are 30+ characters
> > long?  address the problem at its source ..
> 
> Hard to know when to warn as patches could just add uses of already
> existing names and emitting warnings for those would just be annoying.
> 
> Maybe something that tests long identifier additions of
> defines/functions/macros/structs but not their uses and maybe only
> then in patches and not files.
> 
> Perhaps:

Anyone care that this should be added or not added to checkpatch?

> ---
>  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b086d1cd6c2..8579be987fc0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -54,6 +54,7 @@ my @ignore = ();
>  my $help = 0;
>  my $configuration_file = ".checkpatch.conf";
>  my $max_line_length = 100;
> +my $max_identifier_length = 30;
>  my $ignore_perl_version = 0;
>  my $minimum_perl_version = 5.10.0;
>  my $min_conf_desc_length = 4;
> @@ -103,6 +104,8 @@ Options:
>    --max-line-length=n        set the maximum line length, (default $max_line_length)
>                               if exceeded, warn on patches
>                               requires --strict for use with --file
> +  --max-identifier-length=n  set the maximum identifier length, (default $max_identifier_length)
> +                             only used with patches, not output with --file
>    --min-conf-desc-length=n   set the min description length, if shorter, warn
>    --tab-size=n               set the number of spaces for tab (default $tabsize)
>    --root=PATH                PATH to the kernel tree root
> @@ -223,6 +226,7 @@ GetOptions(
>  	'show-types!'	=> \$show_types,
>  	'list-types!'	=> \$list_types,
>  	'max-line-length=i' => \$max_line_length,
> +	'max-identifier-length=i' => \$max_identifier_length,
>  	'min-conf-desc-length=i' => \$min_conf_desc_length,
>  	'tab-size=i'	=> \$tabsize,
>  	'root=s'	=> \$root,
> @@ -2489,6 +2493,7 @@ sub process {
>  	my $suppress_statement = 0;
>  
> 
>  	my %signatures = ();
> +	my %long_identifiers = ();
>  
> 
>  	# Pre-scan the patch sanitizing the lines.
>  	# Pre-scan the patch looking for any __setup documentation.
> @@ -3840,6 +3845,33 @@ sub process {
>  # check we are in a valid C source file if not then ignore this hunk
>  		next if ($realfile !~ /\.(h|c)$/);
>  
> 
> +# check for long identifiers in defines/macros/functions/structs/types/labels
> +		if (!$file) {
> +			while ($sline =~ /^\+.*\b(\w{$max_identifier_length,})\b/g) {
> +				my $id = $1;
> +				next if (exists($long_identifiers{$id}));
> +				my $use = "";
> +				if ($sline =~ /^\+\s*\#\s*define\s+$id(?!\()/) {
> +					$use = "define";
> +				} elsif ($sline =~ /^\+\s*\#\s*define\s+$id\(/) {
> +					$use = "function-like macro";
> +				} elsif ($sline =~ /^\+\s*(?!define)$Declare?$id\s*\(/) {
> +					$use = "function";
> +				} elsif ($sline =~ /^\+\s*(struct|union|enum)\s+$id\b/) {
> +					$use = "$1";
> +				} elsif ($sline =~ /^\+\s*$Declare$id\b/) {
> +					$use = "declaration";
> +				} elsif ($sline =~ /^\+\s*$id\s*:\s*$/) {
> +					$use = "label";
> +				}
> +				if ($use ne "") {
> +					$long_identifiers{$id} = $id;
> +					WARN("LONG_IDENTIFIER",
> +					     "$use '$id' is " . length($id) . " characters - avoid using identifiers with $max_identifier_length+ characters\n" . $herecurr);
> +				}
> +			}
> +		}
> +
>  # check for unusual line ending [ or (
>  		if ($line =~ /^\+.*([\[\(])\s*$/) {
>  			CHK("OPEN_ENDED_LINE",
> 


