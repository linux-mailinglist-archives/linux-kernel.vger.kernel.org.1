Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0373B2D1DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgLGWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:52:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45839 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgLGWwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:52:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id h18so10172377otq.12;
        Mon, 07 Dec 2020 14:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGKTxegR211Y4pxTw/c6D3ElM1Y9Rkhy1L6nJUtWY5o=;
        b=dLwmYPkhqETrGNPB/OkWivsDqSFvxqzzlf55ESlapw83I0jhy4zt9GYEG4sPa1mjFK
         1wAixU9EnA1b4+pXEDuaWCC9wb4Y1ruJ/cT3g+Znmm2Th+Nwaurvxr6UP3Q8LL7FTutv
         mQP8dQoMGZXQhrZ/pysj+qnlQhlZjd1R97SQnMpV174Aj/Lipx6BE7Fu5HcrEFHWwuVL
         k9ZcFdsl6RXPMrlLNZxX8GOnJxd040VN+s/MKf/q1sr6lefg6G0XfILEZbM0UO+hpwdE
         Dse2pLPczMXHmT92eyS/VsFtjP8SGRoOqiUSoqxg1dLe69eNL9/bz9Ki+20GolMgUy6C
         t/+A==
X-Gm-Message-State: AOAM531XRLcIQOg5WvmxePlNWEn15lq9lhE1nXYxixeJixUElFprnfhg
        xExdEgxvxRacTShxuxANsTM83RnQ3w==
X-Google-Smtp-Source: ABdhPJzAEyFWBw8aRWodf+kbRFrizaA2A6sKnSxzif1vg6tYA4do5tJjEUn6/sY2OabGg1xZ8r/f8g==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr14433439otk.262.1607381480806;
        Mon, 07 Dec 2020 14:51:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u10sm2993855otj.31.2020.12.07.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:51:19 -0800 (PST)
Received: (nullmailer pid 991883 invoked by uid 1000);
        Mon, 07 Dec 2020 22:51:18 -0000
Date:   Mon, 7 Dec 2020 16:51:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-ide@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        pchandru@nvidia.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
Message-ID: <20201207225118.GA991823@robh.at.kernel.org>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
 <1606162645-22326-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606162645-22326-4-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 12:17:22 -0800, Sowjanya Komatineni wrote:
> This patch converts text based dt-binding document to YAML based
> dt-binding document.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 138 +++++++++++++++++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
>  2 files changed, 138 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
