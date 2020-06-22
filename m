Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5E2041E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFVUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 16:24:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54177 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgFVUYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:24:09 -0400
Received: from [IPv6:2601:646:8600:3281:1cd3:54b7:ac01:fada] ([IPv6:2601:646:8600:3281:1cd3:54b7:ac01:fada])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 05MKNrdt2206928
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 22 Jun 2020 13:23:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 05MKNrdt2206928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020052301; t=1592857438;
        bh=IqSEQrF9676ZCrhQXlvEtdWT50/OfL/HQJpEwhfhYeo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Xj0h1W3K339hI31OzLc+tPkmcVnQBl1DNFO19MUP/FrkBOFLRVmqrJAQj1sEeGPhV
         3oU9qwCACo+BErBRYGpD77J/m3srt2nJyX7xv2MMuz+reCQeqWUSiHW9+kQNtubCKW
         B/+zblOD97GgFNP2ISOqWq5fiGmUlHuDkBr+gyNBpgbE98o/gI8TTbBfqkckt6bDdS
         Ekr+lC2Fci4Ee9BEYeQSjJ9u6gqnj8uWBW0bz+QFmFZyg36jnrk5F20+YvNtOtzIVM
         zn6vGxdG2i+0rqhwOzkDIsXfBdBM0g1J4DSVLeHMhl4QzCUf+ZFqZMPTq4tNxnc0JZ
         UEULYbTrNXvNQ==
Date:   Mon, 22 Jun 2020 13:23:45 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exY+oyEXt3YGf-f8vwwbQSMkokz=MsWazaekA4F0ZDo1qoQ@mail.gmail.com>
References: <20200619143056.24538-1-trini@konsulko.com> <CAP6exY+oyEXt3YGf-f8vwwbQSMkokz=MsWazaekA4F0ZDo1qoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] initrd: Remove erroneous comment
To:     ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>
CC:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
From:   hpa@zytor.com
Message-ID: <34B3C49E-F12A-41FF-AC2C-11FA53A1FCF6@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 19, 2020 5:03:33 PM PDT, ron minnich <rminnich@gmail=2Ecom> wrote:
>It seems fine to me, but I did not initially object to the use of that
>name anyway=2E hpa, what do you think?
>
>On Fri, Jun 19, 2020 at 7:31 AM Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> Most architectures have been passing the location of an initrd via
>the
>> initrd=3D option since their inception=2E  Remove the comment as it's
>both
>> wrong and unrelated to the commit that introduced it=2E
>>
>> Fixes: 694cfd87b0c8 ("x86/setup: Add an initrdmem=3D option to specify
>initrd physical address")
>> Cc: Andrew Morton <akpm@linux-foundation=2Eorg>
>> Cc: Borislav Petkov <bp@suse=2Ede>
>> Cc: Dominik Brodowski <linux@dominikbrodowski=2Enet>
>> Cc: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Cc: Ronald G=2E Minnich <rminnich@gmail=2Ecom>
>> Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>> ---
>> For a bit more context, I assume there's been some confusion between
>> "initrd" being a keyword in things like extlinux=2Econf and also that
>for
>> quite a long time now initrd information is passed via device tree
>and
>> not the command line on relevant architectures=2E  But it's still true
>> that it's been a valid command line option to the kernel since the
>90s=2E
>> It's just the case that in 2018 the code was consolidated from under
>> arch/ and in to this file=2E
>> ---
>>  init/do_mounts_initrd=2Ec | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/init/do_mounts_initrd=2Ec b/init/do_mounts_initrd=2Ec
>> index d72beda824aa=2E=2E53314d7da4be 100644
>> --- a/init/do_mounts_initrd=2Ec
>> +++ b/init/do_mounts_initrd=2Ec
>> @@ -45,11 +45,6 @@ static int __init early_initrdmem(char *p)
>>  }
>>  early_param("initrdmem", early_initrdmem);
>>
>> -/*
>> - * This is here as the initrd keyword has been in use since 11/2018
>> - * on ARM, PowerPC, and MIPS=2E
>> - * It should not be; it is reserved for bootloaders=2E
>> - */
>>  static int __init early_initrd(char *p)
>>  {
>>         return early_initrdmem(p);
>> --
>> 2=2E17=2E1
>>

Well, I observe that it was documented as reserved for bootloaders since t=
he mid-90s at least=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
