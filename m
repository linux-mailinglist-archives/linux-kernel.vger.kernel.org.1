Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD9D278B10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIYOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:39:44 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37110 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:39:44 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4B1EC80682;
        Fri, 25 Sep 2020 16:39:39 +0200 (CEST)
Date:   Fri, 25 Sep 2020 16:39:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Message-ID: <20200925143937.GA1929717@ravnborg.org>
References: <20200918100812.1447443-1-arnd@arndb.de>
 <20200918124808.GD438822@phenom.ffwll.local>
 <20200924205436.GP1223313@ravnborg.org>
 <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=7mFfxD536KHiRXcuot4A:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 01:31:51PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 24, 2020 at 10:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Daniel/Arnd.
> >
> > On Fri, Sep 18, 2020 at 02:48:08PM +0200, Daniel Vetter wrote:
> > > On Fri, Sep 18, 2020 at 12:08:10PM +0200, Arnd Bergmann wrote:
> > > > The fbdev code uses compat_alloc_user_space in a few of its
> > > > compat_ioctl handlers, which tends to be a bit more complicated
> > > > and error-prone than calling the underlying handlers directly,
> > > > so I would like to remove it completely.
> > > >
> > > > This modifies two such functions in fbdev, and removes another
> > > > one that is completely unused.
> > > >
> > > >     Arnd
> > > >
> > > > Arnd Bergmann (3):
> > > >   fbdev: simplify fb_getput_cmap()
> > > >   fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
> > > >   fbdev: sbuslib: remove compat_alloc_user_space usage
> > >
> > > Looks all good, but we're also kinda looking for a new volunteer for
> > > handling fbdev patches ... drm-misc commit rights, still not interested?
> >
> > Hi Daniel - I read the above as an a-b. And Arnd did not take the bait
> > it seems.
> 
> Ah right, I meant to reply but then forgot about it.
> 
> I don't really want commit access, thanks for the offer.
> 
> > Hi Arnd. checkpatch complained about some whitespace, which I fixed
> > while applying.
> > Will push to drm-misc-next tomorrow unless I hear anything else.
> 
> Great, thanks!
Pushed now.

	Sam

