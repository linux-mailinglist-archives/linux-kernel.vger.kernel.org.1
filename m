Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6592B2B58CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKQE06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:26:58 -0500
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:59708 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgKQE05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:26:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C47CF182CED28;
        Tue, 17 Nov 2020 04:26:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2689:2731:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:4321:5007:7875:7903:9010:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: shock35_5b1437b2732e
X-Filterd-Recvd-Size: 1534
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Nov 2020 04:26:55 +0000 (UTC)
Message-ID: <1b9c5353c6318cc7a4e013886012739e6627d82d.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add fix option for MAINTAINERS_STYLE
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 16 Nov 2020 20:26:54 -0800
In-Reply-To: <20201117040501.21914-1-yashsri421@gmail.com>
References: <20201117040501.21914-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 09:35 +0530, Aditya Srivastava wrote:
> Checkpatch expects entries in MAINTAINERS file in a specific order and
> warns if the changes made do not follow the specified order.
> 
> E.g., running checkpatch on commit b33bc2b878e0 ("nexthop: Add entry to
> MAINTAINERS") reports this warning:
> 
> WARNING: Misordered MAINTAINERS entry - list file patterns in
> alphabetic order
> +F:	include/uapi/linux/nexthop.h
> +F:	include/net/netns/nexthop.h
> 
> Provide a simple fix by swapping the unordered lines, if both the lines
> are additions (start with '+')

On second thought, nak.

This fails when there are 3 consecutive misordered lines.

SECTION
F:	c
F:	b
F:	a


