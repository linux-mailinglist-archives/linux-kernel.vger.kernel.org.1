Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADD2AB3E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKIJpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:45:22 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:45:22 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s8so7590012yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEjfNgJ/5fIZ4OmbjlXI/Ji4fSPJ5/15fdnkqBFwBr0=;
        b=hH79rFcnBf+MZrsctl3PVhI29Qx4iCcQK/h8HUPDpI/JnviVRSl2jFQS/modxFPZuR
         X5E+zy1vElN6bNnUO+Hp2bfLu0/c3Kq3tow+Ggc+tz0fXnhEMH93KyioM51VfNFFk0us
         aYyMyS5Sdakf3kjAshobcGpyShmwkNyGDIhCFi0r1vYWW0PMbyFuvzFhz4sdaeLpVuOY
         QKlErNRS1UKFvEP+gDcZHBz1IJ3l2WcFxvkSyWRZ94TtUzliEZ2XRvQPjJDZH3wBGoQn
         TNp8rF6pvIqd8NDhKh7CSfvJxC2mA/8vGJxZWYx5gPQwcE2MtQH9fZy7lYCHY79C2cLI
         cB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEjfNgJ/5fIZ4OmbjlXI/Ji4fSPJ5/15fdnkqBFwBr0=;
        b=OhaH1CgVJsZaPSX41gHepi0OBWlb3vw6ApsNG7LkRutxUSzEK2TJAvpxYnQ4Ui8vdG
         oxVyjFF+5OLruon5S6XKxZPL5zfW2bWM1GDR5BkqYjhFbjEusRmtqbc8GKuyMzNitzCQ
         HqMlFNa0g8i4OHcpCzBgnS1TPIgzsOiJo0sYByZC8+WR/ZqCkJvIcr4nT39vntxgNwTG
         9hWu2BPmf0GyiP/shpY/sTcEb7eu7+49PRUSJdwF+3YxBo57U54qxvPLuPzeozrSoj9a
         DlydrLuVXgjEbxFEK0OOV7xadnbyTGBNA9CGjY03zUkbNUquy3XOI1KMcKZHKWmImJxa
         eakA==
X-Gm-Message-State: AOAM532cQC1/kkoY/qjcuoU5GrsDwuZ9NxrVA/hMgs/7uAKaLfvOAtVM
        79YTX90zsYDbCHfBYgLCFjzF3QC8zebmdTCRAouQoWTp
X-Google-Smtp-Source: ABdhPJwqj37eo9MjAQJhOFaTidGPNP4XtSJWtxhXcOh4E+57lwNlL89hnaPzd8HlrsZ7vmVjirv1fkTVf959Rn2ujJE=
X-Received: by 2002:a25:384c:: with SMTP id f73mr16987656yba.135.1604915121618;
 Mon, 09 Nov 2020 01:45:21 -0800 (PST)
MIME-Version: 1.0
References: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org> <20201109093154.1080024-1-poeschel@lemonage.de>
In-Reply-To: <20201109093154.1080024-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Nov 2020 10:45:10 +0100
Message-ID: <CANiq72mskWULTsSZp2eKaXNe+VqRrjW3SXKk-4PgXFt8V6mZfw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780_common: Fix build error
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 10:32 AM <poeschel@lemonage.de> wrote:
>
> From: Lars Poeschel <poeschel@lemonage.de>
>
> When building the hd44780_common driver without a driver that actually
> uses it like panel or hd44780 you got a build error, because
> hd44780_common uses charlcd, but did not select it. It's users did
> select it.
> This is fixed now. hd4478_common now selects charlcd in Kconfig and
> panel and hd44780 do not. They only select hd44780_common.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Thanks Lars, I'm picking it up.

Cheers,
Miguel
