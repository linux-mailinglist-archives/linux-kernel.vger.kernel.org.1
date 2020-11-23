Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465E72BFEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKWD45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:56:57 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39943 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWD45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:56:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id r5so8406785vsp.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSA3Ddm+o7uJiNoOrs81/CWwy8hP3wLFFpHjM4ph7cU=;
        b=mMvlNpB/n8EH6knff7ldKxuVAs8tzvwzsCw54Vv0SL/8NCgtP2XdZGBXbXyKRIQ5AI
         tc5eTlcypnZI69J6Nd/2D+DyjZTetJqghsAP4Mt/spGDxTbSzlqZf9fK3TWBiaWTG3k/
         WGAz4AuYXNPL3R5XtatGgZAqTkVMCVJGIN9IFzEM5b2lb6rhO3ui9WsQMobht2jQSB3c
         Kvfvjx61THHls0UndbBL/1R3p+Bmrlg2jEWELQufrn+EWNdA1bZe8etJXw3jzHqj5o3Z
         cQVUutLLHMTEonR+DMx7fWe13tzYDUhh802OWoOkNlWtx6sQPuYlN4YYYtJTX7W+rr06
         KTOA==
X-Gm-Message-State: AOAM5309Lvv9R3gncI3ppEH2EL1EVRhZy26rhdTCYU5Czymgg3FaPu66
        U0y2biyf7qv5eIM8/SbZ70P9OEf9UCO5VQ==
X-Google-Smtp-Source: ABdhPJxZnWBODV7w0XizSaQyC0pcR9PPURpwQ8Rrd07bpEGnm+mH1+hRbCNRI4FD/eVGomLsEIuvig==
X-Received: by 2002:a67:ce1a:: with SMTP id s26mr18008866vsl.0.1606103815582;
        Sun, 22 Nov 2020 19:56:55 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id c21sm1202908vsh.31.2020.11.22.19.56.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 19:56:55 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id m16so8400740vsl.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:56:54 -0800 (PST)
X-Received: by 2002:a67:e2d7:: with SMTP id i23mr19286798vsm.32.1606103814801;
 Sun, 22 Nov 2020 19:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121135933.184203-1-dinghua.ma.sz@gmail.com>
In-Reply-To: <20201121135933.184203-1-dinghua.ma.sz@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 23 Nov 2020 11:56:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67m6P19L2gMO_GnA-h3V9HTe=oQXEnpX+Fda68yXFg2rA@mail.gmail.com>
Message-ID: <CAGb2v67m6P19L2gMO_GnA-h3V9HTe=oQXEnpX+Fda68yXFg2rA@mail.gmail.com>
Subject: Re: [PATCH] Fix the bug of axp20x chip driver
To:     "dinghua.ma" <dinghua.ma.sz@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 21, 2020 at 10:00 PM dinghua.ma <dinghua.ma.sz@gmail.com> wrote:
>
> From: "dinghua.ma" <dinghua.ma.sz@gmail.com>

First of all, the subject should follow existing conventions, with
proper subsystem and driver prefixes, which in this case would be
"regulator: axp20x: ".

Second, the subject should be more precise; "Fix the bug" could mean
anything. "Fix DLDO2 voltage control register mask for AXP22x" says
what is fixed.

So for this patch, the subject should read:

    regulator: axp20x: Fix DLDO2 voltage control register mask for AXP22x

> Modified the mask parameter of the voltage data register of the
> axp20x power chip of the PM system, and its port is DLDO2. My test
> environment is under Allwinner A40I of arm architecture, and the
> test kernel version is 5.4.

Third,

Your commit message should state why you did this change. You already
covered what you changed, but that is also plainly visible from the
patch body.

You should include how you encountered the bug. In your case this would
probably be the regulator output not changing voltage as it should. And
if possible, include why the bug existed (which in this case it was likely
a copy-paste error in the macro conversion patch). The latter is not
required, but is helpful for others looking at the change.

You also included your test platform. But you should include the test
result of the "fixed" system, as a before-and-after comparison. This
could be as simple as "Now the regulator output voltage changes as
the system requests it".

Fourth, please add the following tags so that the patch gets backported:

    Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
    Cc: <stable@vger.kernel.org>

You can read more about stable kernel rules in general in
Documentation/process/stable-kernel-rules.rst in the kernel tree.

Last, and I believe this is more superficial, could you write your
name in a slightly more standard way, such as Ding-Hua Ma, or
DingHua Ma? Apologies if I got that wrong.


Regards
ChenYu


> Signed-off-by: dinghua.ma <dinghua.ma.sz@gmail.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index cd1224182ad7..90cb8445f721 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -594,7 +594,7 @@ static const struct regulator_desc axp22x_regulators[] = {
>                  AXP22X_DLDO1_V_OUT, AXP22X_DLDO1_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
>         AXP_DESC(AXP22X, DLDO2, "dldo2", "dldoin", 700, 3300, 100,
> -                AXP22X_DLDO2_V_OUT, AXP22X_PWR_OUT_DLDO2_MASK,
> +                AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
>                  AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
>         AXP_DESC(AXP22X, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
>                  AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
> --
> 2.25.1
>
