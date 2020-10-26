Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314FC2997C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgJZUPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:15:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43041 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgJZUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:15:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id dn5so10874124edb.10;
        Mon, 26 Oct 2020 13:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LYcZ20BNz5H4rzdEtt69INtVa9znhpyNmuJE8/2xo3w=;
        b=WKSPB+Mojedx0/CtIMFlaOcbPgpXicHNZJBqI4NwF9iU08ZChpV2BwaICT4wXdx+p6
         6juffmmFEZ23RorHh2068i2ACfGvKITV87ycZHmm3spxVQmuLPqhjFGEtf/LwNAab8oF
         6G2rWC8h19k5A1whTy1gml+VShabbz6rPmtsd9uIf2Ah3PV1Kw+J1KsUlRGfsGSQFINw
         EZIMtTcHIWaEc8cKjbTlKpFT8IpCM5JsyFRIlEJftJCk7Catt88g0vokoPM2mYSJJzYG
         p7MmAPZ0hqmawAl6EHxabqIn35VNJM0oz+9S9tQ6QnOlWufoxs1umwNQouwQYNvyqaZe
         s4Pw==
X-Gm-Message-State: AOAM531AUBiri3rlEHv2ZC/tDaxk7MbGkPMpv+IvkyL1Nv3UKBVJ6/Pt
        JrdXL6vK/l3T+8iUBLmjnfI=
X-Google-Smtp-Source: ABdhPJwUVIHasurwPlHimiL4eNyqDMCoMudrGD4Wywu8cUDePfrsdT1NdGiifoTp1CA0z6f3X5d8TA==
X-Received: by 2002:a50:8745:: with SMTP id 5mr17221901edv.49.1603743321408;
        Mon, 26 Oct 2020 13:15:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id os11sm6446166ejb.104.2020.10.26.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:15:20 -0700 (PDT)
Date:   Mon, 26 Oct 2020 21:15:18 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] memory: tegra: Correct tegra210_mc_clients def values
Message-ID: <20201026201518.GB248919@kozik-lap>
References: <20201008003746.25659-1-nicoleotsuka@gmail.com>
 <20201008003746.25659-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008003746.25659-3-nicoleotsuka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 05:37:43PM -0700, Nicolin Chen wrote:
> Some def values are mismatched with Tegra X1 TRM, probably because
> being copied from tegra124.c file. So this patch fixes them.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

