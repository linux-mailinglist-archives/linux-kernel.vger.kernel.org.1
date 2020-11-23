Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06A52C19A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKWX4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgKWX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:56:15 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A96C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:56:15 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so20016007ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnhR1hhTDdb79Txd40YmmmMbIC/AjLNuqdONwWnI2dg=;
        b=kZ+79z/uBo/qRjmY7Jjq0rAD+9AspnfTp6Dw62PbqgrQK57nOMVbJoQvY4j8kmwJeB
         s3vxfoE4mGEJGt+x+84wAJGICr4wuyd3cRiP0ZB4zw80Dr88IMov5y9wp/i6Ksl+3N6O
         HNPOKbOWzXIWbfPCWIQoqsldoNScc49jdbcEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnhR1hhTDdb79Txd40YmmmMbIC/AjLNuqdONwWnI2dg=;
        b=WQRGT76bL85hADu6vtQVRSCIzq7qVQy/2cYJLzVDmfkiRFPcqs9IsRl33UA2GBEXy2
         j1d0TERu2S3OvzVKYpl3KYOMhy9ZeTBYz5u1rP9SD9YWaehE3Sy2oxuSNuWCbenv4NZU
         ZkYzTQBJQzcH0zHCZi876mFTuYP08+qM0bGZv7E6Sn7QtzBs5VxTcr36UAJ131SLhhuQ
         tNGfro/LzCyGH+DSSf1b41twoI0DIpua5ejUZYNZwIGDMLhaJgdCtdLalCt0IfC29w6+
         AkhniZY+RHr0ZNJqtDNkAGr5mj3ESVqeab7FCaJailxsERmgWQDmo+QJKPcrntRq2FN+
         0I4Q==
X-Gm-Message-State: AOAM530/WWo/KsXbvm/ujXtRCxmiD0JHa/E6/dU0P48Wvj2HEU7biTbW
        cMk1sqf1PaHP//osBIzlOeQItn8A0x2jcQ==
X-Google-Smtp-Source: ABdhPJxW7yDijf3YdWgx04ZRg6UusodZ5vBzNcJpCulw+rw9dJJKc/rTHZaYSUl12+OzypxiUvI5cA==
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr701225ljh.415.1606175773518;
        Mon, 23 Nov 2020 15:56:13 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d22sm123301ljh.44.2020.11.23.15.56.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 15:56:12 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id l11so26371829lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:56:12 -0800 (PST)
X-Received: by 2002:a05:6512:5d7:: with SMTP id o23mr598966lfo.272.1606175772082;
 Mon, 23 Nov 2020 15:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20201013124428.783025-1-acourbot@chromium.org>
In-Reply-To: <20201013124428.783025-1-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 24 Nov 2020 08:56:00 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVM81dQyLJANUH7j8b5uhpk8ERdm9gpsGkF4k1Y-ZkYDQ@mail.gmail.com>
Message-ID: <CAPBb6MVM81dQyLJANUH7j8b5uhpk8ERdm9gpsGkF4k1Y-ZkYDQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] media: mtk-vcodec: fix builds when remoteproc is disabled
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping about this - we are already well into the 5.10 cycle so we
don't have much time left if we want to merge this build breakage
fix...


On Tue, Oct 13, 2020 at 9:44 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> No functional changes since v3, but it does the job at fixing the build
> breakage. :) Please kindly take a look.
>
> Changes since v3:
> * Removed obsolete Acked-bys
> * Fixed indentation in Kconfig file
>
> Changes since v2:
> * Use the FOO || !FOO magic suggested by Hans to ensure a built-in
>   module does not try to link against symbols in a module,
> * Added a patch to split the VPU and SCP ops into their own source files
>   and make the optional build cleaner,
> * Control the build of firmware implementations using two new transparent
>   Kconfig symbols.
>
> Changes since v1:
> * Added Acked-by from Randy.
> * Fixed typo in Kconfig description.
>
> Alexandre Courbot (2):
>   media: mtk-vcodec: move firmware implementations into their own files
>   media: mtk-vcodec: fix build breakage when one of VPU or SCP is
>     enabled
>
>  drivers/media/platform/Kconfig                |  28 ++-
>  drivers/media/platform/mtk-vcodec/Makefile    |  10 +-
>  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |   2 +-
>  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |   2 +-
>  .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 174 +-----------------
>  .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |   7 +-
>  .../platform/mtk-vcodec/mtk_vcodec_fw_priv.h  |  52 ++++++
>  .../platform/mtk-vcodec/mtk_vcodec_fw_scp.c   |  73 ++++++++
>  .../platform/mtk-vcodec/mtk_vcodec_fw_vpu.c   | 109 +++++++++++
>  9 files changed, 277 insertions(+), 180 deletions(-)
>  create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
>  create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
>  create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
>
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
