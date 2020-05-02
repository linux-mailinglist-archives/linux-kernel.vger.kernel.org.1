Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2501C21CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEBAKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 20:10:03 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:58482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgEBAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:10:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4F02718224D76;
        Sat,  2 May 2020 00:10:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:4321:5007:6119:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30060:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: desk86_1d52530fcbd4e
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 00:10:01 +0000 (UTC)
Message-ID: <3aac8d7e3f11d7df5b8155c93beee447cf8f064b.camel@perches.com>
Subject: Re: [PATCH 14/14] docs: staging: use small font for literal includes
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 01 May 2020 17:10:00 -0700
In-Reply-To: <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
         <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 17:37 +0200, Mauro Carvalho Chehab wrote:
> The normal font is too big to display 80 columns, causing extra
> breaks to be added at weird places.
> 
> change to the footnotesize, as this would fit a little bit
> better.
[]
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
[]
> @@ -19,17 +19,41 @@ Unsorted Documentation
>  Atomic Types
>  ============
>  
> +.. raw:: latex
> +
> +    \footnotesize

Please don't make the markup too invasive.

> +
>  .. include:: ../atomic_t.txt
>     :literal:
>  
> +.. raw:: latex
> +
> +    \normalsize
> +
>  Atomic bitops
>  =============
>  
> +.. raw:: latex
> +
> +    \footnotesize
> +
>  .. include:: ../atomic_bitops.txt
>     :literal:
>  
> +.. raw:: latex
> +
> +    \normalsize
> +
>  Memory Barriers
>  ===============
>  
> +.. raw:: latex
> +
> +    \footnotesize
> +
>  .. include:: ../memory-barriers.txt
>     :literal:
> +
> +.. raw:: latex
> +
> +    \normalsize

