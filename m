Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B932121A39F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGIPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 11:25:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgGIPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594308328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FIvm+5jNb1Yu5G1MxSpTVfRDNWZlB63OHD7nzYJXlw=;
        b=O6MQBdMThKzOfQSNv/BAIkVW6VUWYhbQxGt8Th8zAht8Q4j1XvFnHsgVHnHhn+wE61MS9Y
        khlWMLWBY3OsiSik2Jk3k3GSRXJ9cdb8kVhB86NVlHFpzrSOME+mmN1dLsnP2lb1Lg/4Yd
        rtPhA2Xq+IfJ7husNv6IPMtx7J0Svn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-mtQa0bZ3PVuPUkEKnrtBNA-1; Thu, 09 Jul 2020 11:25:26 -0400
X-MC-Unique: mtQa0bZ3PVuPUkEKnrtBNA-1
Received: by mail-wm1-f72.google.com with SMTP id g187so2502568wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FIvm+5jNb1Yu5G1MxSpTVfRDNWZlB63OHD7nzYJXlw=;
        b=L3mfizQiF7M+Yj/4SCjpjFrexptf6hvU03edpdpAPzZ1RESWMw9GR4Q1Dl+xVHWFbW
         prmonM58m9k3vrf6zzZ2FN8V9PfVBZ68jg2lY6NBYzsxyrlNTqTzhPp/A/MVpjpsGT4g
         6Y9J9SryNOzK9jaeburE9djCkdWyRPj/KNPsS1KE2oYPUUUzbWK8LTRv0Z5jsqjI9/0b
         NYfat7Ei5+HnU1rBPv2/n/ZwhOgZ/BDc9mUD6csJmzb/pAxSEkmfQUQCFZoMK+MfItTh
         x0GAzEig5zRrwAxoFBWh5mI17LE9IAXiFMKv1+H77pTrLAQ3ktpbta/HSZxsoqOF2HPx
         eARw==
X-Gm-Message-State: AOAM532LI5kxHvYOCmgtkK0z/9yyfP9Vi4FTrjRxYPc/bUWyMD2E+8Rl
        drNGC8RaKyd68u5lnE2bs1ChBLzfjbKqhgS93ehQvOq0qUV+HzBhH5iSqCROqsPbV2cst/WfBSj
        eQd/IO4WQWJ4Jwu2oSdM+feOp
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr526247wmd.37.1594308325420;
        Thu, 09 Jul 2020 08:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhZrc+0TzNQ/ccjoCs5+EUyUE8e7OC8ViXIGngOlNVN0t1E7FQYjBTOJ4J4jy+ehCF5fUcyA==
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr526222wmd.37.1594308325223;
        Thu, 09 Jul 2020 08:25:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id e23sm4951923wme.35.2020.07.09.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:25:24 -0700 (PDT)
Subject: Re: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
To:     Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7a9319b-37ec-95dd-c20c-76017a3b1699@redhat.com>
Date:   Thu, 9 Jul 2020 17:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 17:06, Xianting Tian wrote:
> kmem_cache_destroy and mempool_destroy can correctly handle
> null pointer parameter, so there is no need to check if the
> parameter is null before calling kmem_cache_destroy and
> mempool_destroy.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  drivers/scsi/virtio_scsi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84a..54ac83e 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -1003,14 +1003,10 @@ static int __init init(void)
>  	return 0;
>  
>  error:
> -	if (virtscsi_cmd_pool) {
> -		mempool_destroy(virtscsi_cmd_pool);
> -		virtscsi_cmd_pool = NULL;
> -	}
> -	if (virtscsi_cmd_cache) {
> -		kmem_cache_destroy(virtscsi_cmd_cache);
> -		virtscsi_cmd_cache = NULL;
> -	}
> +	mempool_destroy(virtscsi_cmd_pool);
> +	virtscsi_cmd_pool = NULL;
> +	kmem_cache_destroy(virtscsi_cmd_cache);
> +	virtscsi_cmd_cache = NULL;
>  	return ret;
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>

