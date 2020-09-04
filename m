Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20D25D3D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgIDImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:42:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B33C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:42:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 822BF3D5; Fri,  4 Sep 2020 10:42:39 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:42:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: amd: Add missing function prototypes to fix
 -Wmissing-prototypes
Message-ID: <20200904084238.GB6714@8bytes.org>
References: <20200727183631.16744-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727183631.16744-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 08:36:31PM +0200, Krzysztof Kozlowski wrote:
> ---
>  drivers/iommu/amd/amd_iommu.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.
