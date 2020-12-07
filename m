Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3A2D1E65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgLGXeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:34:11 -0500
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:56752 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgLGXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:34:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 623E318029124;
        Mon,  7 Dec 2020 23:33:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:9391:10004:10400:10848:11232:11658:11914:12043:12114:12297:12555:12740:12760:12895:12986:13069:13255:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21627:21740:21819:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: basin47_2606143273e2
X-Filterd-Recvd-Size: 1612
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Dec 2020 23:33:28 +0000 (UTC)
Message-ID: <f508c385bfca84edfc2c08be085090bd8fab92c6.camel@perches.com>
Subject: Re: [PATCH next v3 1/3] printk: inline log_output(),log_store() in
 vprintk_store()
From:   Joe Perches <joe@perches.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Dec 2020 15:33:27 -0800
In-Reply-To: <20201207222020.2923-2-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
         <20201207222020.2923-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-07 at 23:26 +0106, John Ogness wrote:
> In preparation for removing logbuf_lock, inline log_output()
> and log_store() into vprintk_store(). This will simplify dealing
> with the various code branches and fallbacks that are possible.

One nicety would be to add various pr_<level> functions.

From several years ago, (and this should work properly now)

https://lore.kernel.org/lkml/1466739971-30399-1-git-send-email-joe@perches.com/


