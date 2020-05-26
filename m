Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6110C1D9F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgESSds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 14:33:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43378 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:33:48 -0400
Received: by mail-il1-f194.google.com with SMTP id l20so367639ilj.10;
        Tue, 19 May 2020 11:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lRGaswwEMB9v92IBAfHtD4YZ9rbLBXN//F0Wgadf0Zc=;
        b=smFEldyxuPYtB+m0RsNC5oAD8MlfNoi+43ahgcruuq5d/f9AFUsnRsecT729LKT9hT
         P6yeCvQAmV4DQhq360qWh6p5VqT4NBygeRIPEN/8ziUbsiyUlvEYtBvlwZllHHLE0iq6
         Ri16Dk+CQdCl6CM1cyAt+m22iWTgEJrkqX7mESx+eERI60FOlqCB4XRH1NI4lMARnuu2
         MROsS3K5qxnQqDwP6cAMSqe6QMWCqTC+AF84KdxWt5tVA65h0Pb9dXCAu7LNTvXdorob
         WNnyLKM4sh5IEor+CUj8ysnLsXST1TzSFyE657PB/R4p2AGbr31ezGjBsjuUjBvLKjaT
         KUCw==
X-Gm-Message-State: AOAM531QMuRVSsmhHe9CzZbBQafmIIj4+Pvo5bYUm8rJoXPODYVIwhUO
        8nN2Mqc5UR5ep5PWZleEDg==
X-Google-Smtp-Source: ABdhPJwcESmafnqWpyNh2F7ueLag4ryX4RQmW1OgW1IaqcXdzCybZDn1fzWCfLBd4lKhETLf2to/Yw==
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr341351ils.11.1589913227089;
        Tue, 19 May 2020 11:33:47 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i10sm110807ilp.28.2020.05.19.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:33:46 -0700 (PDT)
Received: (nullmailer pid 434955 invoked by uid 1000);
        Tue, 19 May 2020 18:33:45 -0000
Date:   Tue, 19 May 2020 12:33:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/10] dt-bindings: reset: s700: Add binding constants
 for mmc
Message-ID: <20200519183345.GA434412@bogus>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
 <1589912368-480-8-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589912368-480-8-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:49:25PM +0530, Amit Singh Tomar wrote:
> This commit adds device tree binding reset constants for mmc controller
> present on Actions S700 Soc.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v1:
> 	* No change.
> Changes since RFC:
>         * added Rob's acked-by tag

And dropped??

> ---
>  include/dt-bindings/reset/actions,s700-reset.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
> index 5e3b16b8ef53..a3118de6d7aa 100644
> --- a/include/dt-bindings/reset/actions,s700-reset.h
> +++ b/include/dt-bindings/reset/actions,s700-reset.h
> @@ -30,5 +30,8 @@
>  #define RESET_UART4				20
>  #define RESET_UART5				21
>  #define RESET_UART6				22
> +#define RESET_SD0				23
> +#define RESET_SD1				24
> +#define RESET_SD2				25
>  
>  #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
> -- 
> 2.7.4
> 
