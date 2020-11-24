Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892922C255D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbgKXMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgKXMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOMM6/UKvaAowB9/50O0goOjLqACWA2H3QoKxNezUPg=;
        b=PUtCCsfaP/LPrn2ogeU1KHqlinH2jviuiR4yv5QYJE2TrIvJ/fpmU5+mouNd9qxk4Smxo1
        Q6Fe1UHmbHrHWshw0Zq+V0ZOkK+Pre2bj/ZhJeQDS6L1HiKQHhlOx4lG99rDF2fHsFsc2e
        X6iVmHc/UVy21TFRC81OszfTigp9TEk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-uEqckNKTOXa_15K_9SrzSA-1; Tue, 24 Nov 2020 07:07:47 -0500
X-MC-Unique: uEqckNKTOXa_15K_9SrzSA-1
Received: by mail-ej1-f70.google.com with SMTP id q2so6642304ejj.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOMM6/UKvaAowB9/50O0goOjLqACWA2H3QoKxNezUPg=;
        b=f0fqsym8NvJRAciqBngFLJeWnzpIOhuVFWtgKgSx2pjYmxmqOd0YLkt9yX5VjC+J3Z
         bXWcLTxUn14dTsIe7s1sG5HQhP7mJBCZMCUUxEj9N4t2TuXb+srMWlI7Xk4PGI5bVzYG
         UveNBNRpoucNnvKek/amKVrqNmtH4N5AfDIBE0j0XU4B0tUvafmdUfel+gIzsDp3FpCI
         IeANwfvIEd1cBHwq3CavMPmhJTYNXnWsTKDPFS+69c2SVjZeLauCS+hULLsvJaM9QM1Z
         AZJ4f2xQ3Xx/R0WjkBApeuG7XTaEt2FRbnjFmQFLsBgv4h92zqHXpwvPQmFkJulWVBB8
         fBmg==
X-Gm-Message-State: AOAM532CIeISRmzj1tYzOm5BEjarb0ZkFwR9ZyAV5o70PhOH8o4QTZi9
        mB0O8Juu+RMwzawip8UsdfnIzZM7/9S+IKPE7AewqZzCf9S0fk3zJ/u3LQHEe6e5roYyKZR68wM
        K1jLx2IPIjgTrSsAgulOG9xmN
X-Received: by 2002:a17:906:c24b:: with SMTP id bl11mr3826253ejb.3.1606219665925;
        Tue, 24 Nov 2020 04:07:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz98Nk2zSdgqN22qWsD6rq4DWW82NG8CBkl8i2giR8popap81e2BivxoWCtDL/2k5dHWhluMA==
X-Received: by 2002:a17:906:c24b:: with SMTP id bl11mr3826239ejb.3.1606219665759;
        Tue, 24 Nov 2020 04:07:45 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c6sm6380279edy.62.2020.11.24.04.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:07:45 -0800 (PST)
Subject: Re: [PATCH] platform/x86: toshiba_acpi: Fix the wrong variable
 assignment
To:     xiakaixu1987@gmail.com, coproscefalo@gmail.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1606024177-16481-1-git-send-email-kaixuxia@tencent.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <543af665-bec9-3407-73cb-0e5b614de810@redhat.com>
Date:   Tue, 24 Nov 2020 13:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606024177-16481-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/22/20 6:49 AM, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The commit 78429e55e4057 ("platform/x86: toshiba_acpi: Clean up
> variable declaration") cleans up variable declaration in
> video_proc_write(). Seems it does the variable assignment in the
> wrong place, this results in dead code and changes the source code
> logic. Fix it by doing the assignment at the beginning of the funciton.
> 
> Fixes: 78429e55e4057 ("platform/x86: toshiba_acpi: Clean up variable declaration")
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/toshiba_acpi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index e557d757c647..fa7232ad8c39 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -1478,7 +1478,7 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
>  	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
>  	char *buffer;
>  	char *cmd;
> -	int lcd_out, crt_out, tv_out;
> +	int lcd_out = -1, crt_out = -1, tv_out = -1;
>  	int remain = count;
>  	int value;
>  	int ret;
> @@ -1510,7 +1510,6 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
>  
>  	kfree(cmd);
>  
> -	lcd_out = crt_out = tv_out = -1;
>  	ret = get_video_status(dev, &video_out);
>  	if (!ret) {
>  		unsigned int new_video_out = video_out;
> 

