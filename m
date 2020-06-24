Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A845207B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbgFXSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405469AbgFXSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:24:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB62C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:24:27 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so2854322otc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fiC75NJfdMCXZC7LLyYkEHeo9SJKqVNZZjtejNnwUY=;
        b=VdolZ//B0vbO+nqOABrxt/TQqumPP8dm3PBBw6wxjb3BZaQLon7d4HxYj7QekO55r7
         PTMDAgZ0bKRznEmUR1M/viffG7wws5jRlLdYJLfxhgBuqHjW9XlFg0cNO2Y+9pkYMUab
         OGubD6ryQcXuUja8DZHRX0BGldb0+I2+q9bZpcrurlekJdEkcdJZEk+lw+1knTBLMu6Z
         UmHrUnE4+e759VfZ/VWtzLqDKCoCHtMrdoohEEmvB5QXYomatapUKoDvwB7a5QKKKjPR
         e9YSEp2vrtBglC9PzKY5fmLPjPYYw1xLijL+eHfkFNWlYrFj9OkM2SGF2VAWQPy/CSyH
         X/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fiC75NJfdMCXZC7LLyYkEHeo9SJKqVNZZjtejNnwUY=;
        b=ThUcr13dp9EscyonKv7yB4C0YwZO7D/gmJHprIlh2LBQDOzm8krnCydk92EItulUJF
         up8NY4DmY3Q4mf9iJyd5I22rzWzU8E6s5Qoj8mbwSa6VPEHJ+GRqsB2VtrIg3mTW5zkx
         Pt/ZO9tOTg3ZFVtqBPJGFToJl4xnV571nq52EqbuCnwd6lHNAPcWBRBJmpXRR6AhdOQ+
         GOdz5Wvv8UG+GRORfguh9V09rN5HMTUFwOqtCftZOhWb4F/aRx0TPvjOhhA1Jy11esLO
         wcA18ujzWFt84qK2Vqk3h8aao9YxwinFd26YWrqrMLG7dOoNarCVEUBmR3PKf3S8qVyS
         IlWg==
X-Gm-Message-State: AOAM530wyhgFCpIfvmaJJOBwvUs96sGaRV9kgzQGb1ycd/Sll9Mu8/OG
        T3KmN4x7AtykUZ+JOMKkBYdBke7CCXr4KtxOrZU=
X-Google-Smtp-Source: ABdhPJzKQMdT7gRIlOY7dhJHDLJhz9lvvrvE6buoaQObV1gp4fP3MtE1pQQkjUyTWTjJM3neZxYW91CZsKD+jwz6Ia0=
X-Received: by 2002:a4a:5209:: with SMTP id d9mr23832706oob.28.1593023067063;
 Wed, 24 Jun 2020 11:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624152256.21937-1-TheSven73@gmail.com> <CAOMZO5Ca8D-eBe9iKsDnc=zRnasUN2d0WttDS8XEcGmF_H2gEQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Ca8D-eBe9iKsDnc=zRnasUN2d0WttDS8XEcGmF_H2gEQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 24 Jun 2020 14:24:16 -0400
Message-ID: <CAGngYiWg=HHVO00D=3OCEfS_inC3CMY-MQg6iMj9OLxUNFtygA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx6plus: enable internal routing of clk_enet_ref
 where possible
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Jun 24, 2020 at 1:55 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> We could avoid checking for if (!IS_ERR(gpr)) two times in a row if
> the following patch is applied before yours:
> https://pastebin.com/raw/Ftkq2VVp
>
> What do you think?

I think this is a good idea.
I was never fully comfortable with checking IS_ERR(gpr) twice, but I
know from experience that minimal patches are more likely
to be accepted.

Shawn / Andy, what do you think? Should I re-spin this as a patch
set, with Fabio's patch in front?
