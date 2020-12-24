Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CBB2E2860
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLXR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 12:27:59 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:37530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbgLXR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 12:27:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CE9E818026208;
        Thu, 24 Dec 2020 17:27:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3350:3622:3865:3868:3871:3873:4321:5007:7652:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: war02_5e115fe27473
X-Filterd-Recvd-Size: 1406
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Dec 2020 17:27:16 +0000 (UTC)
Message-ID: <c4ad08aeb9ed8e3f8bfaedc3e9e0df245d4a93a3.camel@perches.com>
Subject: Re: [PATCH] staging: ralink-gdma: Fixed blank line coding style
 issue
From:   Joe Perches <joe@perches.com>
To:     Ayoub Soussi <ayoubfme@gmail.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Dec 2020 09:27:15 -0800
In-Reply-To: <20201223202230.31325-1-ayoubfme@gmail.com>
References: <20201223202230.31325-1-ayoubfme@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-23 at 21:22 +0100, Ayoub Soussi wrote:
> Fixed coding style issue.
[]
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
[]
> @@ -122,6 +122,7 @@ struct gdma_dma_dev {
>  	struct gdma_data *data;
>  	void __iomem *base;
>  	struct tasklet_struct task;
> +
>  	volatile unsigned long chan_issued;
>  	atomic_t cnt;

This is presumably a checkpatch false positive.
checkpatch is not now nor never will be a perfect tool.

Please consider what you are doing and what the desired coding style is
before submitting patches.

