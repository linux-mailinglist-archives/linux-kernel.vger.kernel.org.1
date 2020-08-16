Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0B24586A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHPPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 11:43:34 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:47298 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgHPPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:43:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 71AEF182CED2A;
        Sun, 16 Aug 2020 15:43:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3653:3865:3867:3868:3871:3873:4321:4605:5007:8531:10004:10400:10848:11026:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21365:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cook80_0216d722700f
X-Filterd-Recvd-Size: 1586
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 15:43:31 +0000 (UTC)
Message-ID: <b2230c449f5077596e1ce67f835b5c5f93cf4639.camel@perches.com>
Subject: Re: checkpatch.pl- Cleared some white spaces which generated
 warnings and errors.
From:   Joe Perches <joe@perches.com>
To:     Piyush Thange <pthange19@gmail.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Aug 2020 08:43:30 -0700
In-Reply-To: <d9f3bbf1-0912-1955-ae1f-a499d5b0b11b@gmail.com>
References: <d9f3bbf1-0912-1955-ae1f-a499d5b0b11b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-16 at 18:25 +0530, Piyush Thange wrote:
> commit eb027935d819a3160404f05633ae47f8b8a061c8
[]
>      scripts:checkpatch.pl:Cleared the white spaces and errors occured 
> due to them.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -488,17 +488,7 @@ our $allocFunctions = qr{(?x:
>       dma_alloc_coherent
>   )};
> 
> -our $signature_tags = qr{(?xi:
> -    Signed-off-by:|
> -    Co-developed-by:|
> -    Acked-by:|
> -    Tested-by:|
> -    Reviewed-by:|
> -    Reported-by:|
> -    Suggested-by:|
> -    To:|
> -    Cc:
> -)};
> +our $signature_tags = 
> qr{(?xi:Signed-off-by:|Co-developed-by:|Acked-by:|Tested-by:|Reviewed-by:|Reported-by:|Suggested-by:|To:|Cc:)};

Do you think this is more readable now?
No thanks.


