Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E82F767B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbhAOKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAOKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:18:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD040C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:18:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r4so7106888wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqH714PYK9AN3xEW+SZ/vpTilG38WEqVTfd4SHibhpU=;
        b=k8kyRSzrnG765BGTIPNhq6tt7jXTRJHBPp4MqW4LtK6qXVxSLqkAAGHtK6GcnTv/x7
         ckZIyS2Vbzdl78O7H+mh57H2ZmsTu31Wu6EdtppM3KCswyenJkKrr2moN5ZqLi7ua0G1
         UfjX6XCNJSyaT+UCv12mVSpoWQzfE6tvufWfSfsWPIngwcTvFXRuEi5jcqVJ1H2y+w+M
         f9gOCGXaNPYYzxmL5F4d8JNtVP2sHej+pAM5enJmATHG4Ts7NV5IdTcQ7UeuoYJ1rsE6
         X46SYJW4COFQZv4JOx7Qo0G1PtVv2p/KHtnGo3S1+oBHgOfAHLoMjuU/7a5qgziSq7UU
         JV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqH714PYK9AN3xEW+SZ/vpTilG38WEqVTfd4SHibhpU=;
        b=Fp8cSI3mBn9e2MnJJ5gUXb8uIZtLexGmC/YeHoSAXdxxF8Z6y1IN5WAWZSPmL5VGhU
         PpxqFm8wmy/fjoHvoSJZmMozCeHETSNB8yclhOUPvJegKAivnJNouPWZiIw/gdRgYFpo
         TGX8jHWYVUKRcxC95zZZeGlXjcA6kZLdX29MRAzUaSDe6l4OWjZGs7fo7919sQblMR5W
         6TBxRVtRDs3+IkBDrhSUzcp8zhwxRKU3viEjaKiu4XiAQfK33d5Iye5SxOGZbEGG/S23
         gTbNVqKFFtNxwf3IKovcG43wX+EVwXf7MF65PMyW8ADSLCjuhdDTEglqse3gS9LqEZRb
         pkEw==
X-Gm-Message-State: AOAM5337e9IDBl1Un0AlnNFNTqF/dbgkWZCI5naEtkodMIvSwgsL/FOm
        UCR0gFu5ctF2wPouVJ3HzzBWpqwlg76mXQO3mfYC6Q==
X-Google-Smtp-Source: ABdhPJxYWzDRdgGlzCf8uk9kNIzYgdLFZbmwDSF/f2ysaeKZwjAgLQjIZthiqy8sag3DXUvMAfB6+kPI+hUZMBj9faA=
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr8124506wmk.31.1610705888619;
 Fri, 15 Jan 2021 02:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20210115083933.50522-1-zhang.lyra@gmail.com>
In-Reply-To: <20210115083933.50522-1-zhang.lyra@gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 15 Jan 2021 10:17:57 +0000
Message-ID: <CAJ9a7VgxqZw7F8P2TE_javqq-XqunOupu8iKgyMppb211gserw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bin Ji <bin.ji@unisoc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Fri, 15 Jan 2021 at 08:39, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Bin Ji <bin.ji@unisoc.com>
>
> Add ETM amba id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).
>
> Signed-off-by: Bin Ji <bin.ji@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff17cf6..66c6641c71ea 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1709,9 +1709,11 @@ static int etm4_remove(struct amba_device *adev)
>
>  static const struct amba_id etm4_ids[] = {
>         CS_AMBA_ID(0x000bb95d),                 /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bbd05),                 /* Cortex-A55 */

Use AMBA_UCI_ID(). See UCI  comment below.

>         CS_AMBA_ID(0x000bb95e),                 /* Cortex-A57 */
>         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
>         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> +       CS_AMBA_ID(0x000bbd0a),                 /* Cortex-A75 */

This AMBA ID is used for PMU, ETM, debug block and CTI for this core.
Please use the CS_AMBA_UCI_ID macro to correctly identify this
component.
See CoreSight 3.0 Architecture Manual 3.0 (IHI 0029E) section B2.1.2
for an explanation of UCI.

Regards

Mike



>         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
>         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
>         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> --
> 2.25.1
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
