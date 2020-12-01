Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4F2CAC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbgLATnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:43:05 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:52698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgLATnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:43:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ECC8F182CED28;
        Tue,  1 Dec 2020 19:42:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3872:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12895:13019:13069:13161:13229:13311:13357:13439:13894:14659:14721:21080:21627:21987:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: magic08_1c06533273ad
X-Filterd-Recvd-Size: 2218
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 19:42:22 +0000 (UTC)
Message-ID: <83c7170c7ce6195dc73dcf813965c3e4a99fa4ed.camel@perches.com>
Subject: Re: [PATCH 3/3] firmware: xilinx: Properly align function parameter
From:   Joe Perches <joe@perches.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 01 Dec 2020 11:42:21 -0800
In-Reply-To: <fb0a22fd12f6a1d69e4e66aafba5b84859d4a60c.1606837822.git.michal.simek@xilinx.com>
References: <cover.1606837822.git.michal.simek@xilinx.com>
         <fb0a22fd12f6a1d69e4e66aafba5b84859d4a60c.1606837822.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 16:50 +0100, Michal Simek wrote:
> Fix parameters alignment reported by checkpatch --strict.

Please use a newer checkpatch as the 80 column warning
isn't enforced quite the same way.

> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
[]
> @@ -456,7 +456,8 @@ static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  }
>  
> 
>  static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> -			   const enum zynqmp_pm_reset_action assert_flag)
> +					 const enum zynqmp_pm_reset_action
> +					 assert_flag)

I think these changes aren't very good as it separates
the type from the variable name.

> @@ -490,9 +491,10 @@ static inline int zynqmp_pm_release_node(const u32 node)
>  }
>  
> 
>  static inline int zynqmp_pm_set_requirement(const u32 node,
> -					const u32 capabilities,
> -					const u32 qos,
> -					const enum zynqmp_pm_request_ack ack)
> +					    const u32 capabilities,
> +					    const u32 qos,
> +					    const enum zynqmp_pm_request_ack
> +					    ack)



