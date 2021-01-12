Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436EB2F2A48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392401AbhALIrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbhALIrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:47:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 130D022E01;
        Tue, 12 Jan 2021 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610441181;
        bh=Y1GzYRbQvrAPA/+w1mjAvZdM3kH7poVhJbFhssGvWnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EwRH1UUigmJkvLWs0zORnRvjcjGyy3vuh0jpp1r1H5YX2E522bpGtszkvGKx64m3X
         Ymz/Q234SAv+7joy2teL8vX4xwjk4QDTsTjI3+D2AtLq+uts/A7DzkUPr7o2vmR99A
         L5AN+fNkQ86GxcpqFSuGY4UftH0A+zK4E9XKCrYQZc6Lab7p0umIx8AWZcNwJXraPN
         RQu6dHjhQT6otREr4uaNIkylbzTBrTrppJ5LobR7uSzuSa+UEZsuR/YeQwXpJAvYei
         HedUcDEu53rfEX9lCcs6RIrEvAwB+G+KrMf/0ldyvCyDw4kV6/D/1AFvFZRnm0RjR8
         +6ySg8ygZjWjQ==
Received: by mail-ot1-f42.google.com with SMTP id i6so1587325otr.2;
        Tue, 12 Jan 2021 00:46:21 -0800 (PST)
X-Gm-Message-State: AOAM530oZ/ijjpN2jx8H2PsvHXy+dEB+xZR5N5+mNKMpASQZTN1kV6CM
        xLlZoOzJCESBrQGFqwY0bPTRQ4RJDEGU1iEpfRo=
X-Google-Smtp-Source: ABdhPJzM9ncpX519OYLH+0PC8S0hC9gQaClB61ZqP0E18csMrNH++9ADD1MzAIeMYrL667BHTQMz5f0adu6PvVREwuE=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr2191096ots.251.1610441180241;
 Tue, 12 Jan 2021 00:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20210112015602.497-1-thunder.leizhen@huawei.com> <20210112015602.497-3-thunder.leizhen@huawei.com>
In-Reply-To: <20210112015602.497-3-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 12 Jan 2021 09:46:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
Message-ID: <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: hisilicon: Add binding for L3
 cache controller
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:56 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:

> +---
> +$id: http://devicetree.org/schemas/arm/hisilicon/l3cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon L3 cache controller
> +
> +maintainers:
> +  - Wei Xu <xuwei5@hisilicon.com>
> +
> +description: |
> +  The Hisilicon L3 outer cache controller supports a maximum of 36-bit physical
> +  addresses. The data cached in the L3 outer cache can be operated based on the
> +  physical address range or the entire cache.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hisilicon,l3cache
> +

The compatible string needs to be a little more specific, I'm sure
you cannot guarantee that this is the only L3 cache controller ever
designed in the past or future by HiSilicon.

Normally when you have an IP block that is itself unnamed but that is specific
to one or a few SoCs but that has no na, the convention is to include the name
of the first SoC that contained it.

Can you share which products actually use this L3 cache controller?

On a related note, what does the memory map look like on this chip?
Do you support more than 4GB of total installed memory? If you
do, this becomes a problem in the future as highmem support
winds down. In fact  anything more than 1GB on a 32-bit system
requires more work on the kernel to be completed before we remove
highmem, and will incur a slowdown. If the total is under 4GB but the
memory is not in a contiguous physical address range. See my
Linaro connect presentation[1] for further information on the topic.

       Arnd

[1] https://connect.linaro.org/resources/lvc20/lvc20-106/
