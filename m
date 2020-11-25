Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0760A2C36E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKYCrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKYCrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:47:02 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083AEC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:46:55 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so981535lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dQmAVJ9OckwzlsSurqMxYhM29m2a8+zop97yPgBPXE=;
        b=is2GV9Ek/3+TGGREZr6N5mvtJvamdlWs9daD92dvW95+w6beQEyLcxiISgdLMGkXgy
         5bMZ+gwNfMqbTv08fpW4D3FqybduxqI/zRiy2q18DN5f7QWmDIY308p4r4X8YuGc+WJ+
         VUn7mq2EvDUHE4BE6O9j4CulfiId7FWuYBkD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dQmAVJ9OckwzlsSurqMxYhM29m2a8+zop97yPgBPXE=;
        b=HN2X5KG9Z4uyn6zHjSlew32ME+zoN0dr7neLzhmBjMTKHyGvAt3nBvjbcmd599Oxbj
         kpIg5L+EfNdZ7ouB6jQHa5NXUA8uJ9m6lbV14N78EE2FMYRd8vsdYwuWz4GPbTo+LOcG
         fv4mM8PDfw1q8zCrXADRzU7GB3sYWxtd8g6AXJUSwsKdZOeQ+eDWfinXnPzrC3JLFSMD
         rlHvCTLvyhf9ZGrSsA1xTftO+ItyCASclQ3krUdJ6RRwNvRB8XdxQNDDR5R028RXngNJ
         dVpngSkreJn5HgkBaNRmSczyUakjwzyRo7933PfWmbPJvtO7BEy2BoeZW/vDxcfQWFJY
         pt3w==
X-Gm-Message-State: AOAM533KjV37RP33sLnHY1edEifta4SxZpKTNzLPIFsTa1KOX0gkp/jZ
        s3V3DV5bx/yFCLpzsIPgZ8+uRAPjiw2xnQ==
X-Google-Smtp-Source: ABdhPJyc8VwD92qYif4kl/1veqSyfl9nz/IibFVEdiCE3AhFs16gmLl/IooTTNZFceRjrLpFBuFumg==
X-Received: by 2002:a05:6512:210b:: with SMTP id q11mr473457lfr.238.1606272412077;
        Tue, 24 Nov 2020 18:46:52 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z7sm90467lfq.50.2020.11.24.18.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 18:46:50 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 142so660567ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:46:50 -0800 (PST)
X-Received: by 2002:a2e:8115:: with SMTP id d21mr434973ljg.379.1606272410338;
 Tue, 24 Nov 2020 18:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20201029011721.6705-1-irui.wang@mediatek.com>
In-Reply-To: <20201029011721.6705-1-irui.wang@mediatek.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 25 Nov 2020 11:46:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXQadf+0xP3VXAWwaew-OFrFGu-yPZfjXNtMqcfpjzQGg@mail.gmail.com>
Message-ID: <CAPBb6MXQadf+0xP3VXAWwaew-OFrFGu-yPZfjXNtMqcfpjzQGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: mtk-vpu: VPU should be in idle state before
 system is suspended
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maoguang.Meng@mediatek.com, Longfei.Wang@mediatek.com,
        Yunfei.Dong@mediatek.com, Andrew-CT.Chen@mediatek.com,
        erin.lo@mediatek.com, PoChun.Lin@mediatek.com,
        houlong.wei@mediatek.com, hsinyi@google.com,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:17 AM Irui Wang <irui.wang@mediatek.com> wrote:
>
> VPU should be in idle state before system is suspended
> or it will work abnormally like VPU program counter not
> in a correct address or VPU reset
>
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
