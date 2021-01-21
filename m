Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203282FEB51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbhAUNPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbhAUNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:13:01 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753EDC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:12:20 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a25so1266803ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47HDQmqatFJEKXLv4r1tqHnGg1O7gF/kMf8JxqyY3HI=;
        b=B+ofP3N9cw2DRKlNdxTQ0Am4niyM+1VvQaVipuUYDJNl1BN6r57YuCfMkAfRVsN28q
         oihxt7uvf7TlY+yjyh57UPU5tYQAlgX3ei1F/1yIRMvNlPmMjA/c1II9dO2/PVxrklqg
         AN0w0MCJZzaf3si/HIBxibUQc3hdrUFM7b1OZ37lDnFufpg/Pt/9z4xHcgWFPEf/R79i
         iEog+RvVlWuMlW/g4bYKDc4iituhzoLAmvecRs71S2l7yii+S70b2sulEiht14Z45xVJ
         x7OMpyiNZd/yz0rdichaytWAlSAIjdmo+UqDFIfHto6dTp5SDqF1DsE8udHUu1HTHb9g
         bM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47HDQmqatFJEKXLv4r1tqHnGg1O7gF/kMf8JxqyY3HI=;
        b=aoVC79E7rMYQ70CoZB5C2f31Qi8wQ8UM73UNyF3bdSMIJFvNdUwSXRxAtqa+IeUSIl
         2+L/ueO/TXDOgohxririTbKfqtifPWyWCMq9eJgd8tcOmDzFsJq9nhaStAgVYbR7feR1
         ypNySjxs5Lju3N+9DxZyP9270ZQ2qF8YFbgGLwGyPTMKdoj58nccm1KVQyieXZFkvFIk
         4MFEkwA4Du1Lj+iJNnWuc11MiiWhXHC3q//wVRK5bVZiORwVShYJjDFyhF6NIrD4FpOk
         5+gJR6OQo4E1VaVhIfOy4uD567lFkWYOBetnqOPe7h9jQH3sCWoFqw2Ja1GtDwaEr2/h
         k5bQ==
X-Gm-Message-State: AOAM530VISMVFiH+k5zIDlzqLJNh8IVVwp6E89Jfv01dvjnlZO3qpJsB
        Y39L5HuWcPxxy70g+sruQixD4oTxENKXwnp7vEE3Kw==
X-Google-Smtp-Source: ABdhPJyYLUDoklQU++7GwvgK4FZhhv5diXxOMOA4kImyzoS22TfNc7EWPRXHO/OybdPh/v1SQ5NWE47oJiAfepcUFro=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr6868618ljo.368.1611234738978;
 Thu, 21 Jan 2021 05:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20210120080522.471120-1-saravanak@google.com> <20210120080522.471120-3-saravanak@google.com>
In-Reply-To: <20210120080522.471120-3-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 14:12:07 +0100
Message-ID: <CACRpkdYon8jc_Twa83ynGVnWg7mnZ-ix3=mg2xn1XoFQ+Hq-_A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Add fw_devlink support for interrupts
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:05 AM Saravana Kannan <saravanak@google.com> wrote:

> This allows fw_devlink to create device links between consumers of an
> interrupt and the supplier of the interrupt.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
