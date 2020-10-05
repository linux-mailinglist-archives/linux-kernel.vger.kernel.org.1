Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A8283815
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJEOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:43:36 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04840C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:43:35 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id d18so2338453uae.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TU+j+Xbieh3FK7psjds/MoW9/sFR78wjEXA54zTt1Co=;
        b=AUBIqNhqqIjxGu5JNrH+FhF31uWdVM26CNAWD5OoumwwqeZWHte8dEyW+WdIHRaHEf
         U5H0w5E4gnmRWqV0eqDgSAREaCIm9B+bdHSe0ZNZviL6o2bzCa/gKxNDOVx1bGQ6WVeR
         IrTXsFPHUXMHIFX//x/rzb0POtn12pszquBG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU+j+Xbieh3FK7psjds/MoW9/sFR78wjEXA54zTt1Co=;
        b=e+eGLqfm+ySu5GXRuZr2YcIQuJV2RsiLc+dbUw/DyczRkLl/S5P6RxAtK8quOwGJ9x
         YLZW7y0DUQ1hNGCmIpd5hvSAuvThnAraAeNU+tTUKZpDha4c6/Nza6ng4kn8BMVOlKa0
         zZYZWXTRmIdIjRrUk1WM/WN+5lG48HoIiNGR3Wj7X3SqD8U/MEoqgbvGR9sItwUDflQj
         Wy5mVcpSZaE9Kq/my3hwiZyVwr2BObgrceV/6GMH73DxVnujdaC/C12qlbJEIZGc1E6o
         6T9WPL3PMZdeTZcRE/6BSMfPfy2eZ1BY7AyEKcQFuuzhr1I63XIX1W7am6FHjviQbLpq
         Q71Q==
X-Gm-Message-State: AOAM533AhdatIRyxm2e6bcdH+SYPW210X4q6EW1WSc0JKUyjy+d4AI7n
        2B9sh4zQKypz35h1dUYtk+b0Amy34G5k6A==
X-Google-Smtp-Source: ABdhPJwI8vvbpRMFwNCXxsxfUauxKJyxD0A59b5TbTDSXTuUkGN0GZ1a+UmRrrjZc6M2mRS3S/Mw6Q==
X-Received: by 2002:ab0:d93:: with SMTP id i19mr31572uak.7.1601909013986;
        Mon, 05 Oct 2020 07:43:33 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id i25sm25699uac.2.2020.10.05.07.43.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 07:43:33 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id u74so1801396vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:43:33 -0700 (PDT)
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr287395vsn.4.1601909012755;
 Mon, 05 Oct 2020 07:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201005090321.8724-1-vigneshr@ti.com>
In-Reply-To: <20201005090321.8724-1-vigneshr@ti.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 5 Oct 2020 07:43:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLWgyS0T5h9JtNpDSo4PebUYX-YEAW9nBo5VyhKRbvYA@mail.gmail.com>
Message-ID: <CAD=FV=XLWgyS0T5h9JtNpDSo4PebUYX-YEAW9nBo5VyhKRbvYA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Prefer asynchronous probe"
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 5, 2020 at 2:03 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> This reverts commit 03edda0e1edaa3c2e99239c66e3c14d749318fd6.
>
> This leads to warn dump like [1] on some platforms and reorders MTD
> devices thus may break user space expectations. So revert the change.
>
> [1]:
>
> [    1.849801] ------------[ cut here ]------------
> [    1.854271] mscc_felix 0000:00:00.5: device is disabled, skipping
> [    1.858753] WARNING: CPU: 1 PID: 7 at kernel/kmod.c:136 __request_module+0x3a4/0x568
>
> [...]
>
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c | 1 -
>  1 file changed, 1 deletion(-)

Thank you for the revert and sorry for the breakage.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
