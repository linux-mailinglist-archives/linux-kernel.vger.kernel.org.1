Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BA2C8D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgK3Szr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgK3Szp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:55:45 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D326C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:55:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n137so11021990pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Vx4/FiJNN1SrwnDdCOvxazqKVfbLGSmLYwYBmUjLLI=;
        b=IxPlmO7GPxYk8jDbcom3XunGu65QwSmt67V98TljR9QJZexOLAyVEbotoWLPxsrS6m
         Dnq4QqjuXfLwKLMPfQs5c0wc/yCAbtCPwg7+uZR8pWHxjz/UNzO83Wm9CTpjQCvc/ALO
         eeBB7PtJ4TOJiaoTkkxJbZJG37q+I2/zROTPluZYwiMWX5XlQHsZjhkxbhatEdCXeeOQ
         8ohdclWfKHv8Xyf5/vXUEAl82Pk6EY87ASvTSZz/HDxWZeUT4H/YVxM0D7XeP1yWANcl
         excDDyuHPC6zb63K46lD5AerDoL6LsmeKOzg1r1mk3jPC+E++eEUbBwrvwhRI6dGwzIQ
         FxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Vx4/FiJNN1SrwnDdCOvxazqKVfbLGSmLYwYBmUjLLI=;
        b=fcOeIO5mvjiCsyc2JDX4JnFxW3GkI1v4guV8NhrUGIvVrWKBsBxNlhZhQWPAYoXSyu
         EvR9TuG2nyxTyIsg6h+4sJ3gNyDc0gmE6J8SHoSC2FQgwcKlazq+t12i7aN4vtgX1gyL
         QF1YtsUawOWKl5S8Tju/QWIGcD9Zw0emEymInaJoUdkruEdxK9br1ZYry3K54h8alj0c
         9IOqwc2DkXVJMXQGAlQ765xmKomsjo1D/sRLvhlPToEMYLYhC1/z+SzWudgEJcVDZOmh
         4jtQi/1oEhPDqSdgICJvwEcm17lNYGkwWFkJlqPzkP2cusQKc6XkPaNcEkgp6XPggURo
         a0RA==
X-Gm-Message-State: AOAM531fq/OJp+iN5bzAArIoRLblrOmMcAhZlAf/Rs/7KAhoRLu+3Ia0
        lFWANJfZ5fbaGeuUKhr0Gjdr3g==
X-Google-Smtp-Source: ABdhPJxvA2ew/N0+nPbOex6g0qlEJ0rB2I0BryChaExqkZ1KtBtIRREOiPSAA3kirWXgTAnEpD69ng==
X-Received: by 2002:a65:68cd:: with SMTP id k13mr8988005pgt.115.1606762504810;
        Mon, 30 Nov 2020 10:55:04 -0800 (PST)
Received: from google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
        by smtp.gmail.com with ESMTPSA id p127sm17718569pfp.93.2020.11.30.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:55:03 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:55:00 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201130185500.GB744128@google.com>
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de>
 <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201120142954.GC2855047@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:29:54AM -0800, Keith Busch wrote:
>On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>> > This patch changes the NVMe PCI implementation to cache host_mem_descs
>> > in non-DMA memory instead of depending on descriptors stored in DMA
>> > memory. This change is needed under the malicious-hypervisor threat
>> > model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>> > guest memory to make it unreadable. Some versions of these architectures
>> > also make it cryptographically hard to modify guest memory without
>> > detection.
>>
>> I don't think this is a useful threat model, and I've not seen a
>> discussion on lkml where we had any discussion on this kind of threat
>> model either.
>>
>> Before you start sending patches that regress optimizations in various
>> drivers (and there will be lots with this model) we need to have a
>> broader discussion first.
>>
>> And HMB support, which is for low-end consumer devices that are usually
>> not directly assigned to VMs aren't a good starting point for this.
>
>Yeah, while doing this for HMB isn't really a performance concern, this
>method for chaining SGL/PRP lists would be.

I see that this answers a question I just asked in my reply to the 
previous message. Sorry about that. Can you please point me to the code 
in question?

>
>And perhaps more importantly, the proposed mitigation only lets the
>guest silently carry on from such an attack while the device is surely
>corrupting something. I think we'd rather free the wrong address since
>that may at least eventually raise an error.

 From a security perspective, I'd rather not free the wrong address, 
since that could lead to an attack on the guest (use-after-free). But I 
agree with the concern about fixing the problem silently. Maybe this 
code should instead raise an error itself in this case after comparing 
the cached values with the values stored in the DMA memory?
