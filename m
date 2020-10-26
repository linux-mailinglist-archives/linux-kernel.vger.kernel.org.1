Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EE2997CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgJZURU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:17:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35015 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgJZURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:17:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id w25so10908728edx.2;
        Mon, 26 Oct 2020 13:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mp/aT4lG2yNnv3cBNy685YtHQ1mMQvwNP9WwRDpEo6g=;
        b=Qp7yK9uP9ZXe297F57cG1Yh1i0OdVzXlJvgw7CVWwVVxuZZm85XegS0/NQvAUVHoYk
         PcT6zDnjlCMX6Fc1lRv/Ix5XHTWsvv4AI3RPwUPpg1ensTuR2JfeVEG8EIGXlNH4zta6
         uLhnnyoXpuB04U9o0QhVRz7bum8d3spQf/QPww1ZlFgLP1JJhhB6oqkLomIsWjz2UGxW
         LxxEEsK9hgLrcAb09P+6nGLInRFBx3lYjaIpQ+jHcdWctp151obQanakV6yv2tTJ+aXN
         tg1bgLjIpembsxyiPMGA36CpqhHOdtf9kiv4C+HdNLWH04wAtrDg7372uouvqHw+OWa/
         nZiA==
X-Gm-Message-State: AOAM530bdUfoHOmVUxk78NgkB5r9/gmTNVho9sIOFBRwWBdd5khH8Xc8
        TTPIV+bAbLA8tCA+UHjIinA=
X-Google-Smtp-Source: ABdhPJyCOAnfe/KgnvhGY77ZsRuxQ0ucByXgUsCjO5shpZd+3qj2jZ2uMiGTqNLc6+gaX2L+mQEloA==
X-Received: by 2002:a50:eb45:: with SMTP id z5mr17091702edp.144.1603743438436;
        Mon, 26 Oct 2020 13:17:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id lj18sm5477745ejb.71.2020.10.26.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:17:17 -0700 (PDT)
Date:   Mon, 26 Oct 2020 21:17:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] memory: tegra: Sort tegra210_swgroups by reg address
Message-ID: <20201026201715.GC248919@kozik-lap>
References: <20201008003746.25659-1-nicoleotsuka@gmail.com>
 <20201008003746.25659-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008003746.25659-4-nicoleotsuka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 05:37:44PM -0700, Nicolin Chen wrote:
> This is a cleanup change to prepare for new swgroups.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Thanks, applied with adjusted commit msg (use imperative mode, so
"Cleanup list of ...").

Best regards,
Krzysztof

