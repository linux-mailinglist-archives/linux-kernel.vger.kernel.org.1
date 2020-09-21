Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAD271C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIUHwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:52:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:52:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so10904182wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/TQXsV1OAxZyuAqM6MsmSX3HS2PWk6J5g27yL5RaIKE=;
        b=ZOPuPcFxnf2YIF0QiMWlvYnLOS17ma2nco0yEY0in/JT30JAyveWXaA/cu3B0woVN6
         L1/op57360JbwuFikzrPE0sj6cRi9rJq+sVleFwihYDOhGtyWTPp24ulB31u4jO+SRHD
         MZKHfKsjDSw9N7vS+KgdQd+7NmLmgzhfl169Fau1pXEppJ9NvxZZirAz0tExyx369POl
         h9vWB4q+QK5rc+ntEdxc8vuhQNplP3ZrmJcbQZDhD3Tjnb5aOQuTS0sbMWMdrT1UBN/B
         Yd+97zN2psWCIsF1on9BZ1TQkE/fuX+RUR8FloeiGy4woC8MsObeXN6fd4lrmts1/EzV
         XN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/TQXsV1OAxZyuAqM6MsmSX3HS2PWk6J5g27yL5RaIKE=;
        b=QCYbjAwt7bKYQP6E9QpZ7qiQmCTxWYo/DAqfhBt4aahshFeXhnHygrabhO6CAfm2cg
         UFiibcfui/LlNXnKnnr3GyeFPFiOLRAxGxgvN9VgTC7/TMZqXc59roDvWHkjfdJmWnve
         1crJt7Ea4WD8Qi1EnMz7enRRJ5ruZ1COo6rhXhR2lcSNx6Obl69d9qMRZmmLWhwT4tt7
         cpetecuBoRhwbUveSapNQMvflHEUmBVk8dR6mvX48CVcrX+ieSqhAb+9SLaqVILsy1rK
         TeGq/AFfskGtSk4Ih5DjpPUfsxQJXZjTcxWWkOqHE4rGpgV0wCL/1p2Wisg67XoQ2Mto
         78eA==
X-Gm-Message-State: AOAM5310taL1XN+j/afljpo/u5qe/SoSmFXWUmIp1qyEUUrWDpjXT2ul
        IAmoz5OmKijhJoVXNM0lbPqK2g==
X-Google-Smtp-Source: ABdhPJz7MSQdWctQkDiQJlSZbwzMlMgiNCD2Dn/tvOUdjZKiTccdZojOTTrcWOZor3jAw9MQUO8IFw==
X-Received: by 2002:a05:600c:4149:: with SMTP id h9mr11875920wmm.86.1600674750511;
        Mon, 21 Sep 2020 00:52:30 -0700 (PDT)
Received: from [192.168.1.23] (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id f12sm17993488wmf.26.2020.09.21.00.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 00:52:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] drm/panfrost: add Amlogic integration quirks
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200916150147.25753-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <842c31f7-3b59-6442-d4ca-c5dcc2317a04@baylibre.com>
Date:   Mon, 21 Sep 2020 09:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916150147.25753-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, Rob,

Should I send a v3 with the commit log fixes ?

Neil

On 16/09/2020 17:01, Neil Armstrong wrote:
> The T820, G31 & G52 GPUs integrated by Amlogic in the respective GXM, G12A/SM1 & G12B
> SoCs needs a quirk in the PWR registers at the GPU reset time.
> 
> This serie adds the necessary quirks for the Amlogic integrated GPUs only.
> 
> Changes since v1 at [1]:
> - removed the BROKEN_SH quirk after [2] was sent by robin
> - rebased on top of [3] by steven and moved the vendor quirk in the proper quirk function
> - added PWR_KEY unlock definition, and cleaned definition
> 
> [1] https://lkml.kernel.org/r/20200908151853.4837-1-narmstrong@baylibre.com
> [2] https://lkml.kernel.org/r/cover.1600213517.git.robin.murphy@arm.com
> [3] https://lkml.kernel.org/r/20200909122957.51667-1-steven.price@arm.com
> 
> Neil Armstrong (3):
>   drm/panfrost: add support for vendor quirk
>   drm/panfrost: add amlogic reset quirk callback
>   drm/panfrost: add Amlogic GPU integration quirks
> 
>  drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 11 +++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 15 +++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_regs.h   |  4 ++++
>  5 files changed, 35 insertions(+)
> 

