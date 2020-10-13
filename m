Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8012028D36C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgJMSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgJMSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:06:43 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE851C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:06:42 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n65so389890ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC+eIGSuy7HXFNAJKskaB1/Y6uzxiEyHcepnDUSqEgk=;
        b=cwFNqLo6SWnhBa8+TIPZZqs2+EqrKZ7n+KoVTvTSn16WCpfefcSM0sgTuKFXrCHZTI
         pgOYlme9rtwtzS/jiYDDdx6dx5cVq6NhS0Mh2n92YR5/zkzieYDjWXjwk+voweHZWfHr
         5SxM1NiB5MWo2soDsoxEsfsykYZRNTro2zYfO5h/9V14gqmol8tkuSEzWSOoj1PRlj9r
         /ks4Vv37SN7Di2pV5Jzm08ImDweBl5CF1S9Ruw2t5/EmKGgMVpDa7jSSBAcxlsgtyAIO
         KuwxG6Lj9cWn7zSPfy8WGuXu6sqjH3gowT3GtP52pC1VuPHzvdsZ5S81u1CptVzWoHYS
         zxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC+eIGSuy7HXFNAJKskaB1/Y6uzxiEyHcepnDUSqEgk=;
        b=U9PcmSTK+V2Hv2t1c9W9bBi2/lL1TlYjRRy/nXNvs3mzGTbK0m6hsRVFoh5CSerQw0
         sELx8MbQvKNlW3zDVWH6Ct9CYnWDIomwA1BeEFvxyrtcWskVgDvMu6JJ/wvs1Env1+AZ
         KfpirQR0Ex97W7umec3XCz9+7cTmI/TC8yEstSGFr69antGpfvalQfCxCpaiuMO1fkMU
         HsrJJeVTBEd1zpibyJrqZmwrZr0CBm9MODuxo8N5LfL7g5lNdwr2l2hL/ShkCxMtPyJ3
         vLn6rthMnWoh69Xs5Dz+OPvGYjfeToiHqlgGcfvEmV874Plln/KFH84fCj2kIU9DpzW8
         v+mw==
X-Gm-Message-State: AOAM531T7yRHVIATEFG7mJKUIaBVBo3ohRuWh6MLjrEWjB73eoyzdJUu
        Nbh3867icmb8G0AdULWdRpZU848wMyy2Bq6RHP2DBQ==
X-Google-Smtp-Source: ABdhPJxcETRToT2/6ccFA3QydpquprGux5wNNNvYW0oSrenBP4NURbNK4s1GLx0XPCwjbV+g5pdVceBXB7EuDufCdfg=
X-Received: by 2002:a25:c512:: with SMTP id v18mr1815252ybe.20.1602612401925;
 Tue, 13 Oct 2020 11:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201013135913.29059-1-georgi.djakov@linaro.org> <20201013135913.29059-2-georgi.djakov@linaro.org>
In-Reply-To: <20201013135913.29059-2-georgi.djakov@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 13 Oct 2020 11:06:05 -0700
Message-ID: <CAGETcx_fEy2_CkrVe9wMP+KJdbWNjVnew+9HiK06iYkniF2HNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: sdm845: Init BCMs before creating
 the nodes
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>, okukatla@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 6:59 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently if we use sync_state, by default the bandwidth is maxed out,
> but in order to set this in hardware, the BCMs (Bus Clock Managers) need
> to be initialized first. Move the BCM initialization before creating the
> nodes to fix this.
>
> Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/sdm845.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index d79e3163e2c3..47556dc12ec0 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -489,6 +489,9 @@ static int qnoc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       for (i = 0; i < qp->num_bcms; i++)
> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> +
>         for (i = 0; i < num_nodes; i++) {
>                 size_t j;
>
> @@ -512,9 +515,6 @@ static int qnoc_probe(struct platform_device *pdev)
>         }
>         data->num_nodes = num_nodes;
>
> -       for (i = 0; i < qp->num_bcms; i++)
> -               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> -
>         platform_set_drvdata(pdev, qp);
>
>         return 0;

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana
