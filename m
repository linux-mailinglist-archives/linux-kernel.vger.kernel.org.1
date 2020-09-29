Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961F27C1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgI2JxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:53:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36378 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2JxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:53:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id w1so5678929edr.3;
        Tue, 29 Sep 2020 02:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dSAqW2cyeQ0egKUykaEYXlhb5CZIKu20QX0aomphFBo=;
        b=tjKUWLkC4aKb5ldBiDVX9t4DvcFDDBzbrO9jLZ5MXy2gQiNKfgAjaoJclampDxT1NH
         i+opfMI/X0dugmJUz7b41XSOdVfOUHhTH/rF2eM2B5Xc+bPqiWDNB9M9+pSyWSTkDtk9
         nIBrBMKIPEp/bN+ji1b5cICWoja8P7TYrzjgZSwphccRWZ1u2VecWQoi9VvgcUNPywrP
         HzYRN+Hsr2wnZDxxu7X1P8j+ALMEAuibj0idK7hsSyUOtCT2+7AaT74M13Lx0GZaI40T
         N9pE5xyeqOKtO29ctPwVE/6lBOsu8IHz+FVC8XvuHGvzjb0HukpSVYkECGKMrdc4XRQ8
         Aujg==
X-Gm-Message-State: AOAM530j7jlismWTqPHnRqd0OuYIbDwCMx6zS/4bPg2YYpzha7zqST7l
        TlgT2213EJGvRTa78fRMopQ=
X-Google-Smtp-Source: ABdhPJwv9/ka4QCMQyifFX+4Rb6TSmSwEteJroVlbX+i09WZCNIxGbkf/V8sa9FJIbBsP2SI0fG9Sw==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr2310110edq.106.1601373191131;
        Tue, 29 Sep 2020 02:53:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id p11sm5228692edu.93.2020.09.29.02.53.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Sep 2020 02:53:09 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:53:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v2] dt-bindings: mfd: correct interrupt flags in examples
Message-ID: <20200929095307.GB11333@kozik-lap>
References: <20200917185613.5905-1-krzk@kernel.org>
 <20200929094657.GD6148@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929094657.GD6148@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:46:57AM +0100, Lee Jones wrote:
> On Thu, 17 Sep 2020, Krzysztof Kozlowski wrote:
> 
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning:
> > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> > 
> > Correct the interrupt flags, assuming the author of the code wanted same
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> # for BD70528
> > Acked-by: Tim Harvey <tharvey@gateworks.com> # for gateworks-gsc.yaml
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Add acks
> 
> FYI, this should not bump the patch version.

Yes, that was my mistake. I kept this one with multiple other similar
patches and was updating all of them.... but I sent each group
independently at the end so this one did not receive any updates
actually.

Best regards,
Krzysztof
