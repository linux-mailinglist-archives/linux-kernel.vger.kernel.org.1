Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9C2BAE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgKTPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgKTPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:16:02 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EFC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:16:01 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m13so10222178ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvkIOP/BQjTv1vzhil/jbNpm0u7fR43A7TYITMLBF/I=;
        b=jhSa5G4Y7iB3jkInwwKcGaLiphebWNBQASUBnIfeOQYHWOIwnanEB7EZkPypVn0E3G
         TM21rq+CTTmVvcPTr/r/7J/1x+xit/WQQ/SDltQKqMLvr0oeFQD+Ldjm7F3Yup6tWuCA
         +uUV6q7iND8srCqrhp3Vgba9Ehw5u++RVFVz8j3YXqT1JLrJpmPlH7Oh5QJJjKfaEzjN
         pb3gFY90uiK3olPJcNbSFl8YEs/Sj6M5hsYdEA7kFBet5GIKoEZhDFEMaKr1HAsUAadB
         VxLg2TQ2N01RCSfYSra0kq4gWdIKVmDbHxLq9Pj12sRvpJxfVG6iNpNbAsLRE6T9MyBz
         lKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvkIOP/BQjTv1vzhil/jbNpm0u7fR43A7TYITMLBF/I=;
        b=lJkfqOH6TuWKDZNJPANmzkXOT+fdVqpbnQnUYqDHKXIwNTnZtczwMHsfVkuRvFKrQD
         V4B9wChQbrwCVNxHVdQNjI61bUHjV2/rOpu4tB6e5oKuqUWFa1cE3C7U7e+oXEgjuLXR
         KsmybZuOo8xuyWSF8J5+i8MxAFKyllz3UI//mQdmWK/BKAeIm7zj/p1bjeyzHGPBIQRm
         jB7WHxhxVvy8ihyQSiqqw0yR5rszpKOV1rC8FnA1Jy3TyKaRC7pdhpMg8JfL/S64JZeV
         AC+1a6G6RU+tM1FV/mTN3C552n8Pi9L9BlQHJi3vgSanO0pK7F50oBjJEvZVtphze6Bq
         1UUg==
X-Gm-Message-State: AOAM531KzU/QcHd9PuYWL/54Z1fMAi+jTHMfjYR2Ia+pVwMN8C/RZrhz
        /CKKkXpbLllTRpiDcXi3iHSC04ATn9q7KmAiwVeHkQ==
X-Google-Smtp-Source: ABdhPJzpmYxrFIpHcbNNhBq8k3I0UAHRxpoQxKTX3u8IWfhd4Wr21krjkP7KNwzj918RRdobSAeNZjESNs4e6B1965w=
X-Received: by 2002:a5d:8ad6:: with SMTP id e22mr22673857iot.154.1605885360111;
 Fri, 20 Nov 2020 07:16:00 -0800 (PST)
MIME-Version: 1.0
References: <1605839346-10648-1-git-send-email-daoyuan.huang@mediatek.com> <1605839346-10648-3-git-send-email-daoyuan.huang@mediatek.com>
In-Reply-To: <1605839346-10648-3-git-send-email-daoyuan.huang@mediatek.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Fri, 20 Nov 2020 16:15:48 +0100
Message-ID: <CAOwMV_wqv4vJ4Pb3o61Gce7ia3c5wJDWDtapOTqHYRYGNsmYfQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dts: arm64: mt8183: Add Mediatek MDP3 nodes
To:     Daoyuan Huang <daoyuan.huang@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        menghui.lin@mediatek.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        linux-media@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        sj.huang@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, pihsun@chromium.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        randy.wu@mediatek.com, srv_heupstream@mediatek.com,
        acourbot@chromium.org, linux-kernel <linux-kernel@vger.kernel.org>,
        tfiga@chromium.org, ben.lok@mediatek.com, moudy.ho@mediatek.com,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daoyuan,

> Depend on:
>    [1] https://lore.kernel.org/patchwork/patch/1164746/
>    [2] https://patchwork.kernel.org/patch/11703299/
>    [3] https://patchwork.kernel.org/patch/11283773/

Can you provide an updated list of dependencies because it seems this
patch depends on more than the patch aboves. I applied the related
patch series above but there is still missing node
ERROR (phandle_references): /soc/mdp-rdma0@14001000: Reference to
non-existent node or label "scp"
ERROR (phandle_references): /soc/mdp-rdma0@14001000: Reference to
non-existent node or label "mutex"

It would be even better if you could provide a branch with all the
dependencies included.

>                 mmsys: syscon@14000000 {
>                         compatible = "mediatek,mt8183-mmsys", "syscon";
> +                       mdp-comps = "mediatek,mt8183-mdp-dl",
> +                                   "mediatek,mt8183-mdp-dl";
> +                       mdp-comp-ids = <0 1>;
>                         reg = <0 0x14000000 0 0x1000>;
> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>                         #clock-cells = <1>;
> +                       clocks = <&mmsys CLK_MM_MDP_DL_TXCK>,
> +                                <&mmsys CLK_MM_MDP_DL_RX>,
> +                                <&mmsys CLK_MM_IPU_DL_TXCK>,
> +                                <&mmsys CLK_MM_IPU_DL_RX>;
> +               };

The kernel is not booting anymore when the 4 clocks above are added,
if I remove them I can boot again. See the following log:

[    0.401314] Unable to handle kernel paging request at virtual
address fffffffffffffffe
[    0.402320] Mem abort info:
[    0.402674]   ESR = 0x96000004
[    0.403062]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.403741]   SET = 0, FnV = 0
[    0.404128]   EA = 0, S1PTW = 0
[    0.404526] Data abort info:
[    0.404890]   ISV = 0, ISS = 0x00000004
[    0.405374]   CM = 0, WnR = 0
[    0.405751] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000415ee000
[    0.406595] [fffffffffffffffe] pgd=0000000000000000, p4d=0000000000000000
[    0.407457] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.408160] Modules linked in:
[    0.408551] CPU: 4 PID: 51 Comm: kworker/4:1 Not tainted
5.9.0-mtk-00010-g121ba830623e-dirty #2
[    0.409646] Hardware name: MediaTek MT8183 evaluation board (DT)
[    0.410416] Workqueue: events deferred_probe_work_func
[    0.411067] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
[    0.411772] pc : clk_prepare+0x18/0x44
[    0.412252] lr : scpsys_power_on+0x1e8/0x470
[    0.412791] sp : ffff800011fa3a20
[    0.413209] x29: ffff800011fa3a20 x28: 0000000000000000
[    0.413881] x27: 0000000000000000 x26: 0000000000000000
[    0.414551] x25: ffff00007a23ade0 x24: ffff00007a223b80
[    0.415222] x23: ffff800011f5d30c x22: ffff00007a23a888
[    0.415892] x21: fffffffffffffffe x20: 0000000000000000
[    0.416563] x19: 0000000000000000 x18: 0000000000000020
[    0.417233] x17: 0000000000000020 x16: 0000000052d9c4c7
[    0.417904] x15: 0000000000000059 x14: ffff00007a23a640
[    0.418575] x13: ffff00007a23a5c0 x12: 0000000000000000
[    0.419245] x11: ffff8000108331c0 x10: ffff800010833030
[    0.419916] x9 : 0000000000000000 x8 : ffff00007a751c00
[    0.420587] x7 : ffff800011fa3a70 x6 : 00000000130f968d
[    0.421257] x5 : ffff8000110043f0 x4 : 0000000000000184
[    0.421927] x3 : 0000000000000000 x2 : 0000000000000008
[    0.422598] x1 : 000000000000000d x0 : fffffffffffffffe
[    0.423268] Call trace:
[    0.423581]  clk_prepare+0x18/0x44
[    0.424014]  scpsys_power_on+0x1e8/0x470
[    0.424511]  scpsys_probe+0x3f4/0x66c
[    0.424975]  platform_drv_probe+0x54/0xb0
[    0.425483]  really_probe+0xe4/0x490
[    0.425937]  driver_probe_device+0x58/0xc0
[    0.426456]  __device_attach_driver+0xa8/0x10c
[    0.427019]  bus_for_each_drv+0x78/0xcc
[    0.427504]  __device_attach+0xdc/0x180
[    0.427990]  device_initial_probe+0x14/0x20
[    0.428521]  bus_probe_device+0x9c/0xa4
[    0.429007]  deferred_probe_work_func+0x74/0xb0
[    0.429582]  process_one_work+0x1cc/0x350
[    0.430090]  worker_thread+0x2c0/0x470
[    0.430565]  kthread+0x154/0x160
[    0.430976]  ret_from_fork+0x10/0x30
[    0.431431] Code: 910003fd f9000bf3 52800013 b40000e0 (f9400013)
[    0.432200] ---[ end trace d3ecf925b254a559 ]---
