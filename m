Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F672F1E15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbhAKSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389276AbhAKSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:31:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DABC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:30:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y23so174181wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=P9oFeHULbHnF3mpaSPkN9EJ0BKLTK0LDx5Zik7ys4lo=;
        b=oQZex2rjAa3eJHkEVIW3W/XqfY8EKPwW2ruwAROac7O4pWoH+ncg0b1MAC9unk89V1
         mMvDptoHYrKqDaTvqa8kFm4MqOIHPcqwN9Phi9++Cp8N3NHpo51VpvB7BDsmQyg1PDnj
         /ZUa8Yfc9np74F2W1qAYVMCOMbV0e7ne6ueLksZMAk6hy6MQSqHisGBCluWvf6N2uMqu
         nlcxiFlFkmRtQ2L/ImoBYXbjIO9Ne6M6AE+qK9JyQT9Cpz7CMXDIIp9QV/FfkU7xW8Ri
         sPlD6CyXil22NX/DHWueIrw3CGJxJTF/O/XTr/V4AaxUGXWaR0Aj5zDkYsag4YDJKGjo
         2nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=P9oFeHULbHnF3mpaSPkN9EJ0BKLTK0LDx5Zik7ys4lo=;
        b=MEwoAYiPdIITHnB9JjBwiuxHICDDe7s3UAIvZpTiU31ushA85n0ee8gBWaDbGA+hvZ
         rZ7s+qt4xC3X0EduGprA8AGW6Yheg7s8eUTfStkVXe1slsDHqaxLeJZ1eYkpdzCu+Jdz
         WOhYOJ/ZNOlYWIzMTGHRnPDAW6DxTna9wk4nzC5Uu5bh+JTjp4UGJLCd9uEXgIu6rzw/
         HG3Q3NbPy91IOtRQRpQ/Jwx7s4uL4A1UsDALeSlmim8K9P2cu4UkdwoFKehKNI0747uM
         QR1NC4gsHiUvWc263iNByO4Xx7taCMKHBbFt4bq9Ko9Tesw1lANqJ0J4zyBOHCHrc2mG
         PISA==
X-Gm-Message-State: AOAM531DoWT+isC7gJzdGXZyMz3g6OUd1oea+e/PcPymXmqs0SrJnwvR
        s8abbyilrpYlylRjfJicjMI=
X-Google-Smtp-Source: ABdhPJxRVdr7zlJVRa/l1U+FQaFGoCVTfcrsn8wixh4Lc9T0xszv3XaRiS4MEYdIEC8lD0kXiCWExA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr119562wmj.19.1610389852982;
        Mon, 11 Jan 2021 10:30:52 -0800 (PST)
Received: from Saturn.fritz.box ([81.221.211.103])
        by smtp.googlemail.com with ESMTPSA id j10sm234244wmj.7.2021.01.11.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:30:52 -0800 (PST)
Message-ID: <147692b37063057ce4128894db112caf9320b65b.camel@gmail.com>
Subject: Re: [PATCH 1/1] ARM: imx: build suspend-imx6.S with arm instruction
 set
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Mon, 11 Jan 2021 19:30:51 +0100
In-Reply-To: <ecc65820-6b94-bb11-f475-aa0296fce5b8@pengutronix.de>
References: <20210111151704.26296-1-max.krummenacher@toradex.com>
         <20210111151704.26296-2-max.krummenacher@toradex.com>
         <ecc65820-6b94-bb11-f475-aa0296fce5b8@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent due to gmail adding HTML, sorry for the noise.

Am Montag, den 11.01.2021, 18:49 +0100 schrieb
Ahmad Fatoum:
> 
> On 11.01.21 16:17, Max Krummenacher wrote:
> > When the kernel is configured to use the Thumb-2 instruction set
> > "suspend-to-memory" fails to resume. Observed on a Colibri iMX6ULL
> > (i.MX 6ULL) and Apalis iMX6 (i.MX 6Q).
> > 
> > It looks like the CPU resumes unconditionally in ARM instruction mode
> > and then chokes on the presented Thumb-2 code it should execute.
> > 
> > Fix this by using the arm instruction set for all code in
> > suspend-imx6.S.
> > 
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > ---
> > 
> >  arch/arm/mach-imx/suspend-imx6.S | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
> > index 1eabf2d2834be..e06f946b75b96 100644
> > --- a/arch/arm/mach-imx/suspend-imx6.S
> > +++ b/arch/arm/mach-imx/suspend-imx6.S
> > @@ -67,6 +67,7 @@
> >  #define MX6Q_CCM_CCR	0x0
> >  
> >  	.align 3
> > +	.arm
> 
> You had a return to thumb at the end of this subroutine in the cover letter,
> yet here it's omitted. Why?

Now the whole subroutine is compiled for ARM and the return address has bit
0 set so that on jumping back to the caller the CPU will switch back to
Thumb-2.

Probably the return to Thumb-2 isn't needed in the cover letter solution
and it would also work to finish the subroutine in ARM instruction set.
However it looks strange to me if a function which begins with the ARM
instruction set would come to the return in Thumb-2.

> 
> >  
> >  	.macro  sync_l2_cache
> >  
> > 

