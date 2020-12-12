Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150FB2D86E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438946AbgLLNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406410AbgLLNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 08:25:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB25C0613CF;
        Sat, 12 Dec 2020 05:24:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so6155168plk.5;
        Sat, 12 Dec 2020 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ksaEunvK50/nb+IXkmSRKBC9eC7CJwrhhjDMxO0J4Vs=;
        b=jPubJGPEwgmqCTcYXqapBod3nE6ftroDCBLp1viWUx6z1V5Ed03/JOuIu/owXjXydB
         K72EJZicgeXqO0kD0ww0y5cVGiPMcNZ9rLhufpGB+Ovfla0kQy3u6B1neho8kEhu1f2V
         hZ3NTSrEYXYUhDYL5ZIZbfYyexVK08fBdLoPDbaicd6tiXIV/eIDGCPnO4sOoeezvtaJ
         RcYVBpIRaH1KF9TFU1+/yjMS2+w9/bfzNQEvibo9E9JWQtc0Aemhg135HHDLqVwV+Clv
         Xu2n3T/UrWwgtVzljhS8X4aNzdBLPxecQr6/TeVcglR0FWFuvLPuV8Uv6iuz8nqZc2tZ
         fteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksaEunvK50/nb+IXkmSRKBC9eC7CJwrhhjDMxO0J4Vs=;
        b=KYUVN9JZ8yo1e3a5Gh67iESPp9GQtaq/DmS+MPVUjzawGLubMFY26xQzEUAAXXd3tQ
         c4JFRD2PTrClUxKZLHIeOHXq7xadj7QJ3U0Cuzs4Aqg2OuROpu+/rA7NDT0pyVUgJujw
         smGJiYIrJVSQdgv1yxAMcsFdhLJjMdh/OK49TRIj2QSvGSxEQ8Los0x7Nu4ng1ppoL8/
         X5aO16tppyVOLXU/tpUlFcxVSLXIlmUsKP9oTh4R3IEnSy/2JcWjJzCVX5VtE0GuKXN2
         3NnGtmrTzDXdImY26Bscd6mNKqygEy9l/4y85ZgI1BYHEw0GOJh/2eU4MUJsHzi5LE6j
         Dcfw==
X-Gm-Message-State: AOAM533qhmYTVdgoh/+hYZBIQtmt5ZrfrWpOGFRd3ahEM2swkbQHzAvb
        srthMhmwwm9RXClanrUBPHwTDo1ohYGBJzLw3y8=
X-Google-Smtp-Source: ABdhPJzRvA0A57AST/g7uhMgAXYg5I7FGUyX+/1MT4GLltPfTUg+iSAt7f3MkXoxKd9+30Qhv2Gh4uXP6MaSjS7LzZ8=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr17678480pjf.181.1607779485601;
 Sat, 12 Dec 2020 05:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20201211190335.16501-1-rdunlap@infradead.org>
In-Reply-To: <20201211190335.16501-1-rdunlap@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 15:24:29 +0200
Message-ID: <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
> functions are not used:
>
> ../drivers/platform/surface/surface_gpe.c:189:12: warning: =E2=80=98surfa=
ce_gpe_resume=E2=80=99 defined but not used [-Wunused-function]
>  static int surface_gpe_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> ../drivers/platform/surface/surface_gpe.c:184:12: warning: =E2=80=98surfa=
ce_gpe_suspend=E2=80=99 defined but not used [-Wunused-function]
>  static int surface_gpe_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~

...

> +#ifdef CONFIG_PM_SLEEP
>  static int surface_gpe_suspend(struct device *dev)

Perhaps __maybe_unused ?

--=20
With Best Regards,
Andy Shevchenko
