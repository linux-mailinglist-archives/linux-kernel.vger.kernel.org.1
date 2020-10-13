Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9933C28CCFE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgJML4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJMLzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:55:32 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90FA62173E;
        Tue, 13 Oct 2020 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590131;
        bh=C2W5GeQS+7lax4NZVnOhccUWWt4QYGNc1nU/WmZV4M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3Ld85uO14OJ4zdp1b7UN2ZI63616iIvwvgJr5ZxtVpSprY1CzZ28FXYoRfP97Gdw
         SG+HmIluE910NkjJwYDdm1kR0nSkh/K8Jl8NZIxGk+sfEpN4juRMXht8XGksm0D4/w
         bg+c7/78mBYw9SQxZYzONtP4gYXCi4FvO/2gtwL4=
Received: by mail-oi1-f178.google.com with SMTP id l85so22148112oih.10;
        Tue, 13 Oct 2020 04:55:31 -0700 (PDT)
X-Gm-Message-State: AOAM533YBq8hlzDNDRJlP0tkND+vGIM4oIpb5MG+vKi+lZ+5Vl2L+1gX
        HOWHoW1eDNH0eP3O7kaYS53ZJI0wEuWKfGnAcQ==
X-Google-Smtp-Source: ABdhPJxxYPKhssmznIx9VsXNI0i4rSVXTw07iOkQOp7rQN8Ql63pntT4PeU3qJnCUj0QuKXDxsKeqxMcWYPO54bPpq8=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr14017312oia.147.1602590130782;
 Tue, 13 Oct 2020 04:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201012191648.GA1908871@bogus> <61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org>
In-Reply-To: <61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Oct 2020 06:55:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Cmr=92+7aSoNpCXdCTHysvVqU2mn7=GjrUp-7Wn1QNA@mail.gmail.com>
Message-ID: <CAL_Jsq+Cmr=92+7aSoNpCXdCTHysvVqU2mn7=GjrUp-7Wn1QNA@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: mailbox : arm,mhuv2: Add bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>, morten_bp@live.dk,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch adds device tree binding for ARM Message Handling Unit (MHU)
> controller version 2.
>
> Based on earlier work by Morten Borup Petersen.
>
> Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> V3->V4:
> - Made interrupts property compulsory for receiver
> - Added interrupts for both nodes in example
> - Fixed min/max items for protocols property
> - Don't add -tx/rx to node's name.
>
> V2->V3:
> - compatible is changed to arm-mhuv2-tx/rx. Later version of MHUv2
>   have an interrupt in the sender mode as well and we can't find if a
>   mailbox is sender or receiver just based on an interrupt anymore. We
>   needed a better way.
>
> - arm-mhuv2-mode is renamed to arm,mhuv2-protocols to fit the purpose
>   better.
>
> - Minor formatting otherwise.
>
> Morten: Please let me know if you want me to add your signoff here from
> some other email id as you no longer work with ARM.
> ---
>  .../bindings/mailbox/arm,mhuv2.yaml           | 215 ++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
