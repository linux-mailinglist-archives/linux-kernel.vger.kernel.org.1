Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF127726B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIXNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgIXNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:34:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5211C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:34:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s205so2756766lja.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucsiRNp5Hmy/M31y3Eu3vnrnRbGbKmAl5qmp/RjXrTA=;
        b=S02vy9Kv3llWRlzvqF+sLjuorHwjd9epvGaI2w+62I2kWh0fjWnUVl+bVyLVpUeXaB
         FxbaidFIYFX47WFWraTZtKAMoVkKtmG2dW2wqJbAOty6bRlWn8XDox+rzlgZ2PRaL9bJ
         iAUBU7KgfF1aWo6JaYNQ6/6BqgzdhezeH115RlSzLgNJ49g2iOWJrCTrtFGDgRoIJEcg
         9WW1rFYlkaKG2ae+vc3pY2lfpVnGMeMsUdCvlMiitPyxku1oTmIPwscQF4qIQEpiA5bs
         oaNh4/4NYJvohnLhmesYkVrWEvyb8oW7nwAnCb9suq+huLb1gplJtBK1yI5b0+CX9Iw+
         ewqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucsiRNp5Hmy/M31y3Eu3vnrnRbGbKmAl5qmp/RjXrTA=;
        b=dKQXiI7T5Pnj3xs6VsaxJk9Fi9mhOdzoDsMr3njUHT9uDSeWhjuZ9kXIzESwZEGLwG
         KPXjv5gudp5raW19xD7qPfn69Zmr9/QstaVJANa7UCW4JfLf7H0kHAx9a8yKAejUVCjG
         HdOgPhMmp202Jr8NdxpBHm+6f66vcNvlnc47vSRJhjPk6+QB+Cp061n5wPVJvPVg/Hyt
         vjpP4Htk/96BK17wqwaG6Cr8UwZRmwUiHExCy6IXz2h6r3TCmIVGSRZPsDiX0MTRDQDa
         STJBYNcNjKTpF5gzmcy4yvF8LE7BKmuBzG3ov07PKvZdtV1lQs1fXgcke239/FyX3baB
         ZdIg==
X-Gm-Message-State: AOAM533d/TjHeq8ImX4wMs+nl+ye60b8/9a0+aaDaSA3+tv8U/q7IzTj
        rILCvlOJQEllJ3RV9WdRobHTNVAKxxATg1kTV84=
X-Google-Smtp-Source: ABdhPJxLbWrllUFAIyhc26p5MBXhkhuwzhhb9AdaoMklO6zQmh50u9jqfejUMeFZa8ILa2Ws4NbrWrrEmNwCmhzF4TM=
X-Received: by 2002:a2e:9ed5:: with SMTP id h21mr329910ljk.178.1600954455161;
 Thu, 24 Sep 2020 06:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-17-maz@kernel.org>
 <aa8ff875-bee8-26f8-46b0-df579f2067a7@collabora.com>
In-Reply-To: <aa8ff875-bee8-26f8-46b0-df579f2067a7@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Sep 2020 10:34:03 -0300
Message-ID: <CAOMZO5COBv=JqxjvsNrqc66FeQqdVEd6=cWyy9zhAY=yNKKEvw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] ARM: Remove custom IRQ stat accounting
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernelci-results@groups.io, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Thu, Sep 24, 2020 at 6:01 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> This appears to be causing a NULL pointer dereference on
> beaglebone-black, it got bisected automatically several times.
> None of the other platforms in the KernelCI labs appears to be
> affected.

Actually imx53-qsb is also affected:
https://storage.kernelci.org/next/master/next-20200924/arm/imx_v6_v7_defconfig/gcc-8/lab-pengutronix/baseline-imx53-qsrb.html

kernelci marks it Boot result: PASS though.

Shouldn't kernelci flag a warning or error instead?

Thanks
