Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C575283F82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgJETVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:21:54 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:45442 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgJETVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:21:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CDE0518224D77;
        Mon,  5 Oct 2020 19:21:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:4250:4321:5007:7903:8784:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21324:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wall78_50031f1271c0
X-Filterd-Recvd-Size: 1640
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 19:21:52 +0000 (UTC)
Message-ID: <714e5d92d8b9f3ba365ec0cabf1406ea1a847d69.camel@perches.com>
Subject: Re: [PATCH] sound: sparc: dbri: fix repeated word 'the'
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Date:   Mon, 05 Oct 2020 12:21:51 -0700
In-Reply-To: <20201005191234.12715-1-rdunlap@infradead.org>
References: <20201005191234.12715-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 12:12 -0700, Randy Dunlap wrote:
> Drop the duplicated word "the".
[]
> --- lnx-59-rc8.orig/sound/sparc/dbri.c
> +++ lnx-59-rc8/sound/sparc/dbri.c
> @@ -620,7 +620,7 @@ A circular command buffer is used here.
>  while another can be executed. The scheme works by adding two WAIT commands
>  after each sent batch of commands. When the next batch is prepared it is
>  added after the WAIT commands then the WAITs are replaced with single JUMP
> -command to the new batch. The the DBRI is forced to reread the last WAIT
> +command to the new batch. The DBRI is forced to reread the last WAIT

Maybe Then the?

>  command (replaced by the JUMP by then). If the DBRI is still executing
>  previous commands the request to reread the WAIT command is ignored.
>  

