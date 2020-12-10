Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA42D58F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbgLJLI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgLJLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:08:58 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA0C0613CF;
        Thu, 10 Dec 2020 03:08:18 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id g15so4331793ybq.6;
        Thu, 10 Dec 2020 03:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMRZYbq3/YGGQqCtm0ztggAEksDLbdNXFqO3NqcBf7o=;
        b=fHRJRDkrFJ0b2hAIm/OBhL4fExu4aI4qM5Q6YkBYURJVyCOQdxoHleTqdUmbO/ENwK
         xG5XV5zl3c9gbSiBSt+wmBweD2R8feb8cMvRauhTQqYFnYT8MY2XZvB9TjY5cmVFUfVu
         I37K5GA7tpUlZL7llHaZMl6Aaqmr7JRfBFItzdeGKcGrEyXNi5gNpuTr1iwsOUMMtvSo
         n5u0VKRkb5wnZFFp3fduENxJdqZ+FR6W6rsePa88w08XGe61RXlkNIMqGP0mf+THKAnB
         qQc+UhfjTnm8jabD+zOm58qaxRytBkpTHEqE2E3P4hiIKdIPq3fSCWniWWufRSC+GP23
         1DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMRZYbq3/YGGQqCtm0ztggAEksDLbdNXFqO3NqcBf7o=;
        b=i77QLUMZyWnLrvKMLkzYf+/HcQCBNPc9Sj44I/4ILuWpPfrKMd1BCr51eXW+H5mg1Z
         mRj19B8P41+VAsg3+4RAGTwznxEKWvGeV47QV0gyNBIfh0xdRSZeZk6raFQcg27E1J0I
         FM9JIzh3c/TxuYsCEfGhiGLjTMDmS4/xsXtzqHXZY6VvwjnV5l9ewT4By+6NEs2Tf1Qj
         qTCslLZ+9SBd0Ac0NCvQ9BM7+fvon4k5PPhmnPV4WL3M5KCdPzADXpxbSrr3Eo214ust
         TFdhyKpA0b43qHrkZG5G440gpSlReM5nSLRYh1kt4xSLg3Yao4oAaAfuI2I/IpmgE+aO
         QvYA==
X-Gm-Message-State: AOAM530iXuHUdNQG2BKwFP1G/Istew6ZE/KEpyo0t5Wn3CLCOZmSrevv
        TozoZ9Cfr6Ny+WgAJOa2/Q+6DSLD+hxHIF5yVBU=
X-Google-Smtp-Source: ABdhPJzhmyM1kStq1dHTTkK8Ne310hXwRuJi6G1CWZtXEXfrPVV1Y0OP/tZcsRT3RL7X8v5m/YbCiyBI4pK+a3ohHHk=
X-Received: by 2002:a25:ec5:: with SMTP id 188mr11136242ybo.387.1607598497708;
 Thu, 10 Dec 2020 03:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204085835.2406541-1-atish.patra@wdc.com> <20201204085835.2406541-6-atish.patra@wdc.com>
In-Reply-To: <20201204085835.2406541-6-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 10 Dec 2020 19:08:06 +0800
Message-ID: <CAEUhbmVZwW-KNcbTp-59wyu-0ia0v02cXy4vxFoYAUH2dbx4-Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] MAINTAINERS: add microchip polarfire soc support
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 5:07 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Add Cyril Jean and Lewis Hanly as maintainers for the Microchip SoC
> directory
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
