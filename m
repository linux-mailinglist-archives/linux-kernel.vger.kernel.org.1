Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DE2EA92C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbhAEKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:49:52 -0500
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:54944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728947AbhAEKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:49:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3089818225E0E;
        Tue,  5 Jan 2021 10:49:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7576:7652:7903:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12698:12737:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:14764:21080:21221:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:174,LUA_SUMMARY:none
X-HE-Tag: grip88_2400adf274d8
X-Filterd-Recvd-Size: 2242
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 10:49:08 +0000 (UTC)
Message-ID: <120df949b3071bdde9c554451130d736eb1fa60c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix unescaped left braces
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
Date:   Tue, 05 Jan 2021 02:49:07 -0800
In-Reply-To: <027501cb2506426d9c05adf56d002781@AcuMS.aculab.com>
References: <20210105093507.29297-1-dwaipayanray1@gmail.com>
         <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
         <027501cb2506426d9c05adf56d002781@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 10:35 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 05 January 2021 10:01
> > 
> > On Tue, 2021-01-05 at 15:05 +0530, Dwaipayan Ray wrote:
> > > Perl 5.22 onwards require that "A literal "{" should now be
> > > escaped in a pattern".
> 
> Sounds like a good reason to never use perl :-)
> 
> > Not quite correct.
> > 
> > > checkpatch contains several literal "{". Fix such instances
> > > by preceding them with a backslash.
> > 
> > Not all literal left braces need to be escaped.
> > https://www.perlmonks.org/?node_id=1191981
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -2036,7 +2036,7 @@ sub annotate_values {
> > >  			print "ASSIGN($1)\n" if ($dbg_values > 1);
> > >  			$type = 'N';
> > > 
> > > 
> > > -		} elsif ($cur =~/^(;|{|})/) {
> > > +		} elsif ($cur =~ /^(;|\{|\})/) {
> 
> isn't (;|{|}) much the same as [;{}] ??

Yes, but without the capture, so /^([;{}])/ would be the same.

I presume the | style was used for consistency with other uses
in the same block.

Andy Whitcroft wrote that bit a long time ago.


