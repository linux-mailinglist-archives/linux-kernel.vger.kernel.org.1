Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0903D281F68
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgJBXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgJBXxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:53:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53FC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:53:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j19so2009313pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Krm4cUinP2ZnHJMcjdvF7+aHcAqaVid7ubHsX5Hx6MY=;
        b=F8kEaJT/81zeRpObqHKzAKAvppEK+jcl3ylqEDHTytBMJo76fgLBX8NRXflEseeuHZ
         0DwxqRnBRhWQn2QB2RxCN3fLYu/6NY4az/an9l7DPNv713X7P3OrSDl67v03+yuahavt
         5OvO8PPkWQug0t/mx8HKbhqbpmfT/3NkKB713jRTvhgdfI8yF6WGqAyR0LUu6r/5Qm8P
         QY6H/C357hZ+V+z1tzNa6rNrqOcXams0qRkOK2R2YzSR1nBGc8kd1awLxDQBe5oD0HBE
         iTYA37R1RL8kKqwTVAugNm1CZV5FDh1+VSMKuBjSTYHm+TUn3hfNj1C+I4AmJ7o9NVFy
         oVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Krm4cUinP2ZnHJMcjdvF7+aHcAqaVid7ubHsX5Hx6MY=;
        b=aOhgrjrxvQVIFjRCPECbGvkY2JPs47nKg9L7DpovG3/uFgGQtFzsgDaRJ/c+tcDPnr
         tk3fvzbxN3afm0ZjFFHqN9iRiZdzlLlXjedjSkjfXt20g7z7/zDsV7IYp8cly2qMMjEw
         XMkBOUNas+BW6/FKpQpirC+bvwTuXCnqhZKW2Sw0nKwYfwU21mQ9g6m/OtOwZkhE6Wg9
         8WDavHTXjeNgY7ntW5ya2yoNO9WA2/ER7Bhj/lt4F0prB/rcIEpE0C/IAdaXF/kPVi2g
         AZK1Gu28scjaIuL8XUo5xt5npxRGg3EufrULpCDhdIOBYBoWnw8aJK6d4qd458pbwG/V
         glUQ==
X-Gm-Message-State: AOAM531CIPXxcGCmqLayJ6z21RYOWtPfm6KzGZv1LDteQDrnW16JwWjg
        B16YSNCXcMCkrSVT6ngWJw22vw==
X-Google-Smtp-Source: ABdhPJydymlGPn7Pk4GNnWGcQav4MOnf+52DlXw05JAhewlJ+3pLJqRd4lFQqGABkUFFASN0QjcPuQ==
X-Received: by 2002:a17:90a:6705:: with SMTP id n5mr5190620pjj.72.1601682786821;
        Fri, 02 Oct 2020 16:53:06 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k7sm2652424pjs.9.2020.10.02.16.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:53:06 -0700 (PDT)
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20201002231033.GA6273@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
Date:   Fri, 2 Oct 2020 17:53:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002231033.GA6273@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 5:10 PM, Gustavo A. R. Silva wrote:
> diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> index 2817230148fd..6c34f6e2f1f7 100644
> --- a/include/uapi/linux/cdrom.h
> +++ b/include/uapi/linux/cdrom.h
> @@ -289,7 +289,10 @@ struct cdrom_generic_command
>  	unsigned char		data_direction;
>  	int			quiet;
>  	int			timeout;
> -	void			__user *reserved[1];	/* unused, actually */
> +	union {
> +		void		__user *reserved[1];	/* unused, actually */
> +		void            __user *unused;
> +	};

What's the point of this union, why not just turn it into

	void *			__user *unused;

?

-- 
Jens Axboe

