Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EEB26A16F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgIOJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIOJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:01:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2132C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:01:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1574945pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gYA3MtqAg2ctkfQ9eBGT89oH24A1NgpAEYYz4X8+KIM=;
        b=NMtSMoy3zXP/UcZ4uZfHN9b+BPNf4GhtA4BMDvHfkWN3cY8Bv1gZyGKfB935ZbJXmr
         KxNVmjSDQraXlj+eDsXBMNh63XMzy5VAVMzJU9u4A7q7Kg/OvlbGFFlqI9Ctq5y6wHVV
         BkOEfpWB7XK6vvoaTt/FMVH5bjbl3PlhIOCbQqzb+XDKDIkraojgXTUZAVXGwNUKgGzl
         vsAdM2Ffd2S4LdpHybkvcAnNVHKFG9v/D3sRT8RMQbPcgRF7WGw0xDUIjRHUIqU2LeeF
         g4vhpsHuMu5//m1YIcmC1+5Jh7O/01FH5KN/HV64+K6JwxIkLNOCsuH0Z4FGbRhZheQH
         M/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gYA3MtqAg2ctkfQ9eBGT89oH24A1NgpAEYYz4X8+KIM=;
        b=KvKaAW6P0VKcIjh32CWpJLfArmohylyJJf1NKGkbEBCCxqjB30k6FeBQxzx0Jd9uWl
         Ekn2h9ANB7xphScMJOMEf8hXX5JyFji4PKjLK6Op+Y986U6QUtEOPLuDHUU5Muzm7fLo
         GjaQeooyaZCDzg1vdf3g4556jNlJr87qD48PWCt7lzkNpiTA7UtTqrT4UweXGD1jzmrv
         vo5l4UnbiouUZxYrxMQ/8BoTDd+yVLNlgQGU/Si9gzswmmAhh/nNGEyLfaxFgC4dZMHA
         Qw/Gk6f1UEgzUZIkPqVaBgZwY2opxD9z91Q3uJNDRdF+8D2h8j0EI1T2u5Wsxi0rA0Tw
         wIOg==
X-Gm-Message-State: AOAM531GIQ1s/0yywbEARLlvoKJOgikXZxQXPv8xAQxbXpo1imXG+7i7
        qEnbHNleg2Kj5JxItz7a2nQ=
X-Google-Smtp-Source: ABdhPJx+Gawtwl0w/yHwVIqfHZrFR1dpr0t2SP8sF44aQ1Xw0SZXmCCselk9l27gK8Zd2+0rFphiGQ==
X-Received: by 2002:a63:df42:: with SMTP id h2mr10335807pgj.239.1600160480491;
        Tue, 15 Sep 2020 02:01:20 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y126sm13023967pfy.138.2020.09.15.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:01:19 -0700 (PDT)
Date:   Tue, 15 Sep 2020 18:01:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf kvm: add kvm-stat for arm64
Message-ID: <20200915090117.GA616@jagdpanzerIV.localdomain>
References: <20200914091713.1485250-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914091713.1485250-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/14 18:17), Sergey Senozhatsky wrote:
> Add initial support for perf kvm stat on arm64 platform.
> 
> Example:
>  # perf kvm stat report
>  Analyze events for all VMs, all VCPUs:
> 
>    VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time
> 
>        IRQ      44110    79.55%     0.51%      0.93us   8364.85us     10.16us ( +-   8.66% )
>       TRAP      11337    20.45%    99.49%      1.31us 3999985.95us   7761.21us ( +-  13.23% )
> 
>  Total Samples:55447, Total events handled time:88437041.52us.

I will submit v2 shortly.

	-ss
