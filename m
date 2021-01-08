Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA62EF111
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhAHLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:08:19 -0500
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:60656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727373AbhAHLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:08:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3EBF1182CED2A;
        Fri,  8 Jan 2021 11:07:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3872:3873:4321:5007:7652:10004:10400:10848:11232:11658:11914:12297:12679:12740:12895:13069:13311:13357:13439:13894:14659:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: songs02_1111c47274f2
X-Filterd-Recvd-Size: 1072
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Jan 2021 11:07:37 +0000 (UTC)
Message-ID: <ec135fa05918f7a2e34e5b6364c691ce0d3d8287.camel@perches.com>
Subject: Re: [PATCH v2 -next] mfd: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 08 Jan 2021 03:07:35 -0800
In-Reply-To: <20210108105355.GE1592923@dell>
References: <20210108092058.18576-1-zhengyongjun3@huawei.com>
         <20210108105355.GE1592923@dell>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-08 at 10:53 +0000, Lee Jones wrote:
> On Fri, 08 Jan 2021, Zheng Yongjun wrote:
> 
> You're still not using the correct subject format.
> 
> It should be:
> 
>  "mfd: <driver>: Description starting with an uppercase char"

IMO: overly pedantic


