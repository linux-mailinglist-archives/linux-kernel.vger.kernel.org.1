Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED602D62E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392468AbgLJRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391956AbgLJRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:01:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19FC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:01:15 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d189so6442083oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=U0QCNM5KhsFPlcnPsOFo/BoOZiFJluT00PipTNkVB0Y=;
        b=td1A1r7g1wq1i9r6xaID8Yi6bJNgXJbquHv8nB4OfmOy3HXX3w9UPiCDKtQ+UrLTrs
         avsd39ECJheH9OQAgScvpcItddmYCeaj0Nc5Ft4VLxFCl8ZlNNHhSgvhNEGFnaorY5W4
         xdc2fruQfQMPsq51qbmFD1+Lqq0xTO1w5ZM9Fsh+f4s1rxJ+xNQH0gNDd8Vsm4hOfMSL
         qFQ5+emolKF5RbQXCdAB7V/AIwPubikcAuaKS5BPMYvqopIoGyx9/vvSHmxs865dNl1v
         EOARcUaSAR9PNw5AuoxS9UE7P/GMw5GBO53S7+WnRMn2qhqo5Yj8GwXcCDVpPY9TV3Kw
         A3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=U0QCNM5KhsFPlcnPsOFo/BoOZiFJluT00PipTNkVB0Y=;
        b=mtrEEiFvCPj/3aIzFaFrEeiNiru7X7WklN5VguCZzL4immXNtHeo8OiEFatkdMjKyj
         Ul5V4l1lnvLbxHkM2JkvLtotIb9b9NPI523YuVGnDBOX50FrYmmhMdXPKxqDpiIEp6IC
         iFc9KgIfslVCtBMs8wunIukNdU3JdO9ux6ABwGZ0ZQwBoYezmstl03Z7rFcsq2yoXL5t
         wB0uCpB0vILkoqrx3xvicctZo1onMEm6EBNxkhKBe6+tsboTDCnsMpqae+obIaMDgnhc
         m2snuxAcJlraafwQAz6wRF8UKGeNDa/zz3uoK5oSSIJ9WO2yoB/pujj6mvg22AJ+Aq2K
         cpVw==
X-Gm-Message-State: AOAM5310Q6+qMxYXJUyuPYuQStKR3nA6RQjxksRVma1WPm4RyCudI7FS
        HVapmw3icB31PjCiDSWpnc1kDCzzlVTxPKQYO2gn7B1S
X-Received: by 2002:aca:44d:: with SMTP id 74mt6873790oie.4.1607619675083;
 Thu, 10 Dec 2020 09:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20201207084616.411531-1-conmanx360@gmail.com> <20201207084616.411531-3-conmanx360@gmail.com>
In-Reply-To: <20201207084616.411531-3-conmanx360@gmail.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Thu, 10 Dec 2020 12:01:04 -0500
Message-ID: <CAM8Agx1wF4W=wQuod5-awNzOppe-4h2xD-h4EDZFoaD0pxd0bw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, this patch seems to be a mistake.

I don't know why I thought this was the case.

On Mon, Dec 7, 2020 at 3:46 AM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Make sure GPIO pin for surround channel mute is set to 0 when speaker
> output is selected.
>
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>  sound/pci/hda/patch_ca0132.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 793dc5d501a5..6d647d461eab 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
>                   .has_hda_gpio     = false,
>                   .mmio_gpio_count  = 3,
>                   .mmio_gpio_pin    = { 2, 3, 5 },
> -                 .mmio_gpio_set    = { 1, 1, 0 },
> +                 .mmio_gpio_set    = { 1, 0, 0 },
>                   .scp_cmds_count   = 0,
>                   .has_chipio_write = false,
>                 },
> --
> 2.25.1
>
