Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930052999DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394712AbgJZWsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394704AbgJZWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603752489;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZENRY/OqurIFQi4CLnDtE3iXJd2mbvXnYEHQia0UHw=;
        b=Z0qtGEy2pivgy8wWXeIWYPwmfNSoGdE3/DnL4bk6McU6Xau/5HzZTHNVgZbdVR7nnMxJDk
        a4P3yzXijYwbKKXzpz89nrun1y5ZtHJpOmxal1ON0nQRDljAj+Y8b0uQT/A9HW5hHahYDE
        aRvg8rLdAtTawIE+nHfRnrK86DZtBNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-0DUL1UT2NrKgBZJ7BUWjsA-1; Mon, 26 Oct 2020 18:48:07 -0400
X-MC-Unique: 0DUL1UT2NrKgBZJ7BUWjsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1268C186DD25;
        Mon, 26 Oct 2020 22:48:06 +0000 (UTC)
Received: from [10.64.54.78] (vpn2-54-78.bne.redhat.com [10.64.54.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 636BC55781;
        Mon, 26 Oct 2020 22:48:04 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/3] KVM: arm64: Check if 52-bits PA is enabled
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-2-gshan@redhat.com> <871rhmpr92.wl-maz@kernel.org>
 <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
 <a676f540d19fba2468fd1a801948826a@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <11639356-397a-4a25-879a-0c91d9845041@redhat.com>
Date:   Tue, 27 Oct 2020 09:48:01 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a676f540d19fba2468fd1a801948826a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/20 7:53 PM, Marc Zyngier wrote:
> On 2020-10-25 22:23, Gavin Shan wrote:
>> Hi Marc,
>>
>> On 10/25/20 8:52 PM, Marc Zyngier wrote:
>>> On Sun, 25 Oct 2020 01:27:37 +0100,
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> The 52-bits physical address is disabled until CONFIG_ARM64_PA_BITS_52
>>>> is chosen. This uses option for that check, to avoid the unconditional
>>>> check on PAGE_SHIFT in the hot path and thus save some CPU cycles.
>>>
>>> PAGE_SHIFT is known at compile time, and this code is dropped by the
>>> compiler if the selected page size is not 64K. This patch really only
>>> makes the code slightly less readable and the "CPU cycles" argument
>>> doesn't hold at all.
>>>
>>> So what are you trying to solve exactly?
>>>
>>
>> There are two points covered by the patch: (1) The 52-bits physical address
>> is visible only when CONFIG_ARM64_PA_BITS_52 is enabled in arch/arm64 code.
>> The code looks consistent with this option used here. (2) I had the assumption
>> that gcc doesn't optimize the code and PAGE_SHIFT is always checked in order
>> to get higher 4 physical address bits, but you said gcc should optimize the
>> code accordingly. However, it would be still nice to make the code explicit.
> 
> Conditional compilation only results in more breakages, specially for configs
> that hardly anyone uses (big-endian and 64K pages are the two that bitrot very
> quickly).
> 
> So if anything can build without #ifdef, I'll take that anytime. If the compiler
> doesn't optimize it away, let's fix the compiler.
> 

Ok. PATCH[1] and PATCH[2] have been dropped in v2.

Cheers,
Gavin

