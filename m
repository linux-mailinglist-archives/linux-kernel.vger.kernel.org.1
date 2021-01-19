Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D632FC0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbhASUXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:23:14 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:38624 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730467AbhASUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:22:37 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id AA0E030E76;
        Tue, 19 Jan 2021 12:21:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AA0E030E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611087694;
        bh=lZ/JMNpu6rfS9YeYxhVgrk4nqkhdY79CK6WmTClAM/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aYbUj63BQSZKC++091Gzm4uOa8RxHIw8yV5j512+pssyyW2NQroamUFHuh4N5lLYI
         KZrGhbgJBBMKEGyz0D2lnBykecfjWvy2mF2NhQLWOehUz3DgQSh0zFfybRUL4Gadxo
         sS9AC8etDvdzqprb/p75sw+vz2dkrPeca6Q4TJFs=
Subject: Re: [PATCH v8 00/13] Add Broadcom VK driver
To:     Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
 <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com>
 <YAU2HnpwqGSNi3zF@kroah.com>
 <CAOesGMjmFPPmH6deqEwifdchpiN_xaCC362NSaJk3Tv=n-7b+g@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <09b6e829-75b8-4f16-3e01-c7193640d9c6@broadcom.com>
Date:   Tue, 19 Jan 2021 12:21:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMjmFPPmH6deqEwifdchpiN_xaCC362NSaJk3Tv=n-7b+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2021-01-18 3:06 p.m., Olof Johansson wrote:
> On Sun, Jan 17, 2021 at 11:17 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Sun, Jan 17, 2021 at 10:47:59AM -0800, Olof Johansson wrote:
>>> Hi,
>>>
>>> On Mon, Nov 30, 2020 at 10:42 AM Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>> This patch series drops previous patches in [1]
>>>> that were incorporated by Kees Cook into patch series
>>>> "Introduce partial kernel_read_file() support" [2].
>>>>
>>>> Remaining patches are contained in this series to add Broadcom VK driver.
>>>> (which depends on request_firmware_into_buf API addition which has
>>>> now been accepted into the upstream kernel as of v5.10-rc1).
>>>>
>>>> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
>>>> [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
>>>
>>> I've been following this series for some time, and I think the code is
>>> ready to go in.
>>>
>>> Greg, mind queuing this up in the misc tree?
>> I will need a new version, this is long gone from my queue.
> I'll let Scott repost then (with acks applied etc)
I can send another patch version with Olof's acks applied to each patch.
Please let me know if that is what you are looking for?
>
>> And hopefully the tty layer abuse is gone... :)
> There's a simple tty driver as the final patch in the series, but it's
> pretty straightforward.
>
> If you've still got concerns with it, the rest of the series should
> stand on its own and should be mergeable without that piece.
Yes, I placed the patch at the end of the series so it can be dropped
if that is what is required to accept the rest of the patches.

There has been no viable solution suggested for replacing this functionality.
We need a tty-like interface that works via access to the circular buffers
in PCIe BAR space and interrupts.

The vk tty devices are a direct replacement to attaching serial cables.
In real production environment it is not possible to attach such cables.

I can work on an alternative tty solution and send such patch later
but I don't know what is going to prevent the tty "abuse".
>
>
> -Olof
Regards,
Scott
