Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B228E561
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgJNRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgJNRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:30:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39359C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:30:14 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x20so3301114ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1/6B+ExNOLwgHkYd/gzHX5f5j+4YiWZyKHmyXxDUj8=;
        b=bwAPSOwC22OH911dd3OisC2/Hvt/5qIPNsp88vJ1KjQXGMq/HVkn2c0Vw5uPjr+/ev
         uCMef1wuAtuM35lViNYCJdKNHm22MfB+SkiGhgCh+61xjy8UjfWnm90lrIJTxcLqz09A
         rykWA+Ci/aFYw1en70dLT+ftggFXmOcwTQqv2ppwNBrjrELvDG+3XLQ2KVrjOBDmk40i
         lF0ucEusyIApuevLPSUaXmGZRmTteaRWqtUCn8wf9w2kVg7J2YpQDa2TU77T1i8rvlKW
         YOy6MTg+ApFlgYHuU1zXzXSVtsXXvez5QvyOZTAOkTn0N1UU0itA+s5S5PSN86eFS/vS
         Y02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1/6B+ExNOLwgHkYd/gzHX5f5j+4YiWZyKHmyXxDUj8=;
        b=ZhEdzg/d0lSNLjFRbgGo0xVP9rRSlDQSqbEEtMVD3tNg0znBlTlDmA3VqaesJf5Yww
         T7+oXX2u6X7iQ/FRU/RXPc56W8SpAi8NO4BwXUWDRVgIpKVbnyjYjpA0CkIhV8YYitvM
         05RiDEoGD2CF3OPUXXS8MdUsZ+TcNAc4lDPBISCz8GI44do4VE0rbmx0son79ekw0j05
         RlvGWxiqwKnnQRG+vhbLwqn5g7hni+c1Ez6M9JuMQG0x1d2MJoOLQew+yYRFbiegfH1k
         bhRzcksI2+V9Ay4B/HMhhGTd+DA51SwD7nZbWpli62ZkCFEV0AD51DSTYbOa0cwZwoxj
         xBEg==
X-Gm-Message-State: AOAM531lRLhy/6vYIjOrSp1+iZKlONdjKIPG6HBC2W9VlGiWWcyLzq3e
        rPGtCMuoToB2EWNI6hwl6G5SCwKFmyWc92+KLYC19g==
X-Google-Smtp-Source: ABdhPJySwERIE8BCo2AspT1JClHe8uDyPag/q5spkL9SIYg81C45VzibA+lnYltI+d6N0mcbx0foZRdRWa6P+J+fs7A=
X-Received: by 2002:a25:244c:: with SMTP id k73mr742738ybk.96.1602696612942;
 Wed, 14 Oct 2020 10:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191235.7f71fcb4@xhacker.debian>
In-Reply-To: <20201014191235.7f71fcb4@xhacker.debian>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Oct 2020 10:29:36 -0700
Message-ID: <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Hi,
>
> If set fw_devlink as on, any consumers of dw apb gpio won't probe.
>
> The related dts looks like:
>
> gpio0: gpio@2400 {
>        compatible = "snps,dw-apb-gpio";
>        #address-cells = <1>;
>        #size-cells = <0>;
>
>        porta: gpio-port@0 {
>               compatible = "snps,dw-apb-gpio-port";
>               gpio-controller;
>               #gpio-cells = <2>;
>               ngpios = <32>;
>               reg = <0>;
>        };
> };
>
> device_foo {
>         status = "okay"
>         ...;
>         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> };
>
> If I change the reset-gpio property to use another kind of gpio phandle,
> e.g gpio expander, then device_foo can be probed successfully.
>
> The gpio expander dt node looks like:
>
>         expander3: gpio@44 {
>                 compatible = "fcs,fxl6408";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&expander3_pmux>;
>                 reg = <0x44>;
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 interrupt-parent = <&portb>;
>                 interrupts = <23 IRQ_TYPE_NONE>;
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
>         };
>
> The common pattern looks like the devlink can't cope with suppliers from
> child dt node.

fw_devlink doesn't have any problem dealing with child devices being
suppliers. The problem with your case is that the
drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
never creates struct devices for them. If you have a node with
compatible string, fw_devlink expects you to create and probe a struct
device for it. So change your driver to add the child devices as
devices instead of just parsing the node directly and doing stuff with
it.

Either that, or stop putting "compatible" string in a node if you
don't plan to actually treat it as a device -- but that's too late for
this driver (it needs to be backward compatible). So change the driver
to add of_platform_populate() and write a driver that probes
"snps,dw-apb-gpio-port".

-Saravana
