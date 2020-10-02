Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407F281F74
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJBX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBX6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:58:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12646C0613E3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:58:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so2479818pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3FtDjywRYZVCPo0ueVtBW5R3Lk6yWZXURM1EQ0TNlg=;
        b=Ct22wxHpRWzfOSSiVXmEfzF79sGTyyQOBW5bFbAJcU2MyV6Gr+9C/tweJxKTY8abc3
         aLbjT0ZSLxIR/9asN1PG8Z3tYSpqYTsVGfm04sSyWCs0+mzf5fkNn2w5LdiGikwwLGv8
         Q+acAVlqHn8iDeJqG7XPL8JqC+klaIYsNAGnqVoGKBo9s0RXZKqbi5Z7ybJkvHSEbRGI
         Io+knCVn35v41Lc+fv4U/lUc09GRfLPZNg9UAeCHQURJNKzfArdC0vVsaO3pmZNhactW
         D4s8OC0VswuJ4FzKiwNm19i5wYp+jZ5AY21jW9WiHVaDBOYfnfbnX2KYnDpX13785DpD
         pBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3FtDjywRYZVCPo0ueVtBW5R3Lk6yWZXURM1EQ0TNlg=;
        b=LyPw16x4xVDCFgNBIkgdp7Dn+sLX3LpiXqxFMBMoPmwMl3orDpWDu+eAvytIqD2jjY
         z5ag0yqhp7dx4ezmlo87j0gRhJ0FAM5Xned2gpUr/ds1D4JnP9aqq5ZXe8Oeq9EZki34
         09yv9zxVDLyoYABqHjEIP0JRiGmPH8emwaip6Qdf34fsMKFABwbEdmwILXI8Xup6WVq6
         vewt/JA4BE+kcbeAV4uF90pA/+rRzNZpQJhyPIS8EOrre9T3lGYYZFI/ar1hNQnyfBcz
         pe6Wt28TobZVIpUb8F4tgKbREH7pidDG0lFvlTIVt0i2qdK2PFbR/1mNaq0HC5G9RW8r
         /y9g==
X-Gm-Message-State: AOAM532MR98qMLuIwOqLFV6PoTb6EmwZMys0vuKZ8t2D3sVItiz6PE3C
        vPDJHvHoElie+2E2r26+CgmcDQ==
X-Google-Smtp-Source: ABdhPJwaBkSvSZDGuQwnXVeAp67bpb7DN3pIABGIInb1GxOry+5Yd59rzH+BsAO6mAkAqGpkfCef0g==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a137 with SMTP id b7-20020aa78ec70000b029013ed13da137mr5408059pfr.31.1601683115490;
        Fri, 02 Oct 2020 16:58:35 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z13sm2735593pjn.51.2020.10.02.16.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:58:34 -0700 (PDT)
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20201002231033.GA6273@embeddedor>
 <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
 <20201003000338.GA13557@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c06da705-3151-0902-066a-92d2e7c558bd@kernel.dk>
Date:   Fri, 2 Oct 2020 17:58:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003000338.GA13557@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 6:03 PM, Gustavo A. R. Silva wrote:
> On Fri, Oct 02, 2020 at 05:53:05PM -0600, Jens Axboe wrote:
>> On 10/2/20 5:10 PM, Gustavo A. R. Silva wrote:
>>> diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
>>> index 2817230148fd..6c34f6e2f1f7 100644
>>> --- a/include/uapi/linux/cdrom.h
>>> +++ b/include/uapi/linux/cdrom.h
>>> @@ -289,7 +289,10 @@ struct cdrom_generic_command
>>>  	unsigned char		data_direction;
>>>  	int			quiet;
>>>  	int			timeout;
>>> -	void			__user *reserved[1];	/* unused, actually */
>>> +	union {
>>> +		void		__user *reserved[1];	/* unused, actually */
>>> +		void            __user *unused;
>>> +	};
>>
>> What's the point of this union, why not just turn it into
>>
>> 	void *			__user *unused;
>>
>> ?
> 
> I just don't want to take any chances of breaking any user-space
> application that, for some reason, may be considering that field.

I guess that's a valid concern, who knows what applications are doing
to an ignored field.

I'll apply it, thanks.

-- 
Jens Axboe

