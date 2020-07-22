Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881502291A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 09:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgGVHHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 03:07:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40476 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727096AbgGVHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:07:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M6v2Gc009722;
        Wed, 22 Jul 2020 09:06:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=FRpQMmPFPg8ANDFOsUwPFCvonf7Q8fHnZkrh2v4evW4=;
 b=OSSDHRqBv1Fev5CXXuLaBdca1+XIBCHALQtPyChzBheTW0qH/B48ipOs2K+uLuSx1+N0
 kcN1xM32Ft0vogJhUdW+I/fAA8iujpEr4l0PZ4NfmEePRiZbmtCH+0au98fvwTFKmsmI
 PNtsPC3QmffCXEqs27tG+FkEdyk1MkeT8t62EpbvT69QvG/7WgC+JxpZIOX5CGon1U79
 J3mSD1MKd4epP/R1GHTQvwYN4nW8C3pNK0jW4ilAkefuNv0Gu23T4ZyhUIr+R+nD4E/+
 i3rwjnBBeZs3wx22mBaTNGQShij9sS91vEnjr1293aZwbi9fJvhmiVniCAVvKUWkgNBQ QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsah221m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 09:06:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5789610002A;
        Wed, 22 Jul 2020 09:06:31 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 44D6121F676;
        Wed, 22 Jul 2020 09:06:31 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Jul
 2020 09:06:30 +0200
Subject: Re: [PATCH for v5.9] ARM: STM32: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <linux@armlinux.org.uk>, <mcoquelin.stm32@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20200719094948.57487-1-grandmaster@al2klimov.de>
 <43c11c7a-269e-cc41-6934-0d2e0dec3226@st.com>
 <219075a0-d7cf-a699-21d7-fabc6f077f95@al2klimov.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
Date:   Wed, 22 Jul 2020 09:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <219075a0-d7cf-a699-21d7-fabc6f077f95@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 7:49 PM, Alexander A. Klimov wrote:
> 
> 
> Am 21.07.20 um 10:49 schrieb Alexandre Torgue:
>> Hi Alexander
>>
>> On 7/19/20 11:49 AM, Alexander A. Klimov wrote:
>>> Rationale:
>>> Reduces attack surface on kernel devs opening the links for MITM
>>> as HTTPS traffic is much harder to manipulate.
>>>
>>> Deterministic algorithm:
>>> For each file:
>>>    If not .svg:
>>>      For each line:
>>>        If doesn't contain `\bxmlns\b`:
>>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>       If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>>              If both the HTTP and HTTPS versions
>>>              return 200 OK and serve the same content:
>>>                Replace HTTP with HTTPS.
>>>
>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>
>> This patch touch 2 different subsystems. Can you please split it ?
> I can. But don't all files belong to the subsystem this patch is for?
> 
> ➜  linux git:(autogen/1029) git show arch/arm/mach-stm32/Makefile.boot 
> |perl scripts/get_maintainer.pl --nogit{,-fallback}
> Russell King <linux@armlinux.org.uk> (odd fixer:ARM PORT)
> Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 
> ARCHITECTURE)
> Alexandre Torgue <alexandre.torgue@st.com> (maintainer:ARM/STM32 
> ARCHITECTURE)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES)
> linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 
> ARCHITECTURE)
> linux-kernel@vger.kernel.org (open list)
> ➜  linux git:(autogen/1029) git show crypto/testmgr.h |perl 
> scripts/get_maintainer.pl --nogit{,-fallback}
> Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
> "David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
> Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 
> ARCHITECTURE)
> Alexandre Torgue <alexandre.torgue@st.com> (maintainer:ARM/STM32 
> ARCHITECTURE)
> linux-crypto@vger.kernel.org (open list:CRYPTO API)
> linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 
> ARCHITECTURE)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 
> ARCHITECTURE)
> linux-kernel@vger.kernel.org (open list)
> ➜  linux git:(autogen/1029)

hum, I was not aware that I could take "crypto" patches. But anyway I 
think, the clean way (to avoid merge  issue later) is that I take 
mach-stm32 patch and Herbert the crypto one. Except if Herbert doesn't 
agree can you please split ?

Thanks
Alex

> 
>>
>> Regards
>> Alex
>>
>>
>>> ---
>>>   Continuing my work started at 93431e0607e5.
>>>   See also: git log --oneline '--author=Alexander A. Klimov 
>>> <grandmaster@al2klimov.de>' v5.7..master
>>>   (Actually letting a shell for loop submit all this stuff for me.)
>>>
>>>   If there are any URLs to be removed completely
>>>   or at least not (just) HTTPSified:
>>>   Just clearly say so and I'll *undo my change*.
>>>   See also: https://lkml.org/lkml/2020/6/27/64
>>>
>>>   If there are any valid, but yet not changed URLs:
>>>   See: https://lkml.org/lkml/2020/6/26/837
>>>
>>>   If you apply the patch, please let me know.
>>>
>>>   Sorry again to all maintainers who complained about subject lines.
>>>   Now I realized that you want an actually perfect prefixes,
>>>   not just subsystem ones.
>>>   I tried my best...
>>>   And yes, *I could* (at least half-)automate it.
>>>   Impossible is nothing! :)
>>>
>>>
>>>   arch/arm/mach-stm32/Makefile.boot | 2 +-
>>>   crypto/testmgr.h                  | 6 +++---
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-stm32/Makefile.boot 
>>> b/arch/arm/mach-stm32/Makefile.boot
>>> index cec195d4fcba..5dde7328a7a9 100644
>>> --- a/arch/arm/mach-stm32/Makefile.boot
>>> +++ b/arch/arm/mach-stm32/Makefile.boot
>>> @@ -1,4 +1,4 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>   # Empty file waiting for deletion once Makefile.boot isn't needed 
>>> any more.
>>>   # Patch waits for application at
>>> -# 
>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
>>> +# 
>>> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
>>> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
>>> index d29983908c38..cdcf0d2fe40d 100644
>>> --- a/crypto/testmgr.h
>>> +++ b/crypto/testmgr.h
>>> @@ -16231,7 +16231,7 @@ static const struct cipher_testvec 
>>> aes_lrw_tv_template[] = {
>>>                 "\xe9\x5d\x48\x92\x54\x63\x4e\xb8",
>>>           .len    = 48,
>>>       }, {
>>> -/* 
>>> http://www.mail-archive.com/stds-p1619@listserv.ieee.org/msg00173.html */ 
>>>
>>> +/* 
>>> https://www.mail-archive.com/stds-p1619@listserv.ieee.org/msg00173.html 
>>> */
>>>           .key    = "\xf8\xd4\x76\xff\xd6\x46\xee\x6c"
>>>                 "\x23\x84\xcb\x1c\x77\xd6\x19\x5d"
>>>                 "\xfe\xf1\xa9\xf3\x7b\xbc\x8d\x21"
>>> @@ -21096,7 +21096,7 @@ static const struct aead_testvec 
>>> aegis128_tv_template[] = {
>>>   /*
>>>    * All key wrapping test vectors taken from
>>> - * http://csrc.nist.gov/groups/STM/cavp/documents/mac/kwtestvectors.zip
>>> + * 
>>> https://csrc.nist.gov/groups/STM/cavp/documents/mac/kwtestvectors.zip
>>>    *
>>>    * Note: as documented in keywrap.c, the ivout for encryption is 
>>> the first
>>>    * semiblock of the ciphertext from the test vector. For 
>>> decryption, iv is
>>> @@ -22825,7 +22825,7 @@ static const struct cipher_testvec 
>>> xeta_tv_template[] = {
>>>    * FCrypt test vectors
>>>    */
>>>   static const struct cipher_testvec fcrypt_pcbc_tv_template[] = {
>>> -    { /* 
>>> http://www.openafs.org/pipermail/openafs-devel/2000-December/005320.html 
>>> */
>>> +    { /* 
>>> https://www.openafs.org/pipermail/openafs-devel/2000-December/005320.html 
>>> */
>>>           .key    = "\x00\x00\x00\x00\x00\x00\x00\x00",
>>>           .klen    = 8,
>>>           .iv    = "\x00\x00\x00\x00\x00\x00\x00\x00",
>>>
