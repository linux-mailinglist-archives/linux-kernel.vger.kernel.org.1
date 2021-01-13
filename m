Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16462F4BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAMMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhAMMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:52:31 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE694C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:51:51 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o6so3730495iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:date:from:to:cc:subject:in-reply-to:references
         :user-agent:message-id:content-transfer-encoding;
        bh=qhkEqXsTfNFQu3YiKYv8ypbqP4b1UyaJYi0d3q+UtuE=;
        b=HQoaVygrHNpMPVy7m82be4EHt4wuqT4sodTPkyC0QpcnxHenhODLCbTXKxnmf9rxDA
         OWXCqZxIHOjBfZojF7bDkqu1l2QaA+5ti2inxc5Y87bYWTmkIh/6Jl9RlOpz17r34kq7
         O6rjrbEQCEwvrZNxpi8JLmP+BNpPRcPgUo20o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:from:to:cc:subject:in-reply-to
         :references:user-agent:message-id:content-transfer-encoding;
        bh=qhkEqXsTfNFQu3YiKYv8ypbqP4b1UyaJYi0d3q+UtuE=;
        b=oXxjxK7EVh2rR9jM38nJiYc4oLLbodGOIuNgT9q9jRg1l+8FLHaGbJG7M+LnQ2cM+s
         O7oPtauak+/LR6nTt0EWVg+9VS2vuatVpMr26Jl4xiwIm09ynxMCqNIblMLygJK1I31I
         xXQ7QAbePZJzfbZXv2KI5xIJs1EoLZg6Zrav/N6wCFVeOJ7yjFDyf7k1mRp3V/Xd1ZfC
         XcjiyqRXLA1odFPiiU4d5dA2GnAYwHjc6N1pp5Y35qHUP5u+krHlJgyx+egcxF2Q49vC
         qygEoKqK8WwNjaQoZzCqBlzlMDPcEBDQ4Er0HeE7EM6m19va3zzxTa88NucTOYL4ZXaR
         bZlw==
X-Gm-Message-State: AOAM530gUwcafHXDX8CuCoojFurgnHJiCZSQ3P23fILfMy2t5o8za3+0
        OOWizP+gNhOSxwP4LJQubj8dag==
X-Google-Smtp-Source: ABdhPJw/6nGXs2lPxyQs0fPF4UVNW8OcJ7FJvcxwo+dJfm3TzpRBLu2WuHAkmo4dvP6otiLpqnpMjw==
X-Received: by 2002:a05:6e02:1787:: with SMTP id y7mr2102033ilu.233.1610542311012;
        Wed, 13 Jan 2021 04:51:51 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id s12sm1483834ilp.66.2021.01.13.04.51.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Jan 2021 04:51:50 -0800 (PST)
Received: from 10.10.2.100 (sunraycer [10.10.2.100])
        by sunraycer.home (Postfix) with ESMTPSA id 9BCFF3749EC;
        Wed, 13 Jan 2021 06:51:49 -0600 (CST)
MIME-Version: 1.0
Date:   Wed, 13 Jan 2021 06:51:49 -0600
From:   Steve Magnani <magnani@ieee.org>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org, 282827961@qq.com
Subject: Re: [PATCH] udf: fix the problem that the disc content is not
 displayed
In-Reply-To: <20210112055304.31842-1-changlianzhi@uniontech.com>
References: <20210112055304.31842-1-changlianzhi@uniontech.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <9495f2dcd2882a43678532eb8df356bc@ieee.org>
X-Sender: magnani@ieee.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 23:53, lianzhi chang wrote:
> When the capacity of the disc is too large (assuming the 4.7G
> specification), the disc (UDF file system) will be burned
> multiple times in the windows (Multisession Usage). When the
> remaining capacity of the CD is less than 300M (estimated
> value, for reference only), open the CD in the Linux system,
> the content of the CD is displayed as blank (the kernel will
> say "No VRS found"). Windows can display the contents of the
> CD normally.
> Through analysis, in the "fs/udf/super.c": udf_check_vsd
> function, the actual value of VSD_MAX_SECTOR_OFFSET may
> be much larger than 0x800000. According to the current code
> logic, it is found that the type of sbi->s_session is "__s32",
>  when the remaining capacity of the disc is less than 300M
> (take a set of test values: sector=3154903040,
> sbi->s_session=1540464, sb->s_blocksize_bits=11 ), the
> calculation result of "sbi->s_session << sb->s_blocksize_bits"
>  will overflow. Therefore, it is necessary to convert the
> type of s_session to "loff_t" (when udf_check_vsd starts,
> assign a value to _sector, which is also converted in this
> way), so that the result will not overflow, and then the
> content of the disc can be displayed normally.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> ---
>  fs/udf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 5bef3a68395d..6c3069cd1321 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -757,7 +757,7 @@ static int udf_check_vsd(struct super_block *sb)
> 
>  	if (nsr > 0)
>  		return 1;
> -	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
> +	else if (!bh && sector - ((loff_t)sbi->s_session << 
> sb->s_blocksize_bits) ==
>  			VSD_FIRST_SECTOR_OFFSET)
>  		return -1;
>  	else


Looks good. Perhaps consider factoring out the conversion (which also 
occurs
earlier in the function) so that the complexity of this "else if" can be 
reduced?

Reviewed-by: Steven J. Magnani <magnani@ieee.org>
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
                                   Earthling, return my space modulator!"

  #include <standard.disclaimer>
