Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C92FE6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbhAUJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbhAUJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:48:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A85C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:48:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m22so1644558lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aL0xTKwWVJPxOEEndQllkam2eBfDInyiBbfZsRYxiac=;
        b=sYoga9YSbGcY/WYYNNQ7nG5x1RQSpmyBi48cE/EYLCa/KOGywXNL10/5OVXfzKTPr3
         4FZihtr/NrKy2b3lvPT90hQmHLieD/WOiu51Sqr80jEZAPDjbwU95klCrs9COuovXBef
         1keDmCCwW4Nmky1AInN3t071XedyeuwzbB8QDmZzUEXoeHzOt/v+MQSeks4s954NHefn
         KxCOYopH853sYtzVpCoj5HaCiJCeUDysHtwpE/EAUtl6WdjrFa10mJLWYVjuSrKr+ibs
         nB0eVua8PRnNDTJdJAGr7kg33BXG1ZkQPWTdaHlVxHPJyHGkoYw1ROLnGaR0s1/4PAix
         m98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aL0xTKwWVJPxOEEndQllkam2eBfDInyiBbfZsRYxiac=;
        b=oCQUCpcQRXkmEuht5zE5RSBGJ94sRH7lbyYhHGRbV+67V68EvH3AfumfLzfPbQe/9O
         ePSLO/4YBEcK++P09DQkEz1YJ7jBd4qjQfH8GvZy1zOShU2kiIyKIiYb4xg76ImMjNZs
         aUlmdEHjZbrhEsVdg3/uKQHXiTscDx5QX1RVwZZvsxL0u6+08SzeEa2DAyfS7N0pTyDq
         w2QqV7v5NEKprlg3XpD23/bbWG15rXf1Hn8DwVilMbuWfxZbz1dua0B2iBEFhqdxuCnc
         rTY6KmP3ZdsF7v4SFWGJMCsotJDqRZHRe6ft+QSEca0TVhxHOuci/O7Ns0MQtitEy5KY
         v2+Q==
X-Gm-Message-State: AOAM5309NXRXkCObZWFDi3pAaMdLFXvhKGAlLxw8gNGHb4ZCO6OGUnIz
        6/Eh6wAAsyPsfS3K82z4JW1XqmX2ieOyi76Hl8RwPg==
X-Google-Smtp-Source: ABdhPJyz5FTradRRNmACyfG8j2k2QrdkCA5RlZLgHRLgbpSbO670VGne4agQFhJboVrW9m8G8QRqnH9tKATFo8HBTsY=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr6355725lfs.529.1611222494230;
 Thu, 21 Jan 2021 01:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com> <20210120132717.395873-5-mohamed.mediouni@caramail.com>
In-Reply-To: <20210120132717.395873-5-mohamed.mediouni@caramail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 10:48:03 +0100
Message-ID: <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohamed,

thanks for your patch!

On Wed, Jan 20, 2021 at 2:31 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:

> +properties:
> +  compatible:
> +    items:
> +      - const: apple,aic

However weird it may seem, Apple is not in the file
Documentation/devicetree/bindings/vendor-prefixes.yaml

(I think it's weird because I remember clearly that they have been
using device tree for PPC since ages.)

Could you add this 2-liner to that file and send it directly to
DT binding maintainers as a single patch as a preparation?

Yours,
Linus Walleij
