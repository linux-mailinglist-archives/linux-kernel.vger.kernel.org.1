Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601691A52EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgDKQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 12:39:16 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:43110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbgDKQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:39:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5FD0718029126;
        Sat, 11 Apr 2020 16:39:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3872:4321:4385:5007:6691:10004:10400:10848:11026:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: songs44_1699a1ced6313
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 16:39:15 +0000 (UTC)
Message-ID: <16239d86d8177e70f15aab5e7dca61758a749fb0.camel@perches.com>
Subject: Re: [trivial PATCH] um virtio: Neaten vu_err macro definition
From:   Joe Perches <joe@perches.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Erel Geron <erelx.geron@intel.com>, linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Apr 2020 09:37:10 -0700
In-Reply-To: <ba7b958fda7c42e10fded7b158e892e2dfb06494.camel@perches.com>
References: <ba7b958fda7c42e10fded7b158e892e2dfb06494.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 09:28 -0700, Joe Perches wrote:
> Defining a macro with ... and __VA_ARGS__ (without ##) can cause
> compilation errors if a macro use does not have additional args.
> 
> Add ## to __VA_ARGS__ in the macro definition.
[]
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
[]
> @@ -74,7 +74,7 @@ struct virtio_uml_vq_info {
>  
>  extern unsigned long long physmem_size, highmem;
>  
> -#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, __VA_ARGS__)
> +#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)

Ignore this.  Caffeine-free so far this morning.

It _might_ be better as:

#define vu_err(vu_dev, fmt, ...)	dev_err(&(vu_dev)->pdev->dev, fmt, ##__VA_ARGS__)


