Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAC1CE346
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgEKSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:54:15 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:43678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEKSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:54:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 536534DCF;
        Mon, 11 May 2020 18:54:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2282:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21063:21080:21365:21451:21627:21990:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: grain11_24e0b558a6440
X-Filterd-Recvd-Size: 2578
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 18:54:13 +0000 (UTC)
Message-ID: <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
Subject: Re: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
From:   Joe Perches <joe@perches.com>
To:     Elliot Berman <eberman@codeaurora.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 11:54:12 -0700
In-Reply-To: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
References: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 11:26 -0700, Elliot Berman wrote:
> This reverts commit c0d2af637863940b1a4fb208224ca7acb905c39f.
> 
> Some compilers[1] may break dynamic_hex_dump by optimizing the
> DYNAMIC_DEBUG_BRANCH check inside __dynamic_func_call_no_desc and completely
> removing the dynamic debug metadata. Thus, there is no dynamic_debug control
> site to enable or disable. The if condition is optimized away based on the
> initial value of flags (i.e. if DEBUG macro is present).
> 
> [1]: This behavior is present on [aarch64-gnu-linux-gcc (Ubuntu/Linaro
> 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609] and [Android Common Kernel
> toolchain: "Android (6051079 based on r370808) clang version
> 10.0.1"] using arm64 default defconfig + DYNAMIC_DEBUG enabled.
> 
> Change-Id: I28e9b86088eee5d5ed2384fbcea2ac2e7337a559
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

Change-Id: probably isn't necessary.

Is there a separate mechanism possible to avoid bloating the
otherwise unused content?

>  include/linux/dynamic_debug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index abcd5fd..7518db4f 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -79,7 +79,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  			 const char *fmt, ...);
>  
>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
> -	static struct _ddebug  __aligned(8)			\
> +	static struct _ddebug __used __aligned(8)		\
>  	__attribute__((section("__verbose"))) name = {		\
>  		.modname = KBUILD_MODNAME,			\
>  		.function = __func__,				\

