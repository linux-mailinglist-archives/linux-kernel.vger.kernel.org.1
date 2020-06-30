Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4119C20F284
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgF3KT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 06:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:50094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbgF3KTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:19:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71D62B0BF;
        Tue, 30 Jun 2020 10:19:22 +0000 (UTC)
Date:   Tue, 30 Jun 2020 12:19:20 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu: add include/uapi/linux/iommu.h to MAINTAINERS file
Message-ID: <20200630101920.GC23790@suse.de>
References: <20200605070025.216124-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605070025.216124-1-jsnitsel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:00:25AM -0700, Jerry Snitselaar wrote:
> When include/uapi/linux/iommu.h was created it was never
> added to the file list in MAINTAINERS.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
