Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E093222C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGPTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:53:26 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44145 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:53:25 -0400
Received: by mail-il1-f195.google.com with SMTP id h16so6136948ilj.11;
        Thu, 16 Jul 2020 12:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPJI5AUNc3GLpKlOl9E8pVIu2DWZ+nUPV7c3Fd1fTW8=;
        b=C0YlOEB3HlfSQOau0l1nAuJSZNvm6nMyGgGWnXUB+WYKXrnEeIETCBYmbYEm6i27i6
         g0Pu0CM4NrNp7MUw3nBZKAmGzOAMDKOqzBWNZfDoLCmf1oHJr/ywoR6tPODEIlf4mcUK
         ESfi7enHHxs9MHkBACte9NKfEuBLtrnoZqY35FfgTTOIh/bBztSxba7p42EQrBdcHzjc
         YUV1CKHhSppkJH4sHtA1xuaRamITQ6K4kCMDjUDrMsfJrvuvhUBgtil+l5DlEsYhBUeG
         Qe1TdcWu4TlJnwKsqQWARKPe97FGfSuAUBuHI/IawwsPugC+zkTjxbWfGFRJftzg3zLy
         lJmQ==
X-Gm-Message-State: AOAM533waWtZJylo4/lPiB6jdJr3sIp3GFzcjzz7NLRDYITWmF0Dh5l1
        EKG/G2OgqJmWUPyvPgqPMQ==
X-Google-Smtp-Source: ABdhPJwbtrb2hzcyMrDtMJ8lQQG2F77dP0WpMBde2WE/BUG6j0yjkG7KFC7V4dHYMGHTHGdG0n/9rA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr6614069ilz.227.1594929204916;
        Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a5sm3219354ilt.71.2020.07.16.12.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: (nullmailer pid 2739233 invoked by uid 1000);
        Thu, 16 Jul 2020 19:53:23 -0000
Date:   Thu, 16 Jul 2020 13:53:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v2 2/3] ASoC: bindings: fsl-asoc-card: Support
 hp-det-gpio and mic-det-gpio
Message-ID: <20200716195323.GA2739158@bogus>
References: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
 <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 22:09:38 +0800, Shengjiu Wang wrote:
> Add headphone and microphone detection GPIO support.
> These properties are optional.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
