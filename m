Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA222E713A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgL2Nzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgL2Nza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:55:30 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DABC061798
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 05:54:50 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e7so8470914ile.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jpkSmof4VOr4c12tpzfleU/MSe0poA4HAiphrbzBfHk=;
        b=Mv5DuuG3xxZ0kni3aZYwK1y/WtJEv9D4NITzoNct8eMAHv4j2J4qmz3pMg1CmOjZY/
         bDXhM/BZvRbA8xkxEa08q9UAjFgmXzJ/bZf59iD88hkNZr+ttOtW75U3fvhtVTMR1mh5
         N8n4o+lxUn9rJiPrcyLUoIbSR6h40MwicbC7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpkSmof4VOr4c12tpzfleU/MSe0poA4HAiphrbzBfHk=;
        b=DmUt1Mg0uiHQdz7LjYXdIgaHoM3aTjwrGXhrgxQvt6je3xkxPVuiMOS57FY77cfkVv
         /91+4eSlhjlKKx5lSg3TcmS9kgyDo/OxQjNzFNJPXoUARanJIUt36yyz0gr/1RoE0tym
         s2bJ5N7ABrqRq9CQiYja18KjBTYtDS+8JjiLcSSqmgJt4gzj3DqD2Qt0hE6SQbNfO/ca
         a86foEYOT7BUgrpdXYMoRi4k3IuRZgntRwW3lH7J2eKNrAn0FuOgmEA0YpIlN5mdtkBw
         zcsx40U85rSqeSH2s2X9yo805uGsbwrE1kQv0LT46qU9bmalP0R0OqioK1JEOFcumLoe
         +hbA==
X-Gm-Message-State: AOAM531HQEDXysQwLpqc9vj64beIN7Pmol0wZ+3kNhoyHuzl5o1rbbL3
        l2jqNtoQaT6rXQbTEdKqb/LL4qJHnULSag==
X-Google-Smtp-Source: ABdhPJzpyn8e275llToao7tMWEy+kFFPHs5GHfCCa0m23gZOsMBCTRvsyGgGc13fCgJ4D0J2Q7snWg==
X-Received: by 2002:a92:d151:: with SMTP id t17mr49032957ilg.108.1609250088642;
        Tue, 29 Dec 2020 05:54:48 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id p11sm29272733ilb.13.2020.12.29.05.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 05:54:48 -0800 (PST)
Subject: Re: [PATCH -next] staging: greybus: light: Use kzalloc for allocating
 only one thing
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, rmfrfs@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20201229135003.23416-1-zhengyongjun3@huawei.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <0b38c99d-badd-7a86-2026-5e2ff783ad98@ieee.org>
Date:   Tue, 29 Dec 2020 07:54:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201229135003.23416-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 7:50 AM, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>            ...)
> // </smpl>
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>   drivers/staging/greybus/light.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d2672b65c3f4..d227382fca20 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -290,7 +290,7 @@ static int channel_attr_groups_set(struct gb_channel *channel,
>   	channel->attrs = kcalloc(size + 1, sizeof(*channel->attrs), GFP_KERNEL);
>   	if (!channel->attrs)
>   		return -ENOMEM;
> -	channel->attr_group = kcalloc(1, sizeof(*channel->attr_group),
> +	channel->attr_group = kzalloc(sizeof(*channel->attr_group),
>   				      GFP_KERNEL);

Looks good but that shortens the line enough to avoid a line wrap.
Please send v2 with GFP_KERNEL on the same line as the kzalloc()
call.

					-Alex

>   	if (!channel->attr_group)
>   		return -ENOMEM;
> 

