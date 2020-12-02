Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A012CB74C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgLBIdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbgLBIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606897935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdS5Ozk3yDJPMYRuoyTOIqVIvgy0FiikSyg8r+DUlWg=;
        b=jL4+Gm93IXEOkapSWCwcpYtm2jEqQPTVU+rKstStEy/IeGIZst8rJxppdP5dnXkhZZRbOP
        iK3bLBzhAjQa4GF+RiSgmEF8z5D1Y5PL/0tVfwgzMr/uXm+V9TlTX4qiz22f+4XnSLI3M3
        Py4msQev5KTP6wEGVycqTIlsLikT0BQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-JTXi2iS_O5O746hXN4Hvwg-1; Wed, 02 Dec 2020 03:32:13 -0500
X-MC-Unique: JTXi2iS_O5O746hXN4Hvwg-1
Received: by mail-wr1-f69.google.com with SMTP id w17so2112717wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 00:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EdS5Ozk3yDJPMYRuoyTOIqVIvgy0FiikSyg8r+DUlWg=;
        b=gUyWqr9vxRxkrXGJKpqglRMyaV9xMV47DO9Yj/YCEcmT4SQqWJ8E9hnqcU2BFs2MAv
         oXgZzVT5IO4NEyMYoUl/CQMya2FHKfmDHn5AvvkduXlY4KAqao1O/JCVdc/c5/qPeRyN
         iteF/Qv2KUsNd8XIDwgXfmTJlkIQpmvP5lM6tGkaMB9lhs+yjMnGBtoEthwn1myLTUtB
         L7RoMWIVluW0aGcHceJ+uUZyuAaspAPNZNRCNODspK0oApoT162cKc7UDhKJb6AUZ3DD
         uctABO2UU5i4SHrrARfnr8jsoH0lRM8ywyR3ExY61c+q9X7GOnyLc6gm4qpPEe/NNxCE
         n2Bw==
X-Gm-Message-State: AOAM5323z1fXeuvGnoCrh5YrkMOjZz2Q+O01FTYxdOywdOzsbqUA2UxH
        VPBpPE7jYhTfywnGAgzrt5kHQPKiSk0B7WzK8JjaKyF8IU4VDlTSS+xe2qwP/KTEKdXjwMGxRKv
        xB0IeBEKg9V9+3Qa3F+47TNn3
X-Received: by 2002:a7b:c770:: with SMTP id x16mr1820577wmk.139.1606897932574;
        Wed, 02 Dec 2020 00:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEVrZqUYCHneGWRpBo4BPzO4zbn5YVkR2h8CaciENRh8epL6dSk21IVODbgmXJbqr9E+jhAw==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr1820554wmk.139.1606897932361;
        Wed, 02 Dec 2020 00:32:12 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id j8sm1123684wrx.11.2020.12.02.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:32:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 09:32:09 +0100
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
Subject: Re: [PATCH net-next v1 1/3] vm_sockets: Include flag field in the
 vsock address data structure
Message-ID: <20201202083209.ex5do3dqekfkj5as@steredhat>
References: <20201201152505.19445-1-andraprs@amazon.com>
 <20201201152505.19445-2-andraprs@amazon.com>
 <20201201160937.sswd3prfn6r52ihc@steredhat>
 <70d9868a-c883-d823-abf8-7e77ea4c933c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70d9868a-c883-d823-abf8-7e77ea4c933c@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:15:04PM +0200, Paraschiv, Andra-Irina wrote:
>
>
>On 01/12/2020 18:09, Stefano Garzarella wrote:
>>
>>On Tue, Dec 01, 2020 at 05:25:03PM +0200, Andra Paraschiv wrote:
>>>vsock enables communication between virtual machines and the host they
>>>are running on. With the multi transport support (guest->host and
>>>host->guest), nested VMs can also use vsock channels for communication.
>>>
>>>In addition to this, by default, all the vsock packets are forwarded to
>>>the host, if no host->guest transport is loaded. This behavior can be
>>>implicitly used for enabling vsock communication between sibling VMs.
>>>
>>>Add a flag field in the vsock address data structure that can be used to
>>>explicitly mark the vsock connection as being targeted for a certain
>>>type of communication. This way, can distinguish between nested VMs and
>>>sibling VMs use cases and can also setup them at the same time. Till
>>>now, could either have nested VMs or sibling VMs at a time using the
>>>vsock communication stack.
>>>
>>>Use the already available "svm_reserved1" field and mark it as a flag
>>>field instead. This flag can be set when initializing the vsock address
>>>variable used for the connect() call.
>>
>>Maybe we can split this patch in 2 patches, one to rename the svm_flag
>>and one to add the new flags.
>
>Sure, I can split this in 2 patches, to have a bit more separation of 
>duties.
>
>>
>>>
>>>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>>>---
>>>include/uapi/linux/vm_sockets.h | 18 +++++++++++++++++-
>>>1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/include/uapi/linux/vm_sockets.h 
>>>b/include/uapi/linux/vm_sockets.h
>>>index fd0ed7221645d..58da5a91413ac 100644
>>>--- a/include/uapi/linux/vm_sockets.h
>>>+++ b/include/uapi/linux/vm_sockets.h
>>>@@ -114,6 +114,22 @@
>>>
>>>#define VMADDR_CID_HOST 2
>>>
>>>+/* This sockaddr_vm flag value covers the current default use case:
>>>+ * local vsock communication between guest and host and nested 
>>>VMs setup.
>>>+ * In addition to this, implicitly, the vsock packets are 
>>>forwarded to the host
>>>+ * if no host->guest vsock transport is set.
>>>+ */
>>>+#define VMADDR_FLAG_DEFAULT_COMMUNICATION     0x0000
>>
>>I think we don't need this macro, since the next one can be used to
>>check if it a sibling communication (flag 0x1 set) or not (flag 0x1
>>not set).
>
>Right, that's not particularly the use of the flag value, as by 
>default comes as 0. It was more for sharing the cases this covers. But 
>I can remove the define and keep this kind of info, with regard to the 
>default case, in the commit message / comments.
>

Agree, you can add few lines in the comment block of VMADDR_FLAG_SIBLING 
describing the default case when it is not set.

>>
>>>+
>>>+/* Set this flag value in the sockaddr_vm corresponding field if 
>>>the vsock
>>>+ * channel needs to be setup between two sibling VMs running on 
>>>the same host.
>>>+ * This way can explicitly distinguish between vsock channels 
>>>created for nested
>>>+ * VMs (or local communication between guest and host) and the 
>>>ones created for
>>>+ * sibling VMs. And vsock channels for multiple use cases (nested 
>>>/ sibling VMs)
>>>+ * can be setup at the same time.
>>>+ */
>>>+#define VMADDR_FLAG_SIBLING_VMS_COMMUNICATION 0x0001
>>
>>What do you think if we shorten in VMADDR_FLAG_SIBLING?
>>
>
>Yup, this seems ok as well for me. I'll update the naming.
>

Thanks,
Stefano

