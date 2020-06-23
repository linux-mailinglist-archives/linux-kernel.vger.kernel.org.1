Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F482049F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 08:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFWGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 02:32:23 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:58798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730645AbgFWGcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:32:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9B796180A7FDA;
        Tue, 23 Jun 2020 06:32:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3867:3868:3872:4321:5007:6119:7514:7901:7903:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21809:21819:30003:30054:30062:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: gold31_1f13a3726e39
X-Filterd-Recvd-Size: 1435
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 06:32:20 +0000 (UTC)
Message-ID: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: use my kernel.org address
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:32:19 -0700
In-Reply-To: <20200623061138.14694-1-jslaby@suse.cz>
References: <20200623061138.14694-1-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 08:11 +0200, Jiri Slaby wrote:
> There were enough problems with suse.{com,cz} MTAs recently. I am bored
> by restoring lost e-mails from public archives. Let's switch (all) my
> MAINTAINERS addresses to @kernel.org and forward it there as I wish.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -2881,7 +2881,7 @@ S:	Supported
>  F:	drivers/net/wireless/ath/*
>  
>  ATHEROS ATH5K WIRELESS DRIVER
> -M:	Jiri Slaby <jirislaby@gmail.com>
> +M:	Jiri Slaby <jirislaby@kernel.org>
[]
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> -M:	Jiri Slaby <jslaby@suse.com>
> +M:	Jiri Slaby <jirislaby@kernel.org>

Add .mailmap entries as well?


