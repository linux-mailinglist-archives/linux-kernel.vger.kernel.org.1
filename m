Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E441D206819
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbgFWXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 19:12:10 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:43652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387709AbgFWXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:12:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 45A69182D3514;
        Tue, 23 Jun 2020 23:12:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2CE9C18080;
        Tue, 23 Jun 2020 23:12:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:4321:5007:6119:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30060:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wool80_25070cf26e3f
X-Filterd-Recvd-Size: 1697
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 23:12:05 +0000 (UTC)
Message-ID: <f47454785a47df6758625d52974753d1a519163d.camel@perches.com>
Subject: Re: [PATCH v2 9/9] docs: staging: use small font for literal
 includes
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Tue, 23 Jun 2020 16:12:04 -0700
In-Reply-To: <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
         <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:53 +0200, Mauro Carvalho Chehab wrote:
> The normal font is too big to display 80 columns, causing extra
> breaks to be added at weird places.
> 
> change to the footnotesize, as this would fit a little bit
> better.
[]
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
[]
> @@ -19,14 +19,41 @@ Unsorted Documentation
>  Atomic Types
>  ============
>  
> -.. literalinclude:: ../atomic_t.txt
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. include:: ../atomic_t.txt
> +   :literal:
> +
> +.. raw:: latex
> +
> +    \normalsize

Is there something like push/pop for styles?
Maybe some variant of include:: with a style?

