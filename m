Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0A2A07DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgJ3O3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3O3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:29:41 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2B922228;
        Fri, 30 Oct 2020 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604068180;
        bh=qsVa9k8Wl+Z5KQVAZGKVs8j/WHBtdKWOwbQHwlaXnRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2o5OIpvKRvgunRH6E0WYQATf6zc80v399OGJni4pBAW6X8PL8/YNpOrsFsh+EhOH
         159RRw5uFVd1fVtpfX3Vqz8HuwG956KTbcndJoXviYKTdHp9EGJpJgi8Fm4SazNLhQ
         h2ScfQIDKTSvSjK2+fq4e7anR3oaaOhUSq6dQKN4=
Received: by mail-ot1-f51.google.com with SMTP id j21so5664748ota.13;
        Fri, 30 Oct 2020 07:29:40 -0700 (PDT)
X-Gm-Message-State: AOAM5339btfKEm/kDoc9nUQj9PruG6JfsO4kdaOxurPCjWVQAqa2nraS
        zim+ePi+qVmnyWEuMyUjVPHPC7uAb0/8orZolA==
X-Google-Smtp-Source: ABdhPJzIDz1vHsjd0mZx2C3VuQDbrssjCTAGOiEKtovrg3KUWMEdfsM/44ZPa+xsp7OFwsxVn7kbaTkBxgcv3W618P4=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr1963470otk.192.1604068179674;
 Fri, 30 Oct 2020 07:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
In-Reply-To: <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Oct 2020 09:29:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
Message-ID: <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>
>
>
> On 10/29/20 4:40 PM, Rob Herring wrote:
> > On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> >> Power operation mode may depends on hardware design, so, add the optional
> >> property power-opmode for usb-c connector to select the power operation
> >> mode capability.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> ---
> >>   .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> index 728f82db073d..200d19c60fd5 100644
> >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> @@ -93,6 +93,24 @@ properties:
> >>         - device
> >>         - dual
> >>
> >> +  power-opmode:
> >
> > I've acked this version:
> >
> > https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
> >
>
> frs is used for Fast Role Swap defined in USB PD spec.
> I understand it allows to get the same information but I'm wondering why
> the property name is limited to -frs- in this case. What about a
> non-power delivery USB-C connector ?

I've got no idea. The folks that know USB-C and PD details need to get
together and work all this out. To me, it looks like the same thing...

And it's not just this, but the stream of USB-C additions that trickle in.

> Moreover, power-opmode property support is already merged in typec class:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/typec/class.c?h=v5.10-rc1&id=12f3467b0d28369d3add7a0deb65fdac9b503c90
> and stusb160x driver uses it :(
>
> So, do I need to modify stusb160x driver (and bindings) to take into
> account this USB PD specific property?

If not documented, then it's not an ABI, so yes.

Rob
