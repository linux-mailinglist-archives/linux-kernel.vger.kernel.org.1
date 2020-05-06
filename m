Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A41C7C65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgEFVZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 17:25:46 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:54658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729152AbgEFVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:25:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 264B918025396;
        Wed,  6 May 2020 21:25:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:5007:6742:6755:7576:10004:10400:10848:11026:11232:11473:11658:11914:12219:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21972:21990:30036:30054:30074:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ice18_31e3e67744b3e
X-Filterd-Recvd-Size: 2298
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 21:25:42 +0000 (UTC)
Message-ID: <4cdeaa2af2fe0d6cc2ca8ce3a37608340799df8a.camel@perches.com>
Subject: Re: [PATCH v3 2/6] pstore/platform: Pass max_reason to kmesg dump
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Wed, 06 May 2020 14:25:41 -0700
In-Reply-To: <20200506211523.15077-3-keescook@chromium.org>
References: <20200506211523.15077-1-keescook@chromium.org>
         <20200506211523.15077-3-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 14:15 -0700, Kees Cook wrote:
> From: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Add a new member to struct pstore_info for passing information about
> kmesg dump maximum reason. This allows a finer control of what kmesg
> dumps are sent to pstore storage backends.

trivia:

> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
[]
> @@ -96,6 +96,12 @@ struct pstore_record {
>   *
>   * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
>   * @flags:	bitfield of frontends the backend can accept writes for
> + * @max_reason:	Used when PSTORE_FLAGS_DMESG is set. Contains the
> + *		kmsg_dump_reason enum value. KMSG_DUMP_UNDEF means
> + *		"use existing kmsg_dump() filtering, based on the
> + *		printk.always_kmsg_dump boot param" (which is either
> + *		KMSG_DUMP_OOPS when false, or KMSG_DUMP_MAX when
> + *		tree); see printk.always_kmsg_dump for more details.

s/tree/true/


