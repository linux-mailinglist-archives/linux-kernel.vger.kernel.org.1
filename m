Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907C282EC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJECEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:04:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C429C0613CE;
        Sun,  4 Oct 2020 19:04:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id az3so1342651pjb.4;
        Sun, 04 Oct 2020 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aTUwkZP4TgjBXDmeQ6siaInF/DW1ZsWStt6LX74Bsew=;
        b=g+HKTtDcZHsbgiKPhrY5U85q3OSDt4LSD/8AMTElUm2yu12834tx3niIg8/9SPdSK0
         9WCBTOseymwiZU5/VZES1n1N1smdc0ponBzNPDHr8GmTwbZSr8qt8D+RtyeN9Aqi9iCN
         KrwXQaXwSo5FMnto/3aryqemXEMvkFE/NL8EwJLJylfdBx47p8EX3GWkrgNay9DjlXqb
         UBy6xEyLhBnG5ujecmqyASm8/SDnTcTndyMciBiFUmQ8VXF7jBqQ5rRwZI8w+Ad1yaZF
         xoukMNNP0oRiIcXnrjmwo9fOwEqXiVxPQoCxp2MsTisQ8eELY8SkNi/ejntO+3qrC7Hw
         ryCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTUwkZP4TgjBXDmeQ6siaInF/DW1ZsWStt6LX74Bsew=;
        b=KWVnQPX3/hK0yyscw8vF22xvm0cfxIcT2uVVcvBPRrKkx+k8lH9qqJzI6CW/UvV2Ap
         XhEvefz1Rl6drVu9qkuw6ApDTeP0bVMCMMGmVd9mPgZEdrlXgJ7bspAsE9JULzUjuVss
         ztmXPGAQ2jnFeYq0SOflCjg+WU67Sj94DTDWsKen5MPf+DZGpi0zT8gVXoIdjXu2pgVm
         uG5bXHsUtKJEO597CDX8aBKkFC6CO4gqNvWqOfKX9mRTBybmBvo9xgTuk7vNFYfwazLZ
         xJs6fs81h8AlNBzveHuggsO2IKI7CrNdkTupFpWdVmTY4R2rJwbheZz4L8ulaPoMHsXJ
         nClA==
X-Gm-Message-State: AOAM530f5zS/Ze+3j2IJnry1zrL1XIeY4aZzJBYxEe4SrldCjBHHSVYF
        VS7mwJsZ87zwKas2UQt2r1w=
X-Google-Smtp-Source: ABdhPJxvPBKIYwYgnndleFVCfof+FTkjjsHYm+GClWonodm05FeVnFZUKmQdjL9eOlM/Hg6V08dQng==
X-Received: by 2002:a17:90a:5e0e:: with SMTP id w14mr12242920pjf.25.1601863447931;
        Sun, 04 Oct 2020 19:04:07 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.164.48])
        by smtp.googlemail.com with ESMTPSA id h31sm8795616pgh.71.2020.10.04.19.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 19:04:07 -0700 (PDT)
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
To:     Leonid Bloch <leonidb@asocscloud.com>,
        Leonid Bloch <lb.workbox@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
 <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
 <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
 <bf28e522-be94-a6f7-ea44-9c954849fca6@gmail.com>
 <ab8c7550-19b9-f8a9-febb-9d2d558978e7@gmail.com>
 <94352367-68b4-0bb4-073f-2bfdd9391061@asocscloud.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <66c07be9-712c-5e24-d921-5c4fa64d1de8@gmail.com>
Date:   Mon, 5 Oct 2020 09:04:04 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <94352367-68b4-0bb4-073f-2bfdd9391061@asocscloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2020 23:03, Leonid Bloch wrote:
> Lars,
> 
> 
> Thank you for your review! The changes which you have suggested also 
> made ModemManager to recognize the device (which it didn't do before). 
> Please check out the v2.
> 
> 
> Cheers,
> Leonid.

The v2 looks good to me

br
Lars
