Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC92E048D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgLVDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:02:29 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:14552 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:02:29 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Dec
 2020 11:01:44 +0800
Received: from [192.168.0.102] (113.201.128.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Dec
 2020 11:01:41 +0800
Date:   Tue, 22 Dec 2020 11:01:39 +0800
From:   <tonywwang-oc@zhaoxin.com>
To:     <hpa@zytor.com>, Eric Biggers <ebiggers@kernel.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <TimGuo-oc@zhaoxin.com>,
        <CooperYan@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <SilviaZhao@zhaoxin.com>
Subject: Re: [PATCH] crypto: x86/crc32c-intel - Don't match some Zhaoxin CPUs
User-Agent: K-9 Mail for Android
In-Reply-To: <AB43DE6C-BF23-4B72-B0C8-09FE0071B2C7@zytor.com>
References: <1607686144-2604-1-git-send-email-TonyWWang-oc@zhaoxin.com> <X9Ov3RWDpUik7gXo@sol.localdomain> <1f8d17bf-c1d9-6496-d2f8-5773633011fb@zhaoxin.com> <X9fN7mOMdn1Dxn63@sol.localdomain> <a95984ea-7451-78fe-88c5-b81f633fecdf@zhaoxin.com> <X9j43b+JPbUUvCrH@sol.localdomain> <345BC725-406B-40C6-88E9-747DBEBE0493@zhaoxin.com> <AB43DE6C-BF23-4B72-B0C8-09FE0071B2C7@zytor.com>
Message-ID: <4CDBFCA0-56B9-495B-9660-3BE9018BC8AE@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [113.201.128.11]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 22, 2020 3:27:33 AM GMT+08:00, hpa@zytor.com wrote:
>On December 20, 2020 6:46:25 PM PST, tonywwang-oc@zhaoxin.com wrote:
>>On December 16, 2020 1:56:45 AM GMT+08:00, Eric Biggers
>><ebiggers@kernel.org> wrote:
>>>On Tue, Dec 15, 2020 at 10:15:29AM +0800, Tony W Wang-oc wrote:
>>>> 
>>>> On 15/12/2020 04:41, Eric Biggers wrote:
>>>> > On Mon, Dec 14, 2020 at 10:28:19AM +0800, Tony W Wang-oc wrote:
>>>> >> On 12/12/2020 01:43, Eric Biggers wrote:
>>>> >>> On Fri, Dec 11, 2020 at 07:29:04PM +0800, Tony W Wang-oc wrote:
>>>> >>>> The driver crc32c-intel match CPUs supporting
>>>X86_FEATURE_XMM4_2.
>>>> >>>> On platforms with Zhaoxin CPUs supporting this X86 feature,
>>When
>>>> >>>> crc32c-intel and crc32c-generic are both registered, system
>>will
>>>> >>>> use crc32c-intel because its .cra_priority is greater than
>>>> >>>> crc32c-generic. This case expect to use crc32c-generic driver
>>>for
>>>> >>>> some Zhaoxin CPUs to get performance gain, So remove these
>>>Zhaoxin
>>>> >>>> CPUs support from crc32c-intel.
>>>> >>>>
>>>> >>>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>>>> >>>
>>>> >>> Does this mean that the performance of the crc32c instruction
>on
>>>those CPUs is
>>>> >>> actually slower than a regular C implementation?  That's very
>>>weird.
>>>> >>>
>>>> >>
>>>> >> From the lmbench3 Create and Delete file test on those chips, I
>>>think yes.
>>>> >>
>>>> > 
>>>> > Did you try measuring the performance of the hashing itself, and
>>>not some
>>>> > higher-level filesystem operations?
>>>> > 
>>>> 
>>>> Yes. Was testing on these Zhaoxin CPUs, the result is that with the
>>>same
>>>> input value the generic C implementation takes fewer time than the
>>>> crc32c instruction implementation.
>>>> 
>>>
>>>And that is really "working as intended"?
>>
>>These CPU's crc32c instruction is not working as intended.
>>
>>  Why do these CPUs even
>>>declare that
>>>they support the crc32c instruction, when it is so slow?
>>>
>>
>>The presence of crc32c and some other instructions supports are
>>enumerated by CPUID.01:ECX[SSE4.2] = 1,  other instructions are ok
>>except the crc32c instruction.
>>
>>>Are there any other instruction sets (AES-NI, PCLMUL, SSE, SSE2, AVX,
>>>etc.) that
>>>these CPUs similarly declare support for but they are uselessly slow?
>>
>>No.
>>
>>Sincerely
>>Tonyw
>>
>>>
>>>- Eric
>
>Then the right thing to do is to disable the CPUID bit in the
>vendor-specific startup code.

This way makes these CPUs do not support all instruction sets enumerated
by CPUID.01:ECX[SSE4.2].
While only crc32c instruction is slow, just expect the crc32c-intel driver do not
match these CPUs.

Sincerely
Tonyw

