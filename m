Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA242824E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgJCO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:59:50 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:35260 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgJCO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:59:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1D589181D3026;
        Sat,  3 Oct 2020 14:59:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2376:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:8531:10004:10400:10450:10455:10848:11026:11232:11658:11914:12295:12296:12297:12663:12740:12760:12895:13069:13095:13255:13311:13357:13439:13972:14659:14721:19904:19999:21080:21433:21451:21611:21627:21990:30012:30045:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: songs04_3112f22271ad
X-Filterd-Recvd-Size: 2739
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Oct 2020 14:59:47 +0000 (UTC)
Message-ID: <b53b75451c7610ec74d15aaec65fb4959d9483b0.camel@perches.com>
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to
 format sysfs output
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Date:   Sat, 03 Oct 2020 07:59:46 -0700
In-Reply-To: <20201003135551.GA3187@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
         <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
         <20200930115740.GA1611809@kroah.com> <202009302108.18B05CA38@keescook>
         <9b57d0d4896a91debc330a70a20ae0f240afbd3b.camel@perches.com>
         <202010021527.DF20CE0@keescook> <20201003135551.GA3187@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-03 at 15:55 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 02, 2020 at 03:30:30PM -0700, Kees Cook wrote:
> > On Wed, Sep 30, 2020 at 09:22:19PM -0700, Joe Perches wrote:
> > > On Wed, 2020-09-30 at 21:17 -0700, Kees Cook wrote:
> > > > On Wed, Sep 30, 2020 at 01:57:40PM +0200, Greg Kroah-Hartman wrote:
> > > > > Kees, and Rafael, I don't know if you saw this proposal from Joe for
> > > > > sysfs files, questions below:
> > > > 
> > > > I'm a fan. I think the use of sprintf() in sysfs might have been one of
> > > > my earliest complaints about unsafe code patterns in the kernel. ;)
> > > []
> > > > > > +	if (WARN(!buf || offset_in_page(buf),
> > > > > > +		 "invalid sysfs_emit: buf:%p\n", buf))
> > > 
> > > The dump_stack() is also going to emit pointers
> > > so I don't see how it does anything but help
> > > show where the buffer was.  It is hashed...
> > 
> > dump_stack() is going to report symbols and register contents.
> > 
> > I was just pointing out that %p has no value here[1]. The interesting
> > states are: "was it NULL?" "how offset was it?". Its actual content
> > won't matter.
> 
> Ok, suggestions for a better error message are always welcome :)

For sysfs_emit, the offset_in_buf test also
effectively checks if buf not PAGE_SIZE so
it helps identify if it is being called from
a non _show function.

That's actually why %p can be somewhat valuable.


