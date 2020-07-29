Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1B2316B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgG2AYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 20:24:53 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:35608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728236AbgG2AYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:24:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 157F1100E7B40;
        Wed, 29 Jul 2020 00:24:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2565:2682:2685:2743:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:7514:7809:9010:9025:9072:10004:10049:10400:10848:10946:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:13846:14181:14659:14721:14764:21080:21451:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hat27_0201f6926f6e
X-Filterd-Recvd-Size: 1546
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Jul 2020 00:24:50 +0000 (UTC)
Message-ID: <c4cb56cca7928f92d642aef467244db434bff26f.camel@perches.com>
Subject: Re: [PATCH] staging/speakup: Move out of staging
From:   Joe Perches <joe@perches.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org
Date:   Tue, 28 Jul 2020 17:24:47 -0700
In-Reply-To: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
References: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 23:12 +0200, Samuel Thibault wrote:
> The nasty TODO items are done.

Nice.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -16077,6 +16077,15 @@ Q:	https://patchwork.kernel.org/project/linux-sparse/list/
>  B:	https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools
>  F:	include/linux/compiler.h
>  
> +SPEAKUP CONSOLE SPEECH DRIVER
> +M:	William Hubbs <w.d.hubbs@gmail.com>
> +M:	Chris Brannon <chris@the-brannons.com>
> +M:	Kirk Reiser <kirk@reisers.ca>
> +M:	Samuel Thibault <samuel.thibault@ens-lyon.org>
> +L:	speakup@linux-speakup.org
> +W:	http://www.linux-speakup.org/
> +F:	drivers/accessibility/speakup/

S:? 	Supported / Maintained / Odd Fixes ?


