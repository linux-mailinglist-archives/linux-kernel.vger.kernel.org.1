Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1C281D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJBVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:01:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800AC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:01:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id q5so2504503ilj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0EgeC/OxuGrek2txihiSmap3MbhbavZ/3tORR9d+J8w=;
        b=E7S1gwZRrc69yNZLUerKmIErkIvVFnHoj3SD/FYUzjDSXz0axcUKil7UeoSdEd36Du
         ccMTE/O6ZMpPqcKN3AmleNx0C9+G2UdapKLC1srcId7hS7kg+JwQOCRL+E5CB3DZUGxu
         na9RqGVxsCTvNXMIZwWY5VnynBV/WVqmMo/pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0EgeC/OxuGrek2txihiSmap3MbhbavZ/3tORR9d+J8w=;
        b=aHkgIOK6ye/cEuDf7nSF7pP3LCwINJc6Z9PTNwR1aSQYBScYZ2R5SDEb5oXP3/5MM+
         RFEWXG7nVjAIbYGsot2lLZOCV0x+Li3TMiwSKzphSlP8MLr6KVoIEC3nbyHtWNDV0mit
         ZzcqebdsWTckNOP0lHBBPazzsslry7k5CEzrH1RE6QNlL3fh+ndwrJD469nVAD46Y8fA
         L2BqJGPZDLFXZt4ViHfC5rJKOSjEp5VRSookacpMz4NrbGyT4j+w3ZR6Vi7s0gx2bqbd
         XB/dmbs1ct4PkvfNxBphBmBfum/EEZlmNZZFinzjkQ1/38/h085Sqqkp1D4gkM1L97wQ
         PhLg==
X-Gm-Message-State: AOAM532td30rBK9lKPrNGrODswiM3+fsoaWYbFV9mZQtt192ZQxVMsWy
        F1CHFGFeVanVYW2GEsgmpZBF/Q==
X-Google-Smtp-Source: ABdhPJwH/+0yI2olAs2o17hTDrZwS2eXv8xXBlbua6zIn6xw456YIv/gW64/Cc4Y1QhUjGk8YbevhA==
X-Received: by 2002:a92:9907:: with SMTP id p7mr3337726ili.200.1601672495127;
        Fri, 02 Oct 2020 14:01:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m85sm1416332ill.64.2020.10.02.14.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 14:01:34 -0700 (PDT)
To:     sudipm.mukherjee@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: drivers/char/ppdev -
Message-ID: <110bee96-0c4b-21dd-9298-932970657801@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 15:01:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

While looking at atomic_t usages and noticed a few potential
problem the way struct pp_struct: atomic_t irqc field

- There is inconsistencies the lock hold in this driver.

pp_do_mutex is help before pp_do_ioctl() is called.
static int pp_do_ioctl()
....

pp_do_mutex
        case PPCLRIRQ:
                 ret = atomic_read(&pp->irqc);
                 if (copy_to_user(argp, &ret, sizeof(ret)))
                         return -EFAULT;
                 atomic_sub(ret, &pp->irqc);
                 return 0;

This path seems safe as far as atomic_t overflow is concerned.

However, pp_poll(), pp_irq(), and pp_open() etc. don't hold
lock while pp_do_ioctl() path does.

Something to look into to see if this is safe. I see this
comment for pp_poll() /* No kernel lock held - fine */

Anyway, please take a look and see if this is indeed a problem.

thanks,
-- Shuah
