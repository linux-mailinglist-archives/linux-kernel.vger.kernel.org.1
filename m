Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1508A21776E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgGGTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 15:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgGGTB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:01:26 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D677206CD;
        Tue,  7 Jul 2020 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594148485;
        bh=yTAxqihv430USW9Qh1Hfg9Wp4VIfe9iWsjLd10DcD4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cx0gQyHstH9QznqMz6bmbgO+S4FeDt1zsNIW/PBoaBvg4/EfZmfApfEHxNPOj4r8u
         heL7RXkJMZXbxqNcDH55IQUMgGuFkgak+A5qVJWtsc7LaG3nYz8n7IE+5IyfI4yUHs
         KnuLhYV4Lg1mZ7wt0k4uoLJFgahZVwDzjMVagdm8=
Date:   Tue, 7 Jul 2020 12:01:23 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Message-ID: <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:49:24AM +0800, Baolin Wang wrote:
>  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
> @@ -844,7 +844,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  	if (dma_mapping_error(dev->dev, iod->meta_dma))
>  		return BLK_STS_IOERR;
>  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> -	return 0;
> +	return BLK_STS_OK;
>  }

This is fine, though it takes knowing that this value is 0 for the
subsequent 'if (!ret)' check to make sense. Maybe those should change to
'if (ret != BLK_STS_OK)' so the check uses the same symbol as the
return, and will always work in the unlikely event that the defines
are reordered.
