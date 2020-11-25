Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C548C2C3FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgKYMYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgKYMYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:24:06 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93874206E5;
        Wed, 25 Nov 2020 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606307046;
        bh=XDwgKOEhVubEPri5ivC7iaWE3ykzukuoYApUlOqRZ4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuAz/g7ltrT31FAAt7dJ2TXyYV+rEveX9kyh1coxGqA8i/c8J+x1ALv56/V6Zcx0t
         dQlV1pn+To+X/LLdkc71FgqZP2V3cHEFrA99DjO6fWS4geFz83DXz09bT/D6cB7Thf
         /Op6Ps+IjwN8OVDxicixULN+0CcJa6Zm9gexaiU4=
Date:   Wed, 25 Nov 2020 12:23:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 00/24] MT8192 IOMMU support
Message-ID: <20201125122358.GA15697@willie-the-truck>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:14PM +0800, Yong Wu wrote:
> This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.
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
> change note:
> v4: a) rebase on v5.10-rc1
>     b) Move the smi part to a independent patchset.
>     c) Improve v7s code from Robin and Will.
>     d) Add a mediatek iommu entry patch in MAINTAINERS.

Please can you post a v5 of this, adding the Acks from v4 and addressing
the build failures reported by the kbuild robot on patch 20?

Thanks,

Will
