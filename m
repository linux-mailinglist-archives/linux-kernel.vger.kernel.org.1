Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF272DD67B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgLQRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:44:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:52633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgLQRoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608226965;
        bh=UkUU0la/6Jv7MXQfdCTccvvTqgYQDgGpJ6ZlfjZav90=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fgNr88QbhYjpSHWs1SECbu8WoCwineyXNBU5FoTm85MzGsNCa1HCMVixCPE6trCbz
         Nvytz2N194PoPMyB2Ou8hI3AoaZhxFXO1jp48FveSiC3fcRNREUGFho3wmH2chEf4m
         97K9h2MuncRLrSZVn4JdfD5eYEloc5LzR9WOTQ/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.140.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1jvVFw2Iq5-00wmWM; Thu, 17
 Dec 2020 18:42:45 +0100
Subject: Re: [PATCH] checkpatch: add new warning when lookup_symbol_name() is
 used
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20201217171111.GA8295@ls3530.fritz.box>
 <816c1571b4132f991089b40a759cf68afcf4af43.camel@perches.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <e0b41739-f72d-be5c-cfaa-39ced0e2ab6f@gmx.de>
Date:   Thu, 17 Dec 2020 18:42:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <816c1571b4132f991089b40a759cf68afcf4af43.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bfvLM5pp4QRnqPWjQv5uJ/11gVus7Bx0nytQe1zpBMM3EvJOy0h
 2DuYJYhHyNdwOD+FZI2UHnie3sCnRkGnGZCvEckhv+CSYDXubfRYfdi391olg5zunbP/oas
 bS1FyYwlsvmTE66VgI1V23AWDkM6s/p+OUfTvvKVnda2tFrf3fVh0jHFZOL+QvcznlxCckD
 sF/oG6zTMckmd6RpzpjJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X2mB/pS+rHE=:D/qfDOEGqw6ALAEJ0Wnp4t
 9C8Gwtq7d4eUql8Nd3dAk767avoQiwZeTgoLVb1suBSEtkT65KcCZLkaKjl8lK+wEuTv8jXkC
 hKa0lztAiYbI3BGlX6OyNcCMGuBBixU0YMkCL7Lzl3j0q3zBPfRIbbY9+lwaBWkyCMBFfNxNP
 zwxYn87Wt4svOKNGUDq0uU9ize51fc02N+bb/bX00HZPlw7X0BYPJB7ftS5ItTbeMXMC2iFzo
 dpzXCjvESoLRywnPIKVFPSga8AUWnR7GmTnvbwv4LAsYUugn2anygnp/ynV/eLqlt2q83vCiY
 uDtXv4SvYbt2hUS6YtKokKVF7DXbNYSzMu6ADkSX5QLjAMJDZrfc/9Kq24eqK8sEDk0txJBmc
 0nn1t1HjMMee5yRGNagDmsH7NM+TWxT9dVkD+BHQhQrrQwRwf2DmqPqpJU5HK4bUXjTnq65QU
 AOapQZjgX/k+uR44cjMSvzaV1W6Myw6PTuUvJCvCfZxd2/17mYaeB/p+jwg0/mhU5+ZVbcAg/
 j2CMwMyu8eFNZ/+xzV6soadsQb7C1Bwi6oeE3Zr/4sEYu0Xrpd/jb5TSIUutqEuP+2+OGNlpn
 tTkoXfk69wbXzUyQMaP9c5+pVOXFHSUdKWE8PY4WXFD5f6xTBbnY1lpyE7l5YmCbmPTlv1deV
 xgVeeb4ld/kqwnuDNJysjjy+IE+Ne6UJO5CefrAdQSIRQmmp8rd9psbfIcXoXtp8kQ2j6G7tQ
 7AJ2SsS5nQORQbiRVVXN7AAKu47k6tdfDRsSuOtqYTGgm0w94Q7mX7aFBOMtNi21tatHkarIr
 MK/vxqx8PwfrPXNSX6nrAbi1v4Abuh9q8Kz5ACocURVzNfVS/CatqlCy1ui0W8PHyVSHf0OFu
 r5yvVJDsvd+Z00gxz/YQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 6:27 PM, Joe Perches wrote:
> On Thu, 2020-12-17 at 18:11 +0100, Helge Deller wrote:
>> In most cases people use lookup_symbol_name() to resolve a kernel symbo=
l
>> and then print it via printk().
>>
>> In such cases using the %ps, %pS, %pSR or %pB printk formats are easier
>> to use and thus should be preferred.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -4317,6 +4317,12 @@ sub process {
>> =C2=A0			     "LINUX_VERSION_CODE should be avoided, code should be for=
 the version to which it is merged\n" . $herecurr);
>> =C2=A0		}
>>
>> +# avoid lookup_symbol_name()
>> +		if ($line =3D~ /\blookup_symbol_name\b/) {
>> +			WARN("PREFER_PRINTK_FORMAT",
>> +			     "If possible prefer %ps or %pS printk format string to print s=
ymbol name instead of using lookup_symbol_name()\n" . $herecurr);
>> +		}
>> +
>> =C2=A0# check for uses of printk_ratelimit
>> =C2=A0		if ($line =3D~ /\bprintk_ratelimit\s*\(/) {
>> =C2=A0			WARN("PRINTK_RATELIMITED",
>
> Huh?  nak.
>
> lookup_symbol_name is used in the kernel a grand total of 3 times.

Yes, there were much more in the past which got fixed by patches I submitt=
ed.

> 2 uses are kprobe, the other is fs/proc

Right. For fs/proc see:
https://lore.kernel.org/lkml/20201217165413.GA1959@ls3530.fritz.box/

> None of the existing uses is equivalent to %ps

Yes, those are the remaining legimate users.

> Why should this be applied?

... to prevent people to add new code with possibly unjustified use?

Helge
