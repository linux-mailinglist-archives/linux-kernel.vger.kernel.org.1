Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84838279D96
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 04:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgI0Cvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0Cvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 22:51:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED0C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 19:51:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id e4so1463634pln.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkAAsu9JWaPIy4rXDra5c7KbxJzhKhciubTYNKP7SJQ=;
        b=X3XVke9M9xzMzweyyrCMSQr7PN9p6RUAp0C1erhi3J6GurrDA46xMZYlz23WTZtmLQ
         jObFtM4QSskC6TM+HhRgdRus+sWZOwA+o4YQOB1xdmeJwNZ+G84Vi87ePmyIL4whEe/G
         Y7GvrQrUGwVpUpJSaFByc+KIbj4BGX7fpwPk7X8d5EXIuQo40GAKZ9kf5D3pt/8llJZV
         91NvLBU7rYY8OH8rL4XUKem5L1CFMKFm+R12YtWbkmrLKwYS2rA7O70aNXAAEroP/Gfr
         AoHkE3SqdHV/HZO4hUkYF/pOg5J0TWo+qqx4d0cJToasbEKSedLHXznM0qH6gpOp9sl6
         B/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkAAsu9JWaPIy4rXDra5c7KbxJzhKhciubTYNKP7SJQ=;
        b=a7YrMFElM1vDuiQioJYEgs0w2SK9ve2kw3iCdFEIj28HhYAZh/TtdXBtO7hEdboFp/
         lBEt+7PIo27ZKefGn8Ujbu7TJsHC/9B/4l+opnaxtosBN3ckMmTxJs46aPA8Vjb/NcbV
         gj4IP0uM9XA/EfFN5mwkCvmfoyvMTD1bnrEG+Tg+zJDDfE3LrZ+3A4+a7kwlnRc08wwB
         E6e9S0zaV4tfs5zyO1KgraidUy612BoIqGQ44mCX85i+7NZbslB1Hz0HO6f6Zx7YyIwz
         ZREOPJjteyjmo/FiIqK1B4gO/L3PhTUpN/AAg8keT3LLoloPn0QqIxA9gvMvGHNqK97/
         y1Ug==
X-Gm-Message-State: AOAM530TlHPAYCIqFIgwG211gbmtd6M8sJWMxnMc1B2BkZOx6tNmmb7a
        g3csy6AfbzKW2ERz6AjTx8uW5Q==
X-Google-Smtp-Source: ABdhPJy5NdnjbH2xU3SziiypDNUc+Uxuq0VvTsDhXW+7TIkBONWXyJ/Ho3tC5K53opZPddkT+/XKPw==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr4069151pjb.101.1601175111415;
        Sat, 26 Sep 2020 19:51:51 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id o20sm6225153pgh.63.2020.09.26.19.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 19:51:50 -0700 (PDT)
Date:   Sun, 27 Sep 2020 10:51:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: spe: Allow new bits in SPE filter register
Message-ID: <20200927025143.GA9677@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-2-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Tue, Sep 22, 2020 at 11:12:21AM +0100, Andre Przywara wrote:
> The ARMv8.3-SPE extension adds some new bits for the event filter.
> 
> Remove bits 11, 17 and 18 from the RES0 mask, so they can be used
> correctly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 554a7e8ecb07..efca4ee28671 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -281,7 +281,7 @@
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>  
>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
> +#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00f90755UL

This patch is duplicate with Wei Li's patch [1].  You could see there
have some discussion and Will gave suggestions [2] for the patch, this
would be a good start point to continue this work.

Thanks,
Leo

[1] https://www.spinics.net/lists/arm-kernel/msg825364.html
[2] https://www.spinics.net/lists/arm-kernel/msg835733.html

>  
>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> -- 
> 2.17.1
> 
