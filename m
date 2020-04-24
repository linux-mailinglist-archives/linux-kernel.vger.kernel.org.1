Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4EC1B7C71
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgDXRMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 13:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:12:06 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9452C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:05 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id a10so10202781uad.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgtbAaNw7D/+aQV1/hPHHraWHOu1y3EAsDYZqoRW2VI=;
        b=WQmEe0r9JmPQULI/cPDvdQAflJ7w7AR1GX8c4BJLVR3/w4H1SuLX61QI7afCu1ln3m
         a4K29DhKyDt7ddf7LzyOxi/5mwvi4ebrc24lWKGI0Ye1Kwx65jyF1YTZEZCSV4D3GTkx
         zcWHDSR6WOBLVdLOVatChqrcKR/qzyUoHA0vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgtbAaNw7D/+aQV1/hPHHraWHOu1y3EAsDYZqoRW2VI=;
        b=PVmCL/eT5jgmEvkA3UWoyCYUIIPMcvyyP6HLxXexbqqhzI/heIM074cLROwPUBv45i
         sABLdAK+kDSSq3Oj22l0wsBOg2ry5U/nHOVBD4SbEgxqBI3fX7ULzi6dMN3JezMyb5jp
         ayBedYADWaqX3CNLRzoVBlNAcyIw+F3IvEXf8wGJ1+zzpOMmM9i9FnoiZ/tE2elUpQEO
         oX0wLTCkw2ZWPIxbkww0IFdr7agKRkf5POqeK7DYadWqKQObA8Vv7AZLDybXWF/X+iUT
         z78pOZgmm7lKTlAJpqv8hEiJvOfA7Q/OW4z7Gd4yrLebpvkA6evjKmsaLDBAA5kWnPQE
         I7gQ==
X-Gm-Message-State: AGi0PubedGuvk/wUpywJeLaxWbn8f/Aa3qy19hUORHJPTBTtgmfCN1UQ
        sKg8I4d9dsSzvxb+qfZh5wIsekUhTJA=
X-Google-Smtp-Source: APiQypJdTJr1tzfTb5keG3HKC43cq1vtXiGxRq0oSz+KGgtFFmPy24ARu5gU8zCdV3rp1zdPdz9tSw==
X-Received: by 2002:ab0:310d:: with SMTP id e13mr8827493ual.17.1587748324719;
        Fri, 24 Apr 2020 10:12:04 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id t66sm1711110vkb.23.2020.04.24.10.12.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:12:03 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a10so10202661uad.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:03 -0700 (PDT)
X-Received: by 2002:a67:eb17:: with SMTP id a23mr8662654vso.111.1587748323043;
 Fri, 24 Apr 2020 10:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-3-swboyd@chromium.org>
In-Reply-To: <20200424045414.133381-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:11:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6YiD=ORDuuRsYVRJriv+jJie3=HoF7MokWbj5Wx0rew@mail.gmail.com>
Message-ID: <CAD=FV=U6YiD=ORDuuRsYVRJriv+jJie3=HoF7MokWbj5Wx0rew@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh-rsc: Loop over less bits in irq handler
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> readl returns a u32, and BITS_PER_LONG is different on 32-bit vs. 64-bit
> architectures. Let's make the type we stash the readl into a u32 and
> then loop over the bits set in that type instead of potentially looping
> over more bits than we will ever need to.
>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
