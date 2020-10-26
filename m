Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36312997A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgJZUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:08:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37345 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgJZUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:08:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id o18so10842794edq.4;
        Mon, 26 Oct 2020 13:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAhJNTcBuylpc827Gc8DE790mcWVOqgUgREe8IN9rGk=;
        b=XR9gLUYDNIEDvnlDYssdSnfC5D/4IO7PZYm7ffv+NKf1Ofm+ggyuwn6sQf8wDUs3h/
         IeTSPjG0AbyPrCLZWyrruIAj6/oO6662jHlxVSnIBDDUXwEvWHQ+OQyXGe7KAcEKR+QU
         zWErCbkFsjIOFy6F/eevCNFW5SjdIb0fq3vMPyaZhngZacP2FfRWZkWQ2vby8vOfETgJ
         XBIPQqZSYAXapRetQLlvad16BzmYfPdSsd3ZiXQiqxTgQd57hHTffFP6Ppyc1OqOtCMm
         PUp9NGKSI/UTaCJmN+0I6gRkHsnjum1Is6sxtu5jR2xy30jEmioOPzleOptPNlshX0nM
         3YYQ==
X-Gm-Message-State: AOAM532R49Ly4ZnHyT/rX6Qaed9wZ0H9xpRPhKtbWfmxyPk3BoMn6Cu6
        Q2lLbFQ+mEqk9T+ZoMqyjrg=
X-Google-Smtp-Source: ABdhPJyeTtkh+7BD+iZP00A29Rs+E9CbsQNM30SNnmXJaudtE/elyiDZQpiu12bDhX/8rOr3FlmfEA==
X-Received: by 2002:a50:fb0d:: with SMTP id d13mr17781115edq.85.1603742922751;
        Mon, 26 Oct 2020 13:08:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id f23sm6453141ejd.5.2020.10.26.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:08:41 -0700 (PDT)
Date:   Mon, 26 Oct 2020 21:08:38 +0100
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
Subject: Re: [PATCH v3 00/24] MT8192 IOMMU support
Message-ID: <20201026200838.GB240203@kozik-lap>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:23PM +0800, Yong Wu wrote:
> This patch mainly adds support for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Comparing with the preview SoC, this patchset mainly adds two new functions:
> a) add iova 34 bits support.
> b) add multi domains support since several HW has the special iova
> region requirement.
> 
> this patchset depend on v5.9-rc1.

Hi,

I think there will be v4 of this, right? If yes, please also describe
the dependencies between the patches. If the entire patchset is strictly
ordered, then mention this as well.

Best regards,
Krzysztof

