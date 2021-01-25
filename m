Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4DE303437
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbhAZFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:19:43 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40816 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbhAYJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:47:48 -0500
Received: by mail-wm1-f54.google.com with SMTP id c127so10119874wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iG617n7RY186O/pmG7ncN7Xf1mrGP2hULOGFRnrxrOI=;
        b=sxpFJbXFGZDlJuIwhiQ69obfBW+QrB/pzyplqBKPjjNrE3UqBXsf3Dq3rrJ1xYLBUX
         6aWRq3Bpa0APbF/WpbAVNHGpKD9pd1ZiC3BLobNvWISQ/J0dQQifERvVn9hOhQn+AV3y
         pEV81Cqw0cG8hkEw3W4kIcMtWwuHyk/UC+6y0tY4s4anJq0jRBz7OGV59nzCFXRcIaW1
         isjP3TTZ7I0omS8tjsQNQm21TXvSLrN9J/QI/PAsL2HWa/7DpsjjP3pNNARUbnyU9dnR
         zm1ef4gyIYA/6+lKLmMOY/12/jDGDLEF+2YPqNucts0aNoFOUzi5sMRHYG6GAB41NlL0
         KHZg==
X-Gm-Message-State: AOAM530dKr4LMWV9Fhm/KA0u6OBeUlDjrPj/w2bHSb4cQffkxoaE0h66
        aXZSm9Pvk5ZYaR/tAzW4e88rYKSC2fw=
X-Google-Smtp-Source: ABdhPJwbi+N5mhqS3OVl7qZ4K7X04AkWAmdd1Z98I7yaiQ3n0D1F04aYVUoXBZy4+it6iLZGkS40Hg==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr1502306wmc.42.1611564292632;
        Mon, 25 Jan 2021 00:44:52 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h125sm20907834wmh.16.2021.01.25.00.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:44:51 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:44:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
Message-ID: <20210125084450.wurwhi2hbbuueapy@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
 <20210122213558.qnboqc4obdmipxs4@kozik-lap>
 <1611557384.3184.22.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1611557384.3184.22.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:49:44PM +0800, Yong Wu wrote:
> On Fri, 2021-01-22 at 22:35 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> > > This patch switches MTK_SMI to tristate. Support it could be 'm'.
> > > 
> > > Meanwhile, Fix a build issue while MTK_SMI is built as module.
> > 
> > s/Fix/fix.
> > 
> > What error is being fixed here? How can I reproduce it? Aren't you just
> > adjusting it to being buildable by module?
> 
> Sorry, I didn't copy the fail log here. This is the build log:
> 
> In file included from .../drivers/iommu/mtk_iommu.c:34:0:
> .../drivers/iommu/mtk_iommu.h:84:28: error: array type has incomplete
> element type 'struct mtk_smi_larb_iommu'
>   struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
> 
> Our iommu driver will use this structure. but it was contained by
> "#ifdef CONFIG_MTK_SMI". thus I change it to "#if
> IS_ENABLED(CONFIG_MTK_SMI)"
> 
> If reproducing it, we should change mtk-iommu to module_init[1]. and
> switch kconfig MTK_IOMMU to tristate, then change the CONFIG_MTK_IOMMU
> to m. we could get the fail log.
> 
> In this case, Should I squash this change into this patch? I though this
> is a preparing patch and the fail is caused by MTK_SMI. thus I squash
> that into this patch. or change it as a independent patch and send when
> I change MTK_IOMMU to tristate?

If I understand correctly, there is no error before this patch. In such
case just don't mention the error to fix, because it is simply part of
making things modular.

Best regards,
Krzysztof

