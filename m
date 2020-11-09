Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B72AC211
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgKIRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgKIRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:21:57 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B72C0613CF;
        Mon,  9 Nov 2020 09:21:57 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id k65so5435539ybk.5;
        Mon, 09 Nov 2020 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kaK7zZ70SukrbuMH1B3STi43ESGK7CokXQJfOjxj9Ok=;
        b=Bp/ZyyAQnwEn1p5BDnzLV5/Lk8Q//LKnHI0Yl4gKqdK5TRMz/Grs6cbw2I+5FLRqbJ
         3JZHmnrL4B2i2EPmQkmP8ECnGyJfVHouG3IdGdNm5XbN9ZyXsh1WKQWXvTMhMLLUL2Aj
         fS2XP9EhR8P9Rn/84nAsTjsglB9sF42briv7sQH3iL50BIkR1UAKmyh/rxVtfDK5M2dz
         vwG33EY0htz7nz6Jp/Yeeak0mAZrAKpV4keAH5S67MIx7prvWyaGPZqnCX0k80dByrxN
         h0s2agNjB/YWRdFx46P1u+0QgNMdZaDAA7EM3sq3gO3uOyr8vBuGQ77jTcbrGuSrWnIr
         lRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kaK7zZ70SukrbuMH1B3STi43ESGK7CokXQJfOjxj9Ok=;
        b=HCRARrpV/q35cDNxZaLC5Hg+HHAfacVkRNsDk1WwgwMjMt+KAKfO1fwgjhNLNGI9B8
         V/6lugry3sUNwP0AR3oWVm5d96XiW6l8ruZF3OeViXEWvcsatLBVPi4oCSx4Hrm8C8mm
         TJIrjY7iG34oglNwNgcMVPUbWyGI+BdsNLfob+E/psgp9vXjMg8uui57w8U/CIpFxKyX
         6WlERBmHGlXjqFYn1Y3ucXejrfJkkfQgX4MMJtdmmVMks5rLPFLil8mlA9uVS4btge03
         i52f3fdlFNvG/5Fk5NM9ELm49c8y2ddMX4XCMnF+SwyubpZGpqWa0sVi+ekr8p3Bj2fV
         99vw==
X-Gm-Message-State: AOAM533GaNPC3wEVr2xCX3ov6uE7pyEuug8xllSJXfGTusDsiHACIEGh
        WknnPe1nAi29a6z/H+cHjOUyo3xeojgA5/FOoB4=
X-Google-Smtp-Source: ABdhPJyy7Li/RGmpGLl0G34qFIjio4znSAg7V/GFEwo7adi/kL9NF6TgwaxVV0HyoSFZsB3HaoIrhgmL7HXnmQxRobM=
X-Received: by 2002:a25:b19f:: with SMTP id h31mr19216673ybj.112.1604942516962;
 Mon, 09 Nov 2020 09:21:56 -0800 (PST)
MIME-Version: 1.0
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com> <20201104202952.783724-2-npcomplete13@gmail.com>
In-Reply-To: <20201104202952.783724-2-npcomplete13@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 9 Nov 2020 18:21:45 +0100
Message-ID: <CACna6ryJ70PepwE1u-kUqjKWbae6F=Gp2Scoe2pHtaGuJvqacA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: BCM5301X: pinctrl - use correct driver
 and define mdio pins
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 21:30, Vivek Unune <npcomplete13@gmail.com> wrote:
> BCM47094 version of pinmux uses different driver and supports mdio
> pinmux pins. Hence, use the correct driver and define the pins.
>
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

Subject and message are a bit confusing as it's actually a matter of
chipset specific binding and not a driver.

Change looks OK, thanks for handling that!

Acked-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
