Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522C26B832
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIPAit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIONXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:23:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0CC061223
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so1942839pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U45qCGtx9SVaBksmUnSx/1V6QHxz6FpyJ904HDB98F4=;
        b=Dq6P7yt4vj+kizZ4X9Ka3FEDRZJJNwBd525w8mw2F0pDzjVGt/f46wofiMMuWzlZSy
         6dpC7e9tI0tcmpbWZpxR95EY5RHK50QlZ3L1X0dscEPg7HeTfsYaFXuLmZFF+pJq8APu
         Rmh34lYvYtod6hZ4y3PhSgSdW1blhiJfIp4o4XbRBbuFlDvxj/YzIrE2xwT9Z5zkzEBw
         lylondjpwN9uiXnwh3GRQWfOFeESfRbRFf3svHbjhbkVyK0paBglYDn88r9ShiW5btj8
         38i35kFCtLUQZgEaXeEiCTG+Q0mJo5TCSULLPBz5A0RDRKtYfM9t5O7qlOoZES+WUVXK
         DCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U45qCGtx9SVaBksmUnSx/1V6QHxz6FpyJ904HDB98F4=;
        b=pGznJ5kUdU0RsYAnTZMsAEY7pCFTTMy5aED0MvscFPcLVIhJk4x6nXd1/C7XMsnoRv
         kBpo6RZ8H0t04mOmIQNBbeJoT26bDOIb/TuWSbUfJb3rRdej1usLoJcMH8jRDYFCDKtV
         aWa0z/HgYUroqmuOSrKftcv89AeEjbhB39e1RqPjd4EiOdpZ0Tz6kIzNzYW/dGzfcB8D
         2xbaDsQnj64pipfDYdnwlso+/ksa4QIPM6M3hXuDEkjerKVPwJB0lUijDqD7XKlUTV0a
         8BfeWmelZyMCXt2yp4LLiRzfzHEY4XrHTRZYbaxNxCViU8imzUoSlNy4B4RefLetLytR
         vVog==
X-Gm-Message-State: AOAM5334oy2Z+rHGrZkoWQALiIif4sblKa0E3yoOC/sI1O0m3ampMHLV
        k+M0lB/9dbEQHHyWkb1uoisx2Q==
X-Google-Smtp-Source: ABdhPJwU7lrcEWwdOVdx2+8cCwzNgDde0rPw4DppzG5Tv00KspesNfv6+Ridx1pPq0GwM7Uu8svg3g==
X-Received: by 2002:a05:6a00:1481:b029:142:2501:35d7 with SMTP id v1-20020a056a001481b0290142250135d7mr1882690pfu.55.1600176077733;
        Tue, 15 Sep 2020 06:21:17 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i2sm12077498pfq.89.2020.09.15.06.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 06:21:17 -0700 (PDT)
Date:   Tue, 15 Sep 2020 21:21:09 +0800
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
Message-ID: <20200915132109.GB32758@leoy-ThinkPad-X240s>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
 <20200915105702.GA604@jagdpanzerIV.localdomain>
 <20200915111541.GB604@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915111541.GB604@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:15:41PM +0900, Sergey Senozhatsky wrote:
> On (20/09/15 19:57), Sergey Senozhatsky wrote:
> > On (20/09/15 18:36), Leo Yan wrote:
> > > > +#define HVC_STUB_ERR		  0xbadca11
> > > > +
> > > > +/* Per asm/kvm_asm.h */
> > > > +#define ARM_EXCEPTION_IRQ		0
> > > > +#define ARM_EXCEPTION_EL1_SERROR	1
> > > > +#define ARM_EXCEPTION_TRAP		2
> > > > +#define ARM_EXCEPTION_IL		3
> > >
> > > Nitpick: from completeness, we also can give out KVM exiting reason
> > > for 'ARM_EXCEPTION_IL'.
> >
> > OK, let me take a look.
> 
> I think ARM_EXCEPTION_IL are reported as HYP_GONE. According to
> arch/arm64/include/asm/kvm_asm.h
> 
> ---
> #define ARM_EXCEPTION_IRQ	  0
> #define ARM_EXCEPTION_EL1_SERROR  1
> #define ARM_EXCEPTION_TRAP	  2
> #define ARM_EXCEPTION_IL	  3
> 
> #define kvm_arm_exception_type					\
> 	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
> 	{ARM_EXCEPTION_EL1_SERROR, 	"SERROR"	},	\
> 	{ARM_EXCEPTION_TRAP, 		"TRAP"		},	\
> 	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
> ---
> 
> So it should be reported already.

Thanks for double checking.  But I still think this is incorrect,
ARM_EXCEPTION_HYP_GONE is defined as HVC_STUB_ERR (0xbadca11), which
is different from ARM_EXCEPTION_IL (3).  So I don't understand why you
have the conclusion that 'ARM_EXCEPTION_IL are reported as HYP_GONE'.

Sorry if I miss anything for this.

Thanks,
Leo
