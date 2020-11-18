Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D712B7903
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKRIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:44:47 -0500
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:52416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgKRIor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:44:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F323812C5;
        Wed, 18 Nov 2020 08:44:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3873:3876:4321:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30045:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:10,LUA_SUMMARY:none
X-HE-Tag: brain89_0b065ed27338
X-Filterd-Recvd-Size: 2196
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 08:44:46 +0000 (UTC)
Message-ID: <0e1a208d3a0d68181c9ee695aabc3655979bfd7f.camel@perches.com>
Subject: Re: [PATCH] net: ipv4: fixed brace and space style
From:   Joe Perches <joe@perches.com>
To:     Armin Gholampoor <armingh379@gmail.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 00:44:44 -0800
In-Reply-To: <20201118165845.16078-1-armingh379@gmail.com>
References: <20201118165845.16078-1-armingh379@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-18 at 11:58 -0500, Armin Gholampoor wrote:
> Fixed bracings for if statements
> 
> Fixed spacings around operators

Do you really think this new code looks better:

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c

[old]

static const unsigned char new_state[16] = {
  /* current state:        new state:      action:	*/
  [0 /* (Invalid) */]	= TCP_CLOSE,
  [TCP_ESTABLISHED]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
  [TCP_SYN_SENT]	= TCP_CLOSE,
  [TCP_SYN_RECV]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
  [TCP_FIN_WAIT1]	= TCP_FIN_WAIT1,
  [TCP_FIN_WAIT2]	= TCP_FIN_WAIT2,
  [TCP_TIME_WAIT]	= TCP_CLOSE,
  [TCP_CLOSE]		= TCP_CLOSE,
  [TCP_CLOSE_WAIT]	= TCP_LAST_ACK  | TCP_ACTION_FIN,
  [TCP_LAST_ACK]	= TCP_LAST_ACK,
  [TCP_LISTEN]		= TCP_CLOSE,
  [TCP_CLOSING]		= TCP_CLOSING,
  [TCP_NEW_SYN_RECV]	= TCP_CLOSE,	/* should not happen ! */

[new]

	/* current state:        new state:      action:	*/
	[0 /* (Invalid) */]	= TCP_CLOSE,
	[TCP_ESTABLISHED]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
	[TCP_SYN_SENT]	= TCP_CLOSE,
	[TCP_SYN_RECV]	= TCP_FIN_WAIT1 | TCP_ACTION_FIN,
	[TCP_FIN_WAIT1]	= TCP_FIN_WAIT1,
	[TCP_FIN_WAIT2]	= TCP_FIN_WAIT2,
	[TCP_TIME_WAIT]	= TCP_CLOSE,
	[TCP_CLOSE]		= TCP_CLOSE,
	[TCP_CLOSE_WAIT]	= TCP_LAST_ACK  | TCP_ACTION_FIN,
	[TCP_LAST_ACK]	= TCP_LAST_ACK,
	[TCP_LISTEN]		= TCP_CLOSE,
	[TCP_CLOSING]		= TCP_CLOSING,
	[TCP_NEW_SYN_RECV]	= TCP_CLOSE,	/* should not happen ! */


