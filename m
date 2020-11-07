Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4702AA279
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 06:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKGFJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 00:09:44 -0500
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:50470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgKGFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 00:09:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D0EC1182CED28;
        Sat,  7 Nov 2020 05:09:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2693:2736:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3872:3873:3874:4184:4321:4605:5007:7903:8526:10004:10400:10848:11232:11658:11783:11889:11914:12043:12297:12740:12895:13439:13894:14180:14181:14659:14721:21060:21080:21433:21451:21627:21660:21740:21741:21819:30003:30022:30029:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: card60_151077e272d8
X-Filterd-Recvd-Size: 3142
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Nov 2020 05:09:41 +0000 (UTC)
Message-ID: <8c642098bbbc92e7c56201184091a97c7b58d073.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Date:   Fri, 06 Nov 2020 21:09:39 -0800
In-Reply-To: <CABJPP5Dyc4iK-3f-N1eKF9sPZhpr6A92PA1rFo1rx+9qvO10zQ@mail.gmail.com>
References: <20201106214530.367247-1-dwaipayanray1@gmail.com>
         <38c2889ad15c0f34ce8c223518f1f6dbc9945286.camel@perches.com>
         <CABJPP5Dyc4iK-3f-N1eKF9sPZhpr6A92PA1rFo1rx+9qvO10zQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-07 at 10:11 +0530, Dwaipayan Ray wrote:
> On Sat, Nov 7, 2020 at 3:34 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Sat, 2020-11-07 at 03:15 +0530, Dwaipayan Ray wrote:
> > > checkpatch doesn't report warnings for many common mistakes
> > > in emails. Some of which are trailing commas and incorrect
> > > use of email comments.
> > 
> > Assuming it all works, this looks good.  I haven't tested it.
> > 
> > How did you test the $fix bits?
> > 
> Hi,
> I actually dumped about 17k unique emails from git log, put it in one of
> my previous patches, and ran checkpatch with --fix on it.
> I checked the diff and most of the cases looked pretty good to me.
> I could send the diff output if you like?

Please.  Likely just to me as I imagine it's not interesting to most.
 
> > Trivial notes:
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > +                             # stable@vger.kernel.org or stable@kernel.org shouldn't
> > > +                             # have an email name. In addition commments should strictly
> > > +                             # begin with a #
> > > +                             if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/) {
> > 
> > Likely better to test with a case insensitive match so
> > STABLE@vger.kernel.org and such are still warned.
> 
> Sure, I will do that.
> > 
> >                                 if ($email =~ /\bstable\@(?:vger\.)?kernel\.org\b/i) {
> > 
> > > +                                     if ($sign_off =~ /cc:$/i && (($comment ne "" && $comment !~ /^#.+/) ||
> > > +                                         ($email_name ne ""))) {
> > 
> > > > $sign_off !~ /^cc:/i ?
> 
> I actually had a doubt about that one. Only the stable address with
> Cc: should be checked right? Or something else?

yes.
 
> What about those stable addresses with tags other than Cc: ? Should
> a change be suggested?

Ideally yes, but there were very few of those in the git commit
history so it's probably not a big deal one way or another.


