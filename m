Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEC2A4F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgKCTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbgKCTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:03:07 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 11:03:07 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 133so15069683pfx.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1MCrAKSHlV5HoEC6LZZ/5ih1567h/RI8mH7ZIf3CyE=;
        b=tYTtG07FanUbjPGNSIIErFGjf4TN/6g2Btl5CJXOXHj5H6TAO8s/NOltPuvMTBPEPI
         jUVn5W6jGc88sU0JqAa0nbqz74ERcgSZftm8CIPZOemeQxjXGLrrHYIyzWVZEoPw6A/p
         tYyqzOLHiPWyXoupVJ2F1W01z4ovqLTvkxn6VMoNmafyYAU2CvtqFe/2QxlITv2qdT3i
         Dqv3yQlhD4fmqkOaNF3iyp0Zt+r8ynlhjXFtSFHVu9hT2xFJoLH84RqHFMu4BzAed8fA
         n+wL6qg6GkuWSUR82rQFk56hMG4+mSlSK9qUdtNRi4QRJloZP2auz6Vyy8ROLxgreyYl
         VgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1MCrAKSHlV5HoEC6LZZ/5ih1567h/RI8mH7ZIf3CyE=;
        b=aShXiHH3F/R0KghB5HxIUmceA/L3Rjmycv4YB1FL9qWzWLihR52Cjcy+L31WUdObE0
         xCxjdNs2pM5ipWU7HW6ovXgdwGuEe1scuHWHSJzfqPbMfyYSNOqYj+I48pakWu/J0Djm
         w+3hdE5iMPmYbyXglILZTCLT9Bm9oJRZD+xd0zD2+Pb+V3oEyyTLHQtS5h+3b9EoeXeA
         B9tmhnRe0q/DtXU07mayPvWAzhoScCRKL9SZA8K3OI88a9lBhQvllHzoOmqKb+pRnn55
         GkR2QlIStlWQnnHoeNoeW5h5gxPJGdUOqjgH11rC8tg2te/7uh4tUWQCYaHiuL9byuUr
         bXjw==
X-Gm-Message-State: AOAM531p4rA1UFI8pibded6Yl/3aH4NoIZy3XP1iacxrQ5628p+zfATQ
        AU3sQHIy0sYv/5H8uo6idrktr4KdDQaKqw==
X-Google-Smtp-Source: ABdhPJxXNtyp//WsG6sYBVzaUsGW2R1ZAdaoPmSUiqfAjZIUj9oVlLFm3S2avsp6ih93kcL/YpqZbQ==
X-Received: by 2002:a65:52cb:: with SMTP id z11mr17726118pgp.368.1604430187148;
        Tue, 03 Nov 2020 11:03:07 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e22sm3585340pjh.45.2020.11.03.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:03:06 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:03:04 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/26] coresight: etm4x: Add commentary on the
 registers
Message-ID: <20201103190304.GF2855763@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-15-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-15-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:32PM +0000, Suzuki K Poulose wrote:
> As we are about define a switch..case table for individual register
> access by offset for implementing the system instruction support,
> document the possible set of registers for each group to make
> it easier to co-relate.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'm done for today and will continue tomorrow.

Thanks,
Mathieu

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 14e0f29db6b3..510828c73db6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -44,13 +44,13 @@
>  #define TRCVDSACCTLR			0x0A4
>  #define TRCVDARCCTLR			0x0A8
>  /* Derived resources registers */
> -#define TRCSEQEVRn(n)			(0x100 + (n * 4))
> +#define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
>  #define TRCSEQRSTEVR			0x118
>  #define TRCSEQSTR			0x11C
>  #define TRCEXTINSELR			0x120
> -#define TRCCNTRLDVRn(n)			(0x140 + (n * 4))
> -#define TRCCNTCTLRn(n)			(0x150 + (n * 4))
> -#define TRCCNTVRn(n)			(0x160 + (n * 4))
> +#define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
>  /* ID registers */
>  #define TRCIDR8				0x180
>  #define TRCIDR9				0x184
> @@ -59,7 +59,7 @@
>  #define TRCIDR12			0x190
>  #define TRCIDR13			0x194
>  #define TRCIMSPEC0			0x1C0
> -#define TRCIMSPECn(n)			(0x1C0 + (n * 4))
> +#define TRCIMSPECn(n)			(0x1C0 + (n * 4)) /* n = 1-7 */
>  #define TRCIDR0				0x1E0
>  #define TRCIDR1				0x1E4
>  #define TRCIDR2				0x1E8
> @@ -68,9 +68,12 @@
>  #define TRCIDR5				0x1F4
>  #define TRCIDR6				0x1F8
>  #define TRCIDR7				0x1FC
> -/* Resource selection registers */
> +/*
> + * Resource selection registers, n = 2-31.
> + * First pair (regs 0, 1) is always present and is reserved.
> + */
>  #define TRCRSCTLRn(n)			(0x200 + (n * 4))
> -/* Single-shot comparator registers */
> +/* Single-shot comparator registers, n = 0-7 */
>  #define TRCSSCCRn(n)			(0x280 + (n * 4))
>  #define TRCSSCSRn(n)			(0x2A0 + (n * 4))
>  #define TRCSSPCICRn(n)			(0x2C0 + (n * 4))
> @@ -80,11 +83,13 @@
>  #define TRCPDCR				0x310
>  #define TRCPDSR				0x314
>  /* Trace registers (0x318-0xEFC) */
> -/* Comparator registers */
> +/* Address Comparator registers n = 0-15 */
>  #define TRCACVRn(n)			(0x400 + (n * 8))
>  #define TRCACATRn(n)			(0x480 + (n * 8))
> +/* Data Value Comparator Value registers, n = 0-7 */
>  #define TRCDVCVRn(n)			(0x500 + (n * 16))
>  #define TRCDVCMRn(n)			(0x580 + (n * 16))
> +/* ContextID/Virtual ContextID comparators, n = 0-7 */
>  #define TRCCIDCVRn(n)			(0x600 + (n * 8))
>  #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
>  #define TRCCIDCCTLR0			0x680
> -- 
> 2.24.1
> 
