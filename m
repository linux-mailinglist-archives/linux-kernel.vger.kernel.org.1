Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E802FA8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407657AbhARSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436897AbhARSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610994742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SivGSgJFEQUXCrUtA+xITIvQY2ohK3O6BF+T2Sbt2e0=;
        b=hzyVX5EEQ+8rvcWRB7fLtQtkcutc63lhJJvUH2KqGOXw4SbVy95siW+ygACbCwckf8ckQ3
        5OB8fyrXIWQZQbWmMJmWlsEy0c5uiAvGL/P4KPSK/tLcQ760oyT1+aIAOudA9yRRjErMub
        qU8zdY78Ypo3phtJZYefJ/EyBFqLte0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-WxeuRLM7P4GpiwW0vegxGg-1; Mon, 18 Jan 2021 13:32:20 -0500
X-MC-Unique: WxeuRLM7P4GpiwW0vegxGg-1
Received: by mail-ej1-f70.google.com with SMTP id p1so5435912ejo.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SivGSgJFEQUXCrUtA+xITIvQY2ohK3O6BF+T2Sbt2e0=;
        b=P5TRLV+4R1LbqEYi2spIaH+IoE0Z0pQy/UmSsrGp62Ybmk5d2YxT8V9XOaPNGWkKSF
         wXnkX46hSWjzGbeUqj3nJ6NKxuj2IeXq2o/zHWh3gfloI00loIT6+pPgM96yKJ+btDBH
         IDKPzpFKpENRyuFElY3rspvlmchNIWr62W34XxlHz/kzUxdIJKRsUWznl+FXNpPT8suk
         VI/xYSIVtw0iJW0r13otxtdDrtojMBAv3IcDlJ0JovDneoougS47fiKU1OMpQ8qT248S
         M3qKRJj662WtByjDAwxfieKs8eSv/JoS6WwxMhKw2j0gXvruEEkIuULqkWOsJih+aP9y
         bppw==
X-Gm-Message-State: AOAM533Byb83fXOdfVg/H8CuGTeL8gv8v42XGsAPkj1PrqTRgm1I60RA
        7fAhe3BYSTWiNaaePQpt0YME3cgqBN+h5MIsnYLbFrodXVo91InJNVuHM/3OrMwyNRlq9xG5ekM
        xvcgUnK2Wxfln093fsiWluaqI0j3GOdka44NrtJyYrOLmpdeWQq4sAsPN3e9eZ7efqLG0nMHnPj
        F9
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr651613ejc.498.1610994733743;
        Mon, 18 Jan 2021 10:32:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrmz3wr4fzkL2a1SfYT86VljwDLjOa5DlzpcfbRWFvHyHdp+6KXXtHhMF1D7CT++aVPWO7Fg==
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr651599ejc.498.1610994733515;
        Mon, 18 Jan 2021 10:32:13 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id c16sm9770094ejk.91.2021.01.18.10.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:32:13 -0800 (PST)
Subject: Re: [PATCH] sony-laptop: Remove unneeded semicolon
To:     Yue Zou <zouyue3@huawei.com>, malattia@linux.it,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210118010137.214378-1-zouyue3@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c0fb7d2-4f32-6d1d-4ed5-29207591a0c7@redhat.com>
Date:   Mon, 18 Jan 2021 19:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118010137.214378-1-zouyue3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 2:01 AM, Yue Zou wrote:
> Remove a superfluous semicolon after function definition.
> 
> Signed-off-by: Yue Zou <zouyue3@huawei.com>

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
>  include/linux/sony-laptop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sony-laptop.h b/include/linux/sony-laptop.h
> index 374d0fdb0743..1e3c92feea6e 100644
> --- a/include/linux/sony-laptop.h
> +++ b/include/linux/sony-laptop.h
> @@ -31,7 +31,7 @@
>  #if IS_ENABLED(CONFIG_SONY_LAPTOP)
>  int sony_pic_camera_command(int command, u8 value);
>  #else
> -static inline int sony_pic_camera_command(int command, u8 value) { return 0; };
> +static inline int sony_pic_camera_command(int command, u8 value) { return 0; }
>  #endif
>  
>  #endif	/* __KERNEL__ */
> 

