Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCC2ADCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKJRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:35:45 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC7EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:35:45 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so12078923pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljtExNLhNJaAYqoAJq6NF87io9zaUPGQ4Epf6Wkqh/s=;
        b=Fp2iAW1L1WrQxhZpGMUIBhyXMlFi0afXkOidkQvgyrAm36yJx4DWIIerKk93f/abQU
         2117o8ZPUzyzmK+5/UHfXIi7GZpnFEi44FD0W+Z7NgC+04PSeO+ToWDI6pwIE8lXOZ9l
         dmcHjcTrGrNCPMTnjfxQ3NLh+AA9CA48y4pIHIH/HNlQtv+VTKzrBkyLOvSW14hu0tMs
         7e+EStdhooSREdyRtmuJxmgDAFXu42v8t/fdIijxwwXVHZxhC43IeKbYv7AsVf+C9PVb
         Zmjj7fGE93/V8GOX41bBK4D/+Q8rqQLgFZaB3nOGoncnnPCwEkodP1Uhc1p1lfigdj+c
         TR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljtExNLhNJaAYqoAJq6NF87io9zaUPGQ4Epf6Wkqh/s=;
        b=t7XBZvwynxQBsgQjBTStr5IYc+idCb07Y9M5hGmSBTX3b1QW85suv/F0BzrVdsMd3l
         20yhrgIorItnPueQQr5SNpkX1PuqCtkY+HYWd1y4mmeDxoTpftoLN9bduszI8lw1WVZn
         L6jsUxXgI6PUl9oRCtcqyR5z/LOo9FLfoFzKPmOwmEgxvVyk3rIH9IbddfBYwF+KSopZ
         hNLxxT9I6/yKkbAiuvZfA+DGoVYro3BPIQR+T9o/L5+diQBtNUYJ7c0OB9aXjV/9B1Bh
         78b8aEF807JGNhTraTUgE75x1etq8e9msZqzE6rht1YGDr0hKNiDUNkEBG7SqsrASKrV
         bZTw==
X-Gm-Message-State: AOAM5313w/vv4XDQfVUE9BrR0sHx4zYIZKE10ckYToO+48x7ZTw/lBGG
        tWS+vYCQhkj5rNMhdZ/SCAlEy0l+b8uoRw==
X-Google-Smtp-Source: ABdhPJzhkbqCLmcN3UQpk2JbMbLrq19EgGLsZe/M+4oh7D4HYnAksRDgka66egyf/MQvmzcL/pVX7A==
X-Received: by 2002:a62:1408:0:b029:18b:78d:4c4b with SMTP id 8-20020a6214080000b029018b078d4c4bmr18838266pfu.25.1605029744692;
        Tue, 10 Nov 2020 09:35:44 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q16sm14866210pff.114.2020.11.10.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:35:44 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:35:42 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization
 for sysreg access
Message-ID: <20201110173542.GC3429138@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-24-suzuki.poulose@arm.com>
 <20201109183255.GA3396611@xps15>
 <7370dc60-ca9c-7b58-0b56-6fcef628304f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7370dc60-ca9c-7b58-0b56-6fcef628304f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:11:23AM +0000, Suzuki K Poulose wrote:
> On 11/9/20 6:32 PM, Mathieu Poirier wrote:
> > On Wed, Oct 28, 2020 at 10:09:41PM +0000, Suzuki K Poulose wrote:
> > > As per the specification any update to the TRCPRGCTLR must be synchronized
> > > by a context synchronization event (in our case an explicist ISB) before
> > > the TRCSTATR is checked.
> > > 
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index e36bc1c722c7..4bc2f15b6332 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -178,6 +178,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> > >   	/* Disable the trace unit before programming trace registers */
> > >   	etm4x_relaxed_write32(csa, 0, TRCPRGCTLR);
> > > +	/*
> > > +	 * If we use system instructions, we need to synchronize the
> > > +	 * write to the TRCPRGCTLR, before accessing the TRCSTATR.
> > > +	 * See ARM IHI0064F, section
> > > +	 * "4.3.7 Synchronization of register updates"
> > > +	 */
> > > +	if (!csa->io_mem)
> > > +		isb();
> > > +
> > 
> > When I first read the documentation on system instruction section 4.3.7 really
> > got me thinking...
> > 
> > At the very top, right after the title "Synchronization of register updates" one
> > can read "Software running on the PE...".  Later in the text, when specifying
> > the synchronisation rules, the term "trace analyzer" is used.  _Typically_ a trace
> > analyzer is an external box.
> > 
> 
> Very good point. The trace analyzer could still use the system register
> to program the ETM and causing a context synchronization event is tricky
> from within the trace analyzer. And I agree that there is a bit of
> confusion around the synchronization from a self-hosted point of view.
> I believe this is true for the self-hosted case too and should be
> clarified in the TRM.

I think John has given us the final answer here - the current implementation
stands.

> 
> > Arm documentation is precise and usually doesn't overlook that kind of detail.
> > The question is to understand if a context synchronisation event is also needed
> > when programming is done on the PE.  If so I think the documentation should be
> > amended.
> > 
> > In that case:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> 
> Thanks
> Suzuki
