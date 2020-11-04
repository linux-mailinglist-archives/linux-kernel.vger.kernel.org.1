Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FD2A6697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgKDOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKDOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:43:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047EC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:43:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so11515758wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7FgbCU8nZGuYRtHpTvALomoL0khWFkHXuAYK0m4DeQs=;
        b=CN+y67Gl01FF/4Ni2j2cltziE8zVpeXVu2Gozd0C93hGRHT9Udr3XP+Q7UiCKElKRf
         B6OGyRnz6dNTh9EZIrH4VD236L4Onc36kbGJ82fJfL8O8DMg2lwLXdFUvMn8kg+IRZdI
         cBQJBY6t0o5rXBlqq/87fF8+KjeSkZcNSIXGMBpQ2wjnAjEvLUfuRVOyxhMLdIhbxg1U
         CcR5pQGCdGWESIzNiHlkcVaKaqX3MsbiS013G8dYE9LxLjiOntqFKbw2eYyOaHXeTjOu
         JdkTl3HNEqeLLaqKNfdvqOhHRB8HhrCN5nNaGSvzxfP9uhdJ/NYpe2xw9h9Y70+xhN21
         Z1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7FgbCU8nZGuYRtHpTvALomoL0khWFkHXuAYK0m4DeQs=;
        b=iPLfoFR3ZhEqZs6wjiZcRg7W9x3MzODxOuchBFFaRv0t4fr3Ee+8EXprJNbjE3QAYH
         uAQ3Jwqh9vWoKXnO+UQMptX2nq0LM93/H2SGWvUwym+unoErw0htSdMcol4umt/uccOr
         p/idPV/CsMCUypeyp2UvMOkZSXLy3LFBNn31zY/9Sn9LgslntaQd8hNMqZtLtz8CNXz2
         xD0t3qV6GmlIkCt1J5giAPktzjQmNrfiIAnwGYuT+ihP3PNOmBY7Xvbohw4Cts+IL6A9
         LRBBhH4V576paNHhnE4xK2b/LkWgUCAGAIRnAeDmdTx8Yl1wc4YUIu3/O5j72LL5vnb+
         l03A==
X-Gm-Message-State: AOAM532g/N7LStFMJtslreP4APowrE/+AodTyDIgnIrpOIlApAgNp8Dc
        amtenOwT3n2NW2wIaAwEfRtyIg==
X-Google-Smtp-Source: ABdhPJwAnbzSBO1YBmmwqKy5evn7MyxK+R5hTL3V2cDosZLva7abhl/GkkB6/OlUL1049GpuUv4FNA==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr32713644wrj.264.1604501013951;
        Wed, 04 Nov 2020 06:43:33 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g66sm2571955wmg.37.2020.11.04.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 06:43:33 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:43:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/5] gpio: tps65910: use regmap accessors
Message-ID: <20201104144331.GG4488@dell>
References: <cover.1601164493.git.mirq-linux@rere.qmqm.pl>
 <e3a3979657babf716e5f4072e373637ce86ad7ff.1601164493.git.mirq-linux@rere.qmqm.pl>
 <CACRpkdaMHH35C1LqUROFBte3T00Lz0zApHy3hdZ83Z8EZR04hw@mail.gmail.com>
 <20201001090104.GM6148@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001090104.GM6148@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020, Lee Jones wrote:

> On Wed, 30 Sep 2020, Linus Walleij wrote:
> 
> > On Sun, Sep 27, 2020 at 1:59 AM Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> > 
> > > Use regmap accessors directly for register manipulation - removing one
> > > layer of abstraction.
> > >
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > I suppose it is easiest that Lee apply all patches to the MFD tree?
> 
> Yes, that's fine.

I think this patch is orthogonal right?

Not sure why it need to go in via MFD.

Is that still want you want Linus?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
