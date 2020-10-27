Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504CA29A609
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508634AbgJ0IB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508625AbgJ0IB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603785716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBD7mu22cE6G+7hG6AbV4IbHD/toQo3DYDwrledmHWk=;
        b=RSyyVled16tHReQ6ngJgC5k5F2bwxQRTKA2u195JB4i9QN7zelVfqkzqlxCx2N619TisYU
        RGKgWD/2Ug9Yz7QZ+GpuO6kuvkiTMLVWNDkdJkY3Kv/wi+MMzTsh5hMiJ3S2CWIOADk05W
        YwaD1mgPQuLuZGF6oF5aHClskAC9w0U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-xX9nxiBhM6mVN6E9IZaeng-1; Tue, 27 Oct 2020 04:01:54 -0400
X-MC-Unique: xX9nxiBhM6mVN6E9IZaeng-1
Received: by mail-wm1-f70.google.com with SMTP id l17so141295wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBD7mu22cE6G+7hG6AbV4IbHD/toQo3DYDwrledmHWk=;
        b=nBwH4DfyqFx6bjeHWKF2DFzmeVc2m4Qb9Q5g4tgoxNPGGkeNOBMPaz/s4URjXsIKql
         wGGU+p0Kx5DdZ/aqFr9cD15YOX5OGx0pJ4/QZOgI0fCRoXO9BPiGhiKvEuBF92SfWvtR
         d50t46eu65OmCysFNJ6qdQ99+mTXSClFA5w6OEEO0r9SQBoLBdM5946pyzh5MzpwKwgK
         HaYQCzMve72YNX9LYtj22eR4HHQqqAXMVswVLd3r3VAdTUw7XbOVFsTSM6DqDIRtd8ij
         hgNRS9XaVlzWfPQ9P8Y7TwIKm6ky1RncOBvypjJjPcGThRJuRNVEbuK9zus1FLGGe2WO
         24uA==
X-Gm-Message-State: AOAM530YZKV1hwx5qr4REDXxGxfUSMCS1Tt7LwYSMLh7dwqMnJ5wGq2S
        x1VcHg49/pb1zWC7RmAcyRjBXWnuiu2fl2NtKnpuwth0xsk4dv4sLxKI47yJsQ4tt/atuIB2hBL
        fTFXtT20O0XosBtfAyL6TYaga
X-Received: by 2002:a5d:414f:: with SMTP id c15mr1270433wrq.59.1603785713425;
        Tue, 27 Oct 2020 01:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMAuRIWL2j7/iF5oAvwo4DEXeh0JSnKPKRJh1NO6ZDaipqPkf8A7vhKevxFzqK+xr1WYu5GA==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr1270398wrq.59.1603785713124;
        Tue, 27 Oct 2020 01:01:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p21sm920442wmc.28.2020.10.27.01.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:01:52 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] kvm/eventfd: Use priority waitqueue to catch
 events before userspace
To:     David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20201026175325.585623-1-dwmw2@infradead.org>
 <20201026175325.585623-2-dwmw2@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
Date:   Tue, 27 Oct 2020 09:01:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026175325.585623-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/20 18:53, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> As far as I can tell, when we use posted interrupts we silently cut off
> the events from userspace, if it's listening on the same eventfd that
> feeds the irqfd.
> 
> I like that behaviour. Let's do it all the time, even without posted
> interrupts. It makes it much easier to handle IRQ remapping invalidation
> without having to constantly add/remove the fd from the userspace poll
> set. We can just leave userspace polling on it, and the bypass will...
> well... bypass it.

This looks good, though of course it depends on the somewhat hackish
patch 1. However don't you need to read the eventfd as well, since
userspace will never be able to do so?

Paolo

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  virt/kvm/eventfd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index d6408bb497dc..39443e2f72bf 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -191,6 +191,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
>  	struct kvm *kvm = irqfd->kvm;
>  	unsigned seq;
>  	int idx;
> +	int ret = 0;
>  
>  	if (flags & EPOLLIN) {
>  		idx = srcu_read_lock(&kvm->irq_srcu);
> @@ -204,6 +205,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
>  					      false) == -EWOULDBLOCK)
>  			schedule_work(&irqfd->inject);
>  		srcu_read_unlock(&kvm->irq_srcu, idx);
> +		ret = 1;
>  	}
>  
>  	if (flags & EPOLLHUP) {
> @@ -227,7 +229,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
>  		spin_unlock_irqrestore(&kvm->irqfds.lock, iflags);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void
> @@ -236,7 +238,7 @@ irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
>  {
>  	struct kvm_kernel_irqfd *irqfd =
>  		container_of(pt, struct kvm_kernel_irqfd, pt);
> -	add_wait_queue(wqh, &irqfd->wait);
> +	add_wait_queue_priority(wqh, &irqfd->wait);
>  }
>  
>  /* Must be called under irqfds.lock */
> 

