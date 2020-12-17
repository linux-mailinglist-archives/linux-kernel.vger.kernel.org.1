Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D62DD93B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLQTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 14:17:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:54759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQTR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608232553;
        bh=1UqtUnci8L99aTh0jhHVHURTwDiqLJkkk1Q10J4YL1I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ut71v9p9AO2P4WBGZ5pHYh5iifZsk5OCvd4shKPOu3B6RZP6T8KnBmrKRWTwBS6ZR
         wTT7ZQipc71yFivn+dEigRvKwXZFaxeXV0QPYvCwwr7g0hT044eUIMnyxBA9LboPxf
         E8l4YdavGoScpA38lI4mloT47bA/jx0Oqel2gLsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.140.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1jz77J1cPY-00r1FT; Thu, 17
 Dec 2020 20:15:53 +0100
Subject: Re: [PATCH] checkpatch: add new warning when lookup_symbol_name() is
 used
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20201217171111.GA8295@ls3530.fritz.box>
 <816c1571b4132f991089b40a759cf68afcf4af43.camel@perches.com>
 <e0b41739-f72d-be5c-cfaa-39ced0e2ab6f@gmx.de>
 <f650d87a5c65e3da44a129297c3254b7da48767c.camel@perches.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <0f8f1a51-a048-a49b-dde2-90f67f5df7f2@gmx.de>
Date:   Thu, 17 Dec 2020 20:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f650d87a5c65e3da44a129297c3254b7da48767c.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sJFhoqOy3BT93iOWSLj3NVEtmqvbwkB1s+Sxcl0xnN9FmC2AvpO
 NezGbrrtqDMP6cosWhsa7jWdN3FcFwMsTXMjiCVPrsc1L64Wr0zSW0y/P6iKZcqyxfZKaBz
 4NXlFx9tK3dyTWzcog+/3GNoRH15RhXJn1AVATCrgWmMq9dprZTpg1ShXsdkcy2pGuhSyQS
 jPUrWNPMnkx1n9CnsKqaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ISBKH05e38=:8BauULtSGZyDA/BDhKIFmM
 KkjlZb7QsNatuPMxGRmaGNKtXeZZYEAo92paKaqBgV839lRgEZRTDmK8YxQIZWwuC5Pcspr47
 QFe8gJT+RDZoCkd93CQwNqAeMu8YnDni5qyqZWQJTKk8GRCN0tPA8e3hMPNwrLYktWup97JG2
 USRfCZWCenk3HfjgZCcW6+3xAxtSdiuXwIuoXMi6c/J0n4T6bZNI2LY5/xZHMeudGaS3uDekm
 jIB5IFjGgU194tOaBQolTRwjaEJjFdVkJtJdMoI1j1S7V0TG12JRwdr4MD3ANUKCfOtIy4eA+
 pKnIWBldis8YWnqvfGePMylgDbDxX7FLLOQPYkRU4URIDEPAoljPv34+hztchs7A0jUJPCWYs
 kXTOSI4DPl/oxNEaJATwAMhwYgjdY5PRiLpVb5O/Enjk9uxRf2fh53Vc6odZhspuuzQg8/MaR
 TdGWUyG0omDXbNAyfyzpnWwdSrQgFYbjg1wsx6oOdw758Mdz9FXkQzhxnSPjxabZ0AZXJw8wD
 lK4GMkP1jHiJloTsGiqsLE7WLMt+fQjDXtRrJAnImgkrZLVbujukKFpu76POVDq3gsLWRs/cL
 v3BJSeUGtoWZgn/4uYSR0S4HayIkb/hikR7vVsjCR8r9c9myoBHcDiDnjkAI3yYwuQ3J308Qe
 03g2r67Bkd9CicMK/Qo0iGsg/Ic9Raa6BgyRUYIz8fudLSzoN4I8SgX3YpS/zYMDDmrIUpgug
 loU0z/YXSY0zIDj85hOPqmxZAUDYwfRxCcrrO/9AECER+4VpKnDWy26vidQZONzhGvs48gK1N
 ZfgMXLezfW20Qrvd/Kamwl36TDR36K4mOAfDQktW6YvQv3B7CljkqXlS0rZQY8EcmAbYScpVr
 wIdnEusDOIM6ph9jcd4g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 7:15 PM, Joe Perches wrote:
> On Thu, 2020-12-17 at 18:42 +0100, Helge Deller wrote:
>> On 12/17/20 6:27 PM, Joe Perches wrote:
>>> On Thu, 2020-12-17 at 18:11 +0100, Helge Deller wrote:
>>>> In most cases people use lookup_symbol_name() to resolve a kernel sym=
bol
>>>> and then print it via printk().
>>>>
>>>> In such cases using the %ps, %pS, %pSR or %pB printk formats are easi=
er
>>>> to use and thus should be preferred.
>>> []
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -4317,6 +4317,12 @@ sub process {
>>>> =C2=A0			     "LINUX_VERSION_CODE should be avoided, code should be f=
or the version to which it is merged\n" . $herecurr);
>>>> =C2=A0		}
>>>>
>>>> +# avoid lookup_symbol_name()
>>>> +		if ($line =3D~ /\blookup_symbol_name\b/) {
>>>> +			WARN("PREFER_PRINTK_FORMAT",
>>>> +			     "If possible prefer %ps or %pS printk format string to print=
 symbol name instead of using lookup_symbol_name()\n" . $herecurr);
>>>> +		}
>>>> +
>>>> =C2=A0# check for uses of printk_ratelimit
>>>> =C2=A0		if ($line =3D~ /\bprintk_ratelimit\s*\(/) {
>>>> =C2=A0			WARN("PRINTK_RATELIMITED",
>>>
>>> Huh?  nak.
>>>
>>> lookup_symbol_name is used in the kernel a grand total of 3 times.
>>
>> Yes, there were much more in the past which got fixed by patches I subm=
itted.
>
> Hi Helge.
>
> Much more may be a bit of an overstatement.
>
> I found 3 instances of lookup_symbol_name removals in 2 patches.
>
> commit 36dbca148bf8e3b8658982aa2256bdc7ef040256
> -		lookup_symbol_name((ulong)pm_power_off, symname);
> -		lookup_symbol_name((ulong)pm_power_off, symname);
> commit da88f9b3113620dcd30fc203236aa53d5430ee98
> -	if (lookup_symbol_name((unsigned long)sym, symname) < 0)
>
> There's a tension between adding tests and newbies that consider
> checkpatch warnings as dicta that must be followed so there would
> be patches submitted eventually against the existing correct uses.
>
> So thanks, but given the very few existing all correct uses of
> this function and the low probability of new uses I'd prefer not
> to apply this.

Ok.

Thanks!
Helge
