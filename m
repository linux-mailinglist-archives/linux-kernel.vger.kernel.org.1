Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247F7222DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 23:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGPV0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgGPV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:26:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E71DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:26:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l17so7658816iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQxCrdBDFS2fRH6xFMh6bKNwdL/lOdhX2TcgbTw/bOw=;
        b=X1bKofa1qS2JEqLt0jom2OGXcSEoy9mscvmqkSKw8hFEy0fixVyEp97RLhJBv0e25M
         5JKdMVDMSTsC5WlnjOSPEo/tHM7cdH3CZ9iJLQBDMXVrv18QtAElSGku/OwZib6w+YDZ
         DPMZ8zhKkmKok/aW7E+USmDemh/OhbI+MFhZDrPjUCoVLLS8sCH6uu61kaFE8LqZrslC
         +nno3iWJZm1lbiDJXPvnuDBIJyTCQRgTVEJMwwqfZZqcxhsf4+9PRJ+/vK22/BTtxuEB
         LK5CvgOZLaUAjsWE48ccQb8xKsqoO2DrM/MEbnYL7Fyo5JpyMmYLeZBXl7GCDwrWKoSG
         2sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQxCrdBDFS2fRH6xFMh6bKNwdL/lOdhX2TcgbTw/bOw=;
        b=nNyou2aCx76/w4tESXPeslYYC094MK0h4k/4pAHRRzsNlWBgfvrjYaTd+b830sVC4R
         u4XaIz3mdFz1YcL+AbpgsX45g2N5WGUgPdHXghjTK5wGKwt+R9sTe45YXK0AYQxJlNR4
         XrPBX5fsvYFQQ+lhz9VaXqXIwywPZVsoHtvSpNwuwsYBkB5Gteud16RNXyg/wor6lLpd
         /3SqSbwjX573mSgHJUkToIr7MBkFLhMPxM0iOMLEf6Bav5v0zmUQqauEmDdRzInyJP2y
         lPpr/QGcmUUCiKmdd4953n/LBekHb7UbtKZZjhdtRNffBE0vKTtvWNnD1G55IGDREJnA
         IxVA==
X-Gm-Message-State: AOAM531XDvSK8yGnlUXIYe/bzXwIM2C9n38CUILn5eV4PmqOWu+NYkSm
        HOi1NSFz442rW3ae05weQenPAIkZARL9bg==
X-Google-Smtp-Source: ABdhPJziyVuAkAxLvealhwn98eWxfMZWbG1ZmYnENKBM0t128sCt9/8AqZ3b6rF3HvTsRxWrjCRABQ==
X-Received: by 2002:a05:6602:2103:: with SMTP id x3mr6450447iox.130.1594934813535;
        Thu, 16 Jul 2020 14:26:53 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u65sm3232286iod.45.2020.07.16.14.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:26:52 -0700 (PDT)
Subject: Re: [PATCH RFC v2 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-3-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0fbb0393-c14f-3576-26b1-8bb22d2e0615@kernel.dk>
Date:   Thu, 16 Jul 2020 15:26:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716124833.93667-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 6:48 AM, Stefano Garzarella wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index efc50bd0af34..0774d5382c65 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -265,6 +265,7 @@ enum {
>  	IORING_REGISTER_PROBE,
>  	IORING_REGISTER_PERSONALITY,
>  	IORING_UNREGISTER_PERSONALITY,
> +	IORING_REGISTER_RESTRICTIONS,
>  
>  	/* this goes last */
>  	IORING_REGISTER_LAST
> @@ -293,4 +294,30 @@ struct io_uring_probe {
>  	struct io_uring_probe_op ops[0];
>  };
>  
> +struct io_uring_restriction {
> +	__u16 opcode;
> +	union {
> +		__u8 register_op; /* IORING_RESTRICTION_REGISTER_OP */
> +		__u8 sqe_op;      /* IORING_RESTRICTION_SQE_OP */
> +	};
> +	__u8 resv;
> +	__u32 resv2[3];
> +};
> +
> +/*
> + * io_uring_restriction->opcode values
> + */
> +enum {
> +	/* Allow an io_uring_register(2) opcode */
> +	IORING_RESTRICTION_REGISTER_OP,
> +
> +	/* Allow an sqe opcode */
> +	IORING_RESTRICTION_SQE_OP,
> +
> +	/* Only allow fixed files */
> +	IORING_RESTRICTION_FIXED_FILES_ONLY,
> +
> +	IORING_RESTRICTION_LAST
> +};
> +

Not sure I totally love this API. Maybe it'd be cleaner to have separate
ops for this, instead of muxing it like this. One for registering op
code restrictions, and one for disallowing other parts (like fixed
files, etc).

I think that would look a lot cleaner than the above.

-- 
Jens Axboe

