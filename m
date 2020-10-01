Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE227F972
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgJAG1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAG1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:27:14 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B4120888;
        Thu,  1 Oct 2020 06:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601533633;
        bh=26OzpoXVjNmkETeSzn8dz/u5lE23kmWOTAChnW4Go7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g/cKkkbvFRn6lEejrz3fX2uK4DhU4EemhzS8DfevjSjUC0qEb+V+AA8omvPI7kRlZ
         e1JsA7mmfeN4s7VuyNJ6cJhPbBREg7CQaqD52qBQd+fWS7Z/bcqnsXWRnn3Li6d1wG
         pKzUQj14JFf953moV5LAi7/FcnFhlfAOR5D8MQGY=
Received: by mail-ej1-f43.google.com with SMTP id md26so649214ejb.10;
        Wed, 30 Sep 2020 23:27:13 -0700 (PDT)
X-Gm-Message-State: AOAM5319TRLP1TxMnY4Yiu7Y6K+xhUt3mnhnfERWipx9/MOpKoKUqukw
        10UQddZtNuc97s0/HvRQx4OVouph495jPduqhb4=
X-Google-Smtp-Source: ABdhPJxuKkKM5+S9tTbnroIoTuTIsm7aVoi92bSQY9FPQF2AHqWz69Tgpy/I9r36K1AuEKlqMBfTJM015uGom93ATCc=
X-Received: by 2002:a17:906:491:: with SMTP id f17mr6375413eja.454.1601533631814;
 Wed, 30 Sep 2020 23:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200930031712.2365-1-thunder.leizhen@huawei.com> <20200930031712.2365-2-thunder.leizhen@huawei.com>
In-Reply-To: <20200930031712.2365-2-thunder.leizhen@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 1 Oct 2020 08:27:00 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdnNncLYgxAcHYS1SGVQkKO=SzFiq4BF=iUU+W3=noMAw@mail.gmail.com>
Message-ID: <CAJKOXPdnNncLYgxAcHYS1SGVQkKO=SzFiq4BF=iUU+W3=noMAw@mail.gmail.com>
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: syscon: add some compatible
 strings for Hisilicon
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 05:19, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Add some compatible strings for Hisilicon controllers:
> hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
> hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
> hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
> hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 049ec2ffc7f97e4..fc2e85004d363bf 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -40,7 +40,10 @@ properties:
>                - allwinner,sun50i-a64-system-controller
>                - microchip,sparx5-cpu-syscon
>                - mstar,msc313-pmsleep
> -
> +              - hisilicon,hi6220-sramctrl
> +              - hisilicon,pcie-sas-subctrl
> +              - hisilicon,peri-subctrl
> +              - hisilicon,dsa-subctrl

Add them in alphabetical order, not at the end of list.

Best regards,
Krzysztof
