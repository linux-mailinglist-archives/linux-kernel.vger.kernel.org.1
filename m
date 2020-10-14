Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710F828DA17
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgJNG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:58:41 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:58456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgJNG6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:58:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0A69518224D82;
        Wed, 14 Oct 2020 06:58:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:6120:8957:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21889:21987:30045:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bee95_1108f8c27209
X-Filterd-Recvd-Size: 2644
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 06:58:39 +0000 (UTC)
Message-ID: <084a2dabe5463a3528bb052515555f939235c012.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 13 Oct 2020 23:58:37 -0700
In-Reply-To: <alpine.DEB.2.21.2010140842310.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
         <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
         <alpine.DEB.2.21.2010140812370.6186@felia>
         <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
         <alpine.DEB.2.21.2010140829150.6186@felia>
         <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com>
         <alpine.DEB.2.21.2010140842310.6186@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 08:47 +0200, Lukas Bulwahn wrote:
> 
> On Tue, 13 Oct 2020, Joe Perches wrote:
> 
> > On Wed, 2020-10-14 at 08:36 +0200, Lukas Bulwahn wrote:
> > > On Tue, 13 Oct 2020, Joe Perches wrote:
> > > 
> > > > On Wed, 2020-10-14 at 08:21 +0200, Lukas Bulwahn wrote:
> > > > > What does checkpatch.pl warn about and what does clang-format still warn 
> > > > > about, which is generally accepted okay as style in the kernel?
> > > > 
> > > > clang-format doesn't warn at all, it just reformats.
> > > > 
> > > You can run clang-format with --dry-run and then it would just state the 
> > > proposed changes, right?
> > 
> > clang-format through at least version 10 does not have
> > a --dry-run option.
> > 
> > 
> 
> Just a quick check:
> 
> version 9 does not have the --dry-run option:
> 
> https://releases.llvm.org/9.0.0/tools/clang/docs/ClangFormat.html
> 
> version 10 does:
> 
> https://releases.llvm.org/10.0.0/tools/clang/docs/ClangFormat.html

Perhaps some version 10 variants do, but 10.0.0 does not.

$ which clang-format
/usr/local/bin/clang-format
$ clang-format --version
clang-format version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)
$ clang-format --dry-run
clang-format: Unknown command line argument '--dry-run'.  Try: 'clang-format --help'
clang-format: Did you mean '  --debug'?



