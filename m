Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226062CD1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgLCIxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgLCIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606985500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmHQQk3x9/fQA1e1iSjFzwxQBkZrVJB5ySbnzT5Z1Ts=;
        b=C/vaNLndULgPn+aalST2d6E3eIaeNmaT9BcVA9Watu9IpsdKzpugY7a31gR4OeYA2hIUE8
        790EpFoyPXzIlImHn1p37nc/S6tuG41BcnCJrxE+Lx5TyJCI00ABZIDzsVdemIHO1JJfa1
        0s9xbMiIifjzoYUU/1HjHRiDmGjKn9c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-sY1YgnuKNnOGVbeT7Uqp1w-1; Thu, 03 Dec 2020 03:51:39 -0500
X-MC-Unique: sY1YgnuKNnOGVbeT7Uqp1w-1
Received: by mail-wr1-f71.google.com with SMTP id f4so956330wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 00:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kmHQQk3x9/fQA1e1iSjFzwxQBkZrVJB5ySbnzT5Z1Ts=;
        b=RbtoEADAlf7uOSRpF2c7OPXn1LL+zjL1clyvWHpgA1xfdGfGHgGLy31fP7ET7QJLbb
         Utxn87CobAv7D5O63Yjz6pZ4bHXnS6ZT74UAo4kKCfO4YwoVLRKYASxv6kDD01x6GUV4
         8iOrsK7w5KiEGEhVWWXcCpj/AuKwU8I2lZjsSRhJGjrROGAMrzzRPmFwICICUjEwYw1V
         63JcSsyiwCkWkf5YubbcS8v+1CcPXfUmB4HMB7er0HnkRD3lzcMfp2G214cRb4JYV68X
         C7K56mkoZUFrbEtvGPN2QsaiFBo/L9y6PQ6KKYND4M20NYUA8eWXmgS5Z9fCru1Db8PJ
         CSEw==
X-Gm-Message-State: AOAM532OhdBiyCD3/G/ybU8BtlNHPOce7qN0doQ1ftURafc8Hki/lF98
        dknEFVT6UYZCy03MjWAeiNEqVK1aQ3A5nUEZgogHCJB2auNrLheta28ekAeEQJ4WJoRFG3ZvxCE
        RcNCmO23YhtAcZ3qZh6fUMZWb
X-Received: by 2002:a1c:491:: with SMTP id 139mr2015878wme.81.1606985497760;
        Thu, 03 Dec 2020 00:51:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZdEBpodbmanLOpEUOyi80M/b/dUdwtOSrUCsb6f/RM7ptKtbJxdbRF8EPPhSniwmzhFf7uQ==
X-Received: by 2002:a1c:491:: with SMTP id 139mr2015845wme.81.1606985497408;
        Thu, 03 Dec 2020 00:51:37 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id c129sm598618wma.31.2020.12.03.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 00:51:36 -0800 (PST)
Date:   Thu, 3 Dec 2020 09:51:34 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>
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
Message-ID: <20201203085134.azxkxvapbjvebciq@steredhat>
References: <20201201152505.19445-1-andraprs@amazon.com>
 <20201202133754.2ek2wgutkujkvxaf@steredhat>
 <d5c55d2e-5dc3-96f2-2333-37e778c761ae@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5c55d2e-5dc3-96f2-2333-37e778c761ae@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:18:15PM +0200, Paraschiv, Andra-Irina wrote:
>
>
>On 02/12/2020 15:37, Stefano Garzarella wrote:
>>
>>Hi Andra,
>>
>>On Tue, Dec 01, 2020 at 05:25:02PM +0200, Andra Paraschiv wrote:
>>>vsock enables communication between virtual machines and the host 
>>>they are
>>>running on. Nested VMs can be setup to use vsock channels, as the multi
>>>transport support has been available in the mainline since the 
>>>v5.5 Linux kernel
>>>has been released.
>>>
>>>Implicitly, if no host->guest vsock transport is loaded, all the 
>>>vsock packets
>>>are forwarded to the host. This behavior can be used to setup 
>>>communication
>>>channels between sibling VMs that are running on the same host. 
>>>One example can
>>>be the vsock channels that can be established within AWS Nitro Enclaves
>>>(see Documentation/virt/ne_overview.rst).
>>>
>>>To be able to explicitly mark a connection as being used for a 
>>>certain use case,
>>>add a flag field in the vsock address data structure. The 
>>>"svm_reserved1" field
>>>has been repurposed to be the flag field. The value of the flag 
>>>will then be
>>>taken into consideration when the vsock transport is assigned.
>>>
>>>This way can distinguish between nested VMs / local communication 
>>>and sibling
>>>VMs use cases. And can also setup one or more types of 
>>>communication at the same
>>>time.
>>>
>>
>>Another thing worth mentioning is that for now it is not supported in
>>vhost-vsock, since we are discarding every packet not addressed to the
>>host.
>
>Right, thanks for the follow-up.
>
>>
>>What we should do would be:
>>- add a new IOCTL to vhost-vsock to enable sibling communication, by
>>  default I'd like to leave it disabled
>>
>>- allow sibling forwarding only if both guests have sibling
>>  communication enabled and we should implement some kind of filtering
>>  or network namespace support to allow the communication only between a
>>  subset of VMs
>>
>>
>>Do you have plans to work on it?
>
>Nope, not yet. But I can take some time in the second part of December 
>/ beginning of January for this. And we can catch up in the meantime 
>if there is something blocking or more clarifications are needed to 
>make it work.
>

Good, it will be great!

Thanks,
Stefano

