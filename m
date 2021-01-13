Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71B2F49D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbhAMLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbhAMLQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:16:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A4E233CE;
        Wed, 13 Jan 2021 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610536544;
        bh=+KwpHDNA1Aor+AsvBmM16YIXiznluriup/9muCgEAng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OWJ1zjksTYle6TKbzWbRDcjrXmlGX67UVj6hkbpUsuYkg1zCb7wfCv0ozRfWOB13R
         P99UF6fYKS7vADXIYqQFK9aYN1A2zV4SL/wUGILJKyzCJsikuwf4ZxTAXLuntHKCeT
         WnwbUwzffMHWKl+a/Ge6OcHNlWB1NBSmY36jFLI0JAS9FIuCyTspLybae9hUSy6wgz
         foAnyrddn/1LZlpunSQugJIY5oVIf+35Ytps1oYZiHOwXykLezQIHTljAuS8Ia0Zpl
         XDZLei7bJyP2IlsKBYSiCjuIRrAzobi7UX/cKu2u1uodInwTg+IqXmtE3Z0ryqiEHW
         cHvpn+wGuVfpw==
Received: by mail-oi1-f179.google.com with SMTP id f132so1642530oib.12;
        Wed, 13 Jan 2021 03:15:43 -0800 (PST)
X-Gm-Message-State: AOAM530C9U+C5SsFonrQYEMLNDP4iz2OkPzyvqPQVSZF26UPbR0zeXYq
        k/YQhMhQyk5+xAwk74B0O6EOyyN6zg+Rclls/PI=
X-Google-Smtp-Source: ABdhPJxZ8wAO+/r7uxZhfD8Ab3Us2Ubaf1q8ERA4r3pTc8QV3ZdPgcNQLLUPFFVLoZ9K1Xe8erI+J7UYLVuwzSn/b70=
X-Received: by 2002:aca:e103:: with SMTP id y3mr798708oig.11.1610536542964;
 Wed, 13 Jan 2021 03:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20210112015602.497-1-thunder.leizhen@huawei.com>
 <20210112015602.497-3-thunder.leizhen@huawei.com> <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
 <a11515e2-1fc6-be7d-f50c-8e3ad20f9e6c@huawei.com> <CAK8P3a1jcg3CEP0QhtTP4gES9MHLdrHPZffkSxtxbr78FScrrg@mail.gmail.com>
 <f563115c-4461-eee0-ee8d-1fd8f4dbbe63@huawei.com> <82720d56-733d-28e9-b682-bcc769ad70ab@huawei.com>
In-Reply-To: <82720d56-733d-28e9-b682-bcc769ad70ab@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 12:15:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a15VnJUWsxhZqPY8dYdCHqswErPJJo+iieJfc7Yc06sJg@mail.gmail.com>
Message-ID: <CAK8P3a15VnJUWsxhZqPY8dYdCHqswErPJJo+iieJfc7Yc06sJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: hisilicon: Add binding for L3
 cache controller
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 9:13 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/1/13 15:44, Leizhen (ThunderTown) wrote:
> > On 2021/1/12 21:55, Arnd Bergmann wrote:
> >> On Tue, Jan 12, 2021 at 1:35 PM Leizhen (ThunderTown)
> >> <thunder.leizhen@huawei.com> wrote:
> >>> On 2021/1/12 16:46, Arnd Bergmann wrote:
> >>>> On Tue, Jan 12, 2021 at 2:56 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>>>
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/arm/hisilicon/l3cache.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Hisilicon L3 cache controller
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Wei Xu <xuwei5@hisilicon.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The Hisilicon L3 outer cache controller supports a maximum of 36-bit physical
> >>>>> +  addresses. The data cached in the L3 outer cache can be operated based on the
> >>>>> +  physical address range or the entire cache.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    items:
> >>>>> +      - const: hisilicon,l3cache
> >>>>> +
> >>>>
> >>>> The compatible string needs to be a little more specific, I'm sure
> >>>> you cannot guarantee that this is the only L3 cache controller ever
> >>>> designed in the past or future by HiSilicon.
> >>>>
> >>>> Normally when you have an IP block that is itself unnamed but that is specific
> >>>> to one or a few SoCs but that has no na, the convention is to include the name
> >>>> of the first SoC that contained it.
> >>>
> >>> Right, thanks for your suggestion, I will rename it to "hisilicon,hi1381-l3cache"
> >>> and "hisilicon,hi1215-l3cache".
> >
> > Sorry, Just received a response from the hardware developers, the SoC names need to
> > be changed:
> > hi1381 --> kunpeng509
> > hi1215 --> kunpeng506
> >
> > So I want to rename the compatible string to "hisilicon,kunpeng-l3v1", Kunpeng L3
>
> I thought about it. Let's name it "hisilicon,kunpeng-l3cache", and then add v2 in
> the future. Maybe the SoC name is changed later, and v2 is not required.

I would prefer the more specific name to be listed as well. You can
use the generic
"hisilicon,kunpeng-l3cache" as the key that the driver uses, but
please also include
the chip specific one here. We tend to use the chip identifiers
(hi1381, ...), but if
the marketing names (kunpeng509, ...) are now what they are known as in the
data sheet, then use that. The problem with marketing names is that they are
more often unrelated to the technology underneath. It's possible that there
might be e.g. kunpeng507 chip that sold to the same customers but very different
internally from kunpeng506/kunpeng509. This also happens with the chip numbers,
but those tend to be more stable (at least for other manufacturers).

       Arnd
