Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921B2C5246
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbgKZKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388207AbgKZKp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606387558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMFsV6J4cYnv0icJ5WDcZXl06565syo1zevHWnWoHSI=;
        b=K8YuiRzL739JZ8XcXT0jNar3M0+GyX3olKgceYcmFVCQ+ODPdKFRA8EeJTIwwucXR1AY2u
        hoVYLZl9kGd1MawFbqqw/mn8+cfboj6yC3Z7ZrJMhcYlGdRJ1AV3gJRsW6zfRgH6WAKvG1
        bjezZPajB6ptmx7pfX5Ila8z9OrabLM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167--WANnoeTM_2K_S9XjqAtnw-1; Thu, 26 Nov 2020 05:45:54 -0500
X-MC-Unique: -WANnoeTM_2K_S9XjqAtnw-1
Received: by mail-ej1-f72.google.com with SMTP id e22so684073ejx.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMFsV6J4cYnv0icJ5WDcZXl06565syo1zevHWnWoHSI=;
        b=rrwbUkIzzFeWP2yCw4ZmsEgmYW1ixSJV93DRE6Lb/EuWEgQh35W1s0djV0WcKST4le
         RpnO/2LTEgqi/FyEigBfSdYVEtt0El+oYigBVZzd/KTZzSIx5QKZFlpeilH8TEyX7QT8
         f9hNwAzcDSyedGvswhVaxqInftmf8ZNXNtAeXfoTbcxbG7qoRoDfdH1chZ3Xtsod+2Q2
         6FKY+xkWYV+NYrKjuq1oF9Ezq0YV4OfuYNvhD9+FOtIoTdGNY00q8ETDd+PYRUVH9Tbk
         xKrIGVu9qWSbRquKn/1HdGMRhqT4z/r/rCGODIHjVNg2kNNUpHCOBTZmNu0il4ceC9jd
         wDGQ==
X-Gm-Message-State: AOAM532PUtfwUibIWVh6PVp7JpIUH3xEqJ3gpVm1oXSvdXT8bh0IGMqW
        VYxbpOxg0sQQQTS2XITWDF/aJjsM4tCPwEsceYJCSgZkJnNPiAmFQpyWzeOebs71GFivYNgddC9
        FlRuXZnLheouYWZiSxA6Vka3s
X-Received: by 2002:a17:906:4c82:: with SMTP id q2mr1986959eju.285.1606387552996;
        Thu, 26 Nov 2020 02:45:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH8NOeignej3q+i+UEpdi3N/tpkCIRdvzf1FEQPgvSmaiPQtiOA1QaUEJPPdzLJRVRe2qmwA==
X-Received: by 2002:a17:906:4c82:: with SMTP id q2mr1986939eju.285.1606387552837;
        Thu, 26 Nov 2020 02:45:52 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w16sm2875826eds.81.2020.11.26.02.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 02:45:52 -0800 (PST)
Subject: Re: [PATCH 4/5] x86/platform/uv: Add deprecated messages to /proc
 info leaves
To:     Mike Travis <mike.travis@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201125172907.240996-1-mike.travis@hpe.com>
 <20201125172907.240996-5-mike.travis@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b0339696-049a-e46e-bcd4-079f1b13d725@redhat.com>
Date:   Thu, 26 Nov 2020 11:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125172907.240996-5-mike.travis@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/20 6:29 PM, Mike Travis wrote:
> Add "deprecated" message to any access to old /proc/sgi_uv/* leaves.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 48746031b39a..bfd77a00c2a1 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -1615,21 +1615,45 @@ static void check_efi_reboot(void)
>  		reboot_type = BOOT_ACPI;
>  }
>  
> -/* Setup user proc fs files */
> +/*
> + * User proc fs file handling now deprecated.
> + * Recommend using /sys/firmware/sgi_uv/... instead.
> + */
> +static void proc_print_msg(int *flag, char *what, char *which)
> +{
> +	if (*flag)
> +		return;
> +
> +	pr_notice(
> +		"%s: using deprecated /proc/sgi_uv/%s, use /sys/firmware/sgi_uv/%s\n",
> +		current->comm, what, which ? which : what);
> +
> +	*flag = 1;
> +}
> +

You have just re-invented pr_notice_once, please just use pr_notice_once
directly in the _show functions.

Regards,

Hans




>  static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
>  {
> +	static int flag;
> +
> +	proc_print_msg(&flag, "hubbed", "hub_type");
>  	seq_printf(file, "0x%x\n", uv_hubbed_system);
>  	return 0;
>  }
>  
>  static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
>  {
> +	static int flag;
> +
> +	proc_print_msg(&flag, "hubless", NULL);
>  	seq_printf(file, "0x%x\n", uv_hubless_system);
>  	return 0;
>  }
>  
>  static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
>  {
> +	static int flag;
> +
> +	proc_print_msg(&flag, "archtype", NULL);
>  	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
>  	return 0;
>  }
> 

