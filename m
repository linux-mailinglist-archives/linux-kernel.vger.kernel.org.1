Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE924296D90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462929AbgJWLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462866AbgJWLXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:23:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAFE220874;
        Fri, 23 Oct 2020 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603452216;
        bh=4b1pTClvfqTD0zeJGuECoVeoiBf7aRxXRCG/K9wwXUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+yKUEZmcyz4U+bMeBwhee3V2xz86xPRPiz+jmZ2hND2fiBzsbBIAbIqBlMvHKUgX
         uB6JZuY0Ou/Qro2AbS0kCSt/ewsVPNBlH+/dOSZAvqwNUdotIExhxqXljN1sm8S38d
         YsY3corj/FTnHIaukNU1dJxmwAILU/aORvQSWUYw=
Date:   Fri, 23 Oct 2020 12:23:29 +0100
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
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 10/24] iommu/io-pgtable-arm-v7s: Add cfg as a param in
 some macros
Message-ID: <20201023112329.GD20933@willie-the-truck>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-11-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-11-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:33PM +0800, Yong Wu wrote:
> Add "cfg" as a parameter for some macros. This is a preparing patch for
> mediatek extend the lvl1 pgtable. No functional change.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 34 +++++++++++++++---------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

(but see my later comments above doing this for some of the 'constants' too)

Will
