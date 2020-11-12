Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C330C2B0851
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgKLPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
        b=hMIJI9aym5yni2izh+hbLXqhyhtVnz7r/Mh6NGGYzcfRQRC7+9mXraJ6ov5xSCxTepqLCl
        Bbq9sIcPC66jgnwK1HqmHl5P/HB1bYf+ldZ6XlAh/agGDteS2vjd9P1eER/mShHJyWhOgX
        j2+mJHd3xyX8USyyIP2lJ7oVCeeS8ZM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-v87lIjcNMLiES-DWYpZrdA-1; Thu, 12 Nov 2020 10:24:41 -0500
X-MC-Unique: v87lIjcNMLiES-DWYpZrdA-1
Received: by mail-wr1-f69.google.com with SMTP id z13so2077583wrm.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
        b=WdLA95+MiFbz4bmY51WYcdbs0YX7Fm9A9zl1OXCet/7ioEDaMwONEZ+BnsCDYmoHoV
         RIxFhXZfaNiXHVMtvjL88W8bhX0ICyVvFIyXKUH8UGHJk+MaaRr0NQwelVtjwcsUiK6w
         oggC4GX6iiJy9TzAtxibrZ2rGPMGsDOtf91XRtnO2Vm34PE3FLdfqwpj+zQGyeoBxeoJ
         szd/YLMBWFHwaVS3iS4fu9VqsM7FBg/SCmZDGMMqMY/ChfZMjH/otUIuOeDzxK1pYP3Y
         EVg3hBIieLOw5F/Ewu0/1QQ6E5PJ1tcUXknEnakSjMUf0QfGArbYV8wDLAbZ+e2xxX8d
         0+bA==
X-Gm-Message-State: AOAM532bu2IwDklDAlSeerRmBZ08Ot4dz7yZLb+JSQzsmq8dKfUE96SI
        yyPJJz1ciX8gqpFAgL753RBbu47Ppr83+NePJGL+gEdFlWwBf1n505+f6Mff1hbNc8HORMHs4fd
        2KZ+HttEaKD7OQ1gM4ZvOMaqJ
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117235wmf.189.1605194680191;
        Thu, 12 Nov 2020 07:24:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX21sudMRdY26dySOmO/to1hNdt6R88HOOtUfizeNAVKSfSVnCXeomIzbUIzj2x9YbFyGcVQ==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117208wmf.189.1605194680020;
        Thu, 12 Nov 2020 07:24:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h62sm7096528wrh.82.2020.11.12.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:24:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v2 03/17] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
In-Reply-To: <20201105165814.29233-4-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-4-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:24:38 +0100
Message-ID: <87imaay4w9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e5..37c4d3a28309 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	if (hv_root_partition)
> +		return -ENODEV;
> +

Nit: any particular reason why we need to return an error from here? I'd
suggest we 'return 0;' if it doesn't break anything (we're still running
on Hyper-V, it's just a coincedence that there's nothing to do here,
eventually we may get some devices/handlers I guess. Also, there's going
to be server-side Vmbus eventually, we may as well initialize it here.

>  	init_completion(&probe_event);
>  
>  	/*

-- 
Vitaly

