Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49826F8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:59:25 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21174C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:59:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C2B2D396; Fri, 18 Sep 2020 10:59:23 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:59:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fsl_pamu: Replace use of kzfree with
 kfree_sensitive
Message-ID: <20200918085922.GK31590@8bytes.org>
References: <20200911135325.66156-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911135325.66156-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 02:53:25PM +0100, Alex Dewar wrote:
> kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
> treewide: rename kzfree() to kfree_sensitive()") and is now simply an
> alias for kfree_sensitive(). So just replace it with kfree_sensitive().
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/iommu/fsl_pamu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

