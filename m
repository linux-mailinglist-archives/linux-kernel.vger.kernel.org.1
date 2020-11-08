Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5982AAA5B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKHJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 04:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgKHJbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 04:31:24 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA9C206ED;
        Sun,  8 Nov 2020 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604827883;
        bh=eOwD/VuP9PtqPjph5jxwLC0h4nX9LAzZMDOhtB6y0P4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tx/D/Nv/ueX6gu+HA9Djkqh+/s+tZjeUmSV6XxavLHcuXLivAoQ938sE8UIPBs5Qc
         JFfWt9IGEHKM3pW9z4yRPwJg4PLrd0duTN7iyUK/Y3pKolmadoi62Al3eeldkIaLmY
         +KfXg36yLC+y3tibJswITBxw9McwSKuTJrPGAX98=
Received: by mail-ej1-f49.google.com with SMTP id o23so7985784ejn.11;
        Sun, 08 Nov 2020 01:31:23 -0800 (PST)
X-Gm-Message-State: AOAM532pPIV03INNFVtS/Asog37+3N48+TYF+NEjpK47Q5p9EOA5/9KC
        E6fhQNDAdEnnZAc/CtSQm58/YrGRq4NPPPtGjeo=
X-Google-Smtp-Source: ABdhPJy1gghEjZlAAJmQ4Ellt2u7JgNZI89WPI/GJbKzVxjl24E8tA0NMQhC8dvhatCuuhzf1wQUvZnQ9WmvonJjKPs=
X-Received: by 2002:a17:907:d1e:: with SMTP id gn30mr10552868ejc.148.1604827881778;
 Sun, 08 Nov 2020 01:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20201108022321.2114430-1-natechancellor@gmail.com>
In-Reply-To: <20201108022321.2114430-1-natechancellor@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 8 Nov 2020 10:31:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdVVgRMaCPfq3nPR232KQyKVVewm5LveUSuyfqE8sScQg@mail.gmail.com>
Message-ID: <CAJKOXPdVVgRMaCPfq3nPR232KQyKVVewm5LveUSuyfqE8sScQg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Nov 2020 at 03:23, Nathan Chancellor <natechancellor@gmail.com> wrote:

Hi,

Thanks for the fixes.

Please mark patches with versions, this should be v2. Otherwise
maintainer might apply the older one,
You also need to add versioning changelog after ---.

> $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- \
> INSTALL_DTBS_PATH=rootfs distclean defconfig dtbs dtbs_install

All this is still irrelevant. Just: "make dtbs". Don't add unrelated
details like how many processes you spawn, where do you want to
install DTBS or even all other make targets.
Everyone should know how to cross compile so simple: make dtbs

> ...
> make[3]: *** No rule to make target
> 'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by
> '__dtbs_install'

This should be joined with previous line. I mentioned it in your previous patch.

> ...

Also not needed dots. This is small change and should go with small
and accurate description. Blowing the description does not help.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
