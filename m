Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752622464E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHQKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 06:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgHQKx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:53:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D29B20758;
        Mon, 17 Aug 2020 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597661606;
        bh=/yg5CG5Pqlvxg6RARc2mE3qINPJ76LuMoK+3ZPUd37k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJs7ih+8pOsI/ft0TcODZut2ndgo9ESSIIxrxt0ZRhkrBwTaEqicpHXLzaEHIp2po
         xTBAnvSRray/zbgtWWx7nVyQo4+83TA/yhFWR2XNsR7NX4GAR8WmgjsVnhbTj3IBJn
         auUSFIUTsuEwhGmVnLTZhzblSXZLR2lfwJTstKxM=
Date:   Mon, 17 Aug 2020 12:53:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>,
        Joerg Roedel <joro@8bytes.org>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817105345.GA3483231@kroah.com>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <20200817082106.GA16296@infradead.org>
 <20200817112725.26f1b7d6@coco.lan>
 <20200817093703.GA2258686@kroah.com>
 <20200817124617.303bb4a9@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817124617.303bb4a9@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:46:17PM +0200, Mauro Carvalho Chehab wrote:
> The main reason of submitting via staging is that I need to preserve
> the patch that added this driver as-is, in order to preserve its
> SoB and not causing legal issues.
> 
> It it is OK for iommu to accept a submission like that, I can
> re-submit it, doing the changes at drivers/iommu.

You can always do this just fine, as one single patch.  You do know
about the co-developed-by: line, right?

thanks,

greg k-h
