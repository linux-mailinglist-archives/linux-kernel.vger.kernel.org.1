Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60532F91C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbhAQKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbhAQKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610879581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tml6sHp1NjNR0HFEv3Pcp5mMcpBNidTf8muhn4StX7M=;
        b=EAay2NViUUTMDIOomnts8r3gJI2rzrARwqjlNh2Ab2F+l/9F74wnP11umiCBI7ZHYXBr2b
        U4PqfAcwg0mPKHnBSqPGeOsVwwT5wY3gnsU/DzbpOWnb+Oda8ll9FOD7HvkiJdKJOqbJSJ
        vzyYZEm9uNa4aHOnWi67DK9/pyFOjT4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-V_9zE4-0MfO6X1XqUu2_Hg-1; Sun, 17 Jan 2021 05:30:07 -0500
X-MC-Unique: V_9zE4-0MfO6X1XqUu2_Hg-1
Received: by mail-wr1-f69.google.com with SMTP id q2so6709955wrp.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 02:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tml6sHp1NjNR0HFEv3Pcp5mMcpBNidTf8muhn4StX7M=;
        b=fVV0aWtqptGXK8xVWXK05OF/zatpetRsS0onXPW+LTGqjc0aRgZviJIDktCgPlRytv
         NsVTDTRUniHJSFyA31lR5TPX3tC1C41w39b6tXmgxDp982+9l6ED/5pciElBRuZCquDF
         KE/ti6hWPmqC4I4jgQrVjhEhQ4iZBC69yw+BU0uAkVDAylcFeVoebNNFj+ZpDEyfQOcR
         Ou9evJTgoBlvIbpEU3Nx3oeo7KJCQzCEpoUvKwLYOux+bz6GFYjtvBCZxQi+WWp7qihb
         52XKXOarmJKegF82nBUsWNs43JIT5GGl2mpvB/8it/hRhegSuqomuwmwyYmJ13WJJs+G
         nAhw==
X-Gm-Message-State: AOAM531lhtZzhuEI1E/shACzS7X86H2NKA1vxOck6qMEgXTRCRgHp7Y9
        H5NA3gbTSHTLRkEefNwtSW5lvuegjiblFycfMZOcTL3wAbx8DIzNwIu8rYXYHGrQ0c1ak7fMsdV
        u/MOsRioEd1TekVootN7wCv+u
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr20882390wrv.427.1610879405575;
        Sun, 17 Jan 2021 02:30:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJOkl7BSAtfyHjEVk7fCu1bVnGq2uHZD9z4fBmoWEo/nxSjQ1VfYa4asP46KP2Zq+ue0UrfA==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr20882379wrv.427.1610879405440;
        Sun, 17 Jan 2021 02:30:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-30-58.red.bezeqint.net. [79.176.30.58])
        by smtp.gmail.com with ESMTPSA id c20sm18850213wmb.38.2021.01.17.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 02:30:04 -0800 (PST)
Date:   Sun, 17 Jan 2021 05:30:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: Re: [PATCH V2] mlx5: vdpa: fix possible uninitialized var
Message-ID: <20210117052810-mutt-send-email-mst@kernel.org>
References: <20210114070904.9981-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114070904.9981-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 03:09:04PM +0800, Jason Wang wrote:
> When compiling with -Werror=maybe-uninitialized, gcc may complains the
> possible uninitialized umem. Since the callers won't pass value other
> than 1 to 3, making 3 as default to fix the compiler warning.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Of course if it's actually something else this is not DTRT ...
As long as we worry about this warning, let's have defence in depth:
  	case 3:
  		umem = &mvq->umem3;
  		break;
 +	default:
 +		umem = NULL;
 +              BUG();
 +		break;


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f1d54814db97..07ccc61cd6f6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -703,7 +703,7 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
>  	case 2:
>  		umem = &mvq->umem2;
>  		break;
> -	case 3:
> +	default:
>  		umem = &mvq->umem3;
>  		break;
>  	}
> -- 
> 2.25.1

