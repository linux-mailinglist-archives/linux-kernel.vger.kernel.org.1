Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6962CFF90
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 23:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLEWmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 17:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLEWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 17:42:52 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3BC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 14:42:12 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a1so9485983ljq.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHdiYald3SQmfqCELRiteTEWnXp3ZfGfk9SY21N1e8g=;
        b=SVvTOHh4Zs69djwNMYv71qL9oF7RI5QGKvUzmhjReqMHNEYv3E/3qvnh7Wjc+v12Fq
         /9lgY3NUiC1vZSmliAk6cAxMgAw/jIoR2g5JgVAIEIaZabWHuU7eF4p6BkPZUh4VmH+n
         IgHt3ykhvIkFeobCadpgpyTvOrEU917DIn8wO0wF+CJeuRe3uaPJqjjsk5ANUy3bvGG3
         ArBb4PGc1UGPOrYtm67bm+Zkbe7r2Mpu3v7kYYT46QGAqN/qdPEnHIWPxPbTxIgXy8gm
         4V7CHIolpUydfXBVEKYYuMSyXL4FZtZ2fqvlS2LBmXjgI6kfXXDVwi3yb0pwtK6VTIni
         Dl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHdiYald3SQmfqCELRiteTEWnXp3ZfGfk9SY21N1e8g=;
        b=rKIY1jtdqI8n+XbGK5eH6u7DF0G8QmkHBp8ua97cQO7DS5VNTbbKsBUoB2/pTGWfb9
         UaDLKeqAq8YhvTI+L6fURxCFD9XCYNKzzJiyBMXnUeRFLv848ZM4EStwqhKKUhPTSLZG
         4fBmWUeO7ttgAZwGmkZUMSRokGq6Q8vNwe1uakaBXrotBPENPLWIow5rZaXa0PAzhVtS
         dKpUk1KQwbHL7qiqTcgpwZycSNIl2hIiIrifRDfPTIqKGfqxZcDOyC1me0qsLe1UL/Ed
         HRT/V42Dd4fKierkrEhpzQQJut+i+BX/kS251mm00I7SftADzeNU0evQZQkBZ+zPlfyH
         eGRw==
X-Gm-Message-State: AOAM533LptrYFbiRAOLJeQvUqu5chMF1aziSSWwEJjm1J4Dv6S4ZqzuD
        ElcHdYilB8rxcqrOt3g//TD0s9bP5WXM1LCHAqVuCw==
X-Google-Smtp-Source: ABdhPJyYd5vDNBRhwjAFXY+jiuvd5ruyIhMF2BQaOJzsOsIL79wFNP2RZ8cbPi+Bet9s5pYtD5ZWxt0Rir/LH45T2U4=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr5741248ljr.104.1607208131024;
 Sat, 05 Dec 2020 14:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-3-andre.przywara@arm.com> <20201202155241.ml4qnkz7xq5lnjln@gilmour>
In-Reply-To: <20201202155241.ml4qnkz7xq5lnjln@gilmour>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Dec 2020 23:41:59 +0100
Message-ID: <CACRpkdb4NCXcBCv-+D2go7cNK_LLJsN2HAVicMPRnRhOLQb6DA@mail.gmail.com>
Subject: Re: [PATCH 2/8] pinctrl: sunxi: Add support for the Allwinner H616
 pin controller
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 4:52 PM Maxime Ripard <maxime@cerno.tech> wrote:

> There's a bunch of issues with wrapped lines alignment reported by
> checkpatch --patch.
>
> Once fixed,
> Acked-by: Maxime Ripard <mripard@kernel.org>

Andre, if you resend just the two pinctrl patches with the collected
ACKs I can apply them.

No DT binding changes needed?

Yours,
Linus Walleij
