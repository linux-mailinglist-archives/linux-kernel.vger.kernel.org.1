Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54CE30203D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 03:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAYCSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 21:18:16 -0500
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:50150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbhAYCBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 21:01:43 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id A4A9F1801EE95
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:00:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E5A08180A8135;
        Mon, 25 Jan 2021 01:59:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:6119:6690:7652:7903:10004:10400:11232:11658:11914:12295:12297:12663:12679:12740:12760:12895:13019:13069:13095:13141:13230:13311:13357:13439:14096:14097:14659:14721:14777:14819:21080:21433:21450:21611:21627:21795:21819:30022:30025:30051:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fish12_580090327581
X-Filterd-Recvd-Size: 2092
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jan 2021 01:59:16 +0000 (UTC)
Message-ID: <53c071a4fc34b1bf5a655cc468837b4fbe6f6787.camel@perches.com>
Subject: Re: Anyone have ideas for checkpatch improvements ?
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Sun, 24 Jan 2021 17:59:15 -0800
In-Reply-To: <08ee32211e8b40234257a236c842a7be6703144c.camel@perches.com>
References: <08ee32211e8b40234257a236c842a7be6703144c.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the linux-mentees, Dwaipayan Ray, asked me in a private
email for ideas for improvements to checkpatch.

Though I am not his nominal mentor, my response to him was the below.

Does anyone have any more ideas for checkpatch improvements or
enhancements?

---

On Fri, 2021-01-15 at 21:02 +0530, Dwaipayan Ray wrote:
> I am actually writing to you
> regarding any possible ideas for checkpatch or any improvements
> you would like to see moving forward with checkpatch.
> 
> The last time you had suggested about --fix options. But as we saw
> that maybe some places are better off with it. So do you have
> anything particular in mind?
> 
> Again, thanks a lot in advance. Since my mentorship will go on till
> about march, I am indeed in dire need of ideas.

You could:

o Separate the various tests into individual modules that are aggregated
  at startup.

o Create a test suite.

o Externally document the thing with use cases, all the named tests
  are not particularly documented.

o Add --verbose test descriptions, so 'why this message is emitted'
  description is optionally available to / understood by the user.

o Add support for various brace location / required spacing styles.



