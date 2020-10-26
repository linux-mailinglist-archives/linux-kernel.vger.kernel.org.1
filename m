Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D62299757
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgJZTub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:50:31 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33359 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgJZTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:50:31 -0400
Received: by mail-pj1-f68.google.com with SMTP id k8so2058591pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlpTSDPfA0UrBOKMG6J79aMdLO6WWnbzuFkDbchHp4c=;
        b=b5LA8oRftaz6Vkp7FSDYjIdNtYZup3hkcqo74rSDdXpfCVE/1t5tFU2/kX5foF4QSM
         Ci629Gr/wY//Cp7rtHlzuOm4b/QoxC5Lmpbb34b7UsqKdT4G9WCig9ezpomztxykxdbm
         ROx07IWYKt8LSokAhrEUsjR06qeunt397stKbNaGEdd/FICK9iqT0UJt7KXp/+Fm7Atz
         KF130+q84KImCUlZLudjKJZuXpg/dIQnkTkkJkQpf0CuSU4A/Qiqow8VUit8oEMroNCx
         3nCYLqbclfeVGls496Bf+FB/Vnq1nQAn1U3aD0hx9WrKl3Xy2eU5YQvjJIs1fntLbDEa
         ZLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlpTSDPfA0UrBOKMG6J79aMdLO6WWnbzuFkDbchHp4c=;
        b=kpOoGHsSQE7OwDV5OI0VVowrbo7+uDN65CoHKGOwWPCZDXpt0RshIuvUm235gQYKNG
         ab4hzxTUWfx039gijsu2Xn0cG2CFvwdq9sIwnw309xwNDRx8GklIAs+vybLEGOXZBtVE
         siIGfgUpaLFxXVFCdKWAAuhcB10d3zVO699BZBHgbBXL957mhvP7luz4Jq8bCnDEjdFA
         6vHlgJAlLLRI4fl7blBabXdfCL8AI4rwaZL/d0RxS1xuk1ttDEjhZnkvO2/1FtT5L6SA
         khK+KYaaSgLM5P9/0X+HjI+L0c+YvrotxnxRntFd85N9ayh7u5hIEWKKsDY6SdKzXoMr
         45Jw==
X-Gm-Message-State: AOAM530YjMmHdMUvWn6IOYn4O/7hjabOAAverF0O6OOS54RUMPa1tnyi
        UEtiVUYLlQ1vDfnWe6v4ifi+mFTnO+U3aieJHHzW7w==
X-Google-Smtp-Source: ABdhPJwIiThTbhw+igCvl9C27O7ZcOpplD58EFuW1KI6p+s7uLzuPmvh5EXboo7kHLxLMIgbUZU0/EZ/lH2yKhGnEZU=
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr17980256pja.75.1603741829917;
 Mon, 26 Oct 2020 12:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201022174706.8813-1-kholk11@gmail.com>
In-Reply-To: <20201022174706.8813-1-kholk11@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 26 Oct 2020 20:50:19 +0100
Message-ID: <CAG3jFyvePZ8OZ+0_8pK7t=-UECd5q8tZ4a=c-dbMcNm6pgfnrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add support for SDM630/660 Camera Subsystem
To:     kholk11@gmail.com
Cc:     Todor Tomov <todor.too@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        linux-arm-msm@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Angelo,

I can't functionally test the code myself, but the series looks good to me now.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Thu, 22 Oct 2020 at 19:47, <kholk11@gmail.com> wrote:
>
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
>
> This patch series implements support for the entire camera subsystem
> found in SDM630/636/660 and SDA variants, including CSIPHY 3-Phase,
> CSID v5.0, ISPIF 3.0 (though it didn't need any adaptation) and
> VFE 4.8.
>
> One small note about VFE4.8, even if I wrote it in the commit that
> adds support for it: I know, the VFE support here is split in
> multiple files having the name of the actual VFE version that it is
> targeting... but it didn't feel right to commonize the VFE 4.7 file
> and make another one only for VFE4.8, when it's just about something
> like 3 small differences.
> That VFE 4.8 seems to be just a minor revision of VFE 4.7.
>
> While at it, also fix a small issue when using two VFEs: only one
> of them was being resetted (always VFE0) so, after the first usage
> of VFE1, in case we leave it in a bad state, it would not properly
> start again. Now... it's fine :)))
>
> P.S.: SDM630/660's camss seems to be *very* similar to MSM8998, so
>       likely 90% of this series should be reusable on that one, too!
>
> Tested on:
>  - Sony Xperia XA2 (IMX300 on CSI0/PHY0/VFE0, IMX219 on CSI2,PHY2,VFE1)
>    * VFE0/1 RDI only, as the VIDEO one does not work with SRGGB Bayer
>      formats yet. As far as I can see, that color format hasn't been
>      implemented yet in the video interface.
>
> Changes in v2:
>  - Splitted out VFE 4.7 functions rename from the VFE 4.8 support commit
>  - Moved a commit so that sequentially picking patches from this series
>    still results in buildable code (heh, oops! sorry!)
>  - Fixed ispif reset commit (moved the fix for itfrom the wrong commit
>    to the right one: that was a "funny" overlook).
>
> AngeloGioacchino Del Regno (7):
>   media: camss: ispif: Correctly reset based on the VFE ID
>   media: camss: vfe-4-7: Rename get_ub_size, set_qos, set_ds, wm_enable
>   media: camss: vfe: Add support for VFE 4.8
>   media: camss: Add support for SDM630/636/660 camera subsystem
>   media: camss: csiphy-3ph: Add support for SDM630/660
>   media: dt-bindings: media: qcom,camss: Add bindings for SDM660 camss
>   media: camss: csiphy: Set rate on csiX_phy clock on SDM630/660
>
>  .../devicetree/bindings/media/qcom,camss.txt  |   7 +
>  .../media/platform/qcom/camss/camss-csid.c    |   9 +-
>  .../qcom/camss/camss-csiphy-3ph-1-0.c         |   7 +-
>  .../media/platform/qcom/camss/camss-csiphy.c  |  25 ++-
>  .../media/platform/qcom/camss/camss-csiphy.h  |   1 +
>  .../media/platform/qcom/camss/camss-ispif.c   | 100 ++++++---
>  .../media/platform/qcom/camss/camss-ispif.h   |   2 +-
>  .../media/platform/qcom/camss/camss-vfe-4-7.c | 131 ++++++++++-
>  drivers/media/platform/qcom/camss/camss-vfe.c |  19 +-
>  drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
>  .../media/platform/qcom/camss/camss-video.c   |   3 +-
>  drivers/media/platform/qcom/camss/camss.c     | 206 +++++++++++++++++-
>  drivers/media/platform/qcom/camss/camss.h     |   1 +
>  13 files changed, 450 insertions(+), 62 deletions(-)
>
> --
> 2.28.0
>
