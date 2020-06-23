Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E82054E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgFWOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbgFWOhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:37:08 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94AA20776;
        Tue, 23 Jun 2020 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923028;
        bh=mkt8dmPDhXNmt2xf23Tm96zuc+IIftb4GzsYnAog1gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nrckng5bhZywoY2H4UQEn8ZatmqTxurbAUbnXWiUCmbZZDTgj7xj3HI4KK4Usolu3
         DAu0alGoTzXr16Vm52qbehY4kwbd8ozxR+XMTCt2W4Yt6QKN58HzyZygJw8gCBjNNc
         idTyGSKrHvbraiB0ZDtgL+XjksVYkGoi1duT6krE=
Received: by mail-lj1-f179.google.com with SMTP id q19so23746091lji.2;
        Tue, 23 Jun 2020 07:37:07 -0700 (PDT)
X-Gm-Message-State: AOAM533shaZOb6nSP3rLBKbLr/hHqrG3IslbD89GSRWDwcA4Tk4wSMr4
        kUcAPEV6wx3htN/pXukaau2RUws9rnBCThQ1crM=
X-Google-Smtp-Source: ABdhPJwAKP2RwWCfrk1lzjJQi1Ti/32Bj7LA/Y6jCdNCwky8kwiheblaoXr2cW9hCKV23rZ6oFRVXfEvEvSTJfd3h1c=
X-Received: by 2002:a2e:954c:: with SMTP id t12mr11068568ljh.287.1592923026058;
 Tue, 23 Jun 2020 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
In-Reply-To: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jun 2020 16:36:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdr6Fq93e8yZUPB_PGWfY4X9+fvWGznkUy=0DQ8=QeiKw@mail.gmail.com>
Message-ID: <CAJKOXPdr6Fq93e8yZUPB_PGWfY4X9+fvWGznkUy=0DQ8=QeiKw@mail.gmail.com>
Subject: Re: krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     gtucker@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 16:23, kernelci.org bot <bot@kernelci.org> wrote:
>
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
>
> Summary:
>   Start:      d6fe116541b7 Merge branch 'next/soc' into for-next
>   Plain log:  https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
>   HTML log:   https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
>   Result:     5b17a04addc2 ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       krzysztof
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>   Branch:     for-next
>   Target:     bcm2837-rpi-3-b

Looks like false positive. The commit does not touch anything in arm64/bcm.

Best regards,
Krzysztof
