Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C642D7921
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbgLKPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437837AbgLKPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607700125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kjpk2RbhIA1YYkgV9aHcKnu44Ila9jeMA1cZc9PaxI=;
        b=cMsflJUvE+JQSt+QzA+ZI6kyb2Wwi4D2895vtE+C0X0g/lx+503+BdblK0IptTOVP6Y20Z
        DzVvbJyNOjEcA4sqYlhjhP2pKMPPECn5fO7dw5+gt7oYGZhjgqhmGBNkJXtnqPAUFfoGiI
        TPiEhkwLpEgVHApQZcFtpfh4bfr3K0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-2w6x2JorN9u9EKsnJYYIFg-1; Fri, 11 Dec 2020 10:22:03 -0500
X-MC-Unique: 2w6x2JorN9u9EKsnJYYIFg-1
Received: by mail-wm1-f72.google.com with SMTP id a134so1731063wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 07:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kjpk2RbhIA1YYkgV9aHcKnu44Ila9jeMA1cZc9PaxI=;
        b=adQFcp5jP48fDlvUxgsTIhKAxeFSN3eWSepZQaPOsfNc7fUpiVP+RPYfsAi2jSgH21
         +gWZD3z4SbOqC2l5/TO6+f8nVPqX1ejEU8W13+QASq3auQV85XYgZryacs5JUfozPSch
         4k+/s6SVdlhn+XysRsfuTJ5Mj4nTh0qMNhBZZEnp/3hzZYkGCCYNrwLjJqQTLnBsJ35N
         PRXd2Z8yy27rM48wnVWZ1v5B8uf7FbFhrk8itb/sirbBuLd/7NVi8p770QYZj4VFl+QU
         Bz3LNuqbev7qswEU714AJ29npIzu61xOrqGbe3B9ITvGtdoj8VZAJXfS/BP/LZZW3cyi
         Kikg==
X-Gm-Message-State: AOAM531l4k0rZr9nl35Isus4U7FQTRfZpnOGwy1rBJMTSzoCtkLqnDaV
        OOiqz2k9sD2SbuQRsoEcXgnfU6juReKszWrT1CCso8dr6dVS0Gt/11cznFE+fEwfxnG2VFt0Xf1
        0OVzhB3PdRQGS4BTaWNSfzODE
X-Received: by 2002:a5d:620e:: with SMTP id y14mr15016565wru.111.1607700122647;
        Fri, 11 Dec 2020 07:22:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2/c4amUxO6yiVGaE6UpZHCLxu+13pZQkjX7jCgTLw7r3kRk4v6rC3eMS0oH2I4Jy+g+zPzg==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr15016543wru.111.1607700122480;
        Fri, 11 Dec 2020 07:22:02 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id a21sm14267289wmb.38.2020.12.11.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:22:01 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:21:59 +0100
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
Subject: Re: [PATCH net-next v3 2/4] vm_sockets: Add VMADDR_FLAG_TO_HOST
 vsock flag
Message-ID: <20201211152159.lndvshjrr5zqzzdt@steredhat>
References: <20201211103241.17751-1-andraprs@amazon.com>
 <20201211103241.17751-3-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201211103241.17751-3-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:32:39PM +0200, Andra Paraschiv wrote:
>Add VMADDR_FLAG_TO_HOST vsock flag that is used to setup a vsock
>connection where all the packets are forwarded to the host.
>
>Then, using this type of vsock channel, vsock communication between
>sibling VMs can be built on top of it.
>
>Changelog
>
>v2 -> v3
>
>* Update comments to mention when the flag is set in the connect and
>  listen paths.
>
>v1 -> v2
>
>* New patch in v2, it was split from the first patch in the series.
>* Remove the default value for the vsock flags field.
>* Update the naming for the vsock flag to "VMADDR_FLAG_TO_HOST".
>
>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>---
> include/uapi/linux/vm_sockets.h | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index 619f8e9d55ca4..c99ed29602345 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -114,6 +114,26 @@
>
> #define VMADDR_CID_HOST 2
>
>+/* The current default use case for the vsock channel is the following:
>+ * local vsock communication between guest and host and nested VMs setup.
>+ * In addition to this, implicitly, the vsock packets are forwarded to the host
>+ * if no host->guest vsock transport is set.
>+ *
>+ * Set this flag value in the sockaddr_vm corresponding field if the vsock
>+ * packets need to be always forwarded to the host. Using this behavior,
>+ * vsock communication between sibling VMs can be setup.
>+ *
>+ * This way can explicitly distinguish between vsock channels created for
>+ * different use cases, such as nested VMs (or local communication between
>+ * guest and host) and sibling VMs.
>+ *
>+ * The flag can be set in the connect logic in the user space application flow.
>+ * In the listen logic (from kernel space) the flag is set on the remote peer
>+ * address. This happens for an incoming connection when it is routed from the
>+ * host and comes from the guest (local CID and remote CID > VMADDR_CID_HOST).
>+ */
>+#define VMADDR_FLAG_TO_HOST 0x0001
>+
> /* Invalid vSockets version. */
>
> #define VM_SOCKETS_INVALID_VERSION -1U
>-- 
>2.20.1 (Apple Git-117)
>
>
>
>
>Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
>

