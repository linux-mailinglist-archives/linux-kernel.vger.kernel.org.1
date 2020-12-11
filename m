Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36212D791D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393039AbgLKPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437820AbgLKPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607700094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2JL8gdYFvxAcjiuHF47Jvj6sREU3Hka+W7jAm2IWls=;
        b=O8+1gfMnb1gPTFL3IsknFyF0SSasDABzGl0JWzxCHclwBsIgidE3sPpprWExfIspmua2y3
        YgTR6qtGLqDoUWPxtBqT4cEUy7KEoEgTomTWT2xXje9JQryafVJNVdzvFzBqBnKTkglYT4
        lWLDg6hsZqFTvGsLTGH2/5NQdX7rIRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-ieRKpU10PGKlBYG5PovtNA-1; Fri, 11 Dec 2020 10:21:32 -0500
X-MC-Unique: ieRKpU10PGKlBYG5PovtNA-1
Received: by mail-wm1-f70.google.com with SMTP id r5so3415491wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 07:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2JL8gdYFvxAcjiuHF47Jvj6sREU3Hka+W7jAm2IWls=;
        b=EMKZlidd19niMUEeq2tLPBsPj/MMBQnGpDmmC7dBVCpXF9FzTbcDHhOetihuWaVSlQ
         sa9H7TXQP6vTTlYSOKMINyst7LJSl16U9Yoi9eP+X6RTu705sSWgDzkXnGUfNx709yqZ
         9nONOnYOgzK3iHm66kWhUm7W281oMQyLDTe3UP9lJqVNyDP+LITTm2ScnR/Xj5Jig0UP
         YIOy0DQre4nFqhhMi3umz5P1Y976VRoUSCviis1qoEIdkbFVglEctqYY/EbyTA5FRA0Y
         UihzI78KNlLl4IzOuQ2cY7Aof06Wgy03QabRA5pEUWxxhTPxYIPdMjpjDCoiJLtZmuSc
         MO3A==
X-Gm-Message-State: AOAM531iaSwtOly/FjOE2I473mCGT7K3YSSm+JfKJzHLCVXuxwuspf2o
        d9THlOa9Xws7WIko4ajgPtJ5qiTbvmNCJmMw7IWEXEUGd0HffN60zi+ertjoQmz5HDhk3wG9vXR
        Z1lQzV3PFqj8xzth4z1Ez3imb
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr3221283wmk.31.1607700091088;
        Fri, 11 Dec 2020 07:21:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGOY59qMEPEBkq+rmwi3sMncPUysDnrHss6YgDgKzFjRisRhWcm7UCEKETYDhF70hrORnRkg==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr3221266wmk.31.1607700090901;
        Fri, 11 Dec 2020 07:21:30 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id u85sm14350188wmu.43.2020.12.11.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:21:30 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:21:27 +0100
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
Subject: Re: [PATCH net-next v3 1/4] vm_sockets: Add flags field in the vsock
 address data structure
Message-ID: <20201211152127.jfst6qfwc663ft7c@steredhat>
References: <20201211103241.17751-1-andraprs@amazon.com>
 <20201211103241.17751-2-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201211103241.17751-2-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:32:38PM +0200, Andra Paraschiv wrote:
>vsock enables communication between virtual machines and the host they
>are running on. With the multi transport support (guest->host and
>host->guest), nested VMs can also use vsock channels for communication.
>
>In addition to this, by default, all the vsock packets are forwarded to
>the host, if no host->guest transport is loaded. This behavior can be
>implicitly used for enabling vsock communication between sibling VMs.
>
>Add a flags field in the vsock address data structure that can be used
>to explicitly mark the vsock connection as being targeted for a certain
>type of communication. This way, can distinguish between different use
>cases such as nested VMs and sibling VMs.
>
>This field can be set when initializing the vsock address variable used
>for the connect() call.
>
>Changelog
>
>v2 -> v3
>
>* Add "svm_flags" as a new field, not reusing "svm_reserved1".

Using the previous 'svn_zero[0]' for the new 'svn_flags' field make sure 
that if an application sets a flag and runs on an older kernel, it will 
receive an error and I think it's perfect, since that kernel is not able 
to handle the flag.

So I think is okay and I confirm my R-b tag ;-)

>
>v1 -> v2
>
>* Update the field name to "svm_flags".
>* Split the current patch in 2 patches.
>
>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/uapi/linux/vm_sockets.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index fd0ed7221645d..619f8e9d55ca4 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -148,10 +148,13 @@ struct sockaddr_vm {
> 	unsigned short svm_reserved1;
> 	unsigned int svm_port;
> 	unsigned int svm_cid;
>+	unsigned short svm_flags;
> 	unsigned char svm_zero[sizeof(struct sockaddr) -
> 			       sizeof(sa_family_t) -
> 			       sizeof(unsigned short) -
>-			       sizeof(unsigned int) - sizeof(unsigned int)];
>+			       sizeof(unsigned int) -
>+			       sizeof(unsigned int) -
>+			       sizeof(unsigned short)];
> };
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>-- 
>2.20.1 (Apple Git-117)
>
>
>
>
>Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
>

