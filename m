Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4292FE526
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbhAUIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbhAUIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:35:38 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:34:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so1485980ljo.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS8yS4z5gTRHyWYZ/MorqH00QDK2F6AOgR3jNZjO6uw=;
        b=BPXcee2xlc4t3zVun2eTfkyri06k5pl6h7fkauTSz0bMHzX51jxkZGvUWY4HmCBHfU
         Uqos+y9JB+nfRQXjsyU+fk7JyjMM/PI+94oZGRP4bEToOrt0vz4OgIUj2WqYPU5MTQ2R
         5YzLNlb/3NrRjd7nZOfVCtQD8MZLu7Ift+AacsLu2R2thwngH4IxM/2eABKE3/kiP/kN
         6RmQcR/yIW31FDZQrU8qJ+ViMK58pM+f5C80rGqK/lkl1AvWmMwXGH5by8rSwK8cs160
         mTcFLMuvN9xyAMiVc6emqDMHJrosXy13tNeBMWbkFJMQ5iV9aHlUZ/zzRRq5Ok71qehj
         cVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS8yS4z5gTRHyWYZ/MorqH00QDK2F6AOgR3jNZjO6uw=;
        b=YNK1ar56lIqW8NMP28aesejgOOqw55jXojb0+yKu9nE6PwE4TiSob5AMFj3rZ+VtUb
         GVAm0cyGpfA+ZPzw4g+fR5jY5iE7wEgwdUOPR1H6Ty8LHBFFCSCwGxAlDzqo6IAnkqAK
         fnSoOpjn+vWFJL9Aul/Tu3VQctrI6XC0zUvOL9X+Gnwb1Rj9QtA6Hj+qWI+WQVMxV7TA
         g1YEdhUnq8nwmO3Msl6ib0tVCWXC1l68MwkEjnIxb+tBcVmeLx/xCmkp7iOkzzPZ1Qmi
         gdd/6gxcLwNvZJ4c8i3bMSxPcgJKbylkfcXIceNRTExlm8zUCFIcVhXh5Vniqmfegp2L
         /r9w==
X-Gm-Message-State: AOAM5327bZ3IODamYOzg9NS/Nq+E+xTIkopkOfCnazH8fn4zht8DibaQ
        kMPZBtUzb4sVSiDtZr1R582fESnUW/D1VSw0LDyT7QCBfDXMZg==
X-Google-Smtp-Source: ABdhPJxMfoLva9Z9+4Vk5RdQNogIN4B9DKEC7RABIHA5mu0hvaAFjmZSPKffe1TCkudstO+9cv1RdOfrQh93Tq/e4jQ=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr6291564ljo.368.1611218095600;
 Thu, 21 Jan 2021 00:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20210120124812.2800027-1-arnd@kernel.org> <20210120124812.2800027-6-arnd@kernel.org>
In-Reply-To: <20210120124812.2800027-6-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:34:44 +0100
Message-ID: <CACRpkdaMZdUebQy7KOeAQz9wqGUWW3_PJUcD8N500NQZ0wXX2Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: remove u300 platform
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:48 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The Ericsson U300 platform was one of two ARM929 based SoC platforms for
> mobile phones in ST-Ericsson after the merger of Ericsson with ST-NXP
> into ST-Ericsson, the other one being the ST Nomadik.
>
> The platform was not widely adopted in Linux based systems and was
> replaced with the far superior ST-Ericsson U8500 in 2011, but Linus
> Walleij kept maintaining the code for the whole time.
>
> Linus continues to use the Nomadik machine, but decided to drop
> u300 from the kernel as part of this year's spring cleaning.
> Thanks for having maintained it all these years.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I was planning to do this but you got there first :)

The reason I cannot work on it anymore is that the device
requires a special signing server to flash new kernels and
I don't have access to that, and we never created a U-boot or
similar for this device so anything needed to go in through
that flashing tool.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will you queue the patch for ARM SoC?

Yours,
Linus Walleij
