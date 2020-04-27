Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABC1B9529
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 04:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD0Cgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgD0Cgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:36:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F1C061A0F;
        Sun, 26 Apr 2020 19:36:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so9274077wmj.3;
        Sun, 26 Apr 2020 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIGMIvukWB0JR+cfXy+rA7pHtSrD50jP/W65MSIyFw0=;
        b=I3lIcaBhb86twoSNgoqT1NsiiU3+PpF0Jcck8obekQF8iTYFw/ekaYVtHZHbTkFzb6
         r1DhUEdhRM71vdTpvnuRUHiYGYCXaX5DX1DesiURaEru3xG5y3g4b8n95H2NUFoSImFr
         9JcyohpsbKt8yarW8TA2C4vL5iBI2CtdYjSIqiJADtS1NAa2iOoVuGPHafeoZT7g2DA+
         PjQaHvauOQ484DlG7OZUKaGJ63Dq3Ps7CKEIm0cgnP0r7A6RwMBA8PuIqiSWizsPVsHF
         C2nGuiN74p3D2l0jKMCFucdWgZGZGOMWsQw9mKxfZguIuJqxunh5e8AXBi4ob5R0PgHC
         w33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIGMIvukWB0JR+cfXy+rA7pHtSrD50jP/W65MSIyFw0=;
        b=gNpxtbMC1Jmx4GB/2NyZ5VPnX3sQBckYpDo0YFLq37SGAXMShfV3rF1sJnk1Nap65t
         mTTmtiM+9JnmJ761ftpY52jQb7IZAOossQ2YA23FrCRNk59tt3B4hOW3y2qA9QObiaaA
         /nCs+mU2ri/McDys1ntabdkiq1/OlDtOHZzJaZ9bMGpNIVifLNNS4NPrl2M1wSAURtdT
         tCtpu8bDR8pBYHClOs5GIqUSAXJwSIPPkC55craOV8Y8WEUckECAsarHgcAdICWtaxsl
         yHyDlgrnBI2bWD3gWXlcUKlk9RCSFd0ZJtXekICKPeXIymwoCm3KXRpOvrT63iAG6WNo
         0GYg==
X-Gm-Message-State: AGi0Puax8nVImTTiyitI5InQyXDoWZOZT+MFgu1iv2QEvQz7uK8T9HDe
        F/2+lobRJBNmjxmyFtlZRDY2AJHwY57ffFJ1Kr/QKfQo
X-Google-Smtp-Source: APiQypL0pr/s2dO3FQgXpMTObZzY0bdp17wEVkUxtYpLeHCgYpZRk0EmyZWKGJm1uIDkoAKE53Ebru7QqEtBt8EIImk=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr22760899wmj.3.1587955003408;
 Sun, 26 Apr 2020 19:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200414033325.26536-1-zhang.lyra@gmail.com>
In-Reply-To: <20200414033325.26536-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 27 Apr 2020 10:36:07 +0800
Message-ID: <CAAfSe-uz2v7AO_pb8zOMN-2RqJ6Y6p=apTQVo=pq_oiDmmOWuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] add mipi_csi_xx gate clocks for SC9863A
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 14 Apr 2020 at 11:33, <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> mipi_csi_xx clocks are used by camera sensors. These clocks cannot be
> accessed (even read) if their parent gate clock is disabled. So this
> patchset also add a check to parent clocks when reading these gate
> clocks which marked with the specific flag (SPRD_GATE_NON_AON).
>
> changes from v1:
> * added Rob's acked-by;
>
> Chunyan Zhang (4):
>   clk: sprd: check its parent status before reading gate clock
>   dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
>   clk: sprd: add dt-bindings include for mipi_csi_xx clocks
>   clk: sprd: add mipi_csi_xx gate clocks
>

Do you have comments or could you please take this patchset to your tree?

Thanks,
Chunyan

>  .../bindings/clock/sprd,sc9863a-clk.yaml      |  1 +
>  drivers/clk/sprd/gate.c                       |  7 ++++
>  drivers/clk/sprd/gate.h                       |  9 ++++++
>  drivers/clk/sprd/sc9863a-clk.c                | 32 +++++++++++++++++++
>  include/dt-bindings/clock/sprd,sc9863a-clk.h  |  5 +++
>  5 files changed, 54 insertions(+)
>
> --
> 2.20.1
>
