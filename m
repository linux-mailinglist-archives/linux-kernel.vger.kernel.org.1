Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952E327A1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0QpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 12:45:24 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:59620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbgI0QpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 12:45:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7ECF818225E17;
        Sun, 27 Sep 2020 16:45:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3873:3874:4321:5007:6691:7264:7576:7875:9545:10004:10400:10848:11232:11658:11914:12043:12295:12297:12683:12740:12760:12895:13069:13071:13095:13161:13229:13311:13357:13439:14110:14180:14659:14721:14777:21060:21080:21433:21451:21627:21819:21939:30022:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: gate88_5f0387d2717a
X-Filterd-Recvd-Size: 1695
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 16:45:20 +0000 (UTC)
Message-ID: <4bff3adc94d909be7132151b1af211ed862b4126.camel@perches.com>
Subject: Re: [PATCH v2] Staging: nvec: nvec: fix double next comment
From:   Joe Perches <joe@perches.com>
To:     Ryan Kosta <ryanpkosta@gmail.com>, gregkh@linuxfoundation.org
Cc:     marvin24@gmx.de, p.zabel@pengutronix.de, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 27 Sep 2020 09:45:19 -0700
In-Reply-To: <20200927163504.7546-1-ryanpkosta@gmail.com>
References: <20200927163504.7546-1-ryanpkosta@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-27 at 09:35 -0700, Ryan Kosta wrote:
> Changes since v1:
>  * Made commit message more clear
>  * Added description
> Note: previous patch named
>  "[PATCH] fix double next comment in drivers/staging/nvec/nvec.c"
> > 8------------------------------------------------------8<
> Fixes a comment typo.

Hi Ryan.

That comment should be _below_ the --- separator line

There's no need to double the nvec: word in the subject either.
And please use the imperative.

So the email message should look something like:

---------------------------------------------------------

From: <you>

Subject: [PATCH V2] staging: nvec: Remove repeated word typo in a comment

Fix a comment typo.

Signed-off-by: <you>
---

V2: Add a commit description

<patch>


