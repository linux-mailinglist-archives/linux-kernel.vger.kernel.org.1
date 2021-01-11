Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180FD2F0E50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbhAKIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbhAKIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:38:35 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B124CC061786;
        Mon, 11 Jan 2021 00:37:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id w26so2446093ljo.4;
        Mon, 11 Jan 2021 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yG1eHcV1L5d/bJR+Q+DTigzH+FMqbFCh9WVBpgc/7t4=;
        b=ZLhz87DEUrCm15tm22kMIqQTcrWG1o6WjyRSg/kYxmsZ6gOULYVMlfsXZyv1LuII77
         M1Y+2hjsQTD+ZpH8+PScq3pXi/zJufaY3BAitF62d1rcRIHZQGqjHu+KqfIInMjXFS8R
         RMFhAsfhplqt5dBxDzZf3LZVYt+jtHV9Qdz07p7yjdI1CPt7CaFZ1sklO4W+6dRXmbr6
         JjWU3jdbglRxIUWvNP2vlOBC6DrCY4KMp/qx9p2GLpq6aneeRwQ9dTbo1F3gnbuV8zGv
         Kj52YeUml6yP20l5q+pM6G8k/1owJsPckWmLUa/jjySQMwSQQQ51HKUbjgh7SL2lIH5K
         1oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yG1eHcV1L5d/bJR+Q+DTigzH+FMqbFCh9WVBpgc/7t4=;
        b=hheBRglohY8dKSdfmdDAJ/6EAes1XNMF4vGLwmVsrgCvXkzGdFcECfbZK4XNwFWLwu
         X11t6H37Vh6aqJYFiEP3/ekDofh9m+yJ3BrK6Tc2GJeNMG++ty1YvgOg+dzissj84c7K
         3TCYSGZE99NV8azlmddCa876OzVJnqyr0wHeyLM3ydSevxxfaeckmqMNVsZYxTQcmXLf
         Xq3+FFksODhw+ymiexkQ+nDU1qtZWaAf7NjModwEHoCYc+w/qVFuNWWBWboCNXvGAl8n
         UQHZy+yr3QOwMZrF17uNAZKXRN0NhfJWItIgclWHP3CIcPhupz51Pk6EK8Egybv6zNmv
         YkDQ==
X-Gm-Message-State: AOAM531lR81DwMe4cm2NisWlE89MpIAQtr6XFLrJch01IStBSFoWwWxx
        4gR8MkP9sYmyYEDMnWfnBIPPJZroXZ1mIg==
X-Google-Smtp-Source: ABdhPJw2FAzXZ8DjkIJ6FZahDXZQg62W0HAHv73AfWR+hGXVFfl/EZMuPFS/I5FORAKnAM66nzJKuw==
X-Received: by 2002:a05:651c:1047:: with SMTP id x7mr7332053ljm.114.1610354273231;
        Mon, 11 Jan 2021 00:37:53 -0800 (PST)
Received: from [192.168.1.100] ([31.173.87.16])
        by smtp.gmail.com with ESMTPSA id q5sm3043102lfr.172.2021.01.11.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 00:37:52 -0800 (PST)
Subject: Re: [PATCH] usb/c67x00: Replace tasklet with work
To:     Davidlohr Bueso <dave@stgolabs.net>, jacmet@sunsite.dk
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20210111044050.86763-1-dave@stgolabs.net>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <87dfaf4f-8a53-2840-c68c-fe10de1408e8@gmail.com>
Date:   Mon, 11 Jan 2021 11:37:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111044050.86763-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.01.2021 7:40, Davidlohr Bueso wrote:

> Tasklets have long been deprecated as being too heavy on the system
> by running in irq context - and this is not a performance critical
> path. If a higher priority process wants to run, it must wait for
> the tasklet to finish before doing so.
> 
> c67x00_do_work() will now run in process context and have further
> concurrency (tasklets being serialized among themselves), but this
> is done holding the c67x00->lock, so it should be fine. Furthermore,
> this patch fixes the usage of the lock in the callback as otherwise
> it would need to be irq-safe.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
[...]
> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
> index e65f1a0ae80b..af60f4fdd340 100644
> --- a/drivers/usb/c67x00/c67x00-sched.c
> +++ b/drivers/usb/c67x00/c67x00-sched.c
> @@ -1123,24 +1123,26 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
>   
>   /* -------------------------------------------------------------------------- */
>   
> -static void c67x00_sched_tasklet(struct tasklet_struct *t)
> +static void c67x00_sched_work(struct work_struct *work)
>   {
> -	struct c67x00_hcd *c67x00 = from_tasklet(c67x00, t, tasklet);
> +	struct c67x00_hcd *c67x00;
> +
> +	c67x00 = container_of(work, struct c67x00_hcd, work);
>   	c67x00_do_work(c67x00);
>   }
>   
>   void c67x00_sched_kick(struct c67x00_hcd *c67x00)
>   {
> -	tasklet_hi_schedule(&c67x00->tasklet);
> +        queue_work(system_highpri_wq, &c67x00->work);

     Use a tab to indent, please.

>   }
>   
>   int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00)
>   {
> -	tasklet_setup(&c67x00->tasklet, c67x00_sched_tasklet);
> +        INIT_WORK(&c67x00->work, c67x00_sched_work);

    Here as well.

>   	return 0;
>   }
>   
>   void c67x00_sched_stop_scheduler(struct c67x00_hcd *c67x00)
>   {
> -	tasklet_kill(&c67x00->tasklet);
> +        cancel_work_sync(&c67x00->work);

    And here.

[...]

MBR, Sergei
