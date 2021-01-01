Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1982E82C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 03:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhAABzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 20:55:44 -0500
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:49046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbhAABzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 20:55:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 12236100E7B40;
        Fri,  1 Jan 2021 01:55:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3353:3421:3622:3677:3865:3866:3867:3868:3870:4184:4250:4321:4361:4425:5007:6119:7652:7974:9108:10004:10394:10400:10848:11026:11232:11473:11658:11783:11914:12043:12114:12297:12438:12555:12740:12895:13069:13152:13228:13311:13357:13439:13894:14180:14181:14659:14721:21060:21080:21433:21451:21627:21789:21939:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: north20_20090f4274b2
X-Filterd-Recvd-Size: 2313
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Jan 2021 01:55:02 +0000 (UTC)
Message-ID: <4abaac7b4b792dd44880d8acf6ef51d9db89e512.camel@perches.com>
Subject: Re: checkpatch.pl: Bogus case of DT_SPLIT_BINDING_PATCH
From:   Joe Perches <joe@perches.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 31 Dec 2020 17:55:00 -0800
In-Reply-To: <X+5LAFw7AHvAXJaK@latitude>
References: <X+5LAFw7AHvAXJaK@latitude>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-31 at 23:04 +0100, Jonathan Neuschäfer wrote:
> Hi,
> 
> I've encountered a case where the DT_SPLIT_BINDING_PATCH warning was
> emitted even though I didn't change anything outside of Documentation/
> devicetree/bindings. I just converted a binding from plain text to YAML.

Rob?  Your code...

> Here's a transcript of checkpatch (from Linux 5.11-rc1)'s output:
> 
>   $ scripts/checkpatch.pl --strict patches-wpcm/0001-dt-bindings-arm-Convert-nuvoton-npcm750-binding-to-Y.patch
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>   #31:
>   deleted file mode 100644
>   
> 
>   WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>   
> 
>   WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>   
> 
>   total: 0 errors, 3 warnings, 0 checks, 21 lines checked
>   
> 
>   NOTE: For some of the reported defects, checkpatch may be able to
>         mechanically convert to the typical style using --fix or --fix-inplace.
>   
> 
>   patches-wpcm/0001-dt-bindings-arm-Convert-nuvoton-npcm750-binding-to-Y.patch has style problems, please review.
>   
> 
>   NOTE: If any of the errors are false positives, please report
>         them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> I attached the patch, for reference.
> 
> 
> Best regards,
> Jonathan Neuschäfer


