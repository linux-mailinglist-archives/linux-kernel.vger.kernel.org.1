Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB272C36F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKYCxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKYCxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:53:33 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54986C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:53:33 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so930859ejg.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KerQ9Iv5uRC8y/oyJ5H9vFpn79bTM4xjZkKRVKH2tQ0=;
        b=lF0N4JHRQSynJbooJkAKI2A7bPU13aiKpsjkPlZxgP6u4rbyjSZ2peN4RjKOQXRjIJ
         j3kFWWmkKbwG3L+Jkh/BV3g1xglRPCydH/R40zQdDa5cXvoDkWeu7r+FvYtVgy4UTd66
         UtSGGBEqbG2G6G9q0pYlF1H0vLnJ+0f8P9UU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KerQ9Iv5uRC8y/oyJ5H9vFpn79bTM4xjZkKRVKH2tQ0=;
        b=nsAb6k+SlpDtyGggfHdCL9uaINl+57LQ2IZZW/Y711JFAaUpsstx1s2wwQ68+Ke+BC
         DU7Z7NwlTpwPEWBRz4Hwr96yv0uBfVUnhAEOUQxMJnZi4J3ZCD4+Td4UPccmy+sd5/y3
         gGcpwOlPEqgH19ILMVrrawvc9l18GtzWShI94Xb920mecENOrPNxUx2CHeH1MIojfbHL
         ZT5r7+pmKNt8b7KShshKiPnwqqW6xyS9LOzeO0DYEb/qDlPYDWAJEi+WSFsh+ZdBdqnX
         t39AAveWGFqNLF8OuPySOzBiuNPcp0QMbieGENBrJkwJ3guUlyTXkUmUgos2g27o0BEa
         n3uw==
X-Gm-Message-State: AOAM532RuJP6+K2kOhVtAmE25DI59o+pGqFGBVgQ6sJvJN7WeSE1/1wf
        W+bG9X4iEUt4UN8WOEyAj8FKcx+xUlgeIcdl
X-Google-Smtp-Source: ABdhPJzEMVUMXDy/LwSvDuGRu0E0axZbbCrhxYPtkGmFtH6+p9mqGFz5rET/H2y6YS9Wd3snMWvWWg==
X-Received: by 2002:a17:906:1183:: with SMTP id n3mr1336533eja.188.1606272811862;
        Tue, 24 Nov 2020 18:53:31 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id o3sm368963edj.41.2020.11.24.18.53.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 18:53:31 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id 23so403095wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:53:31 -0800 (PST)
X-Received: by 2002:a2e:b4c6:: with SMTP id r6mr511760ljm.248.1606272413969;
 Tue, 24 Nov 2020 18:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20201029011721.6705-1-irui.wang@mediatek.com> <20201029011721.6705-2-irui.wang@mediatek.com>
In-Reply-To: <20201029011721.6705-2-irui.wang@mediatek.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 25 Nov 2020 11:46:43 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWGNH180gtmonmO=40dD7fAscTsvvYE=sj8+i5WeR5x1Q@mail.gmail.com>
Message-ID: <CAPBb6MWGNH180gtmonmO=40dD7fAscTsvvYE=sj8+i5WeR5x1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: mtk-vpu: dump VPU status when IPI times out
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
> when IPI time out, dump VPU status to get more debug information
>
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
