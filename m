Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2284D29EC72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJ2NFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgJ2NFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:05:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A3C0613CF;
        Thu, 29 Oct 2020 06:05:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 7so3767073ejm.0;
        Thu, 29 Oct 2020 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jlRvw28Bxq+s0p/obAO5FUK/HKe/tOxPiCwhbWvjxq8=;
        b=jGDq/k51RPhyM4yyaCIfGC86X13Z30xKHvi77d431dDIN7l+pK3cvKUspmos910vKD
         7gCiDeHa7IriMOkCIvGjP3WOiyh22Pzl3Ql5Nu/J9+45YXM30riG+IR6nz3BDIiGB1gO
         H6A5xAhyXWVc035SeaL+pC6jNpRCDnuOz3tjso3qy9TnoYAWFH/GnEiuyM9QutMwo1DL
         o2Rofn/Ui+Lph30OYHyrRyoOJ/9uI9BJNKYVyvaWuWWVex5xyrp75tze7CMdxNjGKqAZ
         mrx7Xc/KrsSybF3lpEWfoKR0o10dBcB7D2F208VUdJMKd5/x543Zn6NcRrlBzdP17Gl5
         xn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlRvw28Bxq+s0p/obAO5FUK/HKe/tOxPiCwhbWvjxq8=;
        b=sXqRP74mji+aywgshNE+i+JKgPRq0NsHD9R+168YNA5qXplWFD/xamjinBxso/hJa7
         1AJb8FZMwS59fJckIfZBnMad8t/Y2NS99iNgUA+D5vfkp9f8LLWowj+SN5iP7oXfm2uF
         g8WuNSFxCvc7zOIzaEYW+JOmSfWPO1MIxZXBMS4liN6GBKWlWCJtKrb3t8G/EyesYXYs
         wRr1gvSKCOoXlQ2SZ3KHqxN7YMLyn2HM0js3PlxkN9VvkiiLfZaT1gmbKYqq30azZxYq
         rQA9IpNYr+/7XX/al4eAVJBQjvQ/0JYdgmsND25j8kwEdsdHNc/yF9X/MjCPNSvbfIjM
         f8+g==
X-Gm-Message-State: AOAM5326H42dfANzVhFOQXp5933y9VePGcMtZhU5a+lTnz7Pcc6RiO6+
        bm67YPBsb3UNaJbniu7IzLc=
X-Google-Smtp-Source: ABdhPJxfDycUZglGd8qcujAsdtea0zQRdHkE08qqZmByL9hVYCQ+4ye2U1iBtn/f8I0HUbXfU67UQA==
X-Received: by 2002:a17:906:1989:: with SMTP id g9mr2324714ejd.62.1603976733687;
        Thu, 29 Oct 2020 06:05:33 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a6e3.dip0.t-ipconnect.de. [217.229.166.227])
        by smtp.gmail.com with ESMTPSA id q19sm1469241ejx.118.2020.10.29.06.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 06:05:32 -0700 (PDT)
Subject: Re: [PATCH -next] platform/surface: remove status assignment without
 reading
To:     Zou Wei <zou_wei@huawei.com>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <1603972048-64271-1-git-send-email-zou_wei@huawei.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <25642c19-6598-42c0-36ad-a2b2d507183a@gmail.com>
Date:   Thu, 29 Oct 2020 14:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1603972048-64271-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 12:47 PM, Zou Wei wrote:
> The status local variable is assigned but never read:

[...]

>   static int s3_wmi_query_block(const char *guid, int instance, int *ret)
>   {
>   	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> -	acpi_status status;
>   	union acpi_object *obj;
>   	int error = 0;
>   
>   	mutex_lock(&s3_wmi_lock);
> -	status = wmi_query_block(guid, instance, &output);

I assume you want to remove the "status =" and not the whole line...

Regardless, I personally would prefer explicit error handling (as is
done in other contexts with wmi_query_block(), see e.g.
platform/x86/intel-wmi-sbl-fw-update.c. Although, yes, the "if (!obj |
..." should cover the error case as far as I can tell.

Also there seems to be the same issue in platform/x86/msi-wmi.c.

On a related note:

Does anyone know if the mutex here is really required? If there are any
problems, I believe it should rather go to s3_wmi_send_lid_state() and
also wrap the input_report_switch() / input_sync(). Otherwise, if there
were any race-type situations, not covering that could lead to wrong
updates:

     Thread 1                            Thread 2
     
     s3_query_lid() returns old
                                         s3_query_lid() returns new
                                         input_report_switch()
                                         input_sync()
     input_report_switch()
     input_sync()

I don't really expect those situations here as s3_wmi_send_lid_state()
is only used in probe(), resume(), and notify() (please correct me if
I'm wrong), so the mutex does seem weird to me here.

Otherwise if it's needed, a comment explaining why wouldn't hurt.

Regards,
Max
