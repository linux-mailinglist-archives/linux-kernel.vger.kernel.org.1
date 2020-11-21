Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675752BBB89
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgKUB3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgKUB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:29:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A47C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:29:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so9577405pfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RYuSCvZCwqyETo386P8sWNEaEYD1M71i/48IDc0TFTI=;
        b=BZyizWUDJ58KxyEwloasLLYMqzf6DIXdjtsJk44VEXmk/u216pKjQlq7/ta3/5wFFA
         /4a1L2Ln7y7QbpgpFLdiABUhqqSjISSB/7Kb23itU+UyexMH2/Jh3yGser3zTAFH/lFK
         1fYzSPyPpRPjeM0bKK1SQ7wbv5TiZRt5PLTNnpdn6dRohqWNQXBKt6mTows04Tlo3pQ/
         dwP4Dw+1fPBXPcJZNvvKrMfz/YIiIhUcF/ekNF6Ezbrk/hCx1fm0lDX4hiwzQFPxgoWJ
         idBjz2XwcC7OF72rqcacDJRbLSgVd508HBUyE5GUN6I0iVteXikZgW6v9JsPkNTclE6q
         ppoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RYuSCvZCwqyETo386P8sWNEaEYD1M71i/48IDc0TFTI=;
        b=o64kg5tW4X1ZYDT8uW8vVb/ZPxBiOvTtaJtdHi7OWPB6xGmj1MRjXdrTEhBwgfsC48
         vNDt/Mm1Wb1NvBhITGCUtZj9qN997BDw5PYycwf2XET4medC6inHav+7WrYPClupAIZK
         +WvzqnSEc6ORpKFrizTo7YoQwrgieIyVtaK7QEqUVzIpoInv/gp1Oj7ZpnnmmljpjcoO
         P0qJAMkcH745i3H/mBjnA2LK5t/4f5hwsr+PUmM2y661ZUv6N4rUh0RYRRw33RBXGnvK
         4qOXnBXZAPB2XeQFkCb0igsvlp5r5knEzIwS5ap8xCFVHf4zxvwPyNo3gD3+0CoZh3p9
         u7gQ==
X-Gm-Message-State: AOAM530QlnpQzpTDnqktF6teczLxf1vdQR1JPJSZ5I1UJ6J83WDIF0Cg
        LgxsN0zfK64IAmlGqjJFsmP1tA==
X-Google-Smtp-Source: ABdhPJzOQ5N9xyaCCoDJftWz+nA3rWzAz1qtBnDtfpqbHEcjJOeCYjsDG9EoKozAfWZzau5aySWivQ==
X-Received: by 2002:a63:f20:: with SMTP id e32mr19335777pgl.130.1605922169524;
        Fri, 20 Nov 2020 17:29:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e8sm4607562pfn.175.2020.11.20.17.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:29:28 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:29:28 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 17:26:26 PST (-0800)
Subject:     Re: [PATCH v4 4/4] clk: sifive: Fix the wrong bit field shift
In-Reply-To: <20201111100608.108842-5-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com, pragnesh.patel@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-738e4a27-9751-4937-b3ed-efdcdce56f0c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 02:06:08 PST (-0800), zong.li@sifive.com wrote:
> The clk enable bit should be 31 instead of 24.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reported-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  drivers/clk/sifive/sifive-prci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
> index 802fc8fb9c09..da7be9103d4d 100644
> --- a/drivers/clk/sifive/sifive-prci.h
> +++ b/drivers/clk/sifive/sifive-prci.h
> @@ -59,7 +59,7 @@
>
>  /* DDRPLLCFG1 */
>  #define PRCI_DDRPLLCFG1_OFFSET		0x10
> -#define PRCI_DDRPLLCFG1_CKE_SHIFT	24
> +#define PRCI_DDRPLLCFG1_CKE_SHIFT	31
>  #define PRCI_DDRPLLCFG1_CKE_MASK	(0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
>
>  /* GEMGXLPLLCFG0 */
> @@ -81,7 +81,7 @@
>
>  /* GEMGXLPLLCFG1 */
>  #define PRCI_GEMGXLPLLCFG1_OFFSET	0x20
> -#define RCI_GEMGXLPLLCFG1_CKE_SHIFT	24
> +#define RCI_GEMGXLPLLCFG1_CKE_SHIFT	31
>  #define PRCI_GEMGXLPLLCFG1_CKE_MASK	(0x1 << PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
>
>  /* CORECLKSEL */

Section 7.3 of v1.0 of the FU540 manual says that bit 24 contains the PLL clock
enable for both of these.  I don't know if that's accurate, but if it is then I
believe this would break the FU540.  Don't have one to test on, though.
