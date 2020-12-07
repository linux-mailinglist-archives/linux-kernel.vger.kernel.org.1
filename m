Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D12D0DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLGKG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgLGKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607335532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ0EqwVdDcSntQ8HHIG1G0YXEUcwMRTK4xGx14tFFhk=;
        b=LsY7DDwlzrJC/7Z7O1uuazGnwlTLtAf46XTHCAP6XDl5BtAG5XcdARJ3I5tdBBRBER/dWF
        7gJFV9dgU1mgJtkgAShaI0wOkDkdeefTfF5jmRSiw+W47h704v5AmJodAZ+uCq4ZNiBNQg
        aJmRD3aImMBR3zXvnRA9QAOGmAlxfsk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-UAfhNY01Phy6rMSF4MFlyA-1; Mon, 07 Dec 2020 05:05:30 -0500
X-MC-Unique: UAfhNY01Phy6rMSF4MFlyA-1
Received: by mail-wr1-f69.google.com with SMTP id u29so256027wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 02:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJ0EqwVdDcSntQ8HHIG1G0YXEUcwMRTK4xGx14tFFhk=;
        b=YYmCPpB+S8izKCwN1/Fi7ti0iLIM25baMxBl6N/zinZ8LSdtEN0t1KlY1HWVIlYdT2
         yAsC/DMw3VHRKu7R0c1e5juct1XezehW2XBs8GkFQR0ZIBYWIFIXiw29DL9R+VTpjj6K
         G+xiTNhvCnZqnGwswwSL3E8RTELLPoO4uZmv0zLVmqy4CjMVDaXV4VaA9XNT0YPzf2gr
         3FShJ++6m7StM5Xgen7q62u604n3hbW4qIHGKlG/Y3m4ccQ1ap08kddWP99pqVNdjAAo
         8VnW+jx+3pc1RwsuHlSv3FnZ0v0zJZDCZvly84HBsm3FXNu+cpRbharuK0jZKjDzQLSq
         QDnw==
X-Gm-Message-State: AOAM531kSIMvRMSp8eOyK4LwWkSGB0KWBR0X4dSQIOz4po2ZPLjVA1+h
        NzKi4h2qdgF6Y8yCuBjmSj6GW2huORr4YRjwF/CGkDLCsLhuqlhTmR9Uz1tPDVoxtIgvLrNkyP+
        wyexLqYEiHpB/xHXlgyMca/Kf
X-Received: by 2002:adf:c648:: with SMTP id u8mr18813377wrg.215.1607335529595;
        Mon, 07 Dec 2020 02:05:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEvKRq05zARKT0OZk4hTLsHMCiWEUHbPzqlj0RKIysUDlMJ2QNt6WpHWi+m/kYzmty+3DFWg==
X-Received: by 2002:adf:c648:: with SMTP id u8mr18813341wrg.215.1607335529355;
        Mon, 07 Dec 2020 02:05:29 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id m4sm13423080wmi.41.2020.12.07.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 02:05:28 -0800 (PST)
Date:   Mon, 7 Dec 2020 11:05:25 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Duncan <davdunc@amazon.com>,
        Dexuan Cui <decui@microsoft.com>,
        Alexander Graf <graf@amazon.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] vsock: Add flags field in the vsock
 address
Message-ID: <20201207100525.v4z7rlewnwubjphu@steredhat>
References: <20201204170235.84387-1-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201204170235.84387-1-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

On Fri, Dec 04, 2020 at 07:02:31PM +0200, Andra Paraschiv wrote:
>vsock enables communication between virtual machines and the host they are
>running on. Nested VMs can be setup to use vsock channels, as the multi
>transport support has been available in the mainline since the v5.5 Linux kernel
>has been released.
>
>Implicitly, if no host->guest vsock transport is loaded, all the vsock packets
>are forwarded to the host. This behavior can be used to setup communication
>channels between sibling VMs that are running on the same host. One example can
>be the vsock channels that can be established within AWS Nitro Enclaves
>(see Documentation/virt/ne_overview.rst).
>
>To be able to explicitly mark a connection as being used for a certain use case,
>add a flags field in the vsock address data structure. The "svm_reserved1" field
>has been repurposed to be the flags field. The value of the flags will then be
>taken into consideration when the vsock transport is assigned. This way can
>distinguish between different use cases, such as nested VMs / local communication
>and sibling VMs.

the series seems in a good shape, I left some minor comments.
I run my test suite (vsock_test, iperf3, nc) with nested VMs (QEMU/KVM), 
and everything looks good.

Note: I'll be offline today and tomorrow, so I may miss followups.

Thanks,
Stefano

