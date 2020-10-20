Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D7293AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405053AbgJTMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404943AbgJTMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:01:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:01:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v22so688957ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjrnApYSSHfkJA9XyzMImP/Ax8x/fHdiuRCtnfYhIS4=;
        b=ioeZItDIsacnc+ENFAmDhOgyQASCUSk3Z1BgUOm4DdrgPZbdiJ/IZ44dXDV9yQ+z3+
         50KwyPtNBGtvVWcK1DO4rB4ieZ9e1qZxvQBWgb5Uh0kI7Vd8DBiB81GpFutmVmAyIlZh
         mEblSrD1U8ZCJxs+1MvD8Ix90AJKHcwvLtc9xZh3RFW84FC05WyeDvGyYdIbRb89Z7/G
         52JI8j8NJFln+cwTmbvrSeGmNi9m2q1pCxfXG/IIlgNyyLaGtrROlWJIlAP7H4Pt9git
         6aZTgrVAjhE4atU4+xx2iIB/8LW0G+R7JoqnSJIohscrn6sR4UMCL+j8ksT96LpaZ4uI
         Q7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjrnApYSSHfkJA9XyzMImP/Ax8x/fHdiuRCtnfYhIS4=;
        b=GDmu0cX+Nd7enF5CoVRQyIGoQLd8+941SfmkObgTv6NDErcLvqUADwnKD6/EH0J9rI
         zwdZac4NyEd87TQPJ1OWlAVHMArVWr7kz4j1BoETyNSMVO44/hFwwIuCYl/9RBoQD32z
         fK/sLrtBEHSNWT7Ym9TJ8gLea01bw2nxWl1nTdFVC7Y/IvVt8lAkh2cgKZ9Jv+dxFCFq
         60ldgmXI/OegRABy69xlSmFXukmTHcpVVvBNrBNxz7wUcAu5QC3VOHpSCoUzXEQwESzn
         QtsYAwihuEzQMg320T8oWBv33R0uQdIT2qbBPcUErZ0qDv6+mNJcVKAZM2wSiltdHnvu
         RWow==
X-Gm-Message-State: AOAM533zXv5gh2qR9HMc7zpue1EGmyJ/Z7aL54W10lRnIpdkyo6BybCG
        Nzu1TcYm4KeZzeP17k4TVqGTppWe4Wq0llG4CBWCUQ==
X-Google-Smtp-Source: ABdhPJylQnQikBvrUcz3Q0APww40MI9CIQFOSnDz0xGU3cktgRGBrt4LRDoniVI18vWIkMWdmQg3cUSidXa6Z271tts=
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr2452586pja.75.1603195307474;
 Tue, 20 Oct 2020 05:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201018125237.16717-1-kholk11@gmail.com>
In-Reply-To: <20201018125237.16717-1-kholk11@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 20 Oct 2020 14:01:36 +0200
Message-ID: <CAG3jFyvY1Uq=3V=tkCzRwOK0Zpqy+wEd=tjjr04w8pHrz=LARg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for SDM630/660 Camera Subsystem
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

Thanks for submitting this, and fixing other issues as you went.

I sent out some SoBs which should have been Reviewed-bys, so if you
add them to your commit please replace the SoBs with RBs.


Rob.

On Sun, 18 Oct 2020 at 14:52, <kholk11@gmail.com> wrote:
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
> AngeloGioacchino Del Regno (6):
>   media: camss: csiphy-3ph: Add support for SDM630/660
>   media: camss: ispif: Correctly reset based on the VFE ID
>   media: camss: vfe: Add support for VFE 4.8
>   media: camss: Add support for SDM630/636/660 camera subsystem
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
>  .../media/platform/qcom/camss/camss-vfe-4-7.c | 129 ++++++++++-
>  drivers/media/platform/qcom/camss/camss-vfe.c |  19 +-
>  drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
>  .../media/platform/qcom/camss/camss-video.c   |   3 +-
>  drivers/media/platform/qcom/camss/camss.c     | 206 +++++++++++++++++-
>  drivers/media/platform/qcom/camss/camss.h     |   1 +
>  13 files changed, 448 insertions(+), 62 deletions(-)
>
> --
> 2.28.0
>
