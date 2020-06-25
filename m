Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6F20A5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406397AbgFYT31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 15:29:27 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:42782 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405229AbgFYT3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:29:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A7FD918029150;
        Thu, 25 Jun 2020 19:29:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3868:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:6742:7510:7901:7903:8985:9010:9025:10004:10400:10429:10430:10431:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:19903:19997:21080:21627:30029:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:9,LUA_SUMMARY:none
X-HE-Tag: birth58_380ea7a26e4f
X-Filterd-Recvd-Size: 2403
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 19:29:20 +0000 (UTC)
Message-ID: <026b38ff947e338a468567dfd20fbde1419bb094.camel@perches.com>
Subject: Re: [PATCH] platform/chrome: Clarify SPDX license with GPL-2.0-only
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Crews <ncrews@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yicheng Li <yichengli@chromium.org>
Date:   Thu, 25 Jun 2020 12:29:19 -0700
In-Reply-To: <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
References: <20200625170356.225136-1-enric.balletbo@collabora.com>
         <CAHp75VdY4TEKfZXDb-f-KC4G2XRJOdB-w4vegSWG9vULLqcUKw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 22:06 +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2020 at 9:25 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > Remove the ambiguity with GPL-2.0 and use an explicit GPL-2.0-only
> > tag.
> 
> Is there any? Last time IIRC Greg told me that in the kernel the old
> and new variants are okay.

If there wasn't any ambiguity, the older license
style wouldn't be deprecated by SPDX.org.

https://spdx.org/licenses/GPL-2.0.html

Deprecated
This license has been deprecated since license list version 3.0.
Full name

GNU General Public License v2.0 only
Short identifier

GPL-2.0


