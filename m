Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2F2CD815
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgLCNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730624AbgLCNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607002695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1KKOKeD8FSQgeNHhs8tw5ZNkxzG3hIsrQPw3IYMYMk=;
        b=He8oLgu2/HnxSTDYli924wgjVOeC0Lrq6LdBVdUUcOIv+cB3iRNz5W06VcJPwyxSgyu3I3
        QzW4Nmhxcp/yC+Sw9FsuMwmD0IPEBP91LS2OE4UF27F5hAn0/+WqVywo+DUC0JclSD6noH
        nUpdMIvwwSbs8CpnzpwciOt2y5Hj+mk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-PHhFhJFUPuittegvd1mvPQ-1; Thu, 03 Dec 2020 08:38:12 -0500
X-MC-Unique: PHhFhJFUPuittegvd1mvPQ-1
Received: by mail-wr1-f70.google.com with SMTP id x10so1279477wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 05:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z1KKOKeD8FSQgeNHhs8tw5ZNkxzG3hIsrQPw3IYMYMk=;
        b=iKy+QFdeBTRWJY8R1p1QA1yXKmF+Pe7PXy3wQYJp0JsZuhr1Us41Q5Yq2CeIpCsR4t
         sKYOvG4UxQNJQIX1HXqZGwzfpI0FHCf72EoRdzohptwwPLHFfKjmofQP6fhsfVskdJRI
         9/G5enISv/hoDEcD1uVrj1qT/IY7fojcR+4VOJJoQV91FvOGL/sjjiXIkAmw+H2eic5s
         zxLdEJ0C8101ze3TsBQP/+lu1rpVmKRzJL/eULf7F9KGM72M0ZAlnFsqLeCHE6Li7L6y
         MeBad3N4akOwEW+HLTwXwWEZOtQuuW57mS/3IcGUSKOR5xlXNnjaJKahJJ9rFWmPVJGE
         bi/w==
X-Gm-Message-State: AOAM531tOt9PDgXNJzN4H8nD4lxDWQMBPn8+if/fFewqCrzipq7GvmSt
        uYJR9SOKq5EYsWFPnFhQOb8j88KFacHETZnNZTyzIxz0c4c63QyO0zI/TP54gk+a0W1S+PHGxMc
        9vvaE2P7mG4k1QzdQqdsjeyuC
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr3299582wmk.131.1607002690859;
        Thu, 03 Dec 2020 05:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg6H2V5t9tmBzfJFjm4InbiCbVIJp+VQ0VfDfx/g9hJiR71wxqmzxajZTbL1cQptwUEM1BQw==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr3299555wmk.131.1607002690596;
        Thu, 03 Dec 2020 05:38:10 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id l14sm1455476wmi.33.2020.12.03.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 05:38:09 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:38:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Duncan <davdunc@amazon.com>,
        Dexuan Cui <decui@microsoft.com>,
        Alexander Graf <graf@amazon.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH net-next v1 1/3] vm_sockets: Include flag field in the
 vsock address data structure
Message-ID: <20201203133807.36t235yemt5f2j4t@steredhat>
References: <20201201152505.19445-1-andraprs@amazon.com>
 <20201201152505.19445-2-andraprs@amazon.com>
 <20201203092155.GB687169@stefanha-x1.localdomain>
 <8fcc1daa-4f03-0240-1dda-4daf2e1f7c44@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fcc1daa-4f03-0240-1dda-4daf2e1f7c44@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:32:08PM +0200, Paraschiv, Andra-Irina wrote:
>
>
>On 03/12/2020 11:21, Stefan Hajnoczi wrote:
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
>>>
>>>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>>>---
>>>  include/uapi/linux/vm_sockets.h | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>>>index fd0ed7221645d..58da5a91413ac 100644
>>>--- a/include/uapi/linux/vm_sockets.h
>>>+++ b/include/uapi/linux/vm_sockets.h
>>>@@ -114,6 +114,22 @@
>>>  #define VMADDR_CID_HOST 2
>>>+/* This sockaddr_vm flag value covers the current default use case:
>>>+ * local vsock communication between guest and host and nested VMs setup.
>>>+ * In addition to this, implicitly, the vsock packets are forwarded to the host
>>>+ * if no host->guest vsock transport is set.
>>>+ */
>>>+#define VMADDR_FLAG_DEFAULT_COMMUNICATION	0x0000
>>>+
>>>+/* Set this flag value in the sockaddr_vm corresponding field if the vsock
>>>+ * channel needs to be setup between two sibling VMs running on the same host.
>>>+ * This way can explicitly distinguish between vsock channels created for nested
>>>+ * VMs (or local communication between guest and host) and the ones created for
>>>+ * sibling VMs. And vsock channels for multiple use cases (nested / sibling VMs)
>>>+ * can be setup at the same time.
>>>+ */
>>>+#define VMADDR_FLAG_SIBLING_VMS_COMMUNICATION	0x0001
>>vsock has the h2g and g2h concept. It would be more general to call this
>>flag VMADDR_FLAG_G2H or less cryptically VMADDR_FLAG_TO_HOST.

I agree, VMADDR_FLAG_TO_HOST is more general and it's clearer that is up 
to the host where to forward the packet (sibling if supported, or 
whatever).

Thanks,
Stefano

>
>Thanks for the feedback, Stefan.
>
>I can update the naming to be more general, such as  "_TO_HOST", and 
>keep the use cases (e.g. guest <-> host / nested / sibling VMs 
>communication) mention in the comments so that would relate more to 
>the motivation behind it.
>
>Andra
>
>>
>>That way it just tells the driver in which direction to send packets
>>without implying that sibling communication is possible (it's not
>>allowed by default on any transport).
>>
>>I don't have a strong opinion on this but wanted to suggest the idea.
>>
>>Stefan
>
>
>
>
>Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
>

