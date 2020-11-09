Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2D2AB42D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgKIJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:58:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36936 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgKIJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:58:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id cq7so7846520edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNFtn6NlswuMMTVzQaKUv9bkNfkyo9u964daRy78q6U=;
        b=DGfww1g/Ufmi1SJHKLdjcpylZxRvgS2tmzGd2nKjHla9poRu5yQWFF2EPc6glhA7C7
         7fclqHFzxrJ2QHjJkPLwdJeviMTV0D6lVi9MckUekMRMlHEy/F8NT/7jXGjt6WZcqc3Z
         DFgQVm2D5mgw6fQ18695ZETlvGNaVIF9I5oNj3uscuUyompLFL1+5aOO1rvMPzzeKhw9
         qLACvtmO3S1z0wjPsPTVtFAfbIFyibrf2sYQEk1gWwaZD0ipMS5GEiCIdQKSVc7QeCY0
         5Glp8A1J1jTGBs+wg6mJPU3t2KDeCY5DPjO6jYYhtqteXuRpkxQrJU5ffafE55Xx6L5E
         mMPA==
X-Gm-Message-State: AOAM532fLd6ItywE6BJcrR8vZISNjLuc1WbvMOQyq5QmYZFkoZXHce2q
        SuYIw1mWpYpoBudN8CpqZqs=
X-Google-Smtp-Source: ABdhPJwR+fYiNi7X9xiAbsJHrodvtkoyYXf9p3LP2pJG+SW3gX79FZHVwlg2YIr86hmiF+6o+f3JyQ==
X-Received: by 2002:aa7:d351:: with SMTP id m17mr14793728edr.215.1604915894377;
        Mon, 09 Nov 2020 01:58:14 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q7sm8310188ejc.28.2020.11.09.01.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 01:58:13 -0800 (PST)
Subject: Re: [PATCH v1 2/3] vt: keyboard, replace numbers with \r, \n where
 appropriate
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <20201106143551.43908-2-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <3c5af900-a8ee-e284-281b-ad8deeb78064@kernel.org>
Date:   Mon, 9 Nov 2020 10:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106143551.43908-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 11. 20, 15:35, Andy Shevchenko wrote:
> Instead of 10, 13 use \n, \r respectively.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/keyboard.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index bfe54b9822af..647c343f61fb 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -462,9 +462,9 @@ static void fn_enter(struct vc_data *vc)
>   		diacr = 0;
>   	}
>   
> -	put_queue(vc, 13);
> +	put_queue(vc, '\r');
>   	if (vc_kbd_mode(kbd, VC_CRLF))
> -		put_queue(vc, 10);
> +		put_queue(vc, '\n');
>   }
>   
>   static void fn_caps_toggle(struct vc_data *vc)
> @@ -827,7 +827,7 @@ static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
>   
>   	put_queue(vc, pad_chars[value]);
>   	if (value == KVAL(K_PENTER) && vc_kbd_mode(kbd, VC_CRLF))
> -		put_queue(vc, 10);
> +		put_queue(vc, '\n');
>   }
>   
>   static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
> 


-- 
js
suse labs
