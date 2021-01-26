Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0C304098
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405934AbhAZOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405920AbhAZOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:38:54 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0DC0698C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:38:13 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f19so10925250ljn.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKIVrzmqYUOvXvYljgTLycglNQxxvxzLssnCcG00JUE=;
        b=Z61ZcYoI1wrAA2mUhS9tDAPopdVOwoZrn8/a/Ig5EK6aUcGMd9YMpTDEIJAmlE938/
         SlHTZ44Z9lRUPUa9HCov9cqK/v7goeGYiErAp3Oy6y9UpyDz1rj94wfD4sObnMG7lcUv
         nNvw3EjqCRjrihEGHJMxhW8pERPsGBYOkQtvbaxKIvm3VduiCBjUdy5M52HaxkvFctne
         vSlG9iQpScJKexeKBHKtlEKi7kWTKLo0GP6ZHHz3ZlyBP00YvQ4qSELb9UxI0JrWITDr
         G1Em0wQmKjj8HNIYESfekCWlED0O01yIA3DXfBKzKSikOr6RMlpR42K4+U5Mfimf63/+
         eruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKIVrzmqYUOvXvYljgTLycglNQxxvxzLssnCcG00JUE=;
        b=hezVAtntEtKYTdb4PJLM3YAXrg5PbR3t9K2MElLdsI3Iqk0+/WtmN58LZrfRt7ECGn
         jalsMCxxpAg0omKXCsypQPomrAuKDRNcLStl0K2QuMVrVxpqX5tbyXiAzu03N26W7eXQ
         oPi5GblWUAxE8nyPOdXpg8Vc+9V+B0FpvgLfU9gPcE0PQ4f8qCOc4QRqKklfJZRiFP6z
         DGK2BwoGbK87kFH3qYMjWeF5Ac0jUwY4urZVSRLBm4DK/kgElPAbr+GcRyrzdCMkNKx9
         H53+Q+Jt/JrIvWTPTkhqhM6Nu9IXdhvXVBE36UP5TqDxYzUY+7H1NlbV7HFfkix0k8G/
         qBew==
X-Gm-Message-State: AOAM5300+8jBRbhdvPyjwA63esw9fd8kLp98zrMY2wbRNVwzwbs8g6sU
        uEF1vtiBApzHrL5QRVTR06P/F9Ed706rPxk1CKEBHQ==
X-Google-Smtp-Source: ABdhPJyemHxtbuIKrWt6zcfpiDcidxt1bc0PXtDRpoE+INHQ4W2AhKMrkiTsUyU018gju4xH9/T2mSZglBVVR+UVjYM=
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr3126644ljm.273.1611671892242;
 Tue, 26 Jan 2021 06:38:12 -0800 (PST)
MIME-Version: 1.0
References: <1611569954-23279-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1611569954-23279-1-git-send-email-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 15:38:01 +0100
Message-ID: <CACRpkdahc-YuqFQR_EBqOw0t3GK=7R7FxYxgE51SOvmCnvyBkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: at91-pio4: add support for slew-rate
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:19 AM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> This series adds support for slew rate on SAMA7G5. Along with this
> patch 3/3 fixes some checkpatch.pl warnings.

Nicolas/Ludovic, can one of you review and ACK this patch set?

Yours,
Linus Walleij
