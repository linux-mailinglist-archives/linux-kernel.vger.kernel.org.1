Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9802A5EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgKDHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:54:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDHyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:54:43 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F05223C7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604476482;
        bh=Fl4puikmts/CeSTNypbndDv/5/t5iRA5j04PtArwfzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uMTWB3UkMdC3mMC7hCaCWFkat2IRgBrmNOfBqDbcFOX0lcOnqx74IKwBe9AzZn4l3
         Wka/fui9QlQBTtHr8iDXdd/Y8v28xvBpAZVX8GZuwtpMLXCWgaDJPqWeriGpHwxoEb
         oQxWBIUbih2RXxmdg/ncX0gbx6Zzs44nKFGxtCh0=
Received: by mail-ej1-f52.google.com with SMTP id 7so28452688ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 23:54:42 -0800 (PST)
X-Gm-Message-State: AOAM532dfWxiku4fjC88NDzyh+VITmQNmczuVqo2XY6c00dVZmtDCr0X
        4VUQthL8UuIWM9jhFhKw+hiCx5HrFhxRpNVd8bE=
X-Google-Smtp-Source: ABdhPJxwYZGXaRjAMnaro4k/mHr9VOSkuWWQDvawDLgiGFcwYmlb5+yMACiM/CPyXeQQ7o3NxnBpDkq+iPcFZ/6UEtU=
X-Received: by 2002:a17:906:c0c1:: with SMTP id bn1mr3969501ejb.454.1604476480838;
 Tue, 03 Nov 2020 23:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20201104030645.12931-1-alice.guo@nxp.com>
In-Reply-To: <20201104030645.12931-1-alice.guo@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 08:54:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcCFX84jCZ7G1iTwqkGjOX2+0cu8Vq6r=gnHk1RxyJmBg@mail.gmail.com>
Message-ID: <CAJKOXPcCFX84jCZ7G1iTwqkGjOX2+0cu8Vq6r=gnHk1RxyJmBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] change drivers/soc/imx/soc-imx8m.c to use platform driver
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 04:09, Alice Guo <alice.guo@nxp.com> wrote:
>
> Directly reading ocotp register relies on bootloader to enable the ocotp clock,
> which is not always true, so we need to use nvmem API. Using nvmem API means
> that driver defer probe needs to be supported.
>
> Alice Guo (4):
>   LF-2571-1: dt-bindings: soc: imx8m: add DT Binding doc for soc unique
>     ID

Judging by recipient address, you are sending to Linux kernel. In such
case, the subject prefix "LF" is wrong and please use "git log
--oneline" to get the list of prefixes for the given subsystem.

Best regards,
Krzysztof
