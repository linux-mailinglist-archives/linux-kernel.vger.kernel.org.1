Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84526BE86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIPHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIPHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:52:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:52:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so2751138pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Anlcd5X+sFxxua67QCprvg2aJ+aYTEJuJfgNbmvuiIM=;
        b=kCueafGrI25+xhYjr5DKPWns8bpI4VT+AFnhb1HcUImGWU/sE8dqPIrmUsJx0D3swI
         WCu+p1NWMPWeZvEwPy77HVFNcpOEKOUN9x1rhllcqpgGpgCOEK/EHv/+v6FQHWXbMd1h
         0jwXraS312mXXjUHAffTk4YpLcdqIwuZYt9c2TuuYdjKz6//MIceBuaSPiDZ8OKxEPiS
         ASU8NwFTYm/hqX1H5RZb15nq+NfnJFV3zDDfLj5TzfR/BeSci4p6ph+/gy/qaEZeeavM
         DsjonQgICs5E+aADBo5EypNyZEh7u8C8pgP0nVxROV+WuL7fbn75PzNyve9llWVHiFVb
         daXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Anlcd5X+sFxxua67QCprvg2aJ+aYTEJuJfgNbmvuiIM=;
        b=BylHEvJgQWZUHewMDq0qXAo2nRabhOUCuBzQ/06OTXO1ztvNmbLcaTG3sIDCOZR5wQ
         USRtlXbrFXxWkFoNqO0kh0+cbJXF4p+mGxBVnycXSgNcMJ/MyQP/NFjiurBvmoa/WeaP
         cAcjKW8PkUGkCYh0jGuZphgyP6E+Z7G2biXI2prA9+5/UZgtRXCMJSAKOI7TK1sN/Lvz
         AIwsCaroRgnwpG50MuBqtZXfsVthhPoXwjvMeozCsOJBXTuaEsfP7xCJVAjfGmDexVkR
         889NqiWIezSQTXyAfb2bqu51IzLxXuTQHK3AOIZKLLjkLYBe2xvKPWScoj5iUdYfxRq9
         B2VQ==
X-Gm-Message-State: AOAM531ZmB192HfCQtMVEjTEuYJmGxlEvgDbZATURo+2AVyllVFebV1v
        Nt3NtYlvtQ14JXFsxbiLaJvE53y3Ei5vIMhN
X-Google-Smtp-Source: ABdhPJz96ZoEE1vXvD2dbTVe9hrtsMkjsrEbFGpTu5obqktOxQj/yrGSkikruZrIPGSWcmz8B5JctA==
X-Received: by 2002:a17:90b:ecc:: with SMTP id gz12mr2707145pjb.219.1600242722990;
        Wed, 16 Sep 2020 00:52:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id s3sm1436331pgc.61.2020.09.16.00.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 00:52:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:51:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2] perf kvm: add kvm-stat for arm64
Message-ID: <20200916075154.GA13660@leoy-ThinkPad-X240s>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
 <20200915105702.GA604@jagdpanzerIV.localdomain>
 <20200915111541.GB604@jagdpanzerIV.localdomain>
 <20200915132109.GB32758@leoy-ThinkPad-X240s>
 <20200916004404.GE604@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916004404.GE604@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:44:04AM +0900, Sergey Senozhatsky wrote:
> On (20/09/15 21:21), Leo Yan wrote:
> > 
> > Sorry if I miss anything for this.
> > 
> 
> No, you are absolutely right! I should have looked more attentively.
> 
> Is "IL" good enough for a decoded reason
> 
>  	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
>  	{ARM_EXCEPTION_EL1_SERROR,	"SERROR"	},	\
>  	{ARM_EXCEPTION_TRAP,		"TRAP"		},	\
> +	{ARM_EXCEPTION_IL,		"IL"		}, \
>  	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
> 
> or should there be "ILLEGAL", or maybe something even better?
> ILLEGAL_EXC, etc.

I personally think "ILLEGAL" is neat and clear :)

Thanks,
Leo
