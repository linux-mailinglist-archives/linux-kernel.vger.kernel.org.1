Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D982F890B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhAOXAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbhAOXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:00:00 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F57C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:59:20 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id x6so6555215ybr.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHMXMZq36V2MZzCSQbRr+IfxatHburmoaN5oRHG5gT4=;
        b=Uk9lGbMa7IVek2U2pKwLcDsTS5la31i1f8Hx5GR3u5ubHXSiyJwWLEbmPXf8Wf6ZxP
         YJ1DLFw6m2g7EPZQazzr9YoyfKUNYqDDtk17kdhFIMg02e3lqR3y+U60ufOuboB/ERsl
         qcZgEhVBio5pA0rbX5OdOZChS8DVKSXyxyZN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHMXMZq36V2MZzCSQbRr+IfxatHburmoaN5oRHG5gT4=;
        b=ULtSWWYsQwHUbjgOi0yX05WzS8Lve1sEqDSsFzNnh3X/+k4HNEaGq2zDnJSXA+f0NY
         BJu17eAXFdD1zvYSqGBjZE+lOp6TEjMLETWnQWSwnO045iHNd0ZNBxloALfRlPxKXFZN
         CWZx0Wv1GGnRAnK4NAXBM6Uo81LDTI3/d7n5uogVCvUacaaDUYN7ea6otouhOFKD+sBJ
         SAWkaAwFVVrsA1m/wH8ZbIvM0tfhNCA43UTgZ5utuLYjY9EYDM8ttev24dcR8Bf2uUlU
         awMTI7j4ZuWqovGAHsVPfWJbu+DbZ0wN4k0CueWPtMRuVAh0h+XTqfhxW5oZOJDPrtUH
         jEDA==
X-Gm-Message-State: AOAM533NCrL5+fGBBRhyKYnq0A+SH2PgLX0ZjdZuKdPtmgIntquaENe1
        uCRBsZWtuTeg8eP8PzRxMWo5wcaZsr7gSx/kcfTZEA==
X-Google-Smtp-Source: ABdhPJxBinPZNvF/Ca/Ux1433LqNPLH+1nCMcyCFZkL1X2MmCK4XKH43895rBcSjaSkxHHW9FUim3nY+gY0rnPYe9n4=
X-Received: by 2002:a25:3d47:: with SMTP id k68mr21099186yba.415.1610751559230;
 Fri, 15 Jan 2021 14:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <161075030927.3661239.13484813586536559071@swboyd.mtv.corp.google.com>
In-Reply-To: <161075030927.3661239.13484813586536559071@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Fri, 15 Jan 2021 14:59:08 -0800
Message-ID: <CA+cxXhmbgE7dT_is1n207D2oTmvU0NrUn=XvQFh6vj6yOQ6MOA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Create macros for cros-ec keymap
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-15 14:36:15)
> > In Chrome OS, the keyboard matrix can be split to two groups:
> >
> > The keymap for the top row keys can be customized based on OEM
> > preference, while the keymap for the other keys is generic/fixed
> > across boards.
> >
> > This patch creates marcos for the keymaps of these two groups, making
> > it easier to reuse the generic portion of keymap when we override the
> > keymap in the board-specific dts for custom top row design.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> > (no changes since v2)
>
> Please keep reviewed-by tags by adding them yourself when resending a
> patch with no changes.
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks - will do it next time!
