Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BF2A9BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgKFSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:15:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbgKFSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604686539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njXTiXf5+NVxfZwZ7si6Kzqa4dEa5pfbQK7/u8nZLAA=;
        b=iPd6S2DAhT/JkvVpS72qklS5fxP733ypgd7lMAHEojZz7RedJyOK955O6wVqo4Jbwi9WSC
        OceoykFo3imYqjafS6mgbnEYoMFoDD0BRRcU65fBTWr5ynzaifwsjdD1tmcWxzRCQdpz5s
        MN+4KJqB7cl5CfbV06/Jmo2i7yC2tY0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Wmxk_r2tMP-7MPdb-WEX8g-1; Fri, 06 Nov 2020 13:15:35 -0500
X-MC-Unique: Wmxk_r2tMP-7MPdb-WEX8g-1
Received: by mail-wr1-f71.google.com with SMTP id h8so761446wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=njXTiXf5+NVxfZwZ7si6Kzqa4dEa5pfbQK7/u8nZLAA=;
        b=FDYM6VMXTnyarfcC4VvyOu5iX8SP2tt9hRYmMwPVcQ1TmMn52omAmq1VknyAlkV9NW
         AEcOV4TEgwSkCbZccp4HUqAoTPMe+tEzh92pBtasaF8ZNS1Rhk+Ma4ITWBduBdygy44t
         xYFCUymFdEtIw9rgF7ov+c1O3hMHyi2z7jspvZcY6wHOfs3VSntxEAeIVjzLDOn54dOd
         Ho5ncKGRW6HGH6Fg55vF8zO6mWVhnSoSARqKemlH8EvJK/osDW8IWkv+ikex9YYolu+R
         hxEyAiyPUfbDUrkALkQIEzIcA3KTkepPKtO9TABmQ/hGnxbKq+TQovJoVng66dwoaXK7
         7AZQ==
X-Gm-Message-State: AOAM531lh8v1ARdgWRqqp8XccitxpoW6fnxcNA+BKgnLXhVGq+SYvscP
        J458ZRXioPCEE8hXhIEijY2LmXAduBsX8MpCQdSrsrxjpuB2H6guzi+L0tOCFKpegxrxHypIE47
        thZlSW3bVRYdGPNsK/OTmgGQM
X-Received: by 2002:a1c:b746:: with SMTP id h67mr839102wmf.43.1604686534021;
        Fri, 06 Nov 2020 10:15:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydW3XZS8v51uQtbtqv7TiJ/HZfs4GAgZWRHDAbg152wQgVp/+3LEpV6UAhQtYmHyBErzbFGQ==
X-Received: by 2002:a1c:b746:: with SMTP id h67mr839087wmf.43.1604686533852;
        Fri, 06 Nov 2020 10:15:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c8sm3300512wrv.26.2020.11.06.10.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 10:15:33 -0800 (PST)
Subject: Re: [PATCH v13 13/14] KVM: selftests: Let dirty_log_test async for
 dirty ring test
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
 <20201001012239.6159-1-peterx@redhat.com>
 <6d5eb99e-e068-e5a6-522f-07ef9c33127f@redhat.com>
 <20201106180610.GC138364@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc32ce97-cbd2-07da-b8ca-30ea67c2d4e3@redhat.com>
Date:   Fri, 6 Nov 2020 19:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106180610.GC138364@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/20 19:06, Peter Xu wrote:
>> +	pthread_sigmask(0, NULL, sigset);
> Not extremely important, but still better with SIG_BLOCK imho, since it seems
> not all archs defined SIG_BLOCK as zero.
> 

If the second argument is NULL, the first is unused.

Paolo

