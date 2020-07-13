Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3203821E398
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGMX0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:26:50 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:32867 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgGMX0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:26:49 -0400
Received: by mail-il1-f195.google.com with SMTP id a11so12755991ilk.0;
        Mon, 13 Jul 2020 16:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFHxmFovIONmFHC16SgYEBEmQflmApOzLP9xBoHSyPQ=;
        b=Q4KZLMWE2vqUR170ZODgzdQrTAMupva59AU01kF00X5sJKpYAm0dQxGSxIztwwHLX1
         clbJa33UKZq4BvEyg0WpMr0UdUY76ILhMnIkTgshl+NiA6qj71H5rGRPz1szgKZhf2C7
         Ai6/0V7TBQaO17RFcQtLHdzS8kEtSVdqTnVzSuVBVnru984pbS2+b8gkuc0JmPxG/SW3
         H9L1Ii+t9Yz1J5ArxgalCPvmiJEcNuc4oWnK5DWTRvx6a2mFti/Xhygb7Y1jOFgHj0+M
         guXakzabxlMYMVFsbXzZ3jIJK37tIp2rFZjyekckrZwyohZVulGaM4jWUdSCVukz+/pk
         Owjg==
X-Gm-Message-State: AOAM533LEh4pPAZH2zoP1u/tgbb6X+4zOfDLUu9u9OQgKt5LZ6FH6psl
        l0wtno+rmNtWwOTxO7agYw==
X-Google-Smtp-Source: ABdhPJy27qX13+1tE7jE7ld3JUbpRnx6b9MQxu2pNLGxORohD464R9qTtxL5/b+eqH9TQVbwBK8ijQ==
X-Received: by 2002:a92:1592:: with SMTP id 18mr2153733ilv.17.1594682808882;
        Mon, 13 Jul 2020 16:26:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm8910046ilq.9.2020.07.13.16.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:26:48 -0700 (PDT)
Received: (nullmailer pid 917599 invoked by uid 1000);
        Mon, 13 Jul 2020 23:26:47 -0000
Date:   Mon, 13 Jul 2020 17:26:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, wens@csie.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        jason@lakedaemon.net, mripard@kernel.org, tiny.windzz@gmail.com
Subject: Re: [PATCH v3 11/16] dt-bindings: irq: sun7i-nmi: fix dt-binding for
 a80 nmi
Message-ID: <20200713232647.GA917546@bogus>
References: <20200713021309.31885-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713021309.31885-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 10:13:09 +0800, Frank Lee wrote:
> There is no one use "allwinner,sun9i-a80-sc-nmi". The A80 uses
> "allwinner,sun9i-a80-nmi".
> 
> Let's fix it.
> 
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  .../bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
