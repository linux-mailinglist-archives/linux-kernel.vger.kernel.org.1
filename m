Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269F12AD75C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgKJNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:20:04 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48949C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:20:04 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 74so17464501lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUc4FROYQtgj3f48EMA2Q35Aoeo6A9Bg4v3Z3azlYbc=;
        b=LKt4KC1Go1Oj5oFXT7AoL8a0nJJznQOtDGScKZujsj5OVIh3fowX7tMSGQHrxnbSUd
         WXh3jubqa5756OKJWf22Psf+4OBUSn3C+75Lh8mhGsHFpri0DHyNwbmpQyOelpARznUL
         z232JG/w47Fy8BxqUKJjlH6796bjpyJwm4a44unW5XPEdLO3Y+0LyIeMazu1bYzh0voK
         oQtCHeRdZ8pLSqErf6QS//DnrCdlkB9YXROmZIj9xS4pQGYUGosiiAiVN1OIeWdTBgH5
         bK5JUz4BvJOx8Ygoen9/YVoc7S9fG0sGxlvuYB+ADxUmRP6/qc2Fn0vbZyQD2QgJqtpc
         AlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUc4FROYQtgj3f48EMA2Q35Aoeo6A9Bg4v3Z3azlYbc=;
        b=D4p7Izk9rrbfQC941zlHF/civNiNnFmZV8QBlXMchkJA5rVex4s25U/GRvN2DjSHt0
         LLlnNFduHCaT1bHHCJXnJem0ZJOVTrPg8/W2Yombm/3ZzHlu66RpWEnT977dv403IBEf
         PtWdLQ9nSCzPphb0KJG+iS/WvwzTB9q9EpfG7b43eTEqquqkWOoD93Ehbour9/0PmT/m
         dOlSo2jrI+6RyBsvVAwwCpjvYZbmTY30upPR+gwItGP9WYP4spV+qFRul+Y7zQC3fqMP
         dXDlT61C2SWACQSTdXRDVWrLNEyjS9eyfv0pCq0z9KAzZeengfbUfj2OhWeHcQhtI+j6
         gdow==
X-Gm-Message-State: AOAM530x1ln6tk9kN+blz9AJL0fxSTqy6QIfDdLMlH0zHxQkJTB2oCBw
        KPpvtIGN9syYIKCXi+GdRZzLk03ISInQTEGeMfvhVg==
X-Google-Smtp-Source: ABdhPJxpyPHQTFP6VP4fU3ofkUDZvR/pdH5VIYTxgPIqiFsFP+wncHwniiJUcsuE+hGmM5FmhF4yAu1OFJ20oB1R8W4=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr7179710lfc.585.1605014402796;
 Tue, 10 Nov 2020 05:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20201105231912.69527-1-coiby.xu@gmail.com> <20201105231912.69527-3-coiby.xu@gmail.com>
In-Reply-To: <20201105231912.69527-3-coiby.xu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:19:52 +0100
Message-ID: <CACRpkdZRwkhk_Bh0ua7sbq0emRRjTRkHwJWE8EMk9JwdPB8kUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pinctrl: amd: use higher precision for 512 RtcClk
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:19 AM Coiby Xu <coiby.xu@gmail.com> wrote:

> RTC is 32.768kHz thus 512 RtcClk equals 15625 usec. The documentation
> likely has dropped precision and that's why the driver mistakenly took
> the slightly deviated value.
>
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link: https://lore.kernel.org/linux-gpio/2f4706a1-502f-75f0-9596-cc25b4933b6c@redhat.com/
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

This patch applied for fixes and tagged for stable.

Yours,
Linus Walleij
