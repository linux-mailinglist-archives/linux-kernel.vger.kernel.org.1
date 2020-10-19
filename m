Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659C292BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgJSQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgJSQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:50:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:50:35 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so835211ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CZGaBpF+XG3vwH05pw71qWVZZZgkknNclI0WAqZQgSY=;
        b=Cj5PKu+w0E1ji2GDGbABo9oM6ap9FJejYSREnFl6+ofXwjpvE9kCJnPziy+E874NK/
         szGIej57JZ2r/5FjwTBHGITuDJX2stUxMPJU/jNvsGlpnexnBQLkQc/nQYOQnIWgjj8h
         VjRwo0HQJ6mzT0EG7UEBPWuqJLBltMHx3zpNhUckZMNqejeUYoAkfSgdKDiJWWsEjxvx
         oUiwGGaJSSw51hLsWIgVFsTOD0k/+bKavrp3vQqq8+nHyQ5GoyBIKdHZ+XyokBWdp9Kx
         rPhfMb7//pnZHlZAqmnSn8XCJ9fcU5Tvt/TSeXgqZUN9J+DTtx3QdN6OFkr6t+jO5IBu
         r8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZGaBpF+XG3vwH05pw71qWVZZZgkknNclI0WAqZQgSY=;
        b=aw26ziYmuO9cyIvQCTPqoF1Ec6x3/Ju1mL7bewqp5AeZEWzKTKPu2bMvYUN2OjCZ1y
         nFN4FTwYfp0GkPjnPiv2yHjT05w5rbHOyGCVRygggwdWDT9F121/O6tgC2mMbjv7LJZy
         ZcAlxIVtYhCUfteDZhQAsJZNmsPUox9qZXsC9I1Dx4DRXXis/0A5trWloEq3JvR4KxqA
         ynmINbWfDH/mwn6BIEWf3CtkJ4FAPV/21bmxhl0TvL63cv7Dn3enBJM+9FZSvRTGOfYY
         tRLZFwNaX5Zoh0ysNItb4qUbUiU7dX1PcxGgRXFzSxxZLLtUr1X0xAJnc8gNYUlnNN9s
         zGcw==
X-Gm-Message-State: AOAM533RiFgOomekDX7W7QYjG56iMVysg02GyixY+oE71KeIP4IIiiUl
        t2jTvVK9fb6byLM7YWOYR7+LJ3OCC2WS6g==
X-Google-Smtp-Source: ABdhPJyfh3SKt/Cs5dzhr5eRA3fFFyIBq9MlPQ3JP992LoEki9nwODqJhoNorbsGwiT26Ui9pkjp1Q==
X-Received: by 2002:a92:bb9c:: with SMTP id x28mr766407ilk.77.1603126233747;
        Mon, 19 Oct 2020 09:50:33 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm275921iot.52.2020.10.19.09.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 09:50:33 -0700 (PDT)
Subject: Re: [PATCH] block/elevator: reduce the critical section
To:     Hui Su <sh_def@163.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201019164246.GA79115@rlk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e63eb362-a1fc-f746-b5cb-b58d76fd3d06@kernel.dk>
Date:   Mon, 19 Oct 2020 10:50:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019164246.GA79115@rlk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 10:42 AM, Hui Su wrote:
> 1.reduce the critical section in elevator_get().
> 2.reduce the critical section in elevator_get_by_features().
> 3.remove the found variable.
> 
> the elv_list_lock is used to protect the elv_list,
> and the operations of elevator_type does not need
> to be protected.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  block/elevator.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 293c5c81397a..727902b31954 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -151,11 +151,11 @@ static struct elevator_type *elevator_get(struct request_queue *q,
>  		spin_lock(&elv_list_lock);
>  		e = elevator_find(name, q->required_elevator_features);
>  	}
> +	spin_unlock(&elv_list_lock);
>  
>  	if (e && !try_module_get(e->elevator_owner))
>  		e = NULL;
>  
> -	spin_unlock(&elv_list_lock);
>  	return e;
>  }

What happens for:

	A					B
	spin_unlock(&elv_list_lock);
						rmmod -> elv_unregister();
	try_module_get();

-- 
Jens Axboe

