Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FC271F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIUJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:48:01 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:47608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgIUJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:48:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 62019182251A2;
        Mon, 21 Sep 2020 09:47:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7514:7576:7903:10004:10400:11026:11232:11473:11658:11914:12043:12297:12740:12895:13255:13439:13894:14181:14659:14721:21080:21433:21451:21627:21819:30003:30022:30026:30029:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wind22_0914db627144
X-Filterd-Recvd-Size: 3631
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Sep 2020 09:47:58 +0000 (UTC)
Message-ID: <984edba5dae45d5b5a9b8381f6164423380037d7.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 21 Sep 2020 02:47:57 -0700
In-Reply-To: <alpine.DEB.2.21.2009210921520.7483@felia>
References: <20200920091706.56276-1-dwaipayanray1@gmail.com>
         <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com>
         <CABJPP5Chm2xd2PW77=Ru9t4C6Yvq3SyEmr1gKsaQGyF5AxRVfA@mail.gmail.com>
         <52ccb41c8922dda44ac325f2f3e09f81f1936611.camel@perches.com>
         <alpine.DEB.2.21.2009210921520.7483@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-21 at 09:39 +0200, Lukas Bulwahn wrote:
> On Sun, 20 Sep 2020, Joe Perches wrote:
> > On Sun, 2020-09-20 at 21:52 +0530, Dwaipayan Ray wrote:
[]
> > > For example, Lukas checked commits between v5.4 and
> > > v5.8 and he found:
> > >     175 Missing Signed-off-by: line by nominal patch authorrep
> > >     'Daniel Vetter <daniel.vetter@ffwll.ch>'
> > > 
> > > Infact in all of those commits he signed off using a different
> > > mail, Daniel Vetter <daniel.vetter@intel.com>.
> > > 
> > > So is it possible to resolve these using perhaps .mailmap
> > > entries? Or should only the name mismatch part be better
> > > handled? Or perhaps both?
> > 
> > Dunno.  It certainly can be improved...
> > Try adding some more logic and see what you come up with.
> > 
> > btw:
> > 
> > The most frequent NO_AUTHOR_SIGN_OFF messages for v5.7..v5.8 are
> > 
> >      98 WARNING: From:/SoB: email address mismatch: 'From: Daniel Vetter <daniel.vetter@ffwll.ch>' != 'Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>'
> >      24 WARNING: From:/SoB: email address mismatch: 'From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>' != 'Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>'
> >      19 WARNING: From:/SoB: email address mismatch: 'From: Wolfram Sang <wsa+renesas@sang-engineering.com>' != 'Signed-off-by: Wolfram Sang <wsa@kernel.org>'
> >      11 WARNING: From:/SoB: email address mismatch: 'From: Luke Nelson <lukenels@cs.washington.edu>' != 'Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>'
> >       8 WARNING: From:/SoB: email address mismatch: 'From: Christophe Leroy <christophe.leroy@c-s.fr>' != 'Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>'
> >       6 WARNING: From:/SoB: email address mismatch: 'From: Davidlohr Bueso <dave@stgolabs.net>' != 'Signed-off-by: Davidlohr Bueso <dbueso@suse.de>'
> >       5 WARNING: Missing Signed-off-by: line by nominal patch author '"Paul A. Clarke" <pc@us.ibm.com>'
> >       4 WARNING: Missing Signed-off-by: line by nominal patch author 'Huang Ying <ying.huang@intel.com>'
> >       3 WARNING: Missing Signed-off-by: line by nominal patch author '"Stephan Müller" <smueller@chronox.de>'
[]
> I hope Dwaipayan can come up with a '.AUTHOR_SIGN_OFF.mailmap' file that 
> we can use to distinguish the known developers that knowingly and 
> intentionally use different identities vs. the 'newbies' that should 
> validly be warned.

I hope not.  One .mailmap should be enough.


