Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC121CB10
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgGLTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 15:07:50 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:36418 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729122AbgGLTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 15:07:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 55523182CED34;
        Sun, 12 Jul 2020 19:07:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3743:3865:3866:3867:3868:3871:3873:3874:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14659:14721:21060:21080:21324:21433:21451:21627:21740:21990:30012:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: smile07_53128a526ee2
X-Filterd-Recvd-Size: 2996
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Jul 2020 19:07:46 +0000 (UTC)
Message-ID: <bc58f9b3f11c5da224187fac0eba33f769d0fb45.camel@perches.com>
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
From:   Joe Perches <joe@perches.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Sun, 12 Jul 2020 12:07:45 -0700
In-Reply-To: <20200712185416.GC12262@blackclown>
References: <cover.1594136880.git.usuraj35@gmail.com>
         <20200710175643.GF17565@ravnborg.org> <20200711151126.GA12262@blackclown>
         <04ce5199522b4136909fa4926282b7da8abddc4a.camel@perches.com>
         <20200712185416.GC12262@blackclown>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-13 at 00:24 +0530, Suraj Upadhyay wrote:
> On Sat, Jul 11, 2020 at 11:16:33AM -0700, Joe Perches wrote:
[]
> > Perhaps change the __drm_printk macro to not
> > dereference the drm argument when NULL.
> > 
> > A trivial but perhaps inefficient way might be
> > used like:
> > 
> > 	drm_<level>(NULL, fmt, ...)
[]
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
[]
> > @@ -395,8 +395,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
> >  
> >  /* Helper for struct drm_device based logging. */
> >  #define __drm_printk(drm, level, type, fmt, ...)			\
> > -	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> > -
> > +	dev_##level##type((drm) ? (drm)->dev : NULL, "[drm] " fmt,	\
> > +			  ##__VA_ARGS__)
> >  
> >  #define drm_info(drm, fmt, ...)					\
> >  	__drm_printk((drm), info,, fmt, ##__VA_ARGS__)
> > 
> 
> Hi Joe,
> 	Thanks for your input.
> But I don't think that this change would be a good idea as we are
> supposed to find or make a substitute of WARN_* macros which
> take a `condition` as an argument and check for its truth.
> And I guess passing a NULL to dev_<level> would cause a format warning.
> 
> Also, the WARN_* macros are doing their job fine, and passing a NULL
> value everytime you want to warn about a certain condition at a
> particular line, doesn't seem good to me.
> 
> Thus, I think that WARN_* macros should be untouched.

So do I but the suggestion was not about WARN macros
only about drm_<level> macros and possibly unnecessary
conversions to dev_<level> when a drm_device context
is unavailable.

Also, you don't have to guess, the code is there for
you to inspect.

dev_<level> when a NULL is used as the first argument
emits "(NULL device *)" instead of dev_driver_string(dev)
and dev_name(dev).

See: drivers/base/core.c::__dev_printk()


