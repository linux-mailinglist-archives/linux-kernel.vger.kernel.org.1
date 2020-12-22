Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6582DE526
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgLROxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgLROxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:53:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8721CC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:53:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t8so1672799pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPIWdyhhv2p0RK54BfyU00oulzKpVJG7soxRWcanAR4=;
        b=F02KD6DaV/aPKcjLUlLPP43rCeLPtbxNuUvPp1MEYpUq0w5n17jV+1bRZEY4+qQoXA
         AOkl7AMKS00RJBlstpvnRhWuSJiI6LZvuhcNrTnEJbcualpbtYXM1ALmw0aLoLodQXQP
         LiaNJ2cAY4Qku6YUDXG1SYzb007BAwE0fsz4Mh1zqJ8KyiniulqNd7dPcJgjRz39re1b
         pOl4E9gpua1SH9s13uNImMPWnYl86WXoVA2IkVdVm3CcYmroufHzRzRJZcUqsY3xxjCa
         5fltazm7+yzzBWlmLCOf1vinzXP5Wv1iSkkL28+xei+g8fKSyBKEl42fuQ8vl6daCmrU
         nxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPIWdyhhv2p0RK54BfyU00oulzKpVJG7soxRWcanAR4=;
        b=Ra0SAVQ66Ei/7kAkmj3mgV7kK5rbHpmJDfpCriUa6Y/puNTFe4bBVQzm4TPO7P4HwK
         /ypcPb+myi7WND9PuLch3uYHn6BiW5sbDDYtPAcnUa6P8Dfs3xUxb+QCgHebHy9aRCuJ
         TBWOFmx0+TPB5ymUB81USMoUoV7u30x8pKyV4RcKYAX+gU768wLIxa6fzCldYG1MBGsp
         RBb2djKWbnctSOPaC63BYJpFkYX1rHAL0NbUp7XqJRamr1cZpxCjAYAG9YiJqHcoFJp7
         yDBWztSShqkM/gYoZECuDbszrlHR2ocGmnH7ELgJLRsZywmsIre+3APnV89WddDHIbwR
         ODOg==
X-Gm-Message-State: AOAM531L3MO9WQJ7b9NyjXYXZrrFL3lgEeP9QbiWl8yllpKuEGeonNrH
        6o9gvOkACm4jRqQ90mhdA2s4EjcknOAWKw==
X-Google-Smtp-Source: ABdhPJyG3zp40pY2POLr3CI3iKSHSsS1x1yHuFri50Mu1Kdnc3J5tOOIRHoPXDTmwr6d7IrUrqfnUw==
X-Received: by 2002:a05:6a00:1344:b029:19d:a886:f0ad with SMTP id k4-20020a056a001344b029019da886f0admr4546691pfu.81.1608303184804;
        Fri, 18 Dec 2020 06:53:04 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k14sm8790624pfp.132.2020.12.18.06.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 06:53:04 -0800 (PST)
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        swapnil ingle <ingleswapnil@gmail.com>,
        linux-rdma@vger.kernel.org,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
 <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com>
 <CAJCWmDdEPa23XDZ8pdStH=PgMszq4N6mHmNWtUA5Fn4THSNRmw@mail.gmail.com>
 <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a36bef5e-f7e3-c29b-8e65-38dc92812850@kernel.dk>
Date:   Fri, 18 Dec 2020 07:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 11:46 PM, Jinpu Wang wrote:
> Hi Jens,
> 
> On Thu, Dec 17, 2020 at 6:44 PM swapnil ingle <ingleswapnil@gmail.com> wrote:
>>
>> Adding linux-rdma@vger.kernel.org
>>
>> On Fri, Nov 27, 2020 at 1:54 PM Danil Kipnis <danil.kipnis@cloud.ionos.com> wrote:
>>>
>>> On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>>>>
>>>> Adding name to the Contributors List
>>>>
>>>> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
>>>
>>> Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Can you pick up this patch, or do you need a resend from me or Swapnil?

Just include as part of the next series of patches. Though I do question
why we need such a contributors list to begin with, if you do git log on
the rnbd/ directory it'd show you anyway.

I'd also suggest moving the parts of the README that makes sense into a
proper Documentation/ file, nobody is going to find it deep in the
kernel source tree as it is.

-- 
Jens Axboe

