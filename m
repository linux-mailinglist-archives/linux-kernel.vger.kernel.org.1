Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249F7270470
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgIRSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 14:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIRSzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:55:50 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42E221D7F;
        Fri, 18 Sep 2020 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455349;
        bh=ihI+7BKGkkYmKR73JMuy1SHqDYxONOS9ajlx6wIRavI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kHGs21LjRsgm28Qa+KeanX9BjuQuudufV+XoGsDt75JdTSZZHLKXBu5oWyvrczFmt
         GxqZ9ihO15nysNNipKsqNsYD+yDH0l/JM+3tNiByRAo5sGPE9KZJTsCXRTod8zxSag
         tL7gmzydlKuszNKet0jQ3e7KGQ/n4y6A1fAlCZEc=
Received: by mail-ot1-f51.google.com with SMTP id q21so6325129ota.8;
        Fri, 18 Sep 2020 11:55:49 -0700 (PDT)
X-Gm-Message-State: AOAM532m4Z7vwHTyTqN2DX6p+Tq72cl5tmVhj/kg1np+0bjcp0/XT4Fi
        CUyZVf1bP7Mcf0UPUxQzyLPxHpqHQNNL5yIMPQ==
X-Google-Smtp-Source: ABdhPJwfcYWEDoDMqrgG2knzf4aCim7g04Lemlql1hss4d1AAsDpNE9H9/loKt4hRFPQvgrTjJ8xkBXNZeco4XovUP4=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr10131043otq.192.1600455349030;
 Fri, 18 Sep 2020 11:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
 <20200903120504.2308-2-thunder.leizhen@huawei.com> <20200914203110.GA185427@bogus>
 <4873e234-d06c-930e-6645-a832164e18ea@huawei.com> <0928ac6a-2295-4e87-5191-4fd4580f87b5@huawei.com>
In-Reply-To: <0928ac6a-2295-4e87-5191-4fd4580f87b5@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Sep 2020 12:55:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK3635vQGK+mw+GKz5Sj2YKEt6+sj8MNo0d3hFESbfUKw@mail.gmail.com>
Message-ID: <CAL_JsqK3635vQGK+mw+GKz5Sj2YKEt6+sj8MNo0d3hFESbfUKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: add Hisilicon
 SD5203 vector interrupt controller
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 9:30 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/9/15 14:12, Leizhen (ThunderTown) wrote:
> >
> >
> > On 2020/9/15 4:31, Rob Herring wrote:
> >> On Thu, Sep 03, 2020 at 08:05:03PM +0800, Zhen Lei wrote:
> >>> Add DT bindings for the Hisilicon SD5203 vector interrupt controller.
> >>>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>> ---
> >>>  .../hisilicon,sd5203-vic.txt                  | 27 +++++++++++++++++++
> >>
> >> Bindings should be in DT schema format now.
>
> Do I need to change the existing "snps,dw-apb-ictl.txt" to DT schema format?

That would be nice, but not necessary for minor changes.

Rob
