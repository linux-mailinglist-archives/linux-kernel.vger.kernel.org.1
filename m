Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03C2C8532
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgK3NcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgK3NcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606743049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFI50pysPtLDcbBO0F/EBWr/g7sPZm/GGocK9h6QMHo=;
        b=P2mVcIuQo+zzmfE11CFsobSJF5BHStwQH1ISZ/Eff+ZVJVEXoLeaML4IdVF1qiABnbZm5d
        4uS/ItwKgPalA0oCNZMp5sPnQWZ/hdxECg8kirBBZlPTPNU74h+mYYDt6oBUxz8fKC0l8A
        fLe5OBwNNSAyA2fUVQtXhJx035fRXRA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-lLWWIwohPi6XsRPNL9cSGw-1; Mon, 30 Nov 2020 08:30:48 -0500
X-MC-Unique: lLWWIwohPi6XsRPNL9cSGw-1
Received: by mail-ed1-f69.google.com with SMTP id c24so6759114edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFI50pysPtLDcbBO0F/EBWr/g7sPZm/GGocK9h6QMHo=;
        b=S5dc73Nl8OSFs3TPoCSF9lmRFwGkqAnBgX3IyFwKw989X8L3EdumlFfE/fEnLJlHEB
         ub286REv5oOW6NiSqofOSNfhrjkoTRnLL6e21oV6uTW7eILLr/vDxwdnKMt0p4TxmSB0
         saDeHscug4K8q0SR6v14bIfprxXjfz/CYd5Ha9tS6tCSMbdR0MqDmTExndKIb3HYNZZC
         hVbc7fvN00/rnLTHdGU4ELXv5Az4Yjyi/XmGVbf8q924EPPY16qeME42sLKuW+S7Ho/g
         hNh5bV/anhORCSZphuoiJKPBTMx+TlDx3nEkwsPThGBOrfhxMw3ENzTxwznzhJmFkM1x
         EeVw==
X-Gm-Message-State: AOAM530RUOFrZhSvn9ZPMJCJB8v1sxRGiaW0hkjRoID2i0iZivdNhuM4
        bbqwkXd9kMmhzfJPS0DwAzCYkt8A6M+PkeczSLawax+D+MnqwvjDbrm42hXA5iKmZIbzU+Lx6hB
        pCdlXg/Jf+L2cHDkjzCiOxFAH
X-Received: by 2002:a17:906:b847:: with SMTP id ga7mr21231514ejb.200.1606743044801;
        Mon, 30 Nov 2020 05:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWfrETdz0fyA5rejX4p0uGY0CZmUOqPJZp556YEBoJVQ1EwdC/eVxo5hjPz4wNn2qj8edhxQ==
X-Received: by 2002:a17:906:b847:: with SMTP id ga7mr21231226ejb.200.1606743041998;
        Mon, 30 Nov 2020 05:30:41 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id da9sm433255edb.13.2020.11.30.05.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:30:41 -0800 (PST)
Subject: Re: [PATCH -next] x86/platform/uv: Mark some symbols with static
 keyword
To:     Zou Wei <zou_wei@huawei.com>, justin.ernst@hpe.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55abc980-2493-5c29-da80-4bb1446fa37d@redhat.com>
Date:   Mon, 30 Nov 2020 14:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+Cc x86 folks

On 11/30/20 12:11 PM, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> drivers/platform/x86/uv_sysfs.c:22:13: warning: symbol 'uv_pcibus_kset' was not declared. Should it be static?
> drivers/platform/x86/uv_sysfs.c:23:13: warning: symbol 'uv_hubs_kset' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Since this is a fix to a series merged through the x86/tip tree, this should be merged
to the x86/tip tree too (or I can pick it up after 5.11-rc1).

Here is my ack for merging this through the x86/tip tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/uv_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
> index 54c3425..c780a4b 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -19,8 +19,8 @@
>  #define INVALID_CNODE -1
>  
>  struct kobject *sgi_uv_kobj;
> -struct kset *uv_pcibus_kset;
> -struct kset *uv_hubs_kset;
> +static struct kset *uv_pcibus_kset;
> +static struct kset *uv_hubs_kset;
>  static struct uv_bios_hub_info *hub_buf;
>  static struct uv_bios_port_info **port_buf;
>  static struct uv_hub **uv_hubs;
> 

