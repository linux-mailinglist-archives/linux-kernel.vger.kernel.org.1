Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C405C2B94EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgKSOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727512AbgKSOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605796882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJ+qneU2nhAWwjWgaWCzq4AJrRh+NHf3E08bJzVcmVY=;
        b=FAdq1bRzIyqHRLbUInRzr1Qbv8YWmb2CE5BNoxvz21wzwcgKtGv83t/aV1mjoGH2Pez0GK
        CCsSrAQQJFP3luAIPZqsBGGESlfbAVWWJQ9hTdMSYwBtwoyQTJTdOroym8+Pht1isbqtS7
        LLPR1D8nggK2AP8CUKpNSaVekueWrR8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-R1g0JWenNbqMmIanG0uOGQ-1; Thu, 19 Nov 2020 09:41:18 -0500
X-MC-Unique: R1g0JWenNbqMmIanG0uOGQ-1
Received: by mail-wr1-f70.google.com with SMTP id y2so2113142wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJ+qneU2nhAWwjWgaWCzq4AJrRh+NHf3E08bJzVcmVY=;
        b=sw9wypu+i06CPIcSTq9su7370NWsuNeA5I4Jwuqn9Om/g4SeqzaAXmuPYCyXDAXgYD
         YpqDQeSM7eu24gg7SUpj9Oe+TgzHs+15r3XPGKtYz7FPVISpDwvOuwpeviBMazCwCyCA
         l7BvzK1+yKBuK6DLOfahDC/52or5RDDDe9MKYWi0XrpcnnX/McV4Qfgj6jo/E3s1Px16
         wRzFFdeMxlIG5bjSBwJ0gqMyk20pFaXiVgqyRhazLzG4JnpaZhi0SQUZ4OF2nz6RKSj4
         E+Ho3QlJRfN/VTUqwFjlvxDGUpCXnZIciJlW5q8gU50aD1asJ5ri1JUFxKH9wqbQ24mb
         b1aw==
X-Gm-Message-State: AOAM532SdrB2LhSxPdBG40dLSP26RGXIamA6b8aNyqM8UZLPx38du+PI
        nj4rW5hPaSTsRNQafJ/rklDmTT6M0dqbsUwjGcZZvk8dERkN5BlakuK+Soha3reRBsvUJLbvPVe
        FvsTArzuMg+k305wPWPFc0hAO
X-Received: by 2002:a7b:c954:: with SMTP id i20mr5258345wml.56.1605796876999;
        Thu, 19 Nov 2020 06:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3l0Gn+NQD1LvOGgSReyW21vrxXik2TUo1EcRZw8L6b3xoogNTPtUgQEg/Aym/jdTNzpOnpw==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr5258318wml.56.1605796876768;
        Thu, 19 Nov 2020 06:41:16 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id w186sm83103wmb.26.2020.11.19.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 06:41:16 -0800 (PST)
Date:   Thu, 19 Nov 2020 15:41:13 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dexuan Cui <decui@microsoft.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Duncan <davdunc@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Graf <graf@amazon.de>
Subject: Re: [PATCH net] vsock: forward all packets to the host when no H2G
 is registered
Message-ID: <20201119144113.glp5mncnrl54nfkn@steredhat>
References: <20201112133837.34183-1-sgarzare@redhat.com>
 <20201119140359.GE838210@stefanha-x1.localdomain>
 <ffdc9e0c-fee2-e334-053b-0a26305b55ae@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ffdc9e0c-fee2-e334-053b-0a26305b55ae@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:25:42PM +0100, Alexander Graf wrote:
>
>On 19.11.20 15:03, Stefan Hajnoczi wrote:
>>On Thu, Nov 12, 2020 at 02:38:37PM +0100, Stefano Garzarella wrote:
>>>Before commit c0cfa2d8a788 ("vsock: add multi-transports support"),
>>>if a G2H transport was loaded (e.g. virtio transport), every packets
>>>was forwarded to the host, regardless of the destination CID.
>>>The H2G transports implemented until then (vhost-vsock, VMCI) always
>>>responded with an error, if the destination CID was not
>>>VMADDR_CID_HOST.
>>>
>>> From that commit, we are using the remote CID to decide which
>>>transport to use, so packets with remote CID > VMADDR_CID_HOST(2)
>>>are sent only through H2G transport. If no H2G is available, packets
>>>are discarded directly in the guest.
>>>
>>>Some use cases (e.g. Nitro Enclaves [1]) rely on the old behaviour
>>>to implement sibling VMs communication, so we restore the old
>>>behavior when no H2G is registered.
>>>It will be up to the host to discard packets if the destination is
>>>not the right one. As it was already implemented before adding
>>>multi-transport support.
>>>
>>>Tested with nested QEMU/KVM by me and Nitro Enclaves by Andra.
>>>
>>>[1] Documentation/virt/ne_overview.rst
>>>
>>>Cc: Jorgen Hansen <jhansen@vmware.com>
>>>Cc: Dexuan Cui <decui@microsoft.com>
>>>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>Reported-by: Andra Paraschiv <andraprs@amazon.com>
>>>Tested-by: Andra Paraschiv <andraprs@amazon.com>
>>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>---
>>>  net/vmw_vsock/af_vsock.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>
>Is there anything we have to do to also get this into the affected 
>stable trees? :)
>

The patch is already queued by Jakub in the netdev stable queue:
https://patchwork.kernel.org/bundle/netdev/stable/?series=382773&state=*

Stefano

