Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A498D1A9B38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 12:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896554AbgDOKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 06:44:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2896512AbgDOKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586947393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNKRF/g9GTKiJfx6XpsmKFnQkmViCDbB0eElZUOgBB0=;
        b=CgqLhOqrbnMMezak2sKFn18s5x0Kcq6icvuywJyhDihesf7VlG0UNyie89meGUPV4SioKH
        tQbWU0WdDo77v3cJJvbgKUj7+YsdN7QxxQuVCPNHfPxZ39Jo58av7nbDybDUZPtQt6H9is
        qDlozoTgZpywGtG682a84L6d8vLDxxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-5F2ZtMycPQaTNZtQLbx7zQ-1; Wed, 15 Apr 2020 06:43:12 -0400
X-MC-Unique: 5F2ZtMycPQaTNZtQLbx7zQ-1
Received: by mail-wr1-f70.google.com with SMTP id p16so7568087wro.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pNKRF/g9GTKiJfx6XpsmKFnQkmViCDbB0eElZUOgBB0=;
        b=WnWhTYKn8hDv7jG89xxaA76c5o1ZXMCFMwTxIn86ZvGuX1FuacJM9D0ezfRhzhHC3x
         QMeQ3WH+rO1RPdPJOZRx8WvOfh/gbFzHA/YPP0z5GUVbR1a2S/wNwdxqP2H9y4s5I3xv
         KqPZ6repno3ALTrLubf1iu99UyHQdAsm0gxPDMCXOWyOxRAqKgyFw1FT0h6nRiI583xA
         5bhDDFYZwqWP/jroxxeQSzzMkZ3ls9jbs86i8bDh2e1Z5vF26BqDa+emPCGRmy3A+jl6
         p0q4MzR/FjgIcJ1R6mqnoWpuUxOq8f3JxPZ+ssEioMn3qv6tMhaXFpAfhrBzqbz83Dzl
         +x0g==
X-Gm-Message-State: AGi0PuaIlwuOzccGBwX/W6ugpRe4WebpjV6xzIstS7FD+KBBVY03/YKC
        Rrn7F41XU65HdUJDL2E5vfPvJE5kn+p74jU+y0Uu661lQzQ8E7wAjFgLU1yi7Yr1W+fsGSszPpS
        C2MJre6nURfdXEoDk52PpvHtP
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4456052wme.75.1586947390579;
        Wed, 15 Apr 2020 03:43:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKhnKuWPRttaxxiCUXsxLxq1NvxVDqGPZoJ9Xtcgg2zFz4OAoyXX13siir7frpyClDWevEokw==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4456039wme.75.1586947390362;
        Wed, 15 Apr 2020 03:43:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h2sm22873378wmf.34.2020.04.15.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:43:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to pointer primary_channel
In-Reply-To: <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
References: <20200414152343.243166-1-colin.king@canonical.com> <87d08axb7k.fsf@vitty.brq.redhat.com> <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
Date:   Wed, 15 Apr 2020 12:43:08 +0200
Message-ID: <87wo6hvxkz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> writes:

> On 14/04/2020 17:51, Vitaly Kuznetsov wrote:
>> Colin King <colin.king@canonical.com> writes:
>> 
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The pointer primary_channel is being assigned with a value that is never,
>>> The assignment is redundant and can be removed.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/hv/channel_mgmt.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>>> index ffd7fffa5f83..f7bbb8dc4b0f 100644
>>> --- a/drivers/hv/channel_mgmt.c
>>> +++ b/drivers/hv/channel_mgmt.c
>>> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>>>  
>>>  	if (channel->primary_channel == NULL) {
>>>  		list_del(&channel->listentry);
>>> -
>>> -		primary_channel = channel;
>>>  	} else {
>>>  		primary_channel = channel->primary_channel;
>>>  		spin_lock_irqsave(&primary_channel->lock, flags);
>> 
>> If I'm looking at the right source (5.7-rc1) it *is* beeing used:
>> 
>> 	if (channel->primary_channel == NULL) {
>> 		list_del(&channel->listentry);
>> 
>> 		primary_channel = channel;
>> 	} else {
>> 		primary_channel = channel->primary_channel;
>> 		spin_lock_irqsave(&primary_channel->lock, flags);
>> 		list_del(&channel->sc_list);
>> 		spin_unlock_irqrestore(&primary_channel->lock, flags);
>> 	}
>> 
>> 	/*
>> 	 * We need to free the bit for init_vp_index() to work in the case
>> 	 * of sub-channel, when we reload drivers like hv_netvsc.
>> 	 */
>> 	if (channel->affinity_policy == HV_LOCALIZED)
>> 		cpumask_clear_cpu(channel->target_cpu,
>> 				  &primary_channel->alloced_cpus_in_node);
>>                                    ^^^^^ HERE ^^^^^
>> 
>
> I was basing my change on linux-next that has removed a hunk of code:
>
> commit bcefa400900739310e8ef0cb34cbe029c404455c
> Author: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Date:   Mon Apr 6 02:15:11 2020 +0200
>
>     Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
> logic
>

Ah, please add the right 'Fixes:' tag then.

-- 
Vitaly

