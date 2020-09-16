Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02F26BEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIPIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:00:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16874C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:00:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so2763362plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OAIQjzWxp9lAMNudVUiJQwy4JFFQa3XuwC39/v/9ilU=;
        b=CueE9/CSb4QP1dKfBaRNwqrA16o7U/cXAxdHPmccV3UJUoyF9f7zeQ3rxfqFl7wPeD
         A1jCXFey4aqxAOalIdx24SIsAWcnQ2ONZKewrR3IxBgCvI2pyh2CBugPZKmZBqf/GPz7
         0wwmbVf05BuC8tVWo3OQGYz4dRJuwQZpbEqyCgcoH7hEp0KqHGrJ3syiTF18PSogC7Vo
         cvU4dDaEKby5xJN5B6+Jqg5J8DYr2JjREb/rN+PoyyxIdiNIePw+tbEaohKQyhda2ALg
         0pujr/jaGD0gC6KeY9bhz83orWg4FU6FTOOOLGFksBZHIO/bTKxU9IOwoqSl0F3y5SH0
         /1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAIQjzWxp9lAMNudVUiJQwy4JFFQa3XuwC39/v/9ilU=;
        b=hzfCKD0lXqjggksHgPYrLJus02jEMo98SjRdkWQsUDFZoDffAvwT/D0H4Zw6o+Rd9d
         u2B1YbFtemO2gmfmtDHxNdj5rkl9tXpCmIDnRrNHsBn3b+i/0v4E6WZVCDdaQVS/3vy3
         pk/a7z9ey5AzYuHyxSWR+09AKqhc8rcx6EYiFIVxMZxpa6Zk1OXrcJhB9n4nSqATIMtm
         Vj1PG1XZRbAM+TjePAAp0yhhoXKDo8GJtfTtO+8mWd5oU+1rQMgRqQwDvO1IMkQ52iq/
         AUsov530fq5iazY2iNWmecWnpsfXPXtrKzKNoJoBTptPau5kVoltF7Dzy/uvnFxOatY+
         YzbQ==
X-Gm-Message-State: AOAM531iZcTBHOCSYa+sMpA/hM0bzcM1q4oPWZyqYTAxyu5uCeiXKQbS
        3WhqfOJ8C2GY1VRv22kv394=
X-Google-Smtp-Source: ABdhPJx3W4zHxBIa46OFWsH/1o0ZQBUSOqEwTK6Ap/U6tJwvwKdKXzviL6wxPLZCKnwhNot7kKZb6A==
X-Received: by 2002:a17:902:d909:b029:d0:cbe1:e716 with SMTP id c9-20020a170902d909b02900d0cbe1e716mr22691608plz.36.1600243253402;
        Wed, 16 Sep 2020 01:00:53 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n127sm15484233pfn.155.2020.09.16.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 01:00:52 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:00:51 +0900
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
Message-ID: <20200916080051.GF604@jagdpanzerIV.localdomain>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
 <20200915105702.GA604@jagdpanzerIV.localdomain>
 <20200915111541.GB604@jagdpanzerIV.localdomain>
 <20200915132109.GB32758@leoy-ThinkPad-X240s>
 <20200916004404.GE604@jagdpanzerIV.localdomain>
 <20200916075154.GA13660@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916075154.GA13660@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/16 15:51), Leo Yan wrote:
> On Wed, Sep 16, 2020 at 09:44:04AM +0900, Sergey Senozhatsky wrote:
> > On (20/09/15 21:21), Leo Yan wrote:
> > > 
> > > Sorry if I miss anything for this.
> > > 
> > 
> > No, you are absolutely right! I should have looked more attentively.
> > 
> > Is "IL" good enough for a decoded reason
> > 
> >  	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
> >  	{ARM_EXCEPTION_EL1_SERROR,	"SERROR"	},	\
> >  	{ARM_EXCEPTION_TRAP,		"TRAP"		},	\
> > +	{ARM_EXCEPTION_IL,		"IL"		}, \
> >  	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
> > 
> > or should there be "ILLEGAL", or maybe something even better?
> > ILLEGAL_EXC, etc.
> 
> I personally think "ILLEGAL" is neat and clear :)

OK.

By the way, arch/arm64/kernel/traps.c has esr_class_str[] with
decoded exception names. Maybe I can reuse some.

	-ss
