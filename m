Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8398D2D592E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbgLJL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:27:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35502 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbgLJL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:27:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id e25so4931570wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=irDctQUnVMF9hDcxwUQ0T1CfjtHIbKWzLtaf8ORwrvw=;
        b=UdpSWRyQB0Pc+Jr7AV4bkcQ1sFpsREtzwfO/rRrowwtIt6qf3CzaCqGO4I2x1ZqT20
         Knh2jO+Uce0ffahlzT1C7XG5Sr1cOzqZHRYKrv/OVKccziwZ+0yG5KVS/k1RrPmx1+ph
         usTx551vetH5yvNevQafZUzrMC4/7Ew2+Iei3FWtDUn/v9m4BIHgIA8k2Yg7XGONf2tH
         pOhl7OCW9fDtJJPZWkj/njChbqn5BluzGNJOm0Kg/+wjabyvvFRV/3HHnOgYy4Ijz5RL
         QeuXOj7oGs87cevQvqUZi9mFGct/NRNUSMaMpOlm5C53n4rf4awJ0fvD4EdabqMePCuw
         jr5Q==
X-Gm-Message-State: AOAM530IJuj4TRMhwpvZ0SlZWoughfQ237hIT03nhAPZhg92jaeOK9es
        qK6tPgTNNAc1y9GJYWPEbfs=
X-Google-Smtp-Source: ABdhPJxSUZwy2Inn/DRXjxqdWP6MuLgRBO40T92j/pQQ30UCYfLoNyCH5oTbEfl0RJVqd5kxLTgukg==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr7452146wml.160.1607599617884;
        Thu, 10 Dec 2020 03:26:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m17sm9951189wrn.0.2020.12.10.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 03:26:56 -0800 (PST)
Date:   Thu, 10 Dec 2020 12:26:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: max14577: Add proper module aliases strings
Message-ID: <20201210112655.GA131701@kozik-lap>
References: <CGME20201210112148eucas1p287afa49e63255e3320495d480eb06965@eucas1p2.samsung.com>
 <20201210112139.5370-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210112139.5370-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:21:39PM +0100, Marek Szyprowski wrote:
> Add proper modalias structures to let this driver load automatically if
> compiled as module, because max14577 MFD driver creates MFD cells with
> such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/max14577-regulator.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
