Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516DC28CBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgJMKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJMKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:41:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F70C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:41:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so14803235wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGnQd8MQizROEGVqO6LoZ2ESTC7FDdoCCXNt1igE99k=;
        b=gyi1yunutoZhUD0/UEF8Y2W7tQM6TS5jmKeONpakXd2rTbWB+a2FoTlYShvboHRUjb
         o+OiIauitVyuRzkw2wlp8deQWzBGISweHB6VZlAgDRaF0NoeuVxg847l/A2/LVMRQJqe
         042rOdRRsmODzQaUz5KmsV7PXCm2iIfq/P9NJvooXN0tU08fjejHSQ+S9ueQ+aE27whw
         px2Vdl4kOBetB0bVfcXL//2xS1Y1bR9G5Y4/SYldp92Mjw39RR00M5wScVXdpvR7CZUV
         HboDSnXSXkCB4XgTJW74jjaWEffi5v3Pi6A7v7NtoKMWoS6bakwtXPTJFSMiRY2Akdqr
         3LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGnQd8MQizROEGVqO6LoZ2ESTC7FDdoCCXNt1igE99k=;
        b=uiogKzhYPL3RmBK1m53wG+md3yePeKr6mapHVNydzsOpwPaxEiCwy2e8vzU8xGD0CW
         uPLVTV/fuYHvVXjRP8dlFdYq+d6c6piknis8LT9i0va6TDyI8oGKVyHZybqc8w03W8wN
         /Of3janMdEerxWpOS8iwipZJN6jVIQPtYKsNgPPVBY9lJO689zSm+Ex/tniIQu0BW1G3
         rpMDYgxWEHC72sLMWbvm+NW+PN+c+vfPsKy8mZVjGYGHgUoQfjWBKeVepzud7+XCMGoh
         SICS7+XJBuCQ4XGNaRl+QyvO4hOVnGc5xUkEUl1+RszbwY1d5yf6f6RTaaZgr8NurRF8
         GKQQ==
X-Gm-Message-State: AOAM533O+e7wEu3QpEw8Ld/mSKjG/GKWlhpPeYdEsd2War+pgMCqAx9u
        u3r0wzdgPEef+9M18UjBGviEZmGmLjXeojh8/XU=
X-Google-Smtp-Source: ABdhPJwhYcYmIneqQARWgsNSZNyQDfcQXjguTWYNKrh+uvUlyMNyvJ07AParV+DeJy+VXRrdkVj2tk2+qAGXHb/6jhw=
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr37900205wrn.204.1602585668012;
 Tue, 13 Oct 2020 03:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com> <20201012190037.GB17643@Asurada-Nvidia>
In-Reply-To: <20201012190037.GB17643@Asurada-Nvidia>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 13 Oct 2020 13:40:56 +0300
Message-ID: <CAEnQRZBrXNgMDNgQ=dMJfZQpZvdq6sUx2y21_fuk9teRd5UM0Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:29 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > Add 88200Hz and 176400Hz sample rates support for TX.
> > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Probably should put your own Signed-off at the bottom?

Hi Shengjiu,

Also please keep the original author of the patch. You can change that
using git commit --amend --author="Viorel Suman <viorel.suman@nxp.com>".

With that,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
