Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACC2FD8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392200AbhATSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:51:08 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55430 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390729AbhATSMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611166326; x=1642702326;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0FqY4Y9ekqo9Njl4eE4yftVIgAdbgRXuwSrgrFbU1KY=;
  b=n2oArYMsNAxf9OPtAtzAl8Tp/o3kGHhlSgRm4dtYt1xEKhBpGNFxbqPQ
   +ALRxgjUqIY1L2kMRuQWfnlDarH5DzU5khCRacimSM7qsAwatZcKyyICg
   Yz1MHYQVhpD9p3yCdb5IPClfCb/MqmtiXxBInCcWsp8FvDI9DrNJyEwzg
   Q=;
X-IronPort-AV: E=Sophos;i="5.79,361,1602547200"; 
   d="scan'208";a="112258151"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Jan 2021 18:11:17 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id CC0E3A21D6;
        Wed, 20 Jan 2021 18:11:15 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 18:11:15 +0000
Received: from edge-m1-r3-201.e-iad16.amazon.com (10.43.161.179) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 18:10:35 +0000
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        <linux-kernel@vger.kernel.org>, Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <ce5692a9-e716-514a-f196-b0645bb03eb8@amazon.com>
 <17579DC5-13AF-48E1-9B72-91B14AB485FA@caramail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <6047872c-8a40-4159-aeb6-ea439bfafd82@amazon.com>
Date:   Wed, 20 Jan 2021 19:10:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <17579DC5-13AF-48E1-9B72-91B14AB485FA@caramail.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D49UWC002.ant.amazon.com (10.43.162.215) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.01.21 19:06, Mohamed Mediouni wrote:
> =

>> On 20 Jan 2021, at 17:47, Alexander Graf <graf@amazon.com> wrote:
>>
>> On 20.01.21 14:27, Mohamed Mediouni wrote:
>>> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious hardw=
are quirk.
>>> On Apple processors, writes using the nGnRE device memory type get drop=
ped in flight,
>>> getting to nowhere.
>>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>>> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
>>> ---
>>>   arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 1f7ee8c8b7b8..06436916f137 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -51,6 +51,25 @@
>>>   #define TCR_KASAN_HW_FLAGS 0
>>>   #endif
>>> +#ifdef CONFIG_ARCH_APPLE
>>
>> Is there any particular reason for this #ifdef?
>>
>>
>> Alex
>>
> Not a particular reason, as we explicitly check for the implementer ID. H=
owever,
> without CONFIG_ARCH_APPLE, other parts of the support for Apple CPUs
> will not be available anyway.

The ifdef below for code looks ok to me, I'm explicitly wondering why =

you're guarding the #define :)

Alex

>>> +
>>> +/*
>>> + * Apple cores appear to black-hole writes done with nGnRE.
>>> + * We settled on a work-around that uses MAIR vs changing every single=
 user of
>>> + * nGnRE across the arm64 code.
>>> + */
>>> +
>>> +#define MAIR_EL1_SET_APPLE                                          \
>>> +    (MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |      \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |       \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |            \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |              \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |                    \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |              \
>>> +     MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
>>> +
>>> +#endif
>>> +
>>>   /*
>>>    * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal m=
emory and
>>>    * changed during __cpu_setup to Normal Tagged if the system supports=
 MTE.
>>> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>>>        * Memory region attributes
>>>        */
>>>       mov_q   x5, MAIR_EL1_SET
>>> +#ifdef CONFIG_ARCH_APPLE
>>> +    mrs     x0, MIDR_EL1
>>> +    lsr     w0, w0, #24
>>> +    mov_q   x1, MAIR_EL1_SET_APPLE
>>> +    cmp     x0, #0x61                       // 0x61 =3D Implementer: A=
pple
>>> +    csel    x5, x1, x5, eq
>>> +#endif
>>>   #ifdef CONFIG_ARM64_MTE
>>>       mte_tcr .req    x20
>>> --
>>> 2.29.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



