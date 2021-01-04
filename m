Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54E2E9335
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhADKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:20:39 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43413 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:20:37 -0500
Received: by mail-oo1-f54.google.com with SMTP id y14so6142948oom.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MI2o+ujCz+LU5O3ouK0OKlA4Edek/liLwkgkpnPez+U=;
        b=aU6s74IZi/WayMe9UfHKyiOXwfz2qPEHWiXVlnl9Q1P8FT8C6pKsnxhT13DTQd+7w8
         6MStTQ++vrm1ZPJD7ebfHNMnxDxpqGtn/D4MPVSzxoWuk5XDcMfQJQ5AFHkSdrSJT+mI
         XTSXNVUudEZLbSdf/584TnQQGinwUY4xVCU1P+lPTHLN7DYD+xne15X8DNU/nOj8dQ2z
         G93zSIL3kNiMjCHY5tKjQQhXG1fIetG+VQzji9DM8SE5nJwDj1/KiwSFk5i0OKTax2ik
         39YkShWWvOXKj85dc4faC8kxBgiF6u/to2a/Ck8l9awz7qPjqpWbX+VC5T7qLuhYZ4Vl
         yM9g==
X-Gm-Message-State: AOAM530n+ZQy+ipox7lG7obqPVi0vva7nFnqcxICByrHvt0lMTKJ37NF
        AovH6pTUze4jCKKgJ/FtY5XA2VQo0BFAcnaOK70=
X-Google-Smtp-Source: ABdhPJyPLQmUSMCeS03diTmv7o2mNZcEaLqowukhPywzoNcKX/msrP76uQaHWAaDa01COgnFGyBXqSj9kWSH8AD+8g8=
X-Received: by 2002:a4a:c191:: with SMTP id w17mr49340186oop.1.1609755596900;
 Mon, 04 Jan 2021 02:19:56 -0800 (PST)
MIME-Version: 1.0
References: <1609750546-17118-1-git-send-email-chensong_2000@189.cn> <X/LauHVX4EPvuzU4@kroah.com>
In-Reply-To: <X/LauHVX4EPvuzU4@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 11:19:46 +0100
Message-ID: <CAMuHMdV_+Cf=5cyJ9-VmAkGU_iCE51m2iEXHaQX3wbfU5PyQHw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: board: Remove macro board_staging
To:     Greg KH <greg@kroah.com>
Cc:     Song Chen <chensong_2000@189.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 4, 2021 at 10:05 AM Greg KH <greg@kroah.com> wrote:
> On Mon, Jan 04, 2021 at 04:55:46PM +0800, Song Chen wrote:
> > Macro is not supposed to have flow control in it's
> > statement, remove.
> >
> > Signed-off-by: Song Chen <chensong_2000@189.cn>
> >
> > ---
> > Changes in v2:
> > 1, kzm9d_init and armadillo800eva_init are not compatible
> > with the definition of device_initcall, fixed.
>
> I already applied v1, so what am I supposed to do here?

Please revert v1, it didn't compile.
https://lore.kernel.org/lkml/20210104122653.6f35b9bb@canb.auug.org.au/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
