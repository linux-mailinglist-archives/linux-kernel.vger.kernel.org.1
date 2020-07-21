Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96093228315
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGUPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:04:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC6C061794;
        Tue, 21 Jul 2020 08:04:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so21956732eje.7;
        Tue, 21 Jul 2020 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/WjG1I1jw+gA2WhVK85qv6i+E0OUDyTrccx3Mlc7NQ=;
        b=YK4OMZ0XyyX1/+bnU5uyRqXAPi/NwezYZaL+3SQ/21qjHrQvQLB5QpTBCGqvSpfp2G
         0dvwYRP2ggj8iJi1OFLEc31LD/505o64O72+/gTxoOZo76Ndlm3mGjn2EZv/v3G6+v4a
         aKSmHBy1odMqQ7JRmYtoXEwS7f1gQ80r15lfBdhYEhTjVZMovK7UqEUBiH2Q2fqM/ocX
         +MXyHN/tmxYATerUHB9o6fDhGL+9FS/qmTCpWlTNbDwE0ediAtl2ZW9ncZW7nHeQSIGm
         A9fkEK5kJth3K/5fZzZK8QDZ7eH9+cZYIb2athqhWpi5JDknWKM5MevSvPLujUL5Ns9o
         VsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/WjG1I1jw+gA2WhVK85qv6i+E0OUDyTrccx3Mlc7NQ=;
        b=rQDJaDcW6td24SDb7pRMbc1NIQTx/OD5issXVX2IO0SC2fJHKRAptLg9GElRC+6+0F
         MgGZ8aEflJHK8JU7YoXwOuOEQ8/o+pn6OlhWCzYNGfY7jacKsA0/amq/6p39Y1u3sQG1
         +P4hlryh/beHyJT3Fw2Lvii1aEFTmF3S6g6sF4zAKGRV6giy1g21IvCLIFFs2z1cF9wE
         wGzwVJ4lDP8h/m1ojkymcpRnfkplyCxMxk0v6+UEKKFGPsBYA5V2f/289K5Ny7hKVkPb
         NSswCtqaH3uGSDl8mk2A0IBKzgPeI4Pz0Xc0pWmLLhwpVhVIUy2LKlJu4Z5ANnM58zDJ
         /DMw==
X-Gm-Message-State: AOAM530W9Gel86/iZKD3X/T63t+BbLC4Kv1RY4eB3Mkvuf5NiF6GkX2I
        E1BGVCvPzIkVwMMag3TOHoBcjmrLJ0QKOfcKIDo=
X-Google-Smtp-Source: ABdhPJyUPjX5E5t4LX3TbhkOYN5/ZjIzw5tH08WLxfBJzEMURod+CD9+rMNIPF5jUFqS644hvbpGtTtu+Lo5lbvFQ98=
X-Received: by 2002:a17:906:40cb:: with SMTP id a11mr24668088ejk.340.1595343887718;
 Tue, 21 Jul 2020 08:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com> <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
In-Reply-To: <20200705033511.GR388985@builder.lan>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Tue, 21 Jul 2020 17:04:11 +0200
Message-ID: <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcrouse@codeaurora.org, John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So.. is this a no-no?

I of course would like to omit this entirely, but SMMUs on sdm630 and
friends are REALLY picky.. What seems to happen is that when the
driver tries to do things the "standard" way, hypervisor decides to
hang the platform or force a reboot. Not very usable.


This thing is needed for the platform to even boot properly and one
more [1] is required to make mdss work with video mode panels (the
fact that CMD-mode panels work is kinda hilarious to me).

To be honest, there are even more qcom quirks (of which at least
qcom,dynamic and qcom-use-3-lvl-tables are used on 630).. [2]

Looking forward to your answers and possibly better solutions.

[1] https://github.com/konradybcio/linux/commit/83ac38af259968f92b6a8b7eab90096c78469f87
[2] https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.7.1.r1/drivers/iommu/arm-smmu.c#L404-L415

Regards
Konrad
