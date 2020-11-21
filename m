Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E005F2BBABC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKUAOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgKUAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:14:13 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:14:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so9419882pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uKqWBXY7mffdyrXuPqWycdmx7WjMxlzQo4Hepbp5MLA=;
        b=MGiQ7+/4djIxMNoiGQ2HQ5FgX0BiX7MECdXbKPZQNck9BCSf+vD2+mluHPNMzxP+cG
         RI0JpcoQox5J9JpacWYIlNvbSs1OrmSiauOJ68nqJB8tYnVuKuPBYc8FcY1jjqvArHkA
         I6HVsM1vDIu+1mfN0Wl7aQWjh2gsxwta3wtgwqJ9oZ+fcL+3/zZ0LOLgvGnvXFaqMwCj
         hL03GrfM7phnxuW/StGxVHtcBP2ondXPfL4j3l6zj5t+qWg1haT1vASUsL4Qti5hi+nw
         5coIoF1phUpLhxGUIGQtFXzot8Pa+T381k+CAFNX/BgZfUyxMNe2Zr9rrHM2tF0Z1vRx
         MYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uKqWBXY7mffdyrXuPqWycdmx7WjMxlzQo4Hepbp5MLA=;
        b=lw7k7X+fSr0961w937N3mZobLGj5P4mwlnAM3t7kQiL/fJqwF634mGVJzQt/BvIbHJ
         QXqKRIS8KB6nGIHlEwFwF4uVPR9luU9MGZ68gg13F74VvSGNr8c8PAO16klmnI+tFxga
         m6RhXUn7nGqS+YXJV5yAxoX/3ff9T/3SkHuU1/WxyfypWJGDnC8IWJOa+aqUeh5agDBI
         mV3uap3/qM/7zJivFwmRQVkilOdEDxxwCn/22R10UQ/gPayRGJ8qjmlkf1RgQ91spYFu
         9FX6sdCkBUVvxPrPczr0CSjwV7NbBAQJNofZe4d3LZfzJg8biyRtw+ebgb1l/iMDxE+F
         7C0A==
X-Gm-Message-State: AOAM530bzyKdfmvlRxdi/jEH0baNLsW1cBIa9WWV3KkJeCK+0kLjAsd7
        GhXgpKiO6nCu8PP8kbJzhX2cJg==
X-Google-Smtp-Source: ABdhPJwimHlEuo6JCbvv0hg1vOC1+1xFeCDf/huX/AovS5V1x99g1hDelggACAaCxCijehAiqasUPg==
X-Received: by 2002:a05:6a00:1684:b029:18b:665e:5211 with SMTP id k4-20020a056a001684b029018b665e5211mr15948880pfc.20.1605917652295;
        Fri, 20 Nov 2020 16:14:12 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s4sm5432591pjr.44.2020.11.20.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:14:11 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:14:11 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 16:14:07 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Add missing jump label initialization
In-Reply-To: <20201106075359.3401471-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-f4c607c8-ecf6-4eda-88de-4011214fcb33@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020 23:53:59 PST (-0800), Anup Patel wrote:
> The jump_label_init() should be called from setup_arch() very
> early for proper functioning of jump label support.
>
> Fixes: ebc00dde8a97 ("riscv: Add jump-label implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index c424cc6dd833..117f3212a8e4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -75,6 +75,7 @@ void __init setup_arch(char **cmdline_p)
>  	*cmdline_p = boot_command_line;
>
>  	early_ioremap_setup();
> +	jump_label_init();
>  	parse_early_param();
>
>  	efi_init();

Thanks, this is on fixes.
