Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E12422E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 19:47:40 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59418 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgHKXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:47:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E6ABC18027463;
        Tue, 11 Aug 2020 23:47:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4184:4321:4605:5007:8985:9025:10004:10400:10481:10848:11026:11232:11658:11914:12043:12291:12296:12297:12555:12679:12683:12740:12760:12895:12986:13069:13311:13357:13439:14095:14096:14180:14181:14659:14721:19900:21060:21080:21451:21627:21749:21811:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hose67_3c0d1e026fe6
X-Filterd-Recvd-Size: 1725
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 23:47:37 +0000 (UTC)
Message-ID: <98383342041c87a8d50fe9cef486a687c50af248.camel@perches.com>
Subject: Re: [PATCH 0/3] mtd: lpddr: Fix bad logic bug in print_drs_error
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Date:   Tue, 11 Aug 2020 16:47:36 -0700
In-Reply-To: <cover.1588013366.git.gustavo@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:00 -0500, Gustavo A. R. Silva wrote:
> Hi,
> 
> This series aims to fix a bad logic bug in print_drs_error, which is
> tagged for -stable.  The series also include some formatting fixups.

AFAICT: This series is still not applied to any tree.

Can someone please apply it?

https://lore.kernel.org/linux-mtd/cover.1588016644.git.gustavo@embeddedor.com/

> Thanks
> 
> Gustavo A. R. Silva (3):
>   mtd: lpddr: Fix bad logic in print_drs_error
>   mtd: lpddr: Replace printk with pr_notice
>   mtd: lpddr: Move function print_drs_error to lpddr_cmds.c
> 
>  drivers/mtd/lpddr/lpddr_cmds.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/pfow.h       | 32 --------------------------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
> 

