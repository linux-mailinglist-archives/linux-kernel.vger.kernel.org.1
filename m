Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC62CCB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgLCBSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgLCBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:18:45 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB11C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:18:05 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id s6so47849vka.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpagofRh16VTEf0yM/jWle+M5bCtYp5ztfFUeZyD1Rw=;
        b=CwteP/fAytozg99oEQEcp4Q8UE/om6gvgCWi2wmQNHhDYrWoSJjjLAb+XX9nuKKLm6
         28tdPR0oRuwocPFe5DCtcfoECyC2P7/bxNMj4EFW23wbJzMygYCVxb1Tt02uJoehGvJX
         e+xOHFEgeiPbLcnsFYUGtIunbA8H7GI7tITy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpagofRh16VTEf0yM/jWle+M5bCtYp5ztfFUeZyD1Rw=;
        b=GlIMr2IaMNGYhBKGv6ank0D2zjgFqOvePGvO6EyY0rkBnBk/lNAZ68gILAscSLJJP5
         0YKrNbe699mpw9wqJ1h+kXyuZMaVu/rZKMDbubtYL5TYMsk8pykchS9Dmqy2XL6MUlru
         60s2ZU7bT7jFq/RZnREXjJByzNHWcb1UciyM7a3dUSW4xJRpJgUM/G6kjqLfzc6YBvej
         P/UyCVZkdVq5o9qWIdgQ8z9IjXN0ME9fPyGL4I3mef4TwJRQnKY5+KbPxbwOWt/41J80
         UYkeRbYXJ0v0aY5uGyiMr/IQIkOC4bG0PHpBorVVhEwxULeRNQDXnBGNHnp+HxEGAAXW
         BxUA==
X-Gm-Message-State: AOAM5336eo99NN2QojdXOdWYm5lqHXH4CKcjq1OfIOVDW/0KWfH6wLM1
        ovmdLEz9UdqROr6KcCVurDvhU2nGbJVhQQ==
X-Google-Smtp-Source: ABdhPJx90diYPXTlkq9RgbQhIGiRsgt+9Uaef7ttNzvnxOWJAEdGigItobVpm2oE65ziW1NoWv5y0A==
X-Received: by 2002:a1f:d4c4:: with SMTP id l187mr489575vkg.14.1606958284019;
        Wed, 02 Dec 2020 17:18:04 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id t66sm77882vkd.49.2020.12.02.17.18.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 17:18:03 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id x4so367119vsp.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:18:03 -0800 (PST)
X-Received: by 2002:a67:70c6:: with SMTP id l189mr752080vsc.34.1606958282923;
 Wed, 02 Dec 2020 17:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20201203011649.1405292-1-swboyd@chromium.org> <20201203011649.1405292-2-swboyd@chromium.org>
In-Reply-To: <20201203011649.1405292-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Dec 2020 17:17:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WpLAsb3akm2m7i_azj_3etxR0Y+L-wu9BC8YdN-C7KOg@mail.gmail.com>
Message-ID: <CAD=FV=WpLAsb3akm2m7i_azj_3etxR0Y+L-wu9BC8YdN-C7KOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_spi: Don't overwrite spi::mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 2, 2020 at 5:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There isn't any need to overwrite the mode here in the driver with what
> has been detected by the firmware, such as DT or ACPI. In fact, if we
> use the SPI CS gpio descriptor feature we will overwrite the mode with
> SPI_MODE_0 where it already contains SPI_MODE_0 and more importantly
> SPI_CS_HIGH. Clearing the SPI_CS_HIGH bit causes the CS line to toggle
> when the device is probed when it shouldn't change, confusing the driver
> and making it fail to probe. Drop the assignment and let the spi core
> take care of it.
>
> Fixes: a17d94f0b6e1 ("mfd: Add ChromeOS EC SPI driver")
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c | 1 -

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
