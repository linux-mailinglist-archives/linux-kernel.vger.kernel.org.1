Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8D26C5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIPRPD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Sep 2020 13:15:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37631 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgIPRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4so7734583wrr.4;
        Wed, 16 Sep 2020 10:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f/vjZ5qVXOPRaO7N1qyaXW4EBfCPk0ZUVPktaETjU8A=;
        b=NULsmW+HpSjOhuhXrTrt+vxdr+f6loyKEFUiE7ZldinzC3sh0iI3Sj/Xnolmsse7XE
         +hpS6TXxIuMrFYZey82vBm03mjbkqoQbKcgnbk/GiV2A/rXU9ejOhUml85U4qVTUArHm
         dzgQ7BVAoliiSXrYPif8ciw7Y43XwRw6OyWbgnHthDemEpFIVWj1F8SYFHLbjjSh8lvA
         W7hwVhOKv3A7oD9HknFmKxY20nlGbJEBh0nDKGvv3VENvWzP6xJ6rW5iA8nT+uZUPaTh
         Y+grT4rDQ8M8/bWXCk4IAz/elC+bgsas+ZxkZIGN4hz4Q2MmtGgO9Pd2a72xO0tOdD2B
         7Ttg==
X-Gm-Message-State: AOAM530a9BbnbTC4gpTUW01WLLwPlIw4SIlyMEJt938w/2Kd09ftHvoW
        PkxHfbB0a47NgUQYsxeOhY8=
X-Google-Smtp-Source: ABdhPJwmJ2e+t9hZmYr64pvM4lBibRqr4nKDnRP/3Be66E5m5Qedo5Ij+8Wi/bjTZ1O7QlTmHILB8w==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr26930933wrp.37.1600276209235;
        Wed, 16 Sep 2020 10:10:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id v9sm38769873wrv.35.2020.09.16.10.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:10:07 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:10:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tomasz Figa <t.figa@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: s3c24xx: fix Wunused-variable warning on !MMU
Message-ID: <20200916171005.GB19427@kozik-lap>
References: <20200910154150.3318-1-krzk@kernel.org>
 <20200910154150.3318-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200910154150.3318-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 05:41:50PM +0200, Krzysztof Kozlowski wrote:
> If S3C24xx machine code is build without CONFIG_MMU, the iotable()
> macros do nothing so annotate structures to get rid of warnings:
> 
>   arch/arm/mach-s3c24xx/common.c:140:24: warning: ‘s3c_iodesc’ defined but not used [-Wunused-variable]
>   arch/arm/mach-s3c24xx/s3c2410.c:49:24: warning: ‘s3c2410_iodesc’ defined but not used [-Wunused-variable]
>   arch/arm/mach-s3c24xx/s3c2412.c:60:24: warning: ‘s3c2412_iodesc’ defined but not used [-Wunused-variable]
>   arch/arm/mach-s3c24xx/s3c2416.c:54:24: warning: ‘s3c2416_iodesc’ defined but not used [-Wunused-variable]
>   arch/arm/mach-s3c24xx/s3c2443.c:45:24: warning: ‘s3c2443_iodesc’ defined but not used [-Wunused-variable]
>   arch/arm/mach-s3c24xx/s3c244x.c:44:24: warning: ‘s3c244x_iodesc’ defined but not used [-Wunused-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-s3c24xx/common.c  | 2 +-
>  arch/arm/mach-s3c24xx/s3c2410.c | 2 +-
>  arch/arm/mach-s3c24xx/s3c2412.c | 2 +-
>  arch/arm/mach-s3c24xx/s3c2416.c | 2 +-
>  arch/arm/mach-s3c24xx/s3c2443.c | 2 +-
>  arch/arm/mach-s3c24xx/s3c244x.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied.

Best regards,
Krzysztof

