Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78871A5F70
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgDLRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgDLRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:05:06 -0400
Received: from smtprelay.hostedemail.com (smtprelay0242.hostedemail.com [216.40.44.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B81C0A3BF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 09:58:53 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 71D88100E7B40;
        Sun, 12 Apr 2020 16:58:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3653:3865:3867:3872:3873:4321:5007:6119:6691:7514:7903:9010:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30060:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bag70_6a529ded9e51b
X-Filterd-Recvd-Size: 1544
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Apr 2020 16:58:50 +0000 (UTC)
Message-ID: <ac67c70345464efd347d56267d6748064131f7e2.camel@perches.com>
Subject: Re: [PATCH] Staging: comedi: drivers: jr3_pci: fixed two warnings
From:   Joe Perches <joe@perches.com>
To:     carlosteniswarrior@gmail.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 12 Apr 2020 09:56:44 -0700
In-Reply-To: <20200412142508.327-1-carlosteniswarrior@gmail.com>
References: <20200412142508.327-1-carlosteniswarrior@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-12 at 16:25 +0200, carlosteniswarrior@gmail.com wrote:
> Fixed two checkpatch warnings.

by introducing compiler errors.

> diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
[]
> @@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
>  };
 
>  union jr3_pci_single_range {
> -	struct comedi_lrange l;
> -	char _reserved[offsetof(struct comedi_lrange, range[1])];
> +	const comedi_lrange l;
> +	char _reserved[offsetof(const comedi_lrange, range[1])];
>  };

try this:

$ make allyesconfig
$ make drivers/staging/comedi/drivers/jr3_pci.o

_always_ compile the files modified by your patch before
you post it to a mailing list or submit it to a maintainer.


