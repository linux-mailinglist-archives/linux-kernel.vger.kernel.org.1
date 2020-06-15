Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1601F9EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgFORsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 13:48:23 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:41310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbgFORsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:48:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 60AFF180AD393;
        Mon, 15 Jun 2020 17:48:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:967:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2525:2561:2564:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:5007:6117:6119:7875:7903:9025:10004:10400:10848:11658:11914:12043:12114:12297:12740:12760:12895:13019:13069:13311:13357:13439:13845:14096:14097:14181:14659:14721:14764:14819:21080:21433:21451:21627:21772:21939:30054:30060:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thing04_3f0858226df8
X-Filterd-Recvd-Size: 2362
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 17:48:20 +0000 (UTC)
Message-ID: <4e00b2fa91f1f818de4658f2695d4b433852959d.camel@perches.com>
Subject: Re: [PATCH 18/22] docs: trace: ring-buffer-design.txt: convert to
 ReST format
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 10:48:10 -0700
In-Reply-To: <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
         <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 08:50 +0200, Mauro Carvalho Chehab wrote:
> - Just like some media documents, this file is dual licensed
>   with GPL and GFDL. As right now the GFDL SPDX definition is
>   bogus (as it doesn't tell anything about invariant parts),
>   let's not use SPDX here. Let's use, instead, the same test
>   as we have on media.
[]
> diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.rst
> []
> +.. Or, alternatively,
> +..
> +.. b) Permission is granted to copy, distribute and/or modify this
> +..    document under the terms of the GNU Free Documentation License,
> +..    Version 1.1 or any later version published by the Free Software
> +..    Foundation, with no Invariant Sections, no Front-Cover Texts
> +..    and no Back-Cover Texts. A copy of the license is available at
> +..    https://www.gnu.org/licenses/old-licenses/fdl-1.2.html

Use of a version 1.1 reference with a 1.2 link.

Perhaps the link should be:
https://www.gnu.org/licenses/old-licenses/fdl-1.1.html

> +..
> +.. TODO: replace it to GPL-2.0 OR GFDL-1.2-or-later WITH no-invariant-sections

Is there some reason a new GFDL entry has not yet been added
to the LICENSES directory?



