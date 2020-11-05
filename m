Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C552B2A78B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgKEIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:16:30 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41592 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgKEIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:16:26 -0500
Received: by mail-ej1-f68.google.com with SMTP id cw8so1315221ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mzOnbpeAJjhktwiculdbHKFD/HWtRTT5V8Z1Bgn+oRQ=;
        b=r1J9AyF71m/whKvx74X5gyo6k0XSIHKD2D7XFDZSXFKFVqxjz+YYAyYogDqCIx0mGl
         ChWWnNpVGt8+O1R9DMJIXBLZy43oqBEc1CxVfbYkR3abWLHd99P4k3qDzUn8VRmUEa9r
         d4H4d0C0sixOpMyoB7KhYgtdRGEAlu69o/8LplPeIiYqMawGpLMq9T3Rk9eSFvC2UCNj
         q0+B75SHNOZBzgzew6Rpe14oYnLfL6f1glSMi4pI5UgQtUYmcN8BcgOPzV78oYioTPsV
         ZHk582iQQ2L/7B89w1PR03IRBX0HGlFca56xM3bvLFw49etuMEMBjtMv68E3dqcpvKFp
         eS7Q==
X-Gm-Message-State: AOAM530isPS5XIRf2mzU4TBmjzG7lZl0v8Q0CtkYeZDA84dZkZP/iesn
        At2hO52r5GBwmW20Oct4a3U=
X-Google-Smtp-Source: ABdhPJxtp3gB9Gzcor3S5u8HrOSmnrI9aAzhs8915Qtj8hwJzm+xOusbbYe3pxarQSAwfeb7TvR46w==
X-Received: by 2002:a17:906:90da:: with SMTP id v26mr1207188ejw.367.1604564183563;
        Thu, 05 Nov 2020 00:16:23 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b8sm426759edv.20.2020.11.05.00.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:16:22 -0800 (PST)
Subject: Re: [PATCH 12/36] tty: tty_io: Fix some kernel-doc issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrew Morton <andrewm@uow.edu.eu>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-13-lee.jones@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <715cfe26-18d3-a035-0cf8-958f1235b4f7@kernel.org>
Date:   Thu, 5 Nov 2020 09:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-13-lee.jones@linaro.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 20, 20:35, Lee Jones wrote:
> Demote non-conformant headers and supply some missing descriptions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/tty_io.c:218: warning: Function parameter or member 'file' not described in 'tty_free_file'
>   drivers/tty/tty_io.c:566: warning: Function parameter or member 'exit_session' not described in '__tty_hangup'
>   drivers/tty/tty_io.c:1077: warning: Function parameter or member 'tty' not described in 'tty_send_xchar'
>   drivers/tty/tty_io.c:1077: warning: Function parameter or member 'ch' not described in 'tty_send_xchar'
>   drivers/tty/tty_io.c:1155: warning: Function parameter or member 'file' not described in 'tty_driver_lookup_tty'
>   drivers/tty/tty_io.c:1508: warning: Function parameter or member 'tty' not described in 'release_tty'
>   drivers/tty/tty_io.c:1508: warning: Function parameter or member 'idx' not described in 'release_tty'
>   drivers/tty/tty_io.c:2973: warning: Function parameter or member 'driver' not described in 'alloc_tty_struct'
>   drivers/tty/tty_io.c:2973: warning: Function parameter or member 'idx' not described in 'alloc_tty_struct'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
> Cc: -- <julian@uhunix.uhcc.hawaii.edu>
> Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
> Cc: Bill Hawes <whawes@star.net>
> Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Andrew Morton <andrewm@uow.edu.eu>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/tty_io.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 88b00c47b606e..f50286fb080da 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2961,7 +2965,7 @@ static struct device *tty_get_device(struct tty_struct *tty)
>   }
>   
>   
> -/**
> +/*
>    *	alloc_tty_struct
>    *
>    *	This subroutine allocates and initializes a tty structure.

Why do you randomly sometimes fix kernel-doc and sometimes remove 
functions from kernel-doc? What's the rule? For example, 
alloc_tty_struct is among the ones, I would like to see fixed instead of 
removed from kernel-doc.

thanks,
-- 
js
suse labs
