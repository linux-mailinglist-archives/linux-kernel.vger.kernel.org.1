Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E572FDFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbhAUChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbhAUCNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:13:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4A3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 18:12:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d4so397956plh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 18:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KFE5noGXAuRHseytXWLkgabaBCOI5rOUIyEQZlvkEWs=;
        b=JSgzFePOIcaTpUnQsLrOkkz6KpIXDlStzyxsZE1R1jcw9WyZ8NTYhRW5wyBit85M8+
         rbbZYX2Zi9m53g7GDHv1olFsCmQerHSHfzE7JkQKYEcX6u9jJwwsLVpwGL/Fo5Rhlzpm
         tiF6Hp6BYSoTKGauo7a0XrMRDcz2UGt9f6i7SqeWVHiljLwdRV8/6eEwDsyqqgyBveCa
         aBEAHwqa6aylDP1aDLHO34wj7oersMJsN8yMANFPFhlR74m3uW08MwJbvRJ1BFh127cO
         SQ4feYzVF0L+13enzODXKb4h7i3auT5KZl6kWmHJlWb6Ip9f92LsGHAUeHUSMxYjhbS9
         f6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFE5noGXAuRHseytXWLkgabaBCOI5rOUIyEQZlvkEWs=;
        b=JWdtmxAhAUOsXUo5+x94ctwAM6DWAMDZJsHxAliGXTZ0irRmDJnfiCGaM8x197Jl2O
         EHwvSRKcXNq3M69RqlqRqiaXIvLNV49sa3x+LSGbreLaCLWxGIrSWHY8lWuaqAIbCJa5
         xelEgpszUqPcQ1MNDX+LW2/rXRoRWCx9bqc9hSGkERY4UkuO+mQVguXfih+TOeZqq9Wd
         5odYVZijbcZ+H0W2yegZ4DN+6H12HPQTPbbevYtWX1MNBenNoHKCQxCzkXfyVZcyScTB
         lbTLdgHjmwZU7tAy8OJstGf+ZzBJcA+wVcvQDCabSE9Rw9JYpRrAh061Vn+aOTkHy/Rm
         HYoA==
X-Gm-Message-State: AOAM533G4c6qbe55ciFrD9u5u5Adl7YB3bfxf4sDPNkY8MAZrXvzr6Ks
        btp7kYMpl0ysrIlr8PXRRyCCPPIXTq5Rq9vJCqA=
X-Google-Smtp-Source: ABdhPJwtep2NXsZGaaGd+0BDBNYkG2E0oGDolC7uOSiGqlZW7qgQ4TscfVozCNr+0py+ZSsIaFx5Sg==
X-Received: by 2002:a17:902:a708:b029:da:ec42:a3d4 with SMTP id w8-20020a170902a708b02900daec42a3d4mr12803584plq.40.1611195141340;
        Wed, 20 Jan 2021 18:12:21 -0800 (PST)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id y23sm1648989pfp.38.2021.01.20.18.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 18:12:20 -0800 (PST)
Subject: Re: Re: PING: [PATCH v5 0/2] misc: pvpanic: introduce capability &
 event attribute
To:     Greg KH <gregkh@linuxfoundation.org>, pbonzini@redhat.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
 <cee80030-dab1-fe79-f14c-24e45532d814@bytedance.com>
 <YAhuD04p4daZd/1W@kroah.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <baebee60-3d5d-ed7a-ecb8-09a8b2d61ede@bytedance.com>
Date:   Thu, 21 Jan 2021 10:12:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YAhuD04p4daZd/1W@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 1:53 AM, Greg KH wrote:
> X-Gm-Spam: 0
> X-Gm-Phishy: 0
> 
> On Mon, Jan 18, 2021 at 09:42:57AM +0800, zhenwei pi wrote:
>> Hi, Greg
>>
>> What's the next step I should take?
> 
> I need some reviews by the people who will be doing the qemu portion of
> this, or someone else, please.
> 
> thanks,
> 
> greg k-h
> 

Paolo has already fixed QEMU side compat stuff.
https://github.com/qemu/qemu/commit/b1b0393c3c58c0e96c7c44e2e98baa252d6c6813

And I realized that guest side also needs to test capability, so I 
always CC Paolo in this patch series.

-- 
zhenwei pi
