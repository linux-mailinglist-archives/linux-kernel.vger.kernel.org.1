Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3325F29A377
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505280AbgJ0Dzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:55:40 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:38078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503802AbgJ0Dzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:55:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 61476837F24A;
        Tue, 27 Oct 2020 03:55:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2919:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:4321:5007:7903:10004:10400:10848:11026:11232:11658:11783:11914:12043:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:21990:30054:30056:30060:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mouth68_4c0cee527279
X-Filterd-Recvd-Size: 2500
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Oct 2020 03:55:37 +0000 (UTC)
Message-ID: <0b1436d7f3f4267d518013919edd351dba4bcc92.camel@perches.com>
Subject: Re: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Oct 2020 20:55:35 -0700
In-Reply-To: <20201026080322.4d0b26f5@coco.lan>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
         <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
         <20201023112226.4035e3f7@lwn.net>
         <c0210eade81060382884e1f38ca7f71742d02b61.camel@perches.com>
         <20201026080322.4d0b26f5@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-26 at 08:03 +0100, Mauro Carvalho Chehab wrote:
[]
> Well, this can help:
> 	my $typedef_type = qr { ((?:\w+\s+){1,}) }x;

unbounded captures are generally bad, I suggest a limit like {1,5}

>     if ($x =~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> 	$x =~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) {
[]
> Fix the regex in order to accept composite types when
> defining a typedef for a function pointer.
[] 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
[]
> @@ -1438,13 +1438,14 @@ sub dump_typedef($$) {
>      $x =~ s@/\*.*?\*/@@gos;	# strip comments.
>  
> 
>      # Parse function prototypes
> -    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> -	$x =~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
> +    if ($x =~ /typedef\s+((?:\w+\s+){1,})\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> +	$x =~ /typedef\s+((?:\w+\s+){1,})\s*\*?(\w\S+)\s*\s*\((.*)\);/) {

This typedef does not allow * returns like

	const unsigned char *(*string)(args...);
or
	unsigned char *const(*fn)(args...);
or
	void *(*alloc)(args...);

(not to mention the truly unusual stuff like the typedefs in
 tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c)

typedef void (* (*signal_t)(int, void (*)(int)))(int);
typedef char * (*fn_ptr_arr1_t[10])(int **);
typedef char * (* const (* const fn_ptr_arr2_t[5])())(char * (*)(int));


