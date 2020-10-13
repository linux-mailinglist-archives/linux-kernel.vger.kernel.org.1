Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8128D617
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgJMVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:04:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A728C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:04:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so960186edk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dpznq1bVtHuTvkgZ0V3uOe64d8urDDLe1UJMO63b1Hs=;
        b=B7TVlQ2cGFtisTvY81goMmv1p7zhU8tVopK6OyjfNs0BEU7T2p+ZQfOnQmGLPH176X
         Ddx44SpYCO2gquP5hbMHKic8xHREKYmC0yPabTFE1gplCRX/1peJ9ZrQtrX6RdXv81VN
         K4JPq9b14w6YErYoiaxnLTBoSOxjd8Vw7AzCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dpznq1bVtHuTvkgZ0V3uOe64d8urDDLe1UJMO63b1Hs=;
        b=tplTX9ThZO9TFPuQfuTfAfrFDycTylF2xj7Rlu8MlCm45P3+C7m2xIGsjSyjOpXjZX
         8ls/FFnpdPmZIYG0myzPxhmQhI50E7o3EtMbkxyp7RxCJTn8Ca+VyVw6HuhJEKn0QyNN
         2/4kWGpVmULZGdOiBgCq4aezEXH7rTOmIHtOhCEmEnmFd/UvpbMhUTf0C4lhOngFxLR8
         7f992cjvbw7hul+dIKW9ZA5DCb3FiD8wxTDOqwAwyWJ1a7XV+dbrak9qVJWyVNj85oma
         Z4tKRZ2WokD7ZhCMPJC6dibh6x581iKyLwdNe7Gc7qZcRAPmWKoOUs610R9HEuTbcida
         fq7Q==
X-Gm-Message-State: AOAM532I+Ww0mOx4CNv93juPP07TYmdPdRQ85VoA8UtYiX8QjRHWulzP
        x5dlJMlWrzcBw+5HN+Xn+R6otg==
X-Google-Smtp-Source: ABdhPJw5D4eRrsPzQP92gAP9vfi6hiIqR+4GaLJTcdF3tCuPnywuQSebLETL8Z2Ciy7q0rfo+5zGxQ==
X-Received: by 2002:aa7:d143:: with SMTP id r3mr1636703edo.103.1602623062929;
        Tue, 13 Oct 2020 14:04:22 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id f23sm543444ejd.5.2020.10.13.14.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 14:04:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
 <20201013205427.clvqno24ctwxbuyv@wittgenstein>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <22ff41f8-c009-84f4-849b-a807b7382253@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 23:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013205427.clvqno24ctwxbuyv@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2020 22.54, Christian Brauner wrote:
> On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
> 
> Hey Guiseppe,
> 
> Thanks for the patch!
> 
>> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
>> immediately close the files but it sets the close-on-exec bit.
> 
> Hm, please expand on the use-cases a little here so people know where
> and how this is useful. Keeping the rationale for a change in the commit
> log is really important.
> 

> I think I don't have quarrels with this patch in principle but I wonder
> if something like the following wouldn't be easier to follow:
> 
> diff --git a/fs/file.c b/fs/file.c
> index 21c0893f2f1d..872a4098c3be 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -672,6 +672,32 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  }
>  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>  
> +static inline void __range_cloexec(struct files_struct *cur_fds,
> +				   unsigned int fd, unsigned max_fd)
> +{
> +	struct fdtable *fdt;
> +	spin_lock(&cur_fds->file_lock);
> +	fdt = files_fdtable(cur_fds);
> +	while (fd <= max_fd)
> +		__set_close_on_exec(fd++, fdt);

Doesn't that want to be

  bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1)

to do word-at-a-time? I assume this would mostly be called with (3, ~0U)
as arguments or something like that.

Rasmus
