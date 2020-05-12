Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235241CFA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgELQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:06:23 -0400
Received: from verein.lst.de ([213.95.11.211]:41975 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACFB468BEB; Tue, 12 May 2020 18:06:18 +0200 (CEST)
Date:   Tue, 12 May 2020 18:06:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wu Bo <wubo40@huawei.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] nvme/core:disable streams when get stream params failed
Message-ID: <20200512160618.GA5403@lst.de>
References: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:37:01PM +0800, Wu Bo wrote:
> After enable nvme streams, then if get stream params failed, 
> We should disable streams before return error in 
> nvme_configure_directives() function.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f2adea9..afe1f5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -552,8 +552,10 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
>  		return ret;
>  
>  	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
> -	if (ret)
> +	if (ret) {
> +		nvme_disable_streams(ctrl);
>  		return ret;
> +	}

Please use a out_disable goto label to not duplicate the error
handling with the other case that needs it.
