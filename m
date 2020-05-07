Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C61C82E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgEGGze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 02:55:34 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:36912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGGze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:55:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 643B412F5C;
        Thu,  7 May 2020 06:55:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3872:3874:4321:5007:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21212:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mass87_4d4fdba8e3930
X-Filterd-Recvd-Size: 2187
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:55:31 +0000 (UTC)
Message-ID: <777550697e44478c46768db5265dcdda094932f4.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
From:   Joe Perches <joe@perches.com>
To:     christian.koenig@amd.com, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Guchun Chen <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Dennis Li <Dennis.Li@amd.com>
Date:   Wed, 06 May 2020 23:55:30 -0700
In-Reply-To: <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
References: <20200505140208.284473-1-arnd@arndb.de>
         <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
         <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 08:42 +0200, Christian König wrote:
> Am 06.05.20 um 21:01 schrieb Joe Perches:
[]
> > And trivia:
> > 
> > The !! uses with bool seem unnecessary and it's probably better
> > to make amdgpu_ras_is_feature_enabled to return bool.
[]
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
[]
> > @@ -560,7 +560,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
> >   	 */
> >   	if (!amdgpu_ras_is_feature_allowed(adev, head))
> >   		return 0;
> > -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> > +	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
> 
> And while we are at improving coding style I think that writing this as 
> "if (enabled == amdgpu_ras_is_feature_enabled(adev, head))" would be 
> much more readable.

<blink, chuckle> that's decidedly true...


