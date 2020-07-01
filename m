Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29C210277
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 05:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGADWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 23:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:22:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:22:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 76so5910296otu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6Wcbur2BcxA/2SwdlYsRcboQiRRQa/uiPODuO/VSLs=;
        b=RvCFU8605SjLYaG70zLK+0uxlwZUBkkmmgtY7dm3OkUTtJEowyKrLxgWa9uI8uHYgo
         NCQIY3xbQ6OOVxHAAyFAtD65pQC5VJA3MjkzNSma4jPJM/Pt/thqrtlFaBqDc2ZGIzua
         aLJPrHDKZY9Dl2ZmoB5ZN33Sq6CvkWYPVuPOGDXWnKmA8Iqrsx32nQP19R6NTb3GtvvC
         +QUueFod7xsOskHR6Pv9wfqdRbmBY4SYTjC4AjJ8L6Satxjm7ca0ijJCaCgt8ylBvLJs
         8X0fEXtMILLGYyIyJpzHw8mAJKdFZkAcsbs9SpjGB5MM7zFXah/seTbhuTeLSFzIMzCR
         3TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6Wcbur2BcxA/2SwdlYsRcboQiRRQa/uiPODuO/VSLs=;
        b=jagQj624s2/Cl9kxXQdsbUEJhkrKh2WDBOHUkWALOhnSc+dyKUGTDBT6uxBRIcU9rI
         Fw4hvFUKK63MvjlEPLX2z+ccqKtgq3l74wpz+L/rZFIN1gzlHJmCR8W02VuEYF+HAtVO
         5yEUFGWamjxdsMVLcTVh6H5oXfb+7TphhanYXrCMBATn2X6EJKe3cYE6lL1bTvappMbe
         MMPMjVFpV2E9HzLAPD/D1w+MotdqXuPSrccC7HBwhiKbagXU+6ssJUMTYyQtpR8Xcy8z
         BsJV6OPO+j+WUA3S4YXi/ljBq3hGl+Mk6JNGxoradD3lJR/K/cZvyra551HUxtdPkwrm
         g7/A==
X-Gm-Message-State: AOAM5306oR6EP60XuMm4LkWH167qdKN5iKC+R1Kq9T2CZVDmO4avdOh9
        ST3KjGFKxcqBLboB3+lEEdTV3PvOjz1/yDu4FwV1lnyFqyQT0g==
X-Google-Smtp-Source: ABdhPJwQ8eI9QVyXoY0iY48/NkTpBY2b114TMeosKBxvdz0skb3SSIDgp6VBMvnsq6whxCEGjBTpV271g6emaWULuZ8=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr21343282otc.129.1593573768420;
 Tue, 30 Jun 2020 20:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
 <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
 <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com>
 <CAAhSdy3BUfPCS+LUWp9GKdnf960N-UkxtUtRArgkVd-1cGZxhQ@mail.gmail.com>
 <CANXhq0rvjJ6yAcOq=bc7O_rYGDcbRfp7DJhcM0RBQ8q2x7xH0A@mail.gmail.com> <CAAhSdy1NE2yd1gGZBjEdUSt0cZy6b+pLH5sqLBmUafzryqd4iA@mail.gmail.com>
In-Reply-To: <CAAhSdy1NE2yd1gGZBjEdUSt0cZy6b+pLH5sqLBmUafzryqd4iA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 1 Jul 2020 11:22:36 +0800
Message-ID: <CANXhq0pQRTTDhS561t-5XaW0rgdLAQ+JpZBXZT+-0+G_xWiN6g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: riscv: Add YAML documentation for PMU
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:31 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 29, 2020 at 12:06 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Mon, Jun 29, 2020 at 12:38 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 9:58 AM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > On Mon, Jun 29, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
> > > > >
> > > > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > > > > >
> > > > > > Add device tree bindings for performance monitor unit. And it passes the
> > > > > > dt_binding_check verification.
> > > > > >
> > > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
> > > > > >  1 file changed, 59 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..f55ccbc6c685
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > > @@ -0,0 +1,59 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: RISC-V Performance Monitor Units
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Zong Li <zong.li@sifive.com>
> > > > > > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > > > > > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    items:
> > > > > > +      - const: riscv,pmu
> > > > > > +
> > > > > > +  riscv,width-base-cntr:
> > > > > > +    description: The width of cycle and instret CSRs.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +
> > > > > > +  riscv,width-event-cntr:
> > > > > > +    description: The width of hpmcounter CSRs.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > >
> > > > > The terms "base" and "event" is confusing because
> > > > > we only have counters with no interrupt associated with it.
> > > > >
> > > > > The RISC-V spec defines 3 counters and rest are all
> > > > > implementation specific counters.
> > > >
> > > > As I know, there are 2 counters of spec definition: cycle and instret.
> > > > What is the 3rd counter you mentioned?
> > >
> > > TIME is a counter CSR.
> > >
> > > >
> > > > >
> > > > > I suggest using the terms "spec counters" and "impl counters"
> > > > > instead of "base counters" and "event counters".
> > > >
> > > > OK, they are good to me. Let me change it.
> > > >
> > > >
> > > > >
> > > > > Further, "riscv,width" properties are redundant because
> > > > > RISC-V spec clearly tells that counters are 64bit for both
> > > > > RV32 and RV64.
> > > > >
> >
> > Sorry for the lost replying. The maximum length of counters is 64, but
> > it doesn't require to implement all bits. A real case is that
> > unleashed board only implements 40 bit for mhpmcounters.
>
> The "3.1.11 Hardware Performance Monitor" clearly states that
> all counters are 64bit
>

In the privileged spec, 3.1.11 section said, "The mhpmcounters are
WARL registers that support up to 64 bits of precision on RV32 and
RV64".

It seems to me that WARL implies the size of registers could be
variable, and support up to 64 bits as maximum size.

> To take care of the unleashed board, the "riscv,width-xyz" DT properties
> should be optional. Whenever these properties are not present, we
> should assume 64bit counter width.
>
> >
> > > > > > +
> > > > > > +  riscv,n-event-cntr:
> > > > > > +    description: The number of hpmcounter CSRs.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +
> > > > > > +  riscv,hw-event-map:
> > > > > > +    description: The mapping of generic hardware events. Default is no mapping.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > > +
> > > > > > +  riscv,hw-cache-event-map:
> > > > > > +    description: The mapping of generic hardware cache events.
> > > > > > +      Default is no mapping.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - riscv,width-base-cntr
> > > > > > +  - riscv,width-event-cntr
> > > > > > +  - riscv,n-event-cntr
> > > > > > +
> > > > > > +additionalProperties: false
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    pmu {
> > > > > > +      compatible = "riscv,pmu";
> > > > > > +      riscv,width-base-cntr = <64>;
> > > > > > +      riscv,width-event-cntr = <40>;
> > > > > > +      riscv,n-event-cntr = <2>;
> > > > > > +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> > > > > > +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> > > > > > +    };
> > > > > > +
> > > > > > +...
> > > > > > --
> > > > > > 2.27.0
> > > > > >
> > > > >
> > > > > Regards,
> > > > > Anup
>
> Regards,
> Anup
