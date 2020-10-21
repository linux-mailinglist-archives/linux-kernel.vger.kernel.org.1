Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC772952F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504958AbgJUT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:26:23 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:39062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504939AbgJUT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:26:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D508F18224D7B;
        Wed, 21 Oct 2020 19:26:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3834:3865:3866:3867:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4560:5007:7514:7903:9025:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21660:21811:30003:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: line11_230ddab2724a
X-Filterd-Recvd-Size: 2668
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 19:26:20 +0000 (UTC)
Message-ID: <5bacf91085ce7e253b2697333dc8ff0378fcfae9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Wed, 21 Oct 2020 12:26:19 -0700
In-Reply-To: <0562c42d-f9af-1141-ab77-8abb73bfd31f@gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <0562c42d-f9af-1141-ab77-8abb73bfd31f@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 00:40 +0530, Aditya wrote:
> On 21/10/20 8:48 pm, Joe Perches wrote:
> > On Wed, 2020-10-21 at 20:31 +0530, Aditya Srivastava wrote:
> > > Presence of hexadecimal address or symbol results in false warning
> > > message by checkpatch.pl.
> > > 
> > > For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> > > memory leak in mptcp_subflow_create_socket()") results in warning:
> > > 
> > > WARNING:REPEATED_WORD: Possible repeated word: 'ff'
> > >     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> > 
> > Right.
> > 
> > > To avoid all such reports, add an additional regex check for a repeating
> > > pattern of 4 or more 2-lettered words separated by space in a line.
> > > A quick evaluation on v5.6..v5.8 showed that this fix reduces
> > > REPEATED_WORD warnings from 2797 to 1043.
> > 
> > Are many of the other 1043 false positives?
> > Any pattern to them?
> > 
> Apart from the changes suggested by Dwaipayan in
> https://lore.kernel.org/linux-kernel-mentees/20201017162732.152351-1-dwaipayanray1@gmail.com/
> 
> The 'ls -l' output seems to be another common false positive for
> REPEATED_WORD (Frequency 106 over v5.6..v5.8). For eg.
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'root'
> #18:
>   drwxr-xr-x. 2 root root    0 Apr 17 10:53 .
[]
> @@ -3050,8 +3050,10 @@ sub process {
>  			}
>  		}
> 
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +		$rawline !~ /\b[a-z-]+.* \d{1,3} [a-zA-Z]+ \w+ +\d+ \w{3} \d{1,2}
> \d{1,2}:\d{1,2}/) {

Perhaps a regex for permissions is good enough

	$line !~ /\b[cbdl-][rwxs-]{9,9}\b/


