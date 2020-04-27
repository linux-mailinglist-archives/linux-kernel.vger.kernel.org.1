Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC361B977B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD0GdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 02:33:06 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:33794 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:33:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 08A06100E7B45;
        Mon, 27 Apr 2020 06:33:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4250:4321:4605:5007:7903:9040:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13071:13072:13311:13357:13439:14096:14097:14180:14181:14659:14721:14777:21060:21080:21433:21627:21660:21740:21819:30022:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shape82_1aade746dd105
X-Filterd-Recvd-Size: 2237
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 06:33:03 +0000 (UTC)
Message-ID: <79ade7bc8ce57ef11f94011bad1842372c61fdd7.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add email addresses from .yaml files
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Sun, 26 Apr 2020 23:33:02 -0700
In-Reply-To: <20200427055755.GA21898@ravnborg.org>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
         <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
         <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
         <20200427055755.GA21898@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 07:57 +0200, Sam Ravnborg wrote:
> Hi Joe.

Hi Sam.

> On Sun, Apr 26, 2020 at 10:40:52PM -0700, Joe Perches wrote:
> > .yaml files can contain maintainer/author addresses and it seems
> > unlikely or unnecessary that individual MAINTAINER file section
> > entries for each .yaml file will be created.
> > 
> > So dd the email addresses found in .yaml files to the default
>      ^
>      add

Andrew, can you add the a to this please?

> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Tested-by: Sam Ravnborg <sam@ravnborg.org>
> 
> The patch did not apply on top of -rc3, but it was trivial to fix.
> Tested and works like a charm.
> Thanks for doing this!

As most of my patches, it was done using -next

cheers, Joe

