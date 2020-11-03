Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6A2A4FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgKCTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCTFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:05:11 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C03C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 11:05:11 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so291798iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXWx0muO7ecYMzH1YdnFMlkk5+baQEgQ629u9wRQxS0=;
        b=OZ37sC1pBnK6HQ3V8ADHTuAJf36wilIJ3Qhhqmp5BmdjuJbREzoXnQtAJLNGJA7oPe
         uNEOHMsJ3luq6XW8MvWYqKzNk9RtxukdveIeqHe/Br1wGIobxdWBBj3vrE5psDO05lXr
         t1LyzrFe2RfCfhdkK6Ze2lgSiUDjOxxYrvgt0UlJbzFWBnLWEpJgwwiaijyQQ0iF2Hql
         gAqhijntKPs/Z1K2tec3nlrfOX2YkWE5yIyD6XAvXo3+UAeEe0ZYB5kpn0nvcx9Mjpiu
         VfLU/k6LX4CdH65hTzm7YlXKCQaqrrTXj/Ga9W6vcFf5cOIe6N90oSa3N4CAOvD/N+wu
         aQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXWx0muO7ecYMzH1YdnFMlkk5+baQEgQ629u9wRQxS0=;
        b=kLRyqvO4M6NyxwIv7cFjHbeGgNnziRE0xpx0vS+1kHdYIKsnivs32lI8uuRRwHa3ac
         97RBMlyvPTh8kafEv95Cw2Cyak7zvZdO4/KevMXxVtgV54TdfwsXEIbhxu4SYE1UYLig
         cHWnhsxdlVRXqeUg1ijKWks0M1kz/7DlFtX2+48IT3R2fkVq2qw+KIPEeg8LiJuRSiHU
         hrUNJcySn5YoQDWPmTnWHYQHILz91zr0OxG3V+zteK55WqhfhgCPka1mZesB4Ta830dH
         i+6/gYfzuOqiIQvIJpA10L+eHLtLa8S7jwjPaKpQs/09C23rDZJSrlzoJ1yb2M+TsyQJ
         AHtw==
X-Gm-Message-State: AOAM532Z4QTpbNg/GrXuZcKJJFaCiZWgFcF+hVs0hT2/BhNbe6vJeya6
        BNr5wSiJtS3TAqis9yDpU336MaG2CQN4XYc5t9E2CSdkLuc=
X-Google-Smtp-Source: ABdhPJyqfBYEAFAY3u2TSmP/KzsKJmirRROwFwtt/XO4pHv4zqN2Df/D1kHZwbdRhi8QXnNuIt1W3njnj4SeWpNhpNo=
X-Received: by 2002:a05:6602:1352:: with SMTP id i18mr15327585iov.148.1604430310602;
 Tue, 03 Nov 2020 11:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20201028220945.3826358-1-suzuki.poulose@arm.com> <20201028220945.3826358-15-suzuki.poulose@arm.com>
In-Reply-To: <20201028220945.3826358-15-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Nov 2020 12:04:59 -0700
Message-ID: <CANLsYkxhsj39+oG6i8hWLUsrU5shSTEq88_6_5zmAJcbFjTMgA@mail.gmail.com>
Subject: Re: [PATCH v3 13/26] coresight: etm4x: Add commentary on the registers
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 at 16:10, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> As we are about define a switch..case table for individual register
> access by offset for implementing the system instruction support,
> document the possible set of registers for each group to make
> it easier to co-relate.

s/co-relate/correlate

>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 14e0f29db6b3..510828c73db6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -44,13 +44,13 @@
>  #define TRCVDSACCTLR                   0x0A4
>  #define TRCVDARCCTLR                   0x0A8
>  /* Derived resources registers */
> -#define TRCSEQEVRn(n)                  (0x100 + (n * 4))
> +#define TRCSEQEVRn(n)                  (0x100 + (n * 4)) /* n = 0-2 */
>  #define TRCSEQRSTEVR                   0x118
>  #define TRCSEQSTR                      0x11C
>  #define TRCEXTINSELR                   0x120
> -#define TRCCNTRLDVRn(n)                        (0x140 + (n * 4))
> -#define TRCCNTCTLRn(n)                 (0x150 + (n * 4))
> -#define TRCCNTVRn(n)                   (0x160 + (n * 4))
> +#define TRCCNTRLDVRn(n)                        (0x140 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTCTLRn(n)                 (0x150 + (n * 4)) /* n = 0-3 */
> +#define TRCCNTVRn(n)                   (0x160 + (n * 4)) /* n = 0-3 */
>  /* ID registers */
>  #define TRCIDR8                                0x180
>  #define TRCIDR9                                0x184
> @@ -59,7 +59,7 @@
>  #define TRCIDR12                       0x190
>  #define TRCIDR13                       0x194
>  #define TRCIMSPEC0                     0x1C0
> -#define TRCIMSPECn(n)                  (0x1C0 + (n * 4))
> +#define TRCIMSPECn(n)                  (0x1C0 + (n * 4)) /* n = 1-7 */
>  #define TRCIDR0                                0x1E0
>  #define TRCIDR1                                0x1E4
>  #define TRCIDR2                                0x1E8
> @@ -68,9 +68,12 @@
>  #define TRCIDR5                                0x1F4
>  #define TRCIDR6                                0x1F8
>  #define TRCIDR7                                0x1FC
> -/* Resource selection registers */
> +/*
> + * Resource selection registers, n = 2-31.
> + * First pair (regs 0, 1) is always present and is reserved.
> + */
>  #define TRCRSCTLRn(n)                  (0x200 + (n * 4))
> -/* Single-shot comparator registers */
> +/* Single-shot comparator registers, n = 0-7 */
>  #define TRCSSCCRn(n)                   (0x280 + (n * 4))
>  #define TRCSSCSRn(n)                   (0x2A0 + (n * 4))
>  #define TRCSSPCICRn(n)                 (0x2C0 + (n * 4))
> @@ -80,11 +83,13 @@
>  #define TRCPDCR                                0x310
>  #define TRCPDSR                                0x314
>  /* Trace registers (0x318-0xEFC) */
> -/* Comparator registers */
> +/* Address Comparator registers n = 0-15 */
>  #define TRCACVRn(n)                    (0x400 + (n * 8))
>  #define TRCACATRn(n)                   (0x480 + (n * 8))
> +/* Data Value Comparator Value registers, n = 0-7 */
>  #define TRCDVCVRn(n)                   (0x500 + (n * 16))
>  #define TRCDVCMRn(n)                   (0x580 + (n * 16))
> +/* ContextID/Virtual ContextID comparators, n = 0-7 */
>  #define TRCCIDCVRn(n)                  (0x600 + (n * 8))
>  #define TRCVMIDCVRn(n)                 (0x640 + (n * 8))
>  #define TRCCIDCCTLR0                   0x680
> --
> 2.24.1
>
