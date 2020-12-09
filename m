Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D62D4B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgLIUDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:03:04 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:46339 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbgLIUCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:54 -0500
Received: by mail-oo1-f66.google.com with SMTP id w9so696934ooh.13;
        Wed, 09 Dec 2020 12:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CT4PDwxWQlH8AFGW6DWTgjgKsDiFOb+UtaZdqpeUc4I=;
        b=jgwNDjpYti1GjIUs54/bKSXVSiZItkKEx0HTl2Mzzlz1cbXK936rO/IoW5DkksNBBz
         btUqQ9Hl7M7iE/jE3I85JyF3DDzepSdz9IULQrYupUdQLkwDvsjvEhNJoPNPawreIyH5
         Ef2x+5U8LBmoQslaLudMEA1cIr/FSI0RUvK/fkDj1owyJ7M6iYGPSzVnitrC3WxXloBZ
         y/nCmLXzL2IuXLo+9JRB0/FtoIsVFEUKmUm+V5DQTcpZZGo84PTWg4wOdG8tLXmqYIX1
         +61jepyyNAqqlOfqtgK7+AHAVX06ip57oHgPDq+PkTZNxXIeXjTmgtY5X0+tI5jc9XEn
         1b3Q==
X-Gm-Message-State: AOAM532HFsMQoeANTmU1FY4EYg+j1lGQ0BkZBF9oyPvzBkz7fgeNBdT5
        cnYm58dXrSOHD6PVMjNNFw==
X-Google-Smtp-Source: ABdhPJzHfu2AIzAnwqkjC98kY5h+nEQzIAojT5SozkRjSJXiZ9f7hyrSIpsiQ97Tusg7zGgr9TzW7Q==
X-Received: by 2002:a4a:c102:: with SMTP id s2mr3285031oop.60.1607544132694;
        Wed, 09 Dec 2020 12:02:12 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v123sm504160oie.20.2020.12.09.12.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:02:11 -0800 (PST)
Received: (nullmailer pid 849058 invoked by uid 1000);
        Wed, 09 Dec 2020 20:02:10 -0000
Date:   Wed, 9 Dec 2020 14:02:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        alexandre.torgue@st.com, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, fabrice.gasnier@st.com
Subject: Re: [PATCH] dt-bindings: mfd: fix stm32 timers example
Message-ID: <20201209200210.GA848983@robh.at.kernel.org>
References: <1606913114-25693-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606913114-25693-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Dec 2020 13:45:14 +0100, Fabrice Gasnier wrote:
> The stm32 timers example name should match the pattern timer@. Also,
> the example is based on stm32mp1 timer 2, so the identifier should be
> '1' instead of '0' (e.g. timer 1).
> 
> Fixes: bfbcbf88f9db ("dt-bindings: timer: Convert stm32 timer bindings to json-schema")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
