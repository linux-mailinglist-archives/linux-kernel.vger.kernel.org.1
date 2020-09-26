Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF442795B6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgIZA4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgIZA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:56:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3926C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:56:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so3976764pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkABhTM4+gjBXbsGX0LKRrzMtJbpdlgplZ12ZAe2qrc=;
        b=DVs4M+SVZf3NvmzPd0twXi8GkXf0+XVQGkPJ2D5CbIsOtbNbqrwJ2VVhFgG/rPZSqB
         I+Yp6uBnQrGo21fG/nSKSViim0KzpxCSnQF25GAa8WkdW6DOraFnT+6SH6rf1QgQOg1b
         lNbBhEa3rddjvkKJGLOR3cSiWpXS5bMM1B7Qn36rQOZuirHL1lPJmHPvS9sV2/3PDIGO
         xxMU2vUq2REiFopho9DeLWl6VIsO+4XVfHVBLC6rQDQLqhd7F826uPNDL0Z9BPU64kON
         PYLczhyUVg1pXKKiZmTR+nuNLFXfvFNg5GCEXZ6l2Dki04r93ZghdDNepAn5tuAriGLI
         B0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkABhTM4+gjBXbsGX0LKRrzMtJbpdlgplZ12ZAe2qrc=;
        b=USaqPXFb0smC8gl4Yq6l0H9BYJxGt3ismlEXWRHPTBMd9bMYQIvEHOfXaTikETKYhF
         upcQooNtz43kDqsN+BmrXx8h5yLFc+Ui+hvMCYLPoiWCLY2BMy0hdvsdnDcZIszMEkVh
         TNepOBBnWeWjB8pg3gaH1hcu4FTdpp715wVDMsonECdz7iD45LcwU+VI4gsB/ozRizlS
         /5lJ1pOWHD9qc8vEE1tQb6zzdYEQqHXbDZERH0RsvAUx6Ti5fZgnC6UAauILca4dhbMX
         MZV/nX3sJ4VU6EWvXmBaXJBIZ4/V4zogzSpE4r4xykCUzPM3AChaGm11PMoK7C7f2Xh5
         osWw==
X-Gm-Message-State: AOAM531m1eEWMJnYn0ZjDRBBmy5itsWiAFCf62G9PaHOrHCjjspmgZfD
        R8dxkikve+5Vxon6pimAknNaLFt8ps0APDJ3XgfHMA==
X-Google-Smtp-Source: ABdhPJx8y4D99gbo4fzAmw2sgsfjzir8Myjf2rJn647+B5G232Sfyky5gCDStSbt/YC5fFqEgZfvaAxvInPmtYPnvWc=
X-Received: by 2002:a63:36cc:: with SMTP id d195mr1221093pga.426.1601081777097;
 Fri, 25 Sep 2020 17:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200925233552.GA4022480@dtor-ws>
In-Reply-To: <20200925233552.GA4022480@dtor-ws>
From:   Kenneth Albanowski <kenalba@google.com>
Date:   Fri, 25 Sep 2020 17:56:06 -0700
Message-ID: <CALvoSf7mjHwUhfnW_nHbsJk5=ZFVCNR5Ae1fXmhDf8PM68Oe2Q@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-input: fix stylus battery reporting
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re-send to appease the mail daemons]

Confirmed, I've validated this on a 4.19 derivative, this fixes the
problem and battery strength gets reported again.

- Kenneth Albanowski


On Fri, Sep 25, 2020 at 4:35 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> With commit 4f3882177240 hid-input started clearing of "ignored" usages
> to avoid using garbage that might have been left in them. However
> "battery strength" usages should not be ignored, as we do want to
> use them.
>
> Fixes: 4f3882177240 ("HID: hid-input: clear unmapped usages")
> Reported-by: Kenneth Albanowski <kenalba@google.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Kenneth, can you please try this one and see if it fixes your issue?
>
>  drivers/hid/hid-input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index dea9cc65bf80..5da631d2ec9b 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -797,7 +797,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case 0x3b: /* Battery Strength */
>                         hidinput_setup_battery(device, HID_INPUT_REPORT, field);
>                         usage->type = EV_PWR;
> -                       goto ignore;
> +                       return;
>
>                 case 0x3c: /* Invert */
>                         map_key_clear(BTN_TOOL_RUBBER);
> @@ -1059,7 +1059,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 case HID_DC_BATTERYSTRENGTH:
>                         hidinput_setup_battery(device, HID_INPUT_REPORT, field);
>                         usage->type = EV_PWR;
> -                       goto ignore;
> +                       return;
>                 }
>                 goto unknown;
>
> --
> 2.28.0.681.g6f77f65b4e-goog
>
>
> --
> Dmitry
