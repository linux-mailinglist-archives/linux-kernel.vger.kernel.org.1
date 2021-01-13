Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7112F512B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbhAMRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbhAMRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:32:10 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA316C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:31:30 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h13so1127989qvo.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+V2Dr2muMkbk0Yt20+kBeKoC8rP7GJB7dLSdIgBdmPU=;
        b=TGvsxQuiRgpoRSNCinvSnrvriBuQfwHVZFHfM1a1dybagvBAQuJXoAB6tesQINtW66
         rZnAujCpdbZJiYkIikadqGylWKIlPfne/BLEPbWGrO57TszPd7LhSpHrbLH2QfZdjRNz
         cPFkmXQJw1OKpOMpbye9/FjUn7KOY1E7gxAyo17gO01nP5cSxzETAzSQ9pPWr9qPdgyh
         NdE/jLXnqXcK/psY1fmr9gqq9DpedoxySG1dpVSIp+FwCsQFtJrUhG3GiT2/yxFUA3Zg
         5Yr74jWVXlHzqNfZYdrqAF/ehceTrb5qJOB1IRFgLFPysIaSyOFCpUyxKC1G+G0OPyBS
         C5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+V2Dr2muMkbk0Yt20+kBeKoC8rP7GJB7dLSdIgBdmPU=;
        b=cFeKjWgYSCkX7Q9DOiHGuLQXbjxDStehIMG1fL4mTdQ1YIQBrS/qfI+VIyo2DxePsv
         fScOsu0e6lt8I+hkkZ7D0+m5uSVTqvLtowyeAVvlgM1xUqDZxCx8SNR5gHegq8x9eLjj
         jn94iqHsK4rlV2QLIDl+tMeKKRjiSan3lel8/+tn+9nn5xBrsHI78pkKIp2y6XpqNZHJ
         KhuavPPLjpYT2xW5NuUlhcxRvECfNfEbVnGoPRir8HvA8kkaf76p/MduxWl7dcb38jdy
         vzdfNH9nyfRNni7UnDGh7V5OuCUal8HREQssEzZsXrQiT1xD9vYujhNO1pbBTRt7Ekgl
         vYIA==
X-Gm-Message-State: AOAM531dTZTv8Yqee/NUR9ImFepPgATb7MqNOydjp7HTvSks9XBeCXDr
        ZV2CrVTYaFnHs6W9yjk71Esfor0e3IXA41f6EjLvMw==
X-Google-Smtp-Source: ABdhPJz285kiLrApEti5WJgRA1E13XN480igK5w4hFcgkOLK8+pftJijGcF2r5qhv2NtQ+Bq2oR1dKlDUWJkPD/JeWo=
X-Received: by 2002:a0c:8203:: with SMTP id h3mr3390601qva.0.1610559089537;
 Wed, 13 Jan 2021 09:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20210113012143.1201105-1-minchan@kernel.org> <20210113012143.1201105-4-minchan@kernel.org>
 <1610552704.254587.2506180.nullmailer@robh.at.kernel.org>
In-Reply-To: <1610552704.254587.2506180.nullmailer@robh.at.kernel.org>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 13 Jan 2021 09:30:53 -0800
Message-ID: <CA+wgaPOwCWc+oYzzaLwUch32-vUMhma3UgFLWZTbOZ5jMuv6Ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: reserved-memory: Make DMA-BUF CMA
 heap DT-configurable
To:     Rob Herring <robh@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Dias <joaodias@google.com>,
        "pullip.cho" <pullip.cho@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        robh+dt@kernel.org, linaro-mm-sig@lists.linaro.org,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-media@vger.kernel.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 7:45 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 12 Jan 2021 17:21:42 -0800, Minchan Kim wrote:
> > From: Hyesoo Yu <hyesoo.yu@samsung.com>
> >
> > Document devicetree binding for chunk cma heap on dma heap framework.
> >
> > The DMA chunk heap supports the bulk allocation of higher order pages.
> >
> > Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Change-Id: I8fb231e5a8360e2d8f65947e155b12aa664dde01
> > ---
> >  .../reserved-memory/dma_heap_chunk.yaml       | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/dma_heap_chunk.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/reserved-memory/dma_heap_chunk.yaml:58:1: [warning] too many blank lines (2 > 1) (empty-lines)
>
> dtschema/dtc warnings/errors:
>
> See https://patchwork.ozlabs.org/patch/1425577
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Hi Rob,

Sorry about that, I can see the warning after installing yamllint.
Will fix it in the next version!

Thanks,
Hridya
