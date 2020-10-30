Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5472A0F90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgJ3UgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgJ3UgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:36:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:36:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so6161806pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CuRbxzDu1XDfx5yN2GvsDOIU4u128uCEzLs7t63aMYQ=;
        b=Jon71kR7/DdyiHTml27SRzpChPyiVZVNcooGCTZNITVgVaQ+eMcHZRmxWYV+WBmpNB
         AaEGy+c3dWb/NTTAS63wkKSHngdWzKBqikpEkBi/JDsPjkkXeqyFjbAyPmWR37BaTRxJ
         074nBN79Yv3SkEhGGX5mC46fBjs6CYO/5oWYGWxQ4czpYgPyjZudtNmDwjxklZvAevDw
         j93Msn9qv8z359SuSJFEIfEiuhBkg9GfFS6Iphdpbj0azas/2nsuOz85tLUiL0/jOheu
         81BApS0X4Fbl1Yry2eGctlKnvYfr+kI/FLxBJFxXnhDrNx+FgT973DgssNo6mI9BOTpy
         2dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuRbxzDu1XDfx5yN2GvsDOIU4u128uCEzLs7t63aMYQ=;
        b=Hq5zxBRwGFpq0vqb2TSM3Jn20BsKa15SwqQ+I7jA/4ynDEy6kt/G1vDvBuPgZZ2Fhd
         SEFvrhShCpvDt4cX3awYW07itCeVPiYouFgT0WUaxwwcYr4wWRnGt+hVBQqzVHbg+NuB
         5tcWBzqI+3d9b63QTo7m6GaEFf43OUsE7QiojQAfGOQKkgmnxA1A9wRgA6Nc0+ilSlRF
         /1g7dIrpHVUN9oXjUcLKzXLZvLVAGozwvKzd2Qc+mI/KIKmG8wG5sTG1107ci3wZl9VE
         7OcCJlm/zelJ6GiSKmboADoQGOMhfbxkGcoWhnwRWQLJv9qborbMozDjz5RmP3vTIGtx
         h+/Q==
X-Gm-Message-State: AOAM533iUGQo8AvMBnnKMt9FR7V+jkQ7n8+ozi2gf71xxQkdYQjQiyJy
        HLFjfXKwspdPGaeA+MtpwcD/22MmFFWiYA==
X-Google-Smtp-Source: ABdhPJwYxy7zJkLjEmNnrlWlDYOal78VkBMnMU0u9/FrqXzCgPSbCbKAMTFM/gLtVJ8FFm0WYe6cBw==
X-Received: by 2002:a63:30d:: with SMTP id 13mr3324733pgd.301.1604090165315;
        Fri, 30 Oct 2020 13:36:05 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q23sm6744147pfg.192.2020.10.30.13.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 13:36:04 -0700 (PDT)
Subject: Re: [PATCH] arc: add support for TIF_NOTIFY_SIGNAL
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>
References: <6b89e805-c645-e738-794f-05ba6be68d60@kernel.dk>
 <faa0272e-9719-8fd4-323c-b32fd4c9ccb6@synopsys.com>
 <5d59c0f2-3a5e-478a-e0e4-4f487a4718a6@kernel.dk>
 <f1a8b2c9-3a72-75c6-f504-18723689fabd@synopsys.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fabeac37-f6a0-34e0-a521-4124f17f2008@kernel.dk>
Date:   Fri, 30 Oct 2020 14:36:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f1a8b2c9-3a72-75c6-f504-18723689fabd@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 2:08 PM, Vineet Gupta wrote:
> On 10/30/20 11:53 AM, Jens Axboe wrote:
>>
>> Ah thanks, I'll make that change. Hard for me to test a lot of these, so
>> I really appreciate someone knowledgable taking a look at it.
> 
> Sure, glad to help, thx to you for writing the arch patches in first 
> place. It takes a bit of daring to venture in unchartered waters ;-)

Nice to do something different for a change! And another motivation is
that I can't drop some old dead code before all archs support
TIF_NOTIFY_SIGNAL.

> These days it is super easy to get your hands on a ARC cross toolchain. 
> We don't have them shipping as regular distro packages just yet, but you 
> can download a prebuilt @
> https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2020.09-release/arc_gnu_2020.09_prebuilt_glibc_le_archs_linux_install.tar.gz
> 
> Or you can just build upstream gcc + binutils for ARC if you so prefer.

Thanks, that's very helpful. Unfortunately my distro didn't have
gcc+binutils packaged for arc, like it did for a lot of the other
targets.

>> commit 3c6239647d95d03d1436bc826a004791c3f04617
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Mon Oct 12 07:15:37 2020 -0600
>>
>>      arc: add support for TIF_NOTIFY_SIGNAL
>>      
>>      Wire up TIF_NOTIFY_SIGNAL handling for arc.
>>      
>>      Cc: linux-snps-arc@lists.infradead.org
>>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>

Added, thanks!

-- 
Jens Axboe

