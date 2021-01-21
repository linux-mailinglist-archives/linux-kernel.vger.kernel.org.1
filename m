Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5239F2FF63C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAUUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:46:04 -0500
Received: from saphodev.broadcom.com ([192.19.232.172]:49076 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbhAUUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:45:36 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 0BD3346B32;
        Thu, 21 Jan 2021 12:44:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0BD3346B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611261884;
        bh=pJqSPhCLxEaf/K5XZRxqMWZzZdmg6FHkG7wWkQ5Qg+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hadffBV3nHLJ1opLGh/26I+97ZmpGHYp5G7l/UreyROHkiCWMPTOcKsQu6yZqKmRd
         v9isA2Oi/Uonj42mrihqQ0ifZ1Ix6aR8de87UNRi1VkhCm7xpLN1Ckt7gZMik8vojw
         4RFGSOcEmIHGVKq0vV3Gvty8MyYf/VGnj1dIQRtk=
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <62f87d72-1804-fb5c-d020-64f2efd2bc0e@broadcom.com>
Date:   Thu, 21 Jan 2021 12:44:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 2021-01-21 12:25 p.m., Masahiro Yamada wrote:
> On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Use python3 instead of python in diffconfig Shebang line.
>> python2 was sunset January 1, 2000 and environments do not need
>> to support python any more.
>>
>> Fixes: b24413180f56 ("tweewide: Fix most Shebang lines")
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  scripts/diffconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/diffconfig b/scripts/diffconfig
>> index 627eba5849b5..d5da5fa05d1d 100755
>> --- a/scripts/diffconfig
>> +++ b/scripts/diffconfig
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/env python
>> +#!/usr/bin/env python3
>>  # SPDX-License-Identifier: GPL-2.0
>>  #
>>  # diffconfig - a tool to compare .config files.
>> --
>> 2.17.1
>>
> Just from curiosity, what problem is this solving?
It is solving the problem that python is long past its life:
https://www.python.org/doc/sunset-python-2/

The 5.11-rc kernel diffconfig doesn't work now due
to the /usr/bin/python change to /usr/bin/env python.

Could we please ensure this makes it into 5.11 and/or
maintains the FIxes tag if it does not?
>
> Is there a distribution where 'python' does not exist,
> but 'python3' does ?
Yes, Python is finally being removed from some distributions
and has already been done so from my yocto builds where
I detected the problem.
>
Thanks,
Scott
