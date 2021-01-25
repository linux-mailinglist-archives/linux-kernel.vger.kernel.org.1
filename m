Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B630373B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbhAZHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbhAYPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:43:28 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5EC061223
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:40:28 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a109so13141067otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HMhlvN/0qUkxkBvn42Qzst+rDXv1nNg5raUrF0ceYAg=;
        b=gniULOJp9n/TmdR7IKubbTansYJHXAkcvl0wE24MWhslCE4CPOqqRk24xAkIPYOzEB
         dhgcZKbe5kBZLAgFIYxEev4AGNLcGBf55ZCAovc4r0OV1n93NPKaQJJ3q4LGotg1YQQL
         iD2L7IidOriAdCFJ0blAPkwRxOPniy8wC4Q6Xf06V6pigOkKQk/oZEbptwMoHH+UZDBi
         KxnQI6IJFviEUChlh7hgfigXXf7cqczov1wkjuWge/cYmpAqv/tFyidObNpifrc5at15
         quucr4NG+yfB0eYwAi9oA0ZBFXff7IVuzaoPwaYm5g1QB+QbOKl1MI9SKb8NV9peT7wt
         B/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HMhlvN/0qUkxkBvn42Qzst+rDXv1nNg5raUrF0ceYAg=;
        b=AIbCDkj4WuFP3e8sHxiA44slAMuLpudTeD9T3OfQ7hQayiLno/GLxiWtY+xCsO9vo4
         7NJu8X2yDxoQ1CZ0wbipxoCFYznd0Orpv6wWrqnR51BUvD4s6MYIaD43gRRqYNsg6wxy
         J/KmjfVyaf+xgMx9UJcP6YarLnPCFmdE5okmayPakwgXSQdOHV8OmVEIazaUVFSQo+o6
         RzccCJP3cquHrrDu1zWXHc48df3hugCcSk5yLMOjuxpbsmmw27u+RyuTGxYEB2HeLJSu
         VGl3Ml2+64gsvUQYDeScWHob1VqMgVT53Xdbx6zXQGUX0rAKJ1JvYuoAMuqfZFmqGT0E
         SKiQ==
X-Gm-Message-State: AOAM530Kj3epNPyxUGtbYhPwfs/lLF72PmbGOR2HwSsZ1QAKKMTBlkOA
        HkuzPDi9DA+KEjcqPexUpr+7jw==
X-Google-Smtp-Source: ABdhPJwhv4969ipyc9wnZkQqK9xyIYx8poGZOlPgc9l0x3BhcmMOT2vPALgymgrWZGST/QrzZBgiHw==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr853016ota.54.1611589228341;
        Mon, 25 Jan 2021 07:40:28 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m185sm3563782oib.48.2021.01.25.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:40:27 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:40:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Samuel Pascua <pascua.samuel.14@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: [PATCH 3/4] ARM: dts: qcom: msm8974-klte: add support for display
Message-ID: <YA7maSZdp1EphINK@builder.lan>
References: <20210124135610.1779295-1-iskren.chernev@gmail.com>
 <20210124135610.1779295-3-iskren.chernev@gmail.com>
 <282b07a1-2e39-2dbe-dd7b-eed2ae9e25fb@somainline.org>
 <6632821.dtBD41K2ms@g550jk>
 <f02b945f-5546-6e15-17b5-74be8af8a501@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02b945f-5546-6e15-17b5-74be8af8a501@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Jan 11:33 CST 2021, Konrad Dybcio wrote:

> 
> > All msm8974 dts(i) files use this style. Deviating from it for this doesn't 
> > make sense. And yes msm8974 should probably be converted to the newer label 
> > style (as was done with msm8916 a while ago).
> 
> I have a >3k lines commit fixing that. Adding more code that strays
> from the new style doesn't really help.
> 

I know how bad it is, so I understand your desire to not have to rebase
that, but I will merge things as they become ready on the list.

So please post your change (perhaps it's posted and I'm failing to find
it in my inbox?) and I'd be happy to merge it so we get it cleaned up!

Thanks,
Bjorn
