Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0801427EA77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgI3N67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:58:59 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:44606 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729903AbgI3N67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:58:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5D77A100E7B48;
        Wed, 30 Sep 2020 13:58:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4886:5007:8985:9025:10004:10400:10848:11232:11658:11914:12043:12266:12295:12297:12438:12555:12663:12740:12760:12895:12986:13018:13019:13069:13255:13311:13357:13439:13845:14181:14659:14721:21080:21347:21365:21451:21627:21749:21811:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brass29_5e1495327193
X-Filterd-Recvd-Size: 1774
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 13:58:54 +0000 (UTC)
Message-ID: <1a9cac491e1813b94cde3bed67d642f52cd81e7d.camel@perches.com>
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to
 format sysfs output
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Date:   Wed, 30 Sep 2020 06:58:53 -0700
In-Reply-To: <20200930115740.GA1611809@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
         <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
         <20200930115740.GA1611809@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 13:57 +0200, Greg Kroah-Hartman wrote:
> Kees, and Rafael, I don't know if you saw this proposal from Joe for
> sysfs files, questions below:

https://lore.kernel.org/linux-pm/5d606519698ce4c8f1203a2b35797d8254c6050a.1600285923.git.joe@perches.com/T/

> So I guess I'm asking for another developer to at least agree that this
> feels like the right way forward here.  I don't want to start down this
> path, only to roll them all back as it feels like pointless churn.

https://lore.kernel.org/lkml/c256eba42a564c01a8e470320475d46f@AcuMS.aculab.com/T/#mb40d265bc1dabb8bb64b0dfa29dd8eda44be056e




