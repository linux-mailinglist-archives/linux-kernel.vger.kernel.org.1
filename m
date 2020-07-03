Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0B213F46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGCS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 14:29:52 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:57106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbgGCS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:29:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B474F4DD0;
        Fri,  3 Jul 2020 18:29:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:6691:7903:8957:10004:10400:10471:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12895:13069:13161:13229:13255:13311:13357:13894:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: steam78_241640d26e94
X-Filterd-Recvd-Size: 2347
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 18:29:49 +0000 (UTC)
Message-ID: <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
Subject: Re: [PATCH 04/30] usb: misc: sisusbvga: sisusb_init: Mark all
 'static const' arrays as __maybe_unused
From:   Joe Perches <joe@perches.com>
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>
Date:   Fri, 03 Jul 2020 11:29:48 -0700
In-Reply-To: <20200703174148.2749969-5-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
         <20200703174148.2749969-5-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 18:41 +0100, Lee Jones wrote:
> drivers/usb/misc/sisusbvga/sisusb_init.h is included by a few
> source files.  Most of which do not use the majority of the
> shared static const arrays which have been declared.  This
> causes the build system to spew 100's of warnings.
> 
> Fixes the following W=1 kernel build warning(s) - and a whole lot more:
> 
>  In file included from drivers/usb/misc/sisusbvga/sisusb.c:54:
>  drivers/usb/misc/sisusbvga/sisusb_init.h:695:34: warning: ‘SiSUSB_VCLKData’ defined but not used [-Wunused-const-variable=]
>  695 | static const struct SiS_VCLKData SiSUSB_VCLKData[] = {
>  | ^~~~~~~~~~~~~~~
> [10's of lines snipped]
>  drivers/usb/misc/sisusbvga/sisusb_init.h:206:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
>  206 | static const unsigned char SiS_VGA_DAC[] = {
>  | ^~~~~~~~~~~
> [10's of lines snipped]
>  drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
>  171 | static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
>  | ^~~~~~~~~~~~~~~~~~~
> [10's of lines snipped]

They are not __maybe_unused, they _are_ used.

I think these instead should be moved to where
they are used instead of being declared in an
#include file.


