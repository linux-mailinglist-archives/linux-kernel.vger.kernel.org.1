Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45F302FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbhAYW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:59:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732271AbhAYW6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611615399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+br43BWYs8uxBdvKqN099cMR5CRAOYUfWqj6wzB+qg=;
        b=J9QNgzZ2gAczTNRcr0lZW4wpcNzyHu8EzSN7Ll7eEl838u2bhRo2YRwri6JBHKZBtIKN8p
        C3pkLD1D2C4biYsKJj7yft5OZWkFq7/Lc2ACAtlZr4t9BhNcAkObvEUP+MVIbQ7LTnoase
        WBoUl0MSj1N9CnkokD7EdyCj0hwQALk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-6iEmp0MpOEChA8mOWeDLUA-1; Mon, 25 Jan 2021 17:56:37 -0500
X-MC-Unique: 6iEmp0MpOEChA8mOWeDLUA-1
Received: by mail-qt1-f197.google.com with SMTP id k90so7377617qte.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D+br43BWYs8uxBdvKqN099cMR5CRAOYUfWqj6wzB+qg=;
        b=KsxWY6FlLYoVYBZYlt8YXI4g8TvUVZEFHRQhkFiOzEZtYYpSDEptBgbbrEUiHN42AX
         bANfY4atnFxh4870E9q4LKuE+rLhz2aROlNWzLWLpKXbr9A7KLFhX+i3rX/kuf1NQ6fD
         apk3Lq76vjxwJf84syWzHOQ0FYSKVhaibtfXnb/F8UiPUvqmts2O7cNzvSAdy3FuN6pZ
         9fLqrip29Q8vREmPjmxbDUJJ+vs2l9WDzTmszpZ9/IPo6b88M42L6R54r5daI9YgaH8T
         27R5cOLyMfzxpBqqFph8z5dRA8BZcQEYuC8d/MFlEb38VevNU/XK4ECOigQnCgQaKMfa
         6uzQ==
X-Gm-Message-State: AOAM531A2AFVNlckC/8Pba7yzC6aqIKD5fDfJe6RbByMT9Ywx9Dt2H3i
        WNX1itmxuvF68j22ujn0pgwzhKp5fUsWNpVuk8N1t4+ZhBK2V0fmHkMK44AEZDLluqNki2LXQty
        yH+aMT8hIt/eaSs2RZxWj/qq1
X-Received: by 2002:a37:d202:: with SMTP id f2mr3082605qkj.81.1611615396605;
        Mon, 25 Jan 2021 14:56:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0CDpDdzmMTKfL+eejHQpDS9fn/OYZvcxiwollZ5JcIM5XBoJVFbzIxVegmL/lHSuTJYRx2A==
X-Received: by 2002:a37:d202:: with SMTP id f2mr3082590qkj.81.1611615396362;
        Mon, 25 Jan 2021 14:56:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r64sm3941406qkf.121.2021.01.25.14.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 14:56:35 -0800 (PST)
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4e1c60e6-8e6e-d0c6-970f-674958ffe91d@redhat.com>
Date:   Mon, 25 Jan 2021 14:56:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 12:56 PM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
> authentication feature. Authenticating a bitstream is to make sure a signed
> bitstream has the valid signatures.
>
> Except for the actual configuration of the device, the bitstream
> authentication works the same way as FPGA configuration does. If the
> authentication passes, the signed bitstream will be programmed into QSPI
> flash memory and will be expected to boot without issues.
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: new added
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index ebc2956..7ada1f2 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -51,12 +51,17 @@
>  #define SVC_STATUS_NO_SUPPORT		6
>  
>  /*

This patch fails to apply, i believe the conflict is because in mainline this is '/**' not '/*'

Please check or point me at the branch/tag you are using.

I am using char-misc-next.

Tom

Tom

