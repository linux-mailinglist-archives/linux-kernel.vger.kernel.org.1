Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436F1274D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIVX0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:26:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44841 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVX0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:26:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id a2so17239989otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SamQd9yumyVgToTjIG4vxblKvHqR/B5AoVapHfT4xTw=;
        b=scXfIj8yQ3tF/HcygFmYjIoBzpjpn2WkwX9ILyf0WqXJRNbUS7xATDdcCsIrbx+H2L
         g51zl1MwNPHRJQ29JLlhSqPLM2FWP0tjLmThRMJlp3m7DAfFqD5NpFQer/Ffl3HPCmIP
         wtwxSHfoNpMOWKzowfc7JAOdDpXfHI9G6bfqs8BaKKp5PCEvmbc3ONbNDAQeZLgIN2iz
         9n4pJEwThV8iQ/1CdRoQP5QwAi8pQC+VfbZ8N86GfJE5TxJdV5F000ucX8r7v2gwW5Y0
         nB4lyp5E21V9XRlj0fCIkKPoiJ3Eu8xClrF+OldC2KBLaGN47gxcMoxoWtC/9+LWrDQR
         Gokg==
X-Gm-Message-State: AOAM530M9Bdjj49MRidMlfRNHoxlSe/x7aj3ngmssQPzA1vdg1rfF+Wf
        Or4OYJmUZA2671oUf0iHOlLT3PtgA+ogwA==
X-Google-Smtp-Source: ABdhPJy69WvpUb0XlMyexgzIAKO8iRAt4ETgVulK3fNPmIyYadXg8sz312FXuQuL5uEslXTIe+bubQ==
X-Received: by 2002:a9d:66d4:: with SMTP id t20mr4122378otm.133.1600817160158;
        Tue, 22 Sep 2020 16:26:00 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id y84sm3119048oia.10.2020.09.22.16.25.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 16:25:59 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id u25so17269843otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:25:59 -0700 (PDT)
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4552241oti.63.1600817158862;
 Tue, 22 Sep 2020 16:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135644.58878-1-wanghai38@huawei.com>
In-Reply-To: <20200804135644.58878-1-wanghai38@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 22 Sep 2020 18:25:46 -0500
X-Gmail-Original-Message-ID: <CADRPPNSph1VrSgM-_p+in0GqzXi5AKrxCf4SamYmAfB3FOy0Eg@mail.gmail.com>
Message-ID: <CADRPPNSph1VrSgM-_p+in0GqzXi5AKrxCf4SamYmAfB3FOy0Eg@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: qe: Remove unnessesary check in ucc_set_tdm_rxtx_clk
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Zhao Qiang <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 9:04 AM Wang Hai <wanghai38@huawei.com> wrote:
>
> Fix smatch warning:
>
> drivers/soc/fsl/qe/ucc.c:526
>  ucc_set_tdm_rxtx_clk() warn: unsigned 'tdm_num' is never less than zero.
>
> 'tdm_num' is u32 type, never less than zero.
>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/qe/ucc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index cac0fb7693a0..21dbcd787cd5 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -523,7 +523,7 @@ int ucc_set_tdm_rxtx_clk(u32 tdm_num, enum qe_clock clock,
>
>         qe_mux_reg = &qe_immr->qmx;
>
> -       if (tdm_num > 7 || tdm_num < 0)
> +       if (tdm_num > 7)
>                 return -EINVAL;
>
>         /* The communications direction must be RX or TX */
> --
> 2.17.1
>
