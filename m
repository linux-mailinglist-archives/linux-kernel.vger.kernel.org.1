Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40D62B85C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKRUjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:39:04 -0500
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:40624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgKRUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:39:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5397E180A885F;
        Wed, 18 Nov 2020 20:39:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4184:4321:4605:5007:6119:7903:10004:10400:10848:11232:11233:11658:11783:11914:12043:12296:12297:12555:12663:12679:12740:12895:13439:13894:14180:14181:14659:14721:21060:21080:21433:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ghost41_0b0b22e2733d
X-Filterd-Recvd-Size: 4652
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 20:39:01 +0000 (UTC)
Message-ID: <c69f32af186d672c9370750985914b889f6a5b14.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 18 Nov 2020 12:39:00 -0800
In-Reply-To: <CABJPP5DTBkuzEjs28wufdnOXf61-T=wtoZWiTya_idXfJ92eNQ@mail.gmail.com>
References: <20201118124035.96976-1-dwaipayanray1@gmail.com>
         <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
         <CABJPP5CqKjY3_mfkJEsHX_8Zc7q1TRCgA4T54sTEZBiKgPS+OQ@mail.gmail.com>
         <754e240d1c88274ce2d94a5b6dbcfff1cc8c9508.camel@perches.com>
         <CABJPP5CHofzA46FHe3eJrgjQBTcaoCkR=dc29xxK80oFZJVfoQ@mail.gmail.com>
         <12b44d3a477de314320dc9d26b26576875525f27.camel@perches.com>
         <CABJPP5DTBkuzEjs28wufdnOXf61-T=wtoZWiTya_idXfJ92eNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-19 at 01:52 +0530, Dwaipayan Ray wrote:
> On Thu, Nov 19, 2020 at 1:28 AM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-11-19 at 00:15 +0530, Dwaipayan Ray wrote:
> > > On Thu, Nov 19, 2020 at 12:09 AM Joe Perches <joe@perches.com> wrote:
> > > > On Thu, 2020-11-19 at 00:03 +0530, Dwaipayan Ray wrote:
> > > > > On Wed, Nov 18, 2020 at 11:44 PM Joe Perches <joe@perches.com> wrote:
> > > > > > On Wed, 2020-11-18 at 18:10 +0530, Dwaipayan Ray wrote:
> > > > > > > Brace style misuses of the following types are now
> > > > > > > corrected:
> > > > > > []
> > > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > > []
> > > > > > > @@ -3937,9 +3937,23 @@ sub process {
> > > > > > >                       #print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
> > > > > > > 
> > > > > > >                       if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
> > > > > > > -                             ERROR("OPEN_BRACE",
> > > > > > > -                                   "that open brace { should be on the previous line\n" .
> > > > > > > -                                     "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
> > > > > > > +                             if (ERROR("OPEN_BRACE",
> > > > > > > +                                       "that open brace { should be on the previous line\n" .
> > > > > > > +                                             "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
> > > > > > > +                                 $fix) {
> > > > > > > +                                     my $line1 = $rawlines[$ctx_ln - 2];
> > > > > > 
> > > > > > How are you sure that in a patch context this line always starts with /^\+/ ?
> > > > > 
> > > > > Hi,
> > > > > I followed it from the other fixes for OPEN_BRACE which were already
> > > > > there. In the patch context if the lines are added then only I think the fix
> > > > > should be triggered. Other instances should not be modified.
> > > > 
> > > > As far as I know there are no existing uses of --fix with OPEN_BRACE.
> > > > 
> > > 
> > > I think you added it via 8d1824780f2f1 ("checkpatch: add --fix option
> > > for a couple OPEN_BRACE misuses")
> > 
> > The difference here is that you are dealing with a $stat context and
> > the existing --fix entries are just for single line fixes.
> > 
> 
> Hi,
> Ya I understand that. Though I am dealing with $stat content,
> I am also directly accessing $rawlines here.
> So I think that should have the proper patch line format, starting
> with + or - or so.
> 
> So in this case if the error is triggered, checking for /^+/ should be done
> becase it would be wrong to fix the others with /^[- ]/
> 
> Is there something else that I am not getting here?

$stat does not include lines that are skipped if the lines start with -

Patch context may be:

line	content

1		func(...
2	-	     original arguments);
3	+	     changed);

where $stat does not include the 'original arguments' changed line

	func(...,
	     changed);

but the $rawlines[] entries are consecutive.

Anyway, this needs to be handled very carefully if handled at all.

I think it's easier to avoid handling these cases and let the
patch submitter fix it manually if appropriate.

