Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED626B91C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIPA5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIOLPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:15:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C000C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:15:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so1842625pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UukMH/vE9A7R2o9IjYO9vd03rZJWF9Snk9WS+EPtjXs=;
        b=A3uPZSTZrOgPCZ2zggQw1tcZ06j5QLfAdMIC0pE1fs/nwoS81HZJVZjS20pgME5X9I
         +eINnqb4zIzdL4g5QtolfSbyRxr6/yBLD0vUVCdaluw89k1H5Ml9EbsBsxJ4MiY+sqOm
         YCzdSfcPykPBaZylJI9Cvmt0h8i6Q0Bi5wKZrwsMx8/3/6lSD4tYdhZ4qfu0SE+WT4lP
         EZ+ScCI/NtJ01/M+x5Ac6iH1CLptOVa2/osCQ/eZUDGzfhzqK/O43IMOAr9MZu9WIlol
         +9hW9Fl0ZnXcNQjoBHCOA9FIpEWRUTrsOqFjbleZRoEkQL+8SCZKgGmkXBiD59KzZD2x
         pQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UukMH/vE9A7R2o9IjYO9vd03rZJWF9Snk9WS+EPtjXs=;
        b=Pd0k86N+h1eJTAww+CWb1ou2DpdiMwO1Df8XCX/OXd1YsSgtUf4QtXPAXBUTUlbfHX
         gEQq3Q4tzaTDfnCtmpC2JihwyFuLDbYMfoFd2MhvOjVdGxrXTpBxjajugZiz8ig00rfM
         ZIRV9TQXEnLj7iINfAQ9R/vAN4pNODTd3KqdrmtqHt8sIhszR2PmhbcXOA+fSnrL6ZzX
         vyrzvECC/H9JCw+iLLTx24HtVWcSgmihjfwGLKfWPAspJYyy+IPxM4lEbtKKfmdbhV7C
         GTgYtpRlaJ/mZ81C4H6JB4mTV+1IaTLqFKI4Kpbo/PyAh1u7YuM49MCPQ33cYgqw4/PE
         MB5A==
X-Gm-Message-State: AOAM533HtNpg+aYYrx5GnazkE/C6OemsjWHvMNddpXGLOOvLCpO3szgM
        80HyHrR0cCshd+sjRGfuO9I=
X-Google-Smtp-Source: ABdhPJz46bE04HyNijFMSkAHOFC2swk5PHwjSyZtTP7qSc1o7smdJUBiy+KWM3xO2gXMvmK4UqtcaQ==
X-Received: by 2002:a63:e741:: with SMTP id j1mr14403476pgk.422.1600168544998;
        Tue, 15 Sep 2020 04:15:44 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r1sm7847376pgl.66.2020.09.15.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:15:44 -0700 (PDT)
Date:   Tue, 15 Sep 2020 20:15:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] perf kvm: add kvm-stat for arm64
Message-ID: <20200915111541.GB604@jagdpanzerIV.localdomain>
References: <20200915091140.152775-1-sergey.senozhatsky@gmail.com>
 <20200915103644.GA32758@leoy-ThinkPad-X240s>
 <20200915105702.GA604@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915105702.GA604@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/15 19:57), Sergey Senozhatsky wrote:
> On (20/09/15 18:36), Leo Yan wrote:
> > > +#define HVC_STUB_ERR		  0xbadca11
> > > +
> > > +/* Per asm/kvm_asm.h */
> > > +#define ARM_EXCEPTION_IRQ		0
> > > +#define ARM_EXCEPTION_EL1_SERROR	1
> > > +#define ARM_EXCEPTION_TRAP		2
> > > +#define ARM_EXCEPTION_IL		3
> >
> > Nitpick: from completeness, we also can give out KVM exiting reason
> > for 'ARM_EXCEPTION_IL'.
>
> OK, let me take a look.

I think ARM_EXCEPTION_IL are reported as HYP_GONE. According to
arch/arm64/include/asm/kvm_asm.h

---
#define ARM_EXCEPTION_IRQ	  0
#define ARM_EXCEPTION_EL1_SERROR  1
#define ARM_EXCEPTION_TRAP	  2
#define ARM_EXCEPTION_IL	  3

#define kvm_arm_exception_type					\
	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
	{ARM_EXCEPTION_EL1_SERROR, 	"SERROR"	},	\
	{ARM_EXCEPTION_TRAP, 		"TRAP"		},	\
	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
---

So it should be reported already.

	-ss
