Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC842EEB9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAHDEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:04:10 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34055 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAHDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:04:09 -0500
Received: by mail-io1-f44.google.com with SMTP id i18so8415814ioa.1;
        Thu, 07 Jan 2021 19:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7AhJtVW3hdKiTBxP5hqSzO8QFcAILtgkgTjKoMoo8qc=;
        b=fnm3NLJVq3CnzzsZLM90au918LYQF9HxMlDqJ8ognemTV6/EnGZpPP4in9kQqKSnSz
         h9C8CyHrz0Y5klqbHohOboNpH2qYFQfauWNm5r4r7MhEx2q+XXTbd/WfPyHjgleuE1bc
         I0ILJKBsol1Pal8rSKH0n4KryNik2yjay54N2VLCGmJb+Y/z/TgpcrmhnlkUVzkNT/ED
         0Hjoz0+d5BjyPMPO6kC2FzjEnls1HqhoUmScX/Ty1nfZQqKngsysqvs/jLt44IX2Z9R6
         UCHw7EbFzAZcDcfE44YDNV1c2Eneqk+3samBUpqMASvspXaIbrCj4VRT2oHkkdWravWX
         ZUAw==
X-Gm-Message-State: AOAM531UxwnRDvP1Mv3V5Q5b+G7CB4RpX8mD9sLShrWAeB57vfA++Kr3
        UeNxgNZGnYmPc5VtxjRzxw==
X-Google-Smtp-Source: ABdhPJzSrYmiVrZyU+/Rs5g/4+aHh390qkWNVyuKhoFsJ8B5qS6fOFZ40uBapmh9FrAfdGL+I3KT0w==
X-Received: by 2002:a6b:f202:: with SMTP id q2mr3737128ioh.87.1610075008863;
        Thu, 07 Jan 2021 19:03:28 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v5sm4526754iob.26.2021.01.07.19.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:03:28 -0800 (PST)
Received: (nullmailer pid 1797545 invoked by uid 1000);
        Fri, 08 Jan 2021 03:03:25 -0000
Date:   Thu, 7 Jan 2021 20:03:25 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
Message-ID: <20210108030325.GA1794594@robh.at.kernel.org>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-5-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 05:12:47PM +0530, Kishon Vijay Abraham I wrote:
> AM64 has a single lane SERDES which can be configured to be used
> with either PCIe or USB. Define the possilbe values for the SERDES
> function in AM64 SoC here.

Doesn't look like this is used? Would the common phy modes work?
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index 9047ec6bd3cf..68e0f76deed1 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -90,4 +90,8 @@
>  #define J7200_SERDES0_LANE3_USB			0x2
>  #define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
>  
> +/* AM64 */
> +#define AM64_SERDES0_LANE0_PCIE0		0x0
> +#define AM64_SERDES0_LANE0_USB			0x1
> +
>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
> -- 
> 2.17.1
> 
