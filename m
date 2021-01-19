Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912EF2FAEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393969AbhASCLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404721AbhASCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:11:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C694C061573;
        Mon, 18 Jan 2021 18:10:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h205so26830799lfd.5;
        Mon, 18 Jan 2021 18:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaUFV/j6fIPLf9E3GK/p3HaOmFJPo2jVJH2mypUsSUE=;
        b=SkUalU8LqzJ7sWI8nhOtu6d/v1gEueKzrO959w3yFpydyKHfWAKGac03BSsjbqXAJw
         ouUyWjJt6Rrf6LP5y7+x50o4uRlg4qDTBjfxLY0zKNeaLmW8PNe64xWWq5knYrTHSrLT
         dY4Aqk0xpQLLxmMbtWwBDa2lfkuxFaYDyIlhoxhya2xpycjcaMRV/T4hCngXyDv4Y81f
         mpMpE6pAQgoo1u53Kuj3hSvHEjfmtKgOoHxGKSnL1AVIxXEKrLJdwV9+ytOywktbeX2L
         2/wTQbyPQUNvhdGzPsl+pstuFYpSuvPGm/bQ1wFVVm0gB5By6iRR266zXofOEIFSVcbk
         PqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaUFV/j6fIPLf9E3GK/p3HaOmFJPo2jVJH2mypUsSUE=;
        b=az8VlN7HfirU4BE4BQks2L6E48UsWj56LAVIib6rd1SEtDlmwIzk9ssvdPURwGtTpT
         P0pr/Ke8hzZ1KFYwyLnX3sJf4Xl+Q9YMQU80sDymgDtqfuLp1zp4KsSGOY4qIURwOYHC
         x4AWc/DJw7TQ40gK8hJ9ng7D6DUFxNEFHxM7h7jRzKyH4W17rj/RY2gxEsCbmI+p78Iv
         fGzRE/RMaXKid+LthPgaMYHS4p7+v+XA0+B/3W5gh1olYAxc1wXMI+M3EGJt8EFVkUS5
         +AeNeKv9whQK3V5CLOrWjlXrhjWRohGB1B1pAsujt2mNqXeAC4q44joeKdxGYOcOXn29
         3q8A==
X-Gm-Message-State: AOAM531WOZD/iLg4E1VyuLhndE+J2U1UNxhWTeotMtJ/UxV1LBVZ/rNf
        t7534FQ8lLrmzoGikq8qHJ3hsMoGb8jDxkoHE34=
X-Google-Smtp-Source: ABdhPJy38gaPPxNsk35aDKt3LFzwYfOMXm77W89E1Ys1clVyXVykmUd+OyKm85c4JcDJs1aO6uN3H7f01+VAQa0Whfk=
X-Received: by 2002:a19:4856:: with SMTP id v83mr804739lfa.583.1611022251450;
 Mon, 18 Jan 2021 18:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20210118113032.21178-1-a.fatoum@pengutronix.de>
In-Reply-To: <20210118113032.21178-1-a.fatoum@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jan 2021 23:10:39 -0300
Message-ID: <CAOMZO5BdtfXoXMNr0Rsr5YTrahg6Pnz90eryksN4ctnSvOwU+A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx6q: demote warning about pre-boot ldb_di_clk reparenting
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Mon, Jan 18, 2021 at 8:30 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Since 5d283b083800 ("clk: imx6: Fix procedure to switch the parent
> of LDB_DI_CLK"), the clock driver warns if ldb_di\d_sel is changed
> from reset value on system boot. This warning is printed even if
> the bootloader (or a previous kernel that did kexec) followed the
> correct procedure for glitch-free reparenting.
>
> As such systems are doing everything correctly, a warning is too
> harsh. Demote to a notice, so users are still alerted, but without
> cluttering a loglevel=5 boot.
>
> While at it, add the words "possible glitch" into the log message, to
> make it more user-friendly.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
