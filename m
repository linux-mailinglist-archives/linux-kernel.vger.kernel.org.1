Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DD2ECAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 07:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAGGnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 01:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbhAGGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:43:51 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E4C0612F4;
        Wed,  6 Jan 2021 22:43:11 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n42so5358513ota.12;
        Wed, 06 Jan 2021 22:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WQKogou2Yhnca+5Vwh/rfMyvb6d3RQtkwNyUEqBKP0=;
        b=o+pHo+HVfY5QvJGqjRWO/ZVlZ2fZRDsLVWSm2OBswcuk3eCJsFwcCapHMYC8kfAzW2
         4enPD7rUjcPcPrUTxNyeafB55pi+R5Z78XP9PPONiJWhCrUVA3UG2rQrL7ng2hDmg+E6
         b4+lv9/ImXI/LQ1pRV30mKDzi+gKFXBgYaHVT5PWa0P0ev6WpkEl/h/gVzf676mePdK6
         eTuUQcnR1hzRMXi+e+Nkerfx8Coi2ixNlpQuv72fsbeaOmlY5XEo49N9fwotp0S4cSNC
         2pSTWstZ90Dqvg5Xhzb/WyzIQflpK2jgL4QA6i7xrWhwH3g2zqb6CrxYs9ZVpHZw8oNS
         Ht+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WQKogou2Yhnca+5Vwh/rfMyvb6d3RQtkwNyUEqBKP0=;
        b=TtATudmsV1DCr0EkqWlCSE68+YhQErfkJ8QkoTbYitv8Xh7QlM4t8BQNeZhUU9kWyc
         ucDDO8FqUZz0fIEprDTUYtm6RaMIyeF2bapHUnnzXT0+zt5bo8SE2+zk1/0E4fYvthEa
         MpmReNYy4LXdRxOoeEUFzHUb7I15Q23YvG5AeYduxSZygfKfz000wGM22/WMqJ/RhAss
         l2AODDDjHm2NMCwiP9wvfx5hZnGsjSXNTGywYEsAJ2/oJuKBhPg9CstiScVUqaUa3dzP
         T6rHLa9BrnfFZAc3MAjk9rZOUr3JUsr4IHl77ccUneaV0BUEm4WUnds0huSuKd1sr+8m
         zcmg==
X-Gm-Message-State: AOAM533SI2pqvTio7MvgrzncqOGVnsm2Epi81eh9BOT2P66oISHKWduH
        eNhf4Ip/NQY3+OWdSDsgZIye1HQqS/97W+Q8HfM=
X-Google-Smtp-Source: ABdhPJwAEwW7zhfIUlr+NTZ9cwBPosE95OoYKFvsQKn7L7L76Sd+UwhONLHn9w+SMqxnrnslt1wp4uj9e3A7LZeDjVY=
X-Received: by 2002:a9d:ae8:: with SMTP id 95mr5571027otq.304.1610001790751;
 Wed, 06 Jan 2021 22:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20201215212622.717-1-michael@walle.cc> <20210107064046.GF28365@dragon>
In-Reply-To: <20210107064046.GF28365@dragon>
From:   Shawn Guo <shawn.gsc@gmail.com>
Date:   Thu, 7 Jan 2021 14:43:00 +0800
Message-ID: <CAJBJ56+wgA1VLkK+w1kqyaeV=H8jeb_mYKJcrnWWLY5aQC=Dig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix the offset of the reset register
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rai Harninder <harninder.rai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:40 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Dec 15, 2020 at 10:26:22PM +0100, Michael Walle wrote:
> > The offset of the reset request register is 0, the absolute address is
> > 0x1e60000. Boards without PSCI support will fail to perform a reset:
> >
> > [   26.734700] reboot: Restarting system
> > [   27.743259] Unable to restart system
> > [   27.746845] Reboot failed -- System halted
> >
> > Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> > Signed-off-by: Michael Walle <michael@walle.cc>
>
> Out of curiosity, how did you get it fixed with your commit 3f0fb37b22b4

How did you *not*, I meant.

Shawn

> ("arm64: dts: ls1028a: fix reboot node") in the first place?
