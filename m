Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0193A2AAAB7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 12:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgKHLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 06:36:57 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:45246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgKHLg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 06:36:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D0F4E100E7B42;
        Sun,  8 Nov 2020 11:36:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3866:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:5007:7514:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21627:21660:21811:21819:21939:30022:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: deer22_2f0d14d272e3
X-Filterd-Recvd-Size: 1582
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Nov 2020 11:36:54 +0000 (UTC)
Message-ID: <87be917b79ca49d71366f553795da0cc81875c24.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        yashsri421@gmail.com
Date:   Sun, 08 Nov 2020 03:36:53 -0800
In-Reply-To: <20201108100632.75340-1-dwaipayanray1@gmail.com>
References: <20201108100632.75340-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-08 at 15:36 +0530, Dwaipayan Ray wrote:
> checkpatch doesn't report warnings for many common mistakes
> in emails. Some of which are trailing commas and incorrect
> use of email comments.

(just in case link to parent emailed patch for Andrew)

https://lore.kernel.org/lkml/20201108100632.75340-1-dwaipayanray1@gmail.com/T/#u

Thanks Dwaipayan.

Acked-by: Joe Perches <joe@perches.com>

> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---

You should start to add changelog blocks to these
versioned patches so it's easier to look for what
changed between versions.

here...

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl

etc...


