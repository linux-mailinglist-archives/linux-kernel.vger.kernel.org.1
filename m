Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2CB2F1CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbhAKRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbhAKRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:39:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C5C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:38:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r5so555710eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdlutJZbWxlBsMMj13bYddyD43bGm9GpxW+8aixAX/Q=;
        b=nn6G0HH5J1UNcJsb8UCHCcPUQmWYOXwydCTN7d6GmJdLeCR7/PAJ6+bJBDhzussWhH
         Z0NiU5kRzoSrXjqdKBp6iyJeFH9ikCmXo5yT81TOY6rgHCbXM4cRMon5sDbrY6l+aaNr
         XKK94IB1QxrwY4yQXhLfn1ZT5pV5a3em1JyfWedKficuMpsC/WWdCenErmPGwHrPTy/3
         RCC1swH9PBG1c7ZYVoD2iB15OS2vuGS/b49irYg92voNmAWp+t8U/zmBaXZiQXZnJSa4
         Uh5FoTOiuiKX9BQRxCip5c6zEyawHgOslIAwCQJFGoiFajcIYEmNfADNygxcM5QmIenM
         VA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdlutJZbWxlBsMMj13bYddyD43bGm9GpxW+8aixAX/Q=;
        b=sTDXA/RH/qlROlx+kbChSH3KfPIK4XEnoGcRCHUC09M6cSaNZz1WMgCmuXQSWGrhdG
         7oTRf49GpwTQwX0raDDUWfn508P4RTZ83ePkS9ADLykhW73U5k0fWbgQDPClF3I1PECZ
         QnYdVncufN1IEiUuTrmKl4lgwIz8f+65wJeePO4y4DeRhT9h8RHxYj8mKM8lgW6vay37
         axC3uNq/oWR2GGa07F9LFFMukg53jXB42NDywYpRU42ko5AiKEz8wfmwFJK97WWwvUqF
         Lq6tQvEOVwbU1DZ28QfOMWBNcsrRypiIfaSZjQr+TN/meoYfg1LfGvSkpozb2MfWuHII
         tqhA==
X-Gm-Message-State: AOAM531Cb/goI/6q6gX9aliPR1zrcnydgbABCFHIGfB411DONyS9pp3Q
        yb07VYES9j7DLuln58MoZlyfUg1auWtF3PnC54c=
X-Google-Smtp-Source: ABdhPJwSjl/SYSqjAkIlKhCbbfhyr+dJQ4sT03UfyN1b+NXK5LBQd9Y0WrDnPdZOy6uJ1f5EsCz3KqEklNbW2shMgVQ=
X-Received: by 2002:aa7:c64e:: with SMTP id z14mr358526edr.69.1610386706256;
 Mon, 11 Jan 2021 09:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20210111151704.26296-1-max.krummenacher@toradex.com> <20210111151704.26296-2-max.krummenacher@toradex.com>
In-Reply-To: <20210111151704.26296-2-max.krummenacher@toradex.com>
From:   Oleksandr Suvorov <cryosay@gmail.com>
Date:   Mon, 11 Jan 2021 19:38:15 +0200
Message-ID: <CAGgjyvEvcNeWQF_ghrJB8P1j9iRJX7C3pYnjbT2K19xVb-dnEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: imx: build suspend-imx6.S with arm instruction set
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 5:20 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> When the kernel is configured to use the Thumb-2 instruction set
> "suspend-to-memory" fails to resume. Observed on a Colibri iMX6ULL
> (i.MX 6ULL) and Apalis iMX6 (i.MX 6Q).
>
> It looks like the CPU resumes unconditionally in ARM instruction mode
> and then chokes on the presented Thumb-2 code it should execute.
>
> Fix this by using the arm instruction set for all code in
> suspend-imx6.S.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Acked-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> ---
>
>  arch/arm/mach-imx/suspend-imx6.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
> index 1eabf2d2834be..e06f946b75b96 100644
> --- a/arch/arm/mach-imx/suspend-imx6.S
> +++ b/arch/arm/mach-imx/suspend-imx6.S
> @@ -67,6 +67,7 @@
>  #define MX6Q_CCM_CCR   0x0
>
>         .align 3
> +       .arm
>
>         .macro  sync_l2_cache
>
> --
> 2.26.2
>


-- 
Best regards

Oleksandr Suvorov
cryosay@gmail.com
