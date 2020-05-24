Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67571E0131
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgEXRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 13:38:06 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:40222 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387656AbgEXRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:38:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5E2D5100E7B40;
        Sun, 24 May 2020 17:38:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3351:3622:3867:3871:4250:4321:4605:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12114:12296:12297:12438:12533:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bean88_3a0fbd626d3a
X-Filterd-Recvd-Size: 1808
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 17:38:03 +0000 (UTC)
Message-ID: <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 24 May 2020 10:38:02 -0700
In-Reply-To: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 23:50 +0900, Tetsuo Handa wrote:
> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> because pr_debug() was no-op [1].
> 
>   pr_debug("fallback-read subflow=%p",
>            mptcp_subflow_ctx(ssock->sk));
>   copied = sock_recvmsg(ssock, msg, flags);

> Since console loglevel used by syzkaller will not print KERN_DEBUG
> messages to consoles, always evaluating pr_devel()/pr_debug() messages
> will not cause too much console output. Thus, let's allow fuzzers to
> always evaluate pr_devel()/pr_debug() messages.

While I think this is rather unnecessary,
what about dev_dbg/netdev_dbg/netif_dbg et al ?


