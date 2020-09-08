Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372522615E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgIHQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 12:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbgIHQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:15 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F7D21973
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566213;
        bh=R6Ri+kN/CWed2DNBZP62StZ1wEMT9FRwzqJU/Z6NzJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SWVtuNlaY3haAyUccxSNrLi9U6GD0Rq7hIeTqAhtRBaXTuYLkCgCZqUA4nZ4b9sy2
         J1evluoWPMg7stsApZX/3qncZO1mNWBXD9CVvEwsdruxx+ZiOIIsxxz6cvnT/fSuNW
         scht63IrgMsY+NhdHu/NdZcAl+7v8lOQtbBBUSg4=
Received: by mail-vk1-f176.google.com with SMTP id n193so3974513vkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 04:56:53 -0700 (PDT)
X-Gm-Message-State: AOAM5334O6yFmHWMXdV+NLcfde/HUGIww7ErXkXWFEtkHhdcCeTLIDYx
        wxh41/oigohMvP+nlAVYLDojX0N/lTzUnkin4PZb1w==
X-Google-Smtp-Source: ABdhPJzC9NJ3nazYOiolZObh2wDJpo80fd4t69qUL8OOXd0xqmJBeClHzrZjJMv74mozY0KNwsRwK1UkuUL26gb9exU=
X-Received: by 2002:a1f:26cd:: with SMTP id m196mr420652vkm.7.1599566212846;
 Tue, 08 Sep 2020 04:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org> <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 17:26:42 +0530
X-Gmail-Original-Message-ID: <CAHLCerNm_asVtBadWqRfEmhPRu3ARomM1bd+iJOOOcf0PzvWfQ@mail.gmail.com>
Message-ID: <CAHLCerNm_asVtBadWqRfEmhPRu3ARomM1bd+iJOOOcf0PzvWfQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document
 SM8250 compatible
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
> hardware block which carries out CPUFreq operations on SM8250 SoC is
> called EPSS.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Amit Kucheria <amitk@kernel.org>


> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> index 33856947c561..aea4ddb2b9e8 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -8,7 +8,7 @@ Properties:
>  - compatible
>         Usage:          required
>         Value type:     <string>
> -       Definition:     must be "qcom,cpufreq-hw".
> +       Definition:     must be "qcom,cpufreq-hw" or "qcom,sm8250-epss".
>
>  - clocks
>         Usage:          required
> --
> 2.17.1
>
