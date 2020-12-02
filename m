Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7DF2CBE89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgLBNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730142AbgLBNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606916281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k892U81vm/7Lmbp8gT5mmMxos6ePhrModHip4KLxNhg=;
        b=fnfdlGXdF6ohSqNoBOTEv0djuKLym1za3YDAMvDmOls/pPkUx2tYewFDG/wMMTYqPjwwcu
        SGWcBnKtLQyLDtpk6YhWZ/gOjOCgKpkp/3pxO0Ao8HWYs8ODRozmHKyntGHOms9iWXJrKd
        1ykc2t9V7k5a3KPkscmQFTEw7NhjRKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-bd4uXd5hNnCHfYGS2Tqu8A-1; Wed, 02 Dec 2020 08:38:00 -0500
X-MC-Unique: bd4uXd5hNnCHfYGS2Tqu8A-1
Received: by mail-wm1-f71.google.com with SMTP id y187so3558320wmy.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 05:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k892U81vm/7Lmbp8gT5mmMxos6ePhrModHip4KLxNhg=;
        b=mbGr6+QVhz/6yO6FtQ5h5uYT67kjy4kDWarQXNwAxK/BV6Xxd4+HdwTJm4Hlx9UP7G
         uG71+K16mxm+BiqRnre3GOdBUpwfwXCtzlSs36V7DwOeJEgcPhciGFwB+muqXnzleaaD
         bwgDNVunHpFrkTSMHgr2TC5XR5xB3UkhDB+bMYW11D+qFUpWFBMaDEUUF02DMn8S6lzZ
         UTnYDCCVscb/HAgbQAppAT577Ig9f5V08/ykadIpE81g8IwuCUOW/PNa9MccFRcFD0Rd
         7gkOj4pT6Oo6FAYB537fda+i2hGTuSzlLwJJCei78KWvGxT3gFXj6spV0ejWszHy55A0
         I3sg==
X-Gm-Message-State: AOAM533PI/KKV2VGlSQsVX+GysseeKUKX4bN2WPvuoEszHMNbLchY8WG
        bTJpbiNy/8iMcHyLuRElOWwQo3HZbrOAPRBORoCofHUlWfiX4/+p+PVr+/XyZGAgKIxGHjjqGRs
        neGcV8J4/tyTMT3xFLRWfXL7C
X-Received: by 2002:a1c:b402:: with SMTP id d2mr3149276wmf.38.1606916278579;
        Wed, 02 Dec 2020 05:37:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK+0W4eOojNfyxH8oMw5CnN0catIDj7yFdPtO7YiiunSFYmlGtxxV004j5OKFmH0OOVMjrYw==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr3149257wmf.38.1606916278365;
        Wed, 02 Dec 2020 05:37:58 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id c81sm2150455wmd.6.2020.12.02.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:37:57 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:37:54 +0100
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
Subject: Re: [PATCH net-next v1 0/3] vsock: Add flag field in the vsock
 address
Message-ID: <20201202133754.2ek2wgutkujkvxaf@steredhat>
References: <20201201152505.19445-1-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201201152505.19445-1-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

On Tue, Dec 01, 2020 at 05:25:02PM +0200, Andra Paraschiv wrote:
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
>add a flag field in the vsock address data structure. The "svm_reserved1" field
>has been repurposed to be the flag field. The value of the flag will then be
>taken into consideration when the vsock transport is assigned.
>
>This way can distinguish between nested VMs / local communication and sibling
>VMs use cases. And can also setup one or more types of communication at the same
>time.
>

Another thing worth mentioning is that for now it is not supported in 
vhost-vsock, since we are discarding every packet not addressed to the 
host.

What we should do would be:
- add a new IOCTL to vhost-vsock to enable sibling communication, by 
   default I'd like to leave it disabled

- allow sibling forwarding only if both guests have sibling 
   communication enabled and we should implement some kind of filtering 
   or network namespace support to allow the communication only between a 
   subset of VMs


Do you have plans to work on it?

Otherwise I put it in my to-do list and hope I have time to do it (maybe 
next month).

Thanks,
Stefano

