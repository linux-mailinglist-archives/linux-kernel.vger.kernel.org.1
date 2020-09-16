Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5083626B874
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIPAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgIPAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:44:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E61C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 17:44:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg9so2236838plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WelUEM+5yfEBYnXPBUalgoBTEhxzv9s6CTcU5jFzwGo=;
        b=C+6IFR/5lCB/RdX9Cf/jqqE9aeHcEy2zepBCCDyPWuacoo9Zyekk9CnM2cam7lsMPE
         ZX+HIFibRuw75gGbznj1r0hGtkBHMHqRVvundbnLupqdWlaWIKoN5zJXQJByZk32bLMA
         vdQ8Uwo1od3kfIXOLewz8X647gXClzocJ9kmtzvkPNOwR35f2YnpB88Q6RcNRe2j3ZSu
         lmfPhtiOmD4fDIGVkIK4oNJf/hldHTWDCWrDZKWID8PZNZ1tFsp5ORc45oU5hvZNh44/
         +bzOPIh9qPglrbNNaWj/fpg9Vbs7GN2ENweXIR0ekk9lMZHhTER9di0ja9uu0cQ6tBmO
         ZoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WelUEM+5yfEBYnXPBUalgoBTEhxzv9s6CTcU5jFzwGo=;
        b=eiR9GWV+qJ7AR01jL0UH1nVzjYYU2OOQ9W2hvL4p0WMvc4XOrkz5JzEq6hBqm5sgFG
         YekwjQrqommcpKjgzC9h++OKONTj3lxEXfzu5AIdVMjJndvC8ooU8RP+R0oBObzKEina
         0YUurAWdkRj6y+C23MPi6jHuqtdGLnHy4UZYrNzMnT4nfFUgAUhFFZtYPPSxrq8YJGhw
         +8QimDuNvQERKyKBTH8Ql99hcObssGUs9Adr9Af5YhUDzoC/sk6N/jczwSQEmy6Z8Tdq
         tlf3P03CsrPjJgpSEBx3jOaLe33fzSXbknUNrYMCDJ5AVxD5xkpc5WA59x+5U5UP6db8
         bR6Q==
X-Gm-Message-State: AOAM530s6QRQRBDT05vdvt6Zzg41wXCLcTIcfusyK0S2w8OpAAEU9MH0
        eWCMhqaXcwcYTFN3x3cm7Rw=
X-Google-Smtp-Source: ABdhPJx4TI3XOb0GO4QgADNeD7SY0NatZS3cGx28Zz9PwLKDaXszSI2w5toZHCEaFSUSVeKh4Hl/Mg==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr1728315pjg.60.1600217046916;
        Tue, 15 Sep 2020 17:44:06 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id f5sm14127149pfj.212.2020.09.15.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 17:44:06 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:44:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2] perf kvm: add kvm-stat for arm64
Message-ID: <20200916004404.GE604@jagdpanzerIV.localdomain>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
 <20200915105702.GA604@jagdpanzerIV.localdomain>
 <20200915111541.GB604@jagdpanzerIV.localdomain>
 <20200915132109.GB32758@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915132109.GB32758@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/15 21:21), Leo Yan wrote:
> 
> Sorry if I miss anything for this.
> 

No, you are absolutely right! I should have looked more attentively.

Is "IL" good enough for a decoded reason

 	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
 	{ARM_EXCEPTION_EL1_SERROR,	"SERROR"	},	\
 	{ARM_EXCEPTION_TRAP,		"TRAP"		},	\
+	{ARM_EXCEPTION_IL,		"IL"		}, \
 	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}

or should there be "ILLEGAL", or maybe something even better?
ILLEGAL_EXC, etc.

	-ss
