Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901B2C9859
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgLAHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgLAHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:43:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:43:07 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so1111562wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcXJ9iGPXJxbIO5/OmeLfTqLKT5PGKAYjhQLnvXmAUY=;
        b=n9x59rmZI4zDbTRBHyHp+96nEiDWgjaEUJwfPorFT9lDJnBLeqM2KelAgaDJb0txUy
         3zlwVcEYFWLRCA/PwQD+9FBFWVmEVYk+ZUW5UWr+VLArq69HUVotHrvyPpd+8fYtlN5G
         0PC3xMcMbJXvlOAKQYxKSifOrdq9bpvegqI75IvdHMq1W1ENxTfOavbfrYaeDrK06Tar
         U1yI1DbpJZMN7xgh78yLgezZJa5ZUE9yETU82A4DHkTrS+kfF5sJGnekvXUfQBbaHZx2
         cKWiW2Ii4HmcuuREQAl+/CwPYPM4zmOvuOO9KS+SgAfkXXrtsT2+ErVIC/zENfqZZiM7
         S9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcXJ9iGPXJxbIO5/OmeLfTqLKT5PGKAYjhQLnvXmAUY=;
        b=A+AVuynh5rLe2XJfsSK7E8K3P+FntTHH2ZXfSHcT1ScKfKyRu0F1/XmXhmFbTF8hNN
         YdtppkJ/T5AUssdJC7nFXpUHN+EG1AL8WdvLdMcNdWoz5MjW3I8FtMRUFz8S9lS+LbdE
         fSZzZ3b8f2HV62A4eVWFEmfdmM3zwnY8G92tfuavYnB7tjU5+hPIWd//0W9G6bZNBISD
         pgyVk9uH0LLArbZSFI1nO5DQKCkto0vDB6c+HQTdJhWRj6lJMV9p1q5hcqQNiuzOtzHe
         wvuOGidQyzWLs6ssf+Nel7REkqwm1NmBM78yM4TfqPmnqlsQ6SN/QYkDNjpwt5i2ePN7
         ReJg==
X-Gm-Message-State: AOAM531LG6TVmEQ2CZMTAK2lmcQq4yK1hNBnpaagMmehWMQ4+pefhJRj
        gbdV5tjOcylCme0/OT0Cmy/2XTUUKLQkng==
X-Google-Smtp-Source: ABdhPJzgqnIYEL/0SLcifJPCDMLgXcXaGSzFSZ06l0ncRg0TF07/r2LRAGPxzqL/EaZrEtO66+JdJQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr2057765wro.363.1606808585946;
        Mon, 30 Nov 2020 23:43:05 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id f7sm7599819wmc.1.2020.11.30.23.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:43:05 -0800 (PST)
Date:   Tue, 1 Dec 2020 08:43:00 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Travis Carter <traviscarter2@gmail.com>
Cc:     mchehab@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:media:zoran: Fixed grammar issue
Message-ID: <20201201074300.GA7416@Red>
References: <20201130230659.GA10362@linuxmint-midtower-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130230659.GA10362@linuxmint-midtower-pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:06:59PM -0600, Travis Carter wrote:
> Removed repeated word 'in'
> 
> Signed-off-by: Travis Carter <traviscarter2@gmail.com>
> ---
>  drivers/staging/media/zoran/zoran_card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
> index dfc60e2e9dd7..c77aa458b6d2 100644
> --- a/drivers/staging/media/zoran/zoran_card.c
> +++ b/drivers/staging/media/zoran/zoran_card.c
> @@ -39,7 +39,7 @@ MODULE_PARM_DESC(card, "Card type");
>  /*
>   * The video mem address of the video card. The driver has a little database for some videocards
>   * to determine it from there. If your video card is not in there you have either to give it to
> - * the driver as a parameter or set in in a VIDIOCSFBUF ioctl
> + * the driver as a parameter or set in a VIDIOCSFBUF ioctl
>   */
>  
>  static unsigned long vidmem;	/* default = 0 - Video memory base address */
> -- 
> 2.17.1
> 

Hello

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
