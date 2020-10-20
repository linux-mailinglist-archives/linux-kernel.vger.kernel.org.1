Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF84293BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406341AbgJTMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:38:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34396 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406304AbgJTMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:38:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id k21so1093208wmi.1;
        Tue, 20 Oct 2020 05:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTv2TqWQaefwCIoRzRKnAaaiLi/7OL3sa2J56yTprLs=;
        b=jl3fNAPuche9cJk9f3zKV+OcxLEXNJrf2NZJDVeFk6LSt71jpw2k2UKiWvgeaZnESt
         jVr48U72dfWBQwVJdlz6gtcj6Z2Xeq3nsohURCQOZkr0dtMJ8/z+wIlv2GstepFf3I0t
         aIcyLhVcSQr3QqtX5igFyD5I4YZZVbpHx1MbrGgtblsHPORu1iy0ZD7s31XGITgU5EJl
         DDCFzOeTFKvaI7/jwJX9ztCsVIJo/7/KLr5EO1/3s4+gLF3JGA4uQQPfxnFdUrymIKMx
         h3kqTfseM+i9FU9P2V3esI6OSZ6i5TRFoK0Zh3kMvRJ9MkdC+LW8UmCPB9SST2kKN65L
         Xhyg==
X-Gm-Message-State: AOAM532GASN+xme11WvoNoXmNr/OfV3QEKKuBKsY9IDQoLkLZey2a6Hx
        S8fsH9xYEU1wBqASHfB735M=
X-Google-Smtp-Source: ABdhPJxYWnby37gGUJzkP8a+m+DcxULHlq2Ju5ioF7EFg4aW+NMlchfDdOXWGCt5a67pdNl3vfjobw==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr2860427wmj.161.1603197523212;
        Tue, 20 Oct 2020 05:38:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id k6sm2575353wmk.16.2020.10.20.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:38:41 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:38:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/29] powerpc: dts: akebono: Harmonize EHCI/OHCI DT
 nodes name
Message-ID: <20201020123833.GL127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-16-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:45PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/powerpc/boot/dts/akebono.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
