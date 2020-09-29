Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66A427D96E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgI2U6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgI2U6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:51 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id i17so7026585oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF+VZmXpgymJXg5aSsVulYHNq+hO9Tbc9xQXXJOCUZ4=;
        b=mInI0AoNfBUI+EKslq8H7DHgvuWSGjgNqxvau/3r8lHinq5SMMEODdYvE0w4ds1ph0
         bXaFU4uBsYTiKWX5Ksr19j6GHSvWUpIz1ALcVpcnNEkhoNNYKY/P2pasmFC2/nNy1sTW
         2wGznZJyM0988xq+2T+R339D2ifk/lNsu/YtvEqscd3DKsL9jKozQ0lhcihO6nkSl2hf
         ZzoJxAVBmwgi81yztTmMrkPosjWyExrQVJsHNITRR8N0atRCFkWdBiW5HJuCjj84HRb5
         3Ft/g0nINMlEnbXCJUX1j42BtwV00T7Y1lrgZJ82E+kLrwDKIyRrkFTr6NtUpm90G5od
         H5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF+VZmXpgymJXg5aSsVulYHNq+hO9Tbc9xQXXJOCUZ4=;
        b=co6/fXXZm66B7xKc4sG6o1TWWwXz4d0HXchEa6rSm7kPzNNCQU05bdItXiaq1N9Z+0
         uGs90ymui2E8Y344y23A4sQtP0Oc/Z+jVqmORsAE9o5bqMgdAYbLkbGw0D/pD57GMAF3
         aWRrhpzKPGIxpy8pZeSr1H3wnOMm4a/UFPzfyvVkEXLpHUKrgOiSzLzLMGAMu1bkp9w9
         5AyQmik+Hq0awonyhTPyml53HtvFzIyxTMKMn+ehxfO3kOMrB/BCHcyOjnIBMVVDTepr
         5T8JagboliK42U6yCrqcptCjU+M0wtIzoBaUIsTZekQfLm72aJs7E82vbG8lu8246gvS
         zAGw==
X-Gm-Message-State: AOAM531rSjS/WYCOD0WQvsNOWEU1djvVEEXrFI7zTouaf7EaOFXyiF4m
        cskNltU3XvMy3kqgibvAUEC1nqwMxjDFGLkXgy2hVCIyMuQ=
X-Google-Smtp-Source: ABdhPJzG8XP2y29F+O2CyhTKWe1jGvAylif/OT4/LaXa6GOtvVpQmsp5tw1iXcqpLSFz3OF6J4rF3/ldGLjSufCyscw=
X-Received: by 2002:a05:6808:3bb:: with SMTP id n27mr3642294oie.130.1601413130639;
 Tue, 29 Sep 2020 13:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925171415.25663-1-oded.gabbay@gmail.com>
In-Reply-To: <20200925171415.25663-1-oded.gabbay@gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 29 Sep 2020 23:58:22 +0300
Message-ID: <CAFCwf12jX9sg8xjh4AGQvzyJaCu=bZaf+HjBqeauxV4Ry0A5qQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi: use correct define for qman init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 8:14 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> There was a copy-paste error, and the wrong define was used for
> initializing the QMAN.
>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index a227806be328..5f65a1691551 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -2039,7 +2039,7 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
>                 WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
>                                                         QMAN_LDMA_SRC_OFFSET);
>                 WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
> -                                                       QMAN_LDMA_SIZE_OFFSET);
> +                                                       QMAN_LDMA_DST_OFFSET);
>
>                 /* Configure RAZWI IRQ */
>                 dma_qm_err_cfg = HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
> --
> 2.17.1
>

Hi Greg,
Do you think you can apply this patch directly to your char-misc-next
branch before the merge window opens ?
I don't have anything pending and I don't want to send a pull request
for a single patch.

Thanks,
Oded
