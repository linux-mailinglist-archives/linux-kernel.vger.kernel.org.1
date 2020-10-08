Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F6287599
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgJHOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgJHOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:04:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B41C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:04:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so4390174pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jt37dXS34L6OrrLOkGsUD7pu7UmGQsU7qWnxBPvScNc=;
        b=u5Kc3RiL7HbklSB31pqCBDXIEkTsQpsWvA6e5v7U9sRzjoUYY0KAEeTTkRmhRwCCsb
         I7ZnCPz9zk6owa7G8GuKAScYd19dmTzoPHy2jyFCPBNnVB0u7FdBDmddOMBOENeofEuD
         cp2FA3bI8tLekVzetP7V0KVUd3GYeEbhlbvnAMSQMc5JTAmqBRu42q9toOgwmAi3CxKy
         D8uURsODhhIt3JEnoG85MAD/Pe01QmxRAorPnBwb24eROvgiGVH8hLfeb9nkJhcbDoMG
         oNiBGIyY2grEh5KyeKmlblj2o6U1K398S9HaUMiRXjd//fzChEEfEhnj55d/JjMFrxcb
         mcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jt37dXS34L6OrrLOkGsUD7pu7UmGQsU7qWnxBPvScNc=;
        b=erRyBZc2nVCrnB/YVu9tYt7O8dme7xB8m75j1K2ap/rpsN+yRya/cbj9nrnW9R8SLm
         0CwlQo5LQmd0YZzRHkp9B1p/6zV9+tJVEKfOWoHoEozmZsaSNbZiIlACac/wAezGXPq4
         PTw0TzA3kW/xaC8fgrOizw6MJme29k3CfvpgJtN/xdvp27aKg6DQgvdD5swG2bJEvHIT
         F42AZLcnqT/Ynx8coTH4slOETqgcZ5sBm14tpTdEzChowRFakGU6Hk3BXZe8ip6VDOG9
         s5mByiotIN3P9gwfNZKQrD4NryQBFM3+lJ5SoauW7t5kMQSL+9A8ZRrb8rki0uM9jOnY
         WlsA==
X-Gm-Message-State: AOAM531XDfTdjNHi61bjrJuOU+V/c4onrHq9/fTXbdsH1om4X7vTsPfz
        K1ZXj+0L1z97HtwXOUCsGCDx
X-Google-Smtp-Source: ABdhPJxdhQfznR1avOqOyogF/FWuIhGM4D//p1p96Y2UYcJ8OQgm3oT5tKUnLsJ40lYXuzj0w2HuFA==
X-Received: by 2002:a17:90a:c17:: with SMTP id 23mr8473272pjs.127.1602165852330;
        Thu, 08 Oct 2020 07:04:12 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id b6sm7289227pjq.42.2020.10.08.07.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 07:04:08 -0700 (PDT)
Date:   Thu, 8 Oct 2020 19:34:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 5/5] dmaengine: owl-dma: fix kernel-doc style for enum
Message-ID: <20201008140403.GB23649@linux>
References: <20201007083113.567559-1-vkoul@kernel.org>
 <20201007083113.567559-6-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007083113.567559-6-vkoul@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:01:13PM +0530, Vinod Koul wrote:
> Driver doesn't use keyword enum for enum owl_dmadesc_offsets resulting
> in warning:
> 
> drivers/dma/owl-dma.c:139: warning: cannot understand function prototype:
> 'enum owl_dmadesc_offsets '
> 
> So add the keyword to fix it and also add documentation for missing
> OWL_DMADESC_SIZE
> 

Do we really need to document the max value? Does it produce any warning?

> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/owl-dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 331c8d8b10a3..9fede32641e9 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -124,7 +124,7 @@
>  #define FCNT_VAL				0x1
>  
>  /**
> - * owl_dmadesc_offsets - Describe DMA descriptor, hardware link
> + * enum owl_dmadesc_offsets - Describe DMA descriptor, hardware link
>   * list for dma transfer
>   * @OWL_DMADESC_NEXT_LLI: physical address of the next link list
>   * @OWL_DMADESC_SADDR: source physical address
> @@ -135,6 +135,7 @@
>   * @OWL_DMADESC_CTRLA: dma_mode and linklist ctrl config
>   * @OWL_DMADESC_CTRLB: interrupt config
>   * @OWL_DMADESC_CONST_NUM: data for constant fill
> + * @OWL_DMADESC_SIZE: max size of this enum
>   */
>  enum owl_dmadesc_offsets {
>  	OWL_DMADESC_NEXT_LLI = 0,
> -- 
> 2.26.2
> 
