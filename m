Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDADB2AF6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKKQpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgKKQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:45:45 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E37C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:45:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so2934874wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/tc7xjG5IAbwDOITmzqVihGpQaXzagYZQvBTGpgYms8=;
        b=HqZB/9eOVs5Rg+FIk/cwSY1ITdAAr4IZZPS594amIXOyh8I2d8M0/qLDdduvDiTyK3
         F5MgnTA+Qhdyy3QW9QiEbp8JDQMZLo4T0fMsYfxcDydQAsdZqZInzdqpRgJu0v1lMFaA
         pq7+3X4mqnv3He/q7wjGHKJlgCakYJAo5E8cQcbQ60WBt8sBzwrr3DStZh2fUqPS3jMg
         Hj9rEzq4aRJMagdnZ403kmbZ5UiYCZ7ZgUKil49Cxbxdb8y0pte1X6i7e5xMyTYwK8aN
         tzhC/1EIb3tonF54o6OjhfeaGQ39ic1An6wqdheJ+nbJC00L/zOhCR+WMRwOcYrCluP9
         bh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/tc7xjG5IAbwDOITmzqVihGpQaXzagYZQvBTGpgYms8=;
        b=tX3SmqzR1Y7MzhJhOSezfdmJh2SsTdC4JCF6YCpfgHoXApGJXCS6h0g2SbDNpnbNsE
         udx3I1oXeA78ba672ZWRk7lzM7NAUOlmoz5vgA7xyucCLMPqSxfv3id4mHNSiPjeoKh8
         GURCC3LQ+XKirvPq1e4m/e4t4Qs8YCpTt0RBvLz5qgxH0d538ombJbKev3/JFV7bfD/f
         Vdf/wBAJFVJkioIpOqtxBXlo9NiFopIm4SsVpiER8JrxThCSBSKWx8o3wrjHKwuY8L4i
         cQ3l1HU8u9eCUJR5K/VXIHaj4zUwM2dGqrdY486K+WPqUr4xcJr3lZF86XXjvW3xSZ/B
         UOBA==
X-Gm-Message-State: AOAM532VR5lTnOIwexkmwCQYd4cb7/MFoqNYlHq4uZZW7WIEVNIdKP10
        r9//Hh6Ib0OfGwCEFjOzsMxFoA==
X-Google-Smtp-Source: ABdhPJz0o72ogXRNWJ4UArzT4Bpb3qdlMIZVvlFneGXocObLd1BcMYpFQaNQaXJVTTA1BPlz6H5Tyw==
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr5146868wmb.180.1605113142145;
        Wed, 11 Nov 2020 08:45:42 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id c6sm3309966wrh.74.2020.11.11.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:45:41 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:45:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v6 10/11] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20201111164539.GQ2063125@dell>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
 <1604656432-10215-11-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604656432-10215-11-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Merge different sub-devices I2C read/write functions into one Regmap,
> because PMIC and LDO part need CRC bits for access protection.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig       |   1 +
>  drivers/mfd/mt6360-core.c | 203 ++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 181 insertions(+), 23 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
