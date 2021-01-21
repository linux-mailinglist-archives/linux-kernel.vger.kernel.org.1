Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2B2FE9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbhAUM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbhAUMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:24:48 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C122C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:24:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so2261827lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fcGiD7OwR1/jKyiV2ZSUx3opsk7q8xBXMeaqlhO/Z0=;
        b=PVlGTUCv2alBxI/JOalSnfTFcb4Dzn8EOj1UJL731dSslOU5wPg4r/KEJCQq3KLEOZ
         Sto/vWHLdrxicM2ll37EPJf7CUOiJMr6Pox71kBlfEUmIBSGSx5xg/LbCjUKU8jNCkt5
         Lm6j65B6nkAN1WbD0E5TZkZR73GbxwnTj1XufAZU7JT6KOlAhFOOV0kg2fWMfTaKIkSK
         mP8T/xlVGTChQotfDfIzKsIOhwj2A9rjXHZ7mmZyS4Dn+zrfsqAdOv8GB6kv/PxtpOSV
         nx4Je8jRFyArfUzYDlFxynn7YO4zy7Uk446uzFVD8ttN+Uv/g2THRdEOimsB8oU33XD2
         /y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fcGiD7OwR1/jKyiV2ZSUx3opsk7q8xBXMeaqlhO/Z0=;
        b=V2x0YRU1pNRXxy9N2sqzQY8CU75gSwTCqd230+vd9XpaEN0YVvgjZ3pakUGdqzKs+N
         /TKyCs8lURYI5/v8oom18elsfhu/Vp4FaRBcH9luQ6qqeTLWf3LLWaytWko69RzXdSFO
         lfCNupCgDqK7E/TwfiZscE5EDkKdnvnKGhD8VPWE3/L+7VcIN/xJxQzQ+04JNbCvzq4n
         l4YcfZU3RevpTSHHVwxj2xsjGTAkaQR6c///3fVPa0PxO/QummaBrJpHfSIRLdUOdK9v
         p61NYXFcbf6clHdX4/r9vvPnkF+PyUnxgDv5lH1U7HAlY58kiY7I3mpRCn/FK7CN3lVJ
         KMLA==
X-Gm-Message-State: AOAM531L9ZJj/iHAWR8otjt5S5K90rbbDZlJ1T9UJkLfTnOShUPZXGX5
        dnHxscJ3SjADb65/urufY/ZpsHToS7K8W/EEdrz6Kg==
X-Google-Smtp-Source: ABdhPJxGXnl8ByIfSzaEFxWnZM44EtU5FWnXKcITgR1rQdU6CvzXy3G+PyC3djO1tmBtaztm8DIUeQ3d9IZ8KrBum9g=
X-Received: by 2002:a19:6557:: with SMTP id c23mr6068215lfj.157.1611231839384;
 Thu, 21 Jan 2021 04:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20210120154158.1860736-1-arnd@kernel.org> <20210120154158.1860736-4-arnd@kernel.org>
In-Reply-To: <20210120154158.1860736-4-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:23:48 +0100
Message-ID: <CACRpkdYKT=LnCw2qakPYx+uZq4aD8NXXfV6seqt_wF84kTXrfQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: remove ste ab3100 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
