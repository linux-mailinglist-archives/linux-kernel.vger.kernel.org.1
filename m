Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DCE27BB96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgI2De4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgI2Dez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:34:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 20:34:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so3118975pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 20:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8k17uJ99MxV9NnKUFQgSFFIuJ0LBfhoOlmN/Rcs1dOw=;
        b=p0b0rDKmL+AEXbZnY7QxB+7b02eDxF8+J2TG6sFc7i2wi4iFNTZOKBeEU2J3fwgtIn
         bC5fcsocSInkxV1UH191CZHFy7AlE/3BI1+njYSRQXA7dqKq2c/UAt8gLo4kceHBIymm
         mqIiY/Ijd2t8jyEa9KBrAL/g9jmz7yuetQLMXMAmCcnBhMVcb10oYc8ycG63RD+Gh10K
         XZVDAG/zrHYzy8J3d4DWSSRMO0tT/matkyrQXisJ4VwAqDLY7q+R6J4VItCR/T7i96PO
         qXDqipufJOEe2FNPPng2sM47rMSIzypnsMbnhC3w6xbtbBS9Y+JWWpjaNwfLyeBBJIzo
         8WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8k17uJ99MxV9NnKUFQgSFFIuJ0LBfhoOlmN/Rcs1dOw=;
        b=DRlZLRb8gkAsYlR4X2A37q8zv0Ssw/XHMERRmsVaWr8MAAPKUa4ggg8Kw8xqHoirNM
         Dt+syV88fc/aRQqK+a05MF7ExGypbdNuS0R9w2q346EiVDjUAMs8oQMcA17ORy4oDk/b
         hG9z6DHhdyM71pbdA71+wBJEqL8UibYoVWQNDOH7dq976K4ru85UWtDrB3zzYo7wEIUu
         v2ZGZkY9z4qBjf86sb/zIYXZa96y+r0n63odYUOQ+KC7BTXC/E6vSxQ9WeduyynuehP8
         thDCbat0L58uQDUOenKEyhKflouipWppynt0GVqbfPT9S9W0qxw35s84j0ZX0d9HyKVL
         00dw==
X-Gm-Message-State: AOAM531YhL6q09ph/3YPyCuBenQeHwqnrGieaVX4UJYl8TtxA90hShPw
        ylGGHknxHOCDYMi/n+gpAzk=
X-Google-Smtp-Source: ABdhPJwQBm9gjvrPyRSvrSTPmYLGV5Q8rppn0qUNvoKyK4z9PmqfM4/77/XHHKeaVfAisAwUnPFDSA==
X-Received: by 2002:a17:90a:f010:: with SMTP id bt16mr1972910pjb.143.1601350493775;
        Mon, 28 Sep 2020 20:34:53 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 3sm2666669pgw.44.2020.09.28.20.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:34:52 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:34:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv4] perf kvm: add kvm-stat for arm64
Message-ID: <20200929033450.GB529@jagdpanzerIV.localdomain>
References: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/17 19:02), Sergey Senozhatsky wrote:
> Add support for perf kvm stat on arm64 platform.
> 
> Example:
>  # perf kvm stat report
> 
> Analyze events for all VMs, all VCPUs:
> 
>     VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time
> 
>    DABT_LOW     661867    98.91%    40.45%      2.19us   3364.65us      6.24us ( +-   0.34% )
>         IRQ       4598     0.69%    57.44%      2.89us   3397.59us   1276.27us ( +-   1.61% )
>         WFx       1475     0.22%     1.71%      2.22us   3388.63us    118.31us ( +-   8.69% )
>    IABT_LOW       1018     0.15%     0.38%      2.22us   2742.07us     38.29us ( +-  12.55% )
>       SYS64        180     0.03%     0.01%      2.07us    112.91us      6.57us ( +-  14.95% )
>       HVC64         17     0.00%     0.01%      2.19us    322.35us     42.95us ( +-  58.98% )
> 
> Total Samples:669155, Total events handled time:10216387.86us.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Arnaldo, any opinion on this?

	-ss
