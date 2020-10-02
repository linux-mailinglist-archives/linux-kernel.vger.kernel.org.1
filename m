Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1661F281790
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgJBQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:13:39 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38321 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:13:39 -0400
Received: by mail-ej1-f65.google.com with SMTP id ce10so2753498ejc.5;
        Fri, 02 Oct 2020 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTQRaRKy11dUVgsaGQZKMbWSoq0FV88949/wL2UaUSY=;
        b=n8znu/YplqeTgtcCjLmKe/svRxNQ01FyO/XV6zeHx1dAMUTyR6zYhz9yZ7oxWPVG9X
         YYqc8MSSOzfpi0lC9jvjxpUHb+9RqkWzuPlBR1jJrcnVJg2Fu7tKnSVajBDshIzGllQL
         yHciybt4xagkENMLLQnVEzGMOZPP+21lGnsH2j6dHE/RT6TO2nYU65wSFX1kGOTyIZK1
         wbznGvfmi+V8C1P2unZqjqZ/fAgAWOuhFlPkL+Op2Tk753LMGFmN0v5C+o2l1+ChMJyU
         3Dla6ivdwTJWqQesCeoKQKQMtM4TMmZzM0icGwsq36uFbw1xSysW0sdDc5jft3cjwSSy
         Av/g==
X-Gm-Message-State: AOAM530VDDrHZPv3cxFiadmA08shnpATqhvIeMcVMe44tSGpi3l4l9Vy
        j5YAVDa3Ge0lklGV7T85I30=
X-Google-Smtp-Source: ABdhPJzsa4+GOXUgunMMStxgATNr5uJYd/ltlSw6rxkURPMW1LngcpcFLyjB77N8vcRZTGAEGiqEqw==
X-Received: by 2002:a17:906:3ac5:: with SMTP id z5mr3039554ejd.46.1601655218008;
        Fri, 02 Oct 2020 09:13:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id g9sm575787ejz.23.2020.10.02.09.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 09:13:36 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:13:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Message-ID: <20201002161334.GC4542@kozik-lap>
References: <20200917193754.542-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917193754.542-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:37:54PM +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (clock-names,
> clock-output-names) with the common values (actually used in DTSes) to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
>     pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Define the names, as used in existing DTS files.
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)

Dear Lee,

Could you take it via MFD tree? There is a review from Rob and ack from
author (Matti).

Best regards,
Krzysztof
