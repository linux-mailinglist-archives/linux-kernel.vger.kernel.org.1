Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1D2EC049
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAFPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbhAFPUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:20:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 068C32311D;
        Wed,  6 Jan 2021 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609946383;
        bh=u/iJ2yg1n0QdcVgVvjTf284lvZQ11lam/cryS8nLa+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WotmtCzjWxb2CAu2KAtsKTJqh9iCxeOMgicnKsFyUrueNxBBcVCCmpWMJbg8PY8SO
         VFt7v5v95F3h4lF7UoXFeabAeqZHgU866dLUQQrZGu0jdI9RZPELcSdjK+OoEvW37U
         q0mdbZDCAzvwLFBCun8X7E9ZgDEt8NFeSCvFas0qa3f/4K3XPVwl1lsjP+t6l5pJhA
         SROujlVC3B1fXZGLceKzxvi7TQ727HRqhu9pKNB7rcomm3nMWJVGR1utKmSrS7+NR5
         lH1EYBshQUWRi4+1RJmbENh1kBUWaVTGKiMLhpqvzthK/KzcB3xdc0qFVMdk2eVMrp
         CRIZb2wQnRAIg==
Received: by mail-ej1-f42.google.com with SMTP id x16so5495813ejj.7;
        Wed, 06 Jan 2021 07:19:42 -0800 (PST)
X-Gm-Message-State: AOAM533zkV39EsVMBHq76NgypnulOxwz225Y3H8GGq3XcKbeJu/Vphjk
        og8es/ZLkyWIdnCQBrhldGBFDw82mxvEU9BlLg==
X-Google-Smtp-Source: ABdhPJwPL16fykEpX2fD9d2FVv1igr6adK+Y9++9zCcaas+Y0dkpBkV43bpwEX//uW/IjRj0aVqrCnagC5484H8w9Ew=
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr3151012eji.108.1609946381645;
 Wed, 06 Jan 2021 07:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20210104131755.2979203-1-bert@biot.com> <20210104131755.2979203-2-bert@biot.com>
 <1609866288.019144.372417.nullmailer@robh.at.kernel.org> <f5333394-8141-64ed-de30-d3b095ef579e@biot.com>
In-Reply-To: <f5333394-8141-64ed-de30-d3b095ef579e@biot.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Jan 2021 08:19:30 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+o+27V9DzDnShpWt+oLz38qF+a8a8eMi-qKr+nqJWSxw@mail.gmail.com>
Message-ID: <CAL_Jsq+o+27V9DzDnShpWt+oLz38qF+a8a8eMi-qKr+nqJWSxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Realtek
 RTL838x/RTL839x support
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 2:55 AM Bert Vermeulen <bert@biot.com> wrote:
>
> On 1/5/21 6:04 PM, Rob Herring wrote:
> > On Mon, 04 Jan 2021 14:17:54 +0100, Bert Vermeulen wrote:
> >> Signed-off-by: Bert Vermeulen <bert@biot.com>
> >> ---
> >>  .../realtek,rtl-intc.yaml                     | 57 +++++++++++++++++++
> >>  1 file changed, 57 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
>
> I fixed the syntax error that caused this to fail. But running the test now
> produces some errors that are not so obvious:
>
>    interrupt-controller@3000: interrupt-map: [[31, 4294967295, 2], [30,
> 4294967295, 1], [29, 4294967295, 5]] is too short
>
> Not sure where this comes from, but running dt-validate -v gives this:
>
>    Failed validating 'minItems' in schema['properties']['interrupt-map']:
>      {'maxItems': 24, 'minItems': 24}
>
> Where did that 24 come from? I don't even have 24 initerrupts to map :-)

If you don't define minItems, then the default is the same as
maxItems. So you need to set 'minItems'.

>
> Another error is this:
>
>    interrupt-controller@3000: 'interrupt-map-mask' is a dependency of
> 'interrupt-map'
>
> I can see this in your dtschema package's schemas/interrupt-controller.yaml
> where it's defined as a dependency, but why? I don't need that property.

This should be the other way around. I'll fix it.

Rob
