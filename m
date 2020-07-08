Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C435218B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgGHPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:40:02 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:47886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgGHPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:40:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CCC8B181D3026;
        Wed,  8 Jul 2020 15:40:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:582:599:967:968:973:988:989:1152:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6261:7875:7903:9025:9036:10004:10400:11232:11658:11914:12043:12297:12740:12760:12895:12926:13069:13311:13357:14181:14659:14685:14721:14764:21080:21347:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wood85_2f12d7c26ebe
X-Filterd-Recvd-Size: 2129
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Jul 2020 15:40:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jul 2020 08:39:59 -0700
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
In-Reply-To: <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
 <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
 <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <dd532813cc28b6f27b2d0ed6bd3529f2@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [172.58.16.106]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 07:35, Shuah Khan wrote:
> On 7/7/20 7:56 PM, Joe Perches wrote:
>> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
>>> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
>>>> Replace the existing /* fall through */ comments and its variants 
>>>> with
>>>> the new pseudo-keyword macro fallthrough[1]. Also, remove 
>>>> unnecessary
>>>> fall-through markings when it is the case.
>>>> 
>>>> [1] 
>>>> https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>>> 
>>> 
>>> Is fallthrough syntax supported on our min gcc version?
>> 
>> No.  Introduced in gcc 7.
>> 
> 
> Gustavo,
> 
> In which case, this patch would break usbip build on older gcc
> revisions.

No it will not.  Comment fall through was introduced in gcc 7 and this 
devolved into a do while 0
> thanks,
> -- Shuah
