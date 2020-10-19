Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE9292D20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgJSRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:52:18 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:41317 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:52:17 -0400
Received: from [192.168.42.210] ([81.185.173.144])
        by mwinf5d19 with ME
        id htsA2300T37HXBD03tsBYd; Mon, 19 Oct 2020 19:52:14 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Oct 2020 19:52:14 +0200
X-ME-IP: 81.185.173.144
Subject: Re: [PATCH] staging: wfx: make a const array static, makes object
 smaller
To:     Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201016223303.687278-1-colin.king@canonical.com>
 <09cd7e609324d460afdf14829baf3c2f1a9cb9cd.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <18f2f9d4-5199-d6d0-f4f5-c17d609a44a7@wanadoo.fr>
Date:   Mon, 19 Oct 2020 19:52:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <09cd7e609324d460afdf14829baf3c2f1a9cb9cd.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/10/2020 à 02:11, Joe Perches a écrit :
> On Fri, 2020-10-16 at 23:33 +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Don't populate const array filter_ies on the stack but instead
>> make it static. Makes the object code smaller by 261 bytes.
>>
>> Before:
>>     text	   data	    bss	    dec	    hex	filename
>>    21674	   3166	    448	  25288	   62c8	drivers/staging/wfx/sta.o
>>
>> After:
>>     text	   data	    bss	    dec	    hex	filename
>>    21349	   3230	    448	  25027	   61c3	drivers/staging/wfx/sta.o
> 
> Thanks.
> 
> It's odd to me it's so large a change as it's only
> 24 bytes of initialization. (3 entries, each 8 bytes)
> 

The function looks small.
Maybe it is inlined by gcc in each of the 3 callers?

CJ

> This line in the same function:
> 
> 		hif_set_beacon_filter_table(wvif, 3, filter_ies);
> 
> might as well use ARRAY_SIZE(filter_ies) instead of 3
> 
> 
> 

