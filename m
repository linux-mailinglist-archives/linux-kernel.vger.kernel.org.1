Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDF2DC5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgLPR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgLPR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:58:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD5C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 09:57:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s26so15908690lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ZAA26HLG36Xvu0N7Lw9uUcJ1NvzFfW1dGKLX9h8st0=;
        b=JCF0T0BdODPAh9sgJ0Dbubl6gNI0wTOnfeA1T8bbhNeo4Vdg0ZcFBOsPWNhOsF0Nrb
         1uxgjazlpeN28DWB8onxe+uttiZ4WdgiQF/Z/hkz0JVHGKR8LveLBh3U6msHCD6KzhAE
         Kpo+GSw98uqa7eMuQ4zw7Bkai/n2qV0oPMn3ACiMf9UFrVlUv47zskfzOpBbKST+Tg2i
         xA6/UXlcrTrl3Xj7jEzqmU9/zq4GX81slNt0zdoGXz2DGwVxjt1rz7o+fOTdcHpstuB+
         l8kcyn+4nf19fOG7jXArN0uKS+OAoyWkx28Qo1ZNAQzARyAPJj1YgL1Slows/ghyHmNU
         13fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ZAA26HLG36Xvu0N7Lw9uUcJ1NvzFfW1dGKLX9h8st0=;
        b=CL8hW/HaeN/Vk0wksTEmObP3N1oAoeQ6nDGWcvLlZbD5/NqhTl78BhaivC5+D0B4ng
         pB6nbVh31gCJA7JjoBEY5sdVcqlb7taTzwDVr81194WMvbQ5HIMPq20OvZ32hu/BCiSp
         fXlcTM2ntAA4G3gZ4Jy62KPF/gJnVK/aSBjX7jyDmzmJuosH2BzDUeg9MDbrfsnEuZwS
         SIgMm7I+A7JRxywtLkd0w/zrZBzsEOtKsHGljQ4VSz2HxuRuOvi9IN53t7D3a/ba/WUc
         6NhiQxKQSM9xPUJ4GHh9b92QPfDQUEC3ne6rO6YvF3+KrtGIJ59eFO9i15EzkX6/te31
         olFw==
X-Gm-Message-State: AOAM530GDt/qaVAvLUQD9aYQtpVQcTNBc8CpbaaTy3dIcxHcy3yNPAv0
        MKm+FhNbKjTpGoa6w79zv8xepcdCfQw9fgKJpITRFQ==
X-Google-Smtp-Source: ABdhPJw5c3OCJIuoNhHcuvnrQn7/ICbS3gk2kd2nIfl23ui/Q3VovlTktYiHjFn9OPyAOKgVVUNg5KEldFqYcRrHNvQ=
X-Received: by 2002:a19:8c8:: with SMTP id 191mr12977544lfi.492.1608141469335;
 Wed, 16 Dec 2020 09:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20201215235334.GA227480@roeck-us.net> <20201216004931.113505-1-john.stultz@linaro.org>
In-Reply-To: <20201216004931.113505-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 16 Dec 2020 23:27:37 +0530
Message-ID: <CAO_48GGgK8uAVb7pBvusX8ZkQ1B0op4PmqYt7246ZH62aM7J8A@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: cma_heap: Include linux/vmalloc.h to fix build
 failures on MIPS
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


On Wed, 16 Dec 2020 at 06:19, John Stultz <john.stultz@linaro.org> wrote:
>
> We need to include <linux/vmalloc.h> in order for MIPS to find
> vmap(), as it doesn't otherwise get included there.
>
> Without this patch, one can hit the following build error:
>   drivers/dma-buf/heaps/cma_heap.c: In function 'cma_heap_do_vmap':
>   drivers/dma-buf/heaps/cma_heap.c:195:10: error: implicit declaration of=
 function 'vmap'

Thanks for the patch; I've merged it to drm-misc-next-fixes.

>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Daniel Mentz <danielmentz@google.com>
> Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Cc: =C3=98rjan Eide <orjan.eide@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ezequiel Garcia <ezequiel@collabora.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: James Jones <jajones@nvidia.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma=
_heap implementation")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> index 5e7c3436310c..3c4e34301172 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/vmalloc.h>
>
>
>  struct cma_heap {
> --
> 2.17.1
>
Best,
Sumit.
