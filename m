Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE31628503E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJFQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:56:38 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:36932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgJFQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:56:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BDBD763D;
        Tue,  6 Oct 2020 16:56:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:1963:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4321:4362:5007:6117:6742:6743:7901:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30054:30060:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: juice93_3f08596271c8
X-Filterd-Recvd-Size: 2140
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 16:56:32 +0000 (UTC)
Message-ID: <1c2595d8df301b1e7f42a6f0093321a41bfea825.camel@perches.com>
Subject: Re: [PATCH v5 00/52] Fix html build with Sphinx  3.1 and above
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jakub Kicinski <kuba@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Sean Young <sean@mess.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 06 Oct 2020 09:56:31 -0700
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 16:02 +0200, Mauro Carvalho Chehab wrote:
> This series add proper support for Sphinx 3.1 and above for building the html docs.

Thanks Mauro.

I do like how the source docs are simplified for human reading
instead of having to mentally skip useless markup notations.


