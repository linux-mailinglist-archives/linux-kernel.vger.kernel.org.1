Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B033281115
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbgJBLPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:15:51 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41563 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:15:50 -0400
Received: by mail-ej1-f65.google.com with SMTP id ly6so133166ejb.8;
        Fri, 02 Oct 2020 04:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHccXthzZpowujFlX/UIRlonuBGP7oxIKyYm0qA4pvg=;
        b=ZOOumH9NT0heAh690kLmDGJQtBWhxx+8KUdV51xdWsKBwm+CW4cwoyWpYG+3FJ9YV1
         B0Zf8a+555EZYdmAy29DiXcie8SBqaoVkcsmnknhk35uqZTplslGpz3E64RIZTJ8cZ3X
         q/vDrRtEdPiS3DUCQLrPQV1TS+EkXlyZphJOlDgJzyYaRI2aNTp3z/1rGDzNz54NEkMV
         d83MAPkPBuKGUAg6+jIIMAqWV/rw3Pej1WxsFKDJjWQ1SvIqOwePaDfVNFnz2w38bxiA
         g26+uN1SSotChSxwRr5m9Ke4CjY4724zMciTxfLKUhAtcwg3Mu1O4G+cixusk7sMtn/L
         Ns+A==
X-Gm-Message-State: AOAM530eXp+uaqk7FMDT1vr5WMvsTzIccPPJhKlP6bVJukSdthZk0FIA
        f7FIh3/hI1aZYTFNvKfVXv0=
X-Google-Smtp-Source: ABdhPJzSZOSHhDhVdKKucPu1ITBef6j4ONzNmUa9XEdo6BcAOHABAtdMC5eowTZhVkiFyKCfXv3VoQ==
X-Received: by 2002:a17:906:cf9b:: with SMTP id um27mr1735440ejb.66.1601637347031;
        Fri, 02 Oct 2020 04:15:47 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id bt19sm934515ejb.44.2020.10.02.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:15:45 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:15:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 24/24] memory: mtk-smi: Add mt8192 support
Message-ID: <20201002111543.GA7227@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-25-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-25-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:47PM +0800, Yong Wu wrote:
> Add mt8192 smi support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Does it depend on any of the previous patches (so can it be applied
independently)?

Best regards,
Krzysztof
