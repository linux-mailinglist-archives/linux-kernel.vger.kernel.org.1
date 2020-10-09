Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE52289BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbgJIWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:18:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbgJIWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:18:26 -0400
Received: from [192.168.100.1] ([82.252.141.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MV5KC-1ksxjS285W-00S8R5; Sat, 10 Oct 2020 00:18:00 +0200
Subject: Re: [PATCH] m68k: remove unused mach_max_dma_address
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>
References: <20201009095621.833192-1-laurent@vivier.eu>
 <alpine.LNX.2.23.453.2010100857270.12@nippy.intranet>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1aed377a-be35-ac9d-75ac-796d0204d3dd@vivier.eu>
Date:   Sat, 10 Oct 2020 00:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2010100857270.12@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/uDS3coYYLWbgv2KoSz/utnYBZbXQi8FGYVW/GohwmGe9tA8z3p
 UrAxPY8YqnprKhcf0cQn4KmKbwOfuuhwJwpvPzwmnhYFWg0lq8sFGFpwY0W0bzrKGsyrSyD
 /n0DgLQFP7rt6oJwkFQj9uFjBiM7jopYcPi3UxzLq9rB1x8Qk331ZAQh63gJFRJldlsrroI
 x/IHRxPq16+/GvMSbO00A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YIS/yyXSvug=:KKuFeYjkZC9lHADpqOm4qP
 q+7xFQy+v257y+IdduKvpAXsWdQt2strFoaf854X/MqnHGW5LYOgyHdUe7v01CDTydyDA+I32
 qLRatTYtgOf/3iPkIM/uL3QQ4wqUW6D7Ds42DM4+6ALH8LtAhxBG3kbvhHZrB02tF3aqJM0P7
 9lL6nxrFcqnOO5zCWlYpLWWxEyo/YDwCF8gAzyja6EBcRtymbeVoObyvB2xg2UIRHuL0sTmzl
 e3DAlsvVARvgnfuA8+1Z/7HYkQ0DJTBaD1SKfmg5mTnuuf3fN0zAlW4l2wd/dOIOLJOT0r8RT
 Y5wjvtnAlpll7UnAfVAOZYfJHc2/WHl1SSsa7UDMRIkrl9FJnMABVsYi5v7ocbE+TimqMswwI
 5zVXCxXYhQIzBg6LK1DmTKmzTJEO87665L0vOnyvefnHdi07uiqW0dLpifZqB8u1/3R2BvaVv
 TkVsPfIoyH4m5bCLVSe/IXzoSvplbd0Z0KeN0XVLFT44N5kZ4Z3J0tC26ZG2fALVqpIowbJl2
 Zo4SlGGBSH/wCRCAhKsRDZkWaDxKcozm8ftR7rMnbvLEYxVr1eb6ig2nWVSID4oa/U2+/vR0i
 R4Ecatpv+CJmkvhFXdbMbjJjJXFMItKvta1PsGMdH4qyhCGa6OXFCyeChf3Zq+0DPE+5MudyH
 p+9UkE4HtX8Ellcs1kM9g5jnVc1AXhqfbvqUsTpe0d5qX704EzTMg3hA32gYKXcMcu+Km306s
 RK3xNupxnCyr59Iq5QR9VYFb0FxU6LyLoed5xL84xWAD0xgJ8e9rJEej/1ckdrgCzlkp3WmPa
 3AdfY2ys4YJbqtT/w7Hb5TPgpJkxEymL3aEvTNH/5Sa2zVRTJcx//xXftyFW9Xe1zzMGEVe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/10/2020 à 23:59, Finn Thain a écrit :
> On Fri, 9 Oct 2020, Laurent Vivier wrote:
> 
>> This information is unused since the discontinuous memory support
>> has been introduced in 2007.
>>
>> Fixes: 12d810c1b8c2 ("m68k: discontinuous memory support")
> 
> Does this qualify as a bug fix?
> 

It's more like a cleanup for 12d810c1b8c2 than a bug fix.

Thanks,
Laurent
