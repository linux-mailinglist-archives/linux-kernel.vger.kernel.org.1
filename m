Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71BD2FED9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbhAUOze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731630AbhAUOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611240766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loDog159VD/YZKvAODyHGMsyyVC+ozXQO6jj7oflSm0=;
        b=fPBdpPdKwjGVquRqUXVQtUywUmpaF1u7rdWJTif20/Eo+R1sfnyCQqMBuR8ww12kSRN2MP
        g5XZm9IZDmpuNjlbfw6SqnPCdOTRq9KuQlhM5qDqeFHBKJXgH2/gdRvrDYIAhZdU3qHczj
        O9RORwY1c7xAKQYwgkhUL6TKSP0JMQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-ED0IDU3JMnS9T8q6n5wUog-1; Thu, 21 Jan 2021 09:52:45 -0500
X-MC-Unique: ED0IDU3JMnS9T8q6n5wUog-1
Received: by mail-wr1-f71.google.com with SMTP id o17so1203678wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=loDog159VD/YZKvAODyHGMsyyVC+ozXQO6jj7oflSm0=;
        b=sFhKF2o/88O+2pMyDCdiuK5vTMzv58+bsDe6n7aSYugKi0hHQTOfSMoj2xMzO9K/ex
         6bozSzzt/wlCTfi7oImasUQeQEron/1dLlITWuSINZe0KF06DvF6qMOEAeFyuqJxd2ts
         AwskY5+ebORfcHXevGvVy/9e84Yn0Bw97nJUfTchBiuaeDR5hQGME06zHrdeDu68zIoi
         xLYQI5f6EhYgQ09zsYenyYOIpZa5hDDVUzIs9AiYZuxZBjfbtRDDmtbpG1tTQgSM46VA
         tjcVKTgVdzl1bCA9YYv6vO+1YZqsWX+DsiMp9znUpa4jepEbgBHp5TO/3jVrPLOYrOMk
         cbRw==
X-Gm-Message-State: AOAM530/i2/+0iamfzlScoUzbU9kY1t1R16aR2gh6yMv57whfD4Yo7Ea
        k3JkVz6WfFHONsEtXUIntyxUny0psnOxsxVSNK7CR6y1KW/BFdSlQM7nC67+50JYmkGTxr9W8hv
        mMQHXzEpM4ON2YvYCVJfSx6oys/P7umBuj80/9SMMp1WRCKzaM9ezGfwZgTvtcat7xUgE6xTdrr
        /J
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr14796902wrx.165.1611240762516;
        Thu, 21 Jan 2021 06:52:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTe5wBBwk9xIv6MUSk/XHCOU+J6DjPfd4tGzt152OLcgSMRBUxG5aHYa2I6DigvnCpGLXg/A==
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr14796880wrx.165.1611240762266;
        Thu, 21 Jan 2021 06:52:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id a25sm7920265wmb.25.2021.01.21.06.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:52:41 -0800 (PST)
Subject: Re: [PATCH] KVM: Documentation: Update description of
 KVM_{GET,CLEAR}_DIRTY_LOG
To:     Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org
Cc:     corbet@lwn.net, wanghaibin.wang@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201208043439.895-1-yuzenghui@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4229828a-078f-0558-751a-3e56bec66aac@redhat.com>
Date:   Thu, 21 Jan 2021 15:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201208043439.895-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/20 05:34, Zenghui Yu wrote:
> Update various words, including the wrong parameter name and the vague
> description of the usage of "slot" field.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   Documentation/virt/kvm/api.rst | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 70254eaa5229..0eb236737f80 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -360,10 +360,9 @@ since the last call to this ioctl.  Bit 0 is the first page in the
>   memory slot.  Ensure the entire structure is cleared to avoid padding
>   issues.
>   
> -If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 specifies
> -the address space for which you want to return the dirty bitmap.
> -They must be less than the value that KVM_CHECK_EXTENSION returns for
> -the KVM_CAP_MULTI_ADDRESS_SPACE capability.
> +If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 of slot field specifies
> +the address space for which you want to return the dirty bitmap.  See
> +KVM_SET_USER_MEMORY_REGION for details on the usage of slot field.
>   
>   The bits in the dirty bitmap are cleared before the ioctl returns, unless
>   KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is enabled.  For more information,
> @@ -4427,7 +4426,7 @@ to I/O ports.
>   :Capability: KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
>   :Architectures: x86, arm, arm64, mips
>   :Type: vm ioctl
> -:Parameters: struct kvm_dirty_log (in)
> +:Parameters: struct kvm_clear_dirty_log (in)
>   :Returns: 0 on success, -1 on error
>   
>   ::
> @@ -4454,10 +4453,9 @@ in KVM's dirty bitmap, and dirty tracking is re-enabled for that page
>   (for example via write-protection, or by clearing the dirty bit in
>   a page table entry).
>   
> -If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 specifies
> -the address space for which you want to return the dirty bitmap.
> -They must be less than the value that KVM_CHECK_EXTENSION returns for
> -the KVM_CAP_MULTI_ADDRESS_SPACE capability.
> +If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 of slot field specifies
> +the address space for which you want to clear the dirty status.  See
> +KVM_SET_USER_MEMORY_REGION for details on the usage of slot field.
>   
>   This ioctl is mostly useful when KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2
>   is enabled; for more information, see the description of the capability.
> 

Queued, thanks.

Paolo

