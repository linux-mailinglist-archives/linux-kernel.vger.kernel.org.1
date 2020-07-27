Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F084B22E891
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgG0JNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 05:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0JNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:13:53 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B7820714;
        Mon, 27 Jul 2020 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595841233;
        bh=16o1+cYdGRwy4ni1X7ixFCN3bnoiQLhaYX6U2XFL5rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg12UiT0E0EyDhbKiGxoM/A0QJCANyy9klK36SLWiK3623HpGeBiIPivlE/mhmGpd
         IV5PSSE5+4E2hGqTi4190/CPuNjSxHDazFOIu0jT3MyrfjLDr13Mf4CD02tl4w43DR
         okjI2T6fHWhdHJ/KARegcz2UPKvdZVU+bUDLf8ac=
Date:   Mon, 27 Jul 2020 14:43:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 01/10] dt-bindings: dmaengine: convert Actions Semi
 Owl SoCs bindings to yaml
Message-ID: <20200727091348.GP12965@vkoul-mobl>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-2-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-20, 23:11, Amit Singh Tomar wrote:
> Converts the device tree bindings for the Actions Semi Owl SoCs DMA
> Controller over to YAML schemas.
> 
> It also adds new compatible string "actions,s700-dma".

Applied, thanks

-- 
~Vinod
