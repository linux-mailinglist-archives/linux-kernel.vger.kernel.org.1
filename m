Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052312B54B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKPXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:02:40 -0500
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:52874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725379AbgKPXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:02:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9330A100E7B42;
        Mon, 16 Nov 2020 23:02:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:7903:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21067:21080:21451:21627:21987:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: pin73_56106342732c
X-Filterd-Recvd-Size: 1810
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 23:02:37 +0000 (UTC)
Message-ID: <67332536788cefbc39c7f87129adca462bb42fa5.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix unescaped left brace
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 16 Nov 2020 15:02:36 -0800
In-Reply-To: <d3d6b68178b4193f04c35863163ce811a1571c0a.camel@perches.com>
References: <20201115202928.81955-1-dwaipayanray1@gmail.com>
         <d3d6b68178b4193f04c35863163ce811a1571c0a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-15 at 19:43 -0800, Joe Perches wrote:
> On Mon, 2020-11-16 at 01:59 +0530, Dwaipayan Ray wrote:
> > There is an unescaped left brace in a regex in OPEN_BRACE
> > check. This throws a runtime error when checkpatch is run
> > with --fix flag and the OPEN_BRACE check is executed.
> > 
> > Fix it by escaping the left brace.
> > 
> > Fixes: 8d1824780f2f ("checkpatch: add --fix option for a couple OPEN_BRACE misuses")
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> 
> Thanks Dwaipayan.
> 
> Obviously that code path hasn't been tested in awhile.
> 
> I think the notice to require an escape for a { was added back in
> perl 5.16 or so.

Just fyi:  it seems the requirement was actually implemented in perl 5.22
and this code predates the release of perl 5.22

https://github.com/Perl/perl5/blob/blead/pod/perl5220delta.pod

