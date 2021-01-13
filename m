Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F892F4EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbhAMP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:29:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbhAMP3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:29:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 124E2233F6;
        Wed, 13 Jan 2021 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551706;
        bh=Mg2ARogJlO660LgGnPMrdN+6ikF0b/JxVj+vxajyk+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZcVw6Lmqm06Cwx5kwFDHc7g8QO7QcfdqfDCEbWK6E61+n27+/N5vRQPntpD9SbrKI
         ABSRfhvQzozbH6dX5PN7rXGr6BjLU1ByuA6n7XQrTW0zSnH9R9dP0pWXq688j/KPv0
         qU/4Mg2JnZeG3NSUd71XnRBTKbaiagC+VLGTAf7RFYkiF1P+EGBSU2YdMIU9jwngJE
         IzwvZWaNRt/nRG3tTJa7RqhR9pZ5prVYX/36ahpqhJptAqYZc2Uh7pMRLfqmUOeAg/
         vuR7hxhMS9bKcKU/UTpkpRjuD1HRWpOizh3Rp4dJaht1WqnDnDJWMevIRiAflvG7h0
         VKoiv+bGw6U4Q==
Received: by mail-ej1-f43.google.com with SMTP id jx16so3611408ejb.10;
        Wed, 13 Jan 2021 07:28:25 -0800 (PST)
X-Gm-Message-State: AOAM5302w6yjcwc5vMBVUlpEsgGdVA4dwN52zCJKWT6CtrJCs7Gne8x9
        cs1H2OV+zX6az1CULZDIP+n9XWfCc8UamHuftg==
X-Google-Smtp-Source: ABdhPJwSNSW5WjoC5vVbpHCVn5f5VMr7QuBDfdON7GWyYQI8ef3yATBL0johH1JdQeAE83K0V4Og53LZq9AnwQ2itKw=
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr1962502ejb.194.1610551704525;
 Wed, 13 Jan 2021 07:28:24 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
 <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com> <20210112144921.GA330210@robh.at.kernel.org>
In-Reply-To: <20210112144921.GA330210@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 13 Jan 2021 23:28:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=TJw6Hj5UOWSJJh_O6B0Ue43LhtCpJwtJiG-93-kgAg@mail.gmail.com>
Message-ID: <CAAOTY_9=TJw6Hj5UOWSJJh_O6B0Ue43LhtCpJwtJiG-93-kgAg@mail.gmail.com>
Subject: Re: [PATCH v9, 01/11] dt-bindings: mediatek: add rdma-fifo-size
 description for mt8183 display
To:     Rob Herring <robh@kernel.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8812=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 07 Jan 2021 11:11:11 +0800, Yongqiang Niu wrote:
> > rdma fifo size may be different even in same SOC, add this
> > property to the corresponding rdma

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 +=
++++++++
> >  1 file changed, 9 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
