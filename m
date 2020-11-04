Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E32A633B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKDLZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729427AbgKDLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604489132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BNZIwcWLTN05rBOOzJO8LbkDHmlhi2kEJTRvtJ7hAU=;
        b=J3Fa1msVyRjpeUHMPEeWlG6a9vKAIMc8UBGhWjKx8F052Zn/aMNMbJGAJlftUc03FdmQmJ
        tLm7of+FKLLXtrw0RAaGYVUu7uSB6TcJHmKKKKjdfR4RP7uh0NHHzqItjKtDCQUEpabXON
        scYiiqX53AWdbY5x4AIQlgADlpdkEVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-iUgIBh_vOy2h72owMJRDAA-1; Wed, 04 Nov 2020 06:25:30 -0500
X-MC-Unique: iUgIBh_vOy2h72owMJRDAA-1
Received: by mail-wr1-f69.google.com with SMTP id p12so1632192wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BNZIwcWLTN05rBOOzJO8LbkDHmlhi2kEJTRvtJ7hAU=;
        b=rrbIyi3yPIn/uPVh39zKKYwzXwHGOrgQPOBrN9Enkz7wp2rYQ17WpauoxsdA7m2nFM
         IZMSIb9dSiJ4H8pCNPzZHRcM8K0rdVnQET7yLxRUCbKpaavekocsMcmVzBn68ilaOMCL
         6Yx8UdutfCAODOfKazhAaMk4b71sKBL9eAVCmQ/pFWSnLK5Aus626Mn3YDglYoS++obJ
         KkC6gZaYAc7j5j6qbLLBfz/uMrcohauE5zZfxVbNd3HaVAWUQflECpsVN2VIqxyNQ4q7
         L0t2BhFgRYQl7aILunhfUW3J1NCDd0usIENwBXrWBfV2zEG3d0c588kjxXYQ8mCNdAKo
         fpQQ==
X-Gm-Message-State: AOAM531oZoU5H0jJu3nL62VhJUIn5PhiZAY2Bf3PNwkZjG6x+vpEFWD/
        a6ft/xyw4xkmIPdwEUPo3K+ZjdhUhhw9tOAFY1o8XfzT++Ayd1UCXmizSSDY9aaXLfXA9DD5Y0g
        MKw6aX/9ZpX09sCJVF7nR76ES
X-Received: by 2002:a5d:568a:: with SMTP id f10mr31437358wrv.30.1604489129505;
        Wed, 04 Nov 2020 03:25:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy78sXqYN4w55Ebpjk1oN0oNUR1qsCdGgREY39d7+iO2OT4Btt5UeKFF4E22t/folmBpRds0A==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr31437337wrv.30.1604489129348;
        Wed, 04 Nov 2020 03:25:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u10sm2185735wrw.36.2020.11.04.03.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 03:25:28 -0800 (PST)
Subject: Re: [PATCH v2 1/2] sched/wait: Add add_wait_queue_priority()
To:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kvm@vger.kernel.org
References: <20201026175325.585623-1-dwmw2@infradead.org>
 <20201027143944.648769-1-dwmw2@infradead.org>
 <20201027143944.648769-2-dwmw2@infradead.org>
 <20201028143509.GA2628@hirez.programming.kicks-ass.net>
 <ef4660dba8135ca5a1dc7e854babcf65d8cef46f.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fec9ad1-f5b9-6a02-64f7-95aa83668773@redhat.com>
Date:   Wed, 4 Nov 2020 12:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ef4660dba8135ca5a1dc7e854babcf65d8cef46f.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/20 10:35, David Woodhouse wrote:
> On Wed, 2020-10-28 at 15:35 +0100, Peter Zijlstra wrote:
>> On Tue, Oct 27, 2020 at 02:39:43PM +0000, David Woodhouse wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> This allows an exclusive wait_queue_entry to be added at the head of the
>>> queue, instead of the tail as normal. Thus, it gets to consume events
>>> first without allowing non-exclusive waiters to be woken at all.
>>>
>>> The (first) intended use is for KVM IRQFD, which currently has
>>> inconsistent behaviour depending on whether posted interrupts are
>>> available or not. If they are, KVM will bypass the eventfd completely
>>> and deliver interrupts directly to the appropriate vCPU. If not, events
>>> are delivered through the eventfd and userspace will receive them when
>>> polling on the eventfd.
>>>
>>> By using add_wait_queue_priority(), KVM will be able to consistently
>>> consume events within the kernel without accidentally exposing them
>>> to userspace when they're supposed to be bypassed. This, in turn, means
>>> that userspace doesn't have to jump through hoops to avoid listening
>>> on the erroneously noisy eventfd and injecting duplicate interrupts.
>>>
>>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks. Paolo, the conclusion was that you were going to take this set
> through the KVM tree, wasn't it?
> 

Yes.

Paolo

