Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3662F733B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbhAOG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAOG6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01086C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:58:02 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n4so16231488iow.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Fvye0ecwjqCjbYeeG9OHYMe+9/JW5Q3SEi2vbPmIBms=;
        b=DI9/h/vNnjp8Ubhnb82TUS50X9eeTXREGKPJVEILAuKtDDc7MJeDTx6rstHqfxu9mP
         Dvl5ULlWL3SbLvTjKXkOP/37Ww67zMQyBoIXgiIOaiwBrHCsw2PPOTiqKAeZC9AtRulT
         fUzgS/IMkD6quwLzChD+ATJyiVt4Qaaygh7SPA0J3aWmtuow/CW03R6EUgFVezX8mL1O
         sreynpDu27u0ITmEy9DRmJ2cymUb25BEHbBXzNkhCItlku/mD8SQQa2KrHcg5vcbHtvG
         jjjllhGShtvTusUUsX2fB5KZE4RjgW/X94LGNCj7o9PzSfYr+yMoUoq8OsJOJjm9fOtq
         CCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Fvye0ecwjqCjbYeeG9OHYMe+9/JW5Q3SEi2vbPmIBms=;
        b=cXmzWZHxZPl6Cdc2v/dxMFXz8V+fjLP4lkBxZ3kqkVOT8u/rGv0PpGI5lBhwvH2puY
         /GK9ptLEw6NoYlfq0nXMXBFEIoW3CvIFotzWNXxEUddc63rJuvvUJ76xRiRbF2yZ4kuj
         ZMi4qXEsTNPfP83647ChMfekWYQ4z2j5rpm2NYix8voZqPo5ydMbEbnPM5KEan6sp8Cf
         x0/RtWYRCj0DVbS4+vVADt5RHXBgbNtbUXZL0TKtyy2xx2wGtiACMCXHK9Cfw7fUcesn
         U5B/rxxj/+h1412KjwfrgWebGASdGu/USSgGuVHqz47wDuj/UpOqM9I7zsej3LbsX1vr
         +MgQ==
X-Gm-Message-State: AOAM530TbwY/3i9bENfSvgxszCSJTrBAOAlefnby9+4dvZ+qcP7NWI3A
        pUONaLiiJ9FOlpYgaHDK3A+oEK3DKj3HQPi0nH+k1U3gT2xlvQ==
X-Google-Smtp-Source: ABdhPJxzHo1HPzwxeNDwxheNMelSYLMO6eqYEcUTzmzAKISZcImvi/TwL9VdkN419OxQmLY/dzDh9haJwe8b/kc1Lcw=
X-Received: by 2002:a92:bb0b:: with SMTP id w11mr9740760ili.125.1610693882146;
 Thu, 14 Jan 2021 22:58:02 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 15 Jan 2021 07:57:51 +0100
Message-ID: <CAKXUXMzj=LYJK74Le+rYnAaY3ji6AxugppwHwneAEL_xTTAyGw@mail.gmail.com>
Subject: Related work to MAINTAINERS truth and fiction
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thanks for your interesting article, MAINTAINERS truth and fiction,
https://lwn.net/Articles/842415/.

Just some pointers to related work:

Pia Eichinger has done some related analysis and work in this area as
part of her bachelor's thesis on Maintainers Expectations vs.
Maintainers Reality: An Analysis of Organisational and Maintenance
Structure of the Linux Kernel. Simply quoting her conclusion:

"We showed that around 20% of all patches were theoretically wrongly
integrated when strictly analysing MAINTAINERS. The reality of
integration and maintenance structure is more complicated than that,
which we also explored. Furthermore, we identified 12 major subsystems
of the Linux kernel. This is very helpful for an overview of the
organisational structure, realistic grouping of subsystems and further
Linux kernel topology discussions."

Announcement and thesis here:
https://lists.elisa.tech/g/devel/message/1269
https://drive.google.com/file/d/12ta2YxgEzEfrIcmWid8kwIyVEywbUjbA/view?usp=sharing

As you might have noticed as well, ./scripts/get_maintainer.pl
--self-test provides a few checks and warnings on the MAINTAINERS
file. For a few months by now, I have been following up on new
warnings appearing with ./scripts/get_maintainer.pl
--self-test=patterns, excluding Documentation/devicetree/bindings/, as
Mauro takes care of those often before my patches usually get
accepted.

In the past, I also did an analysis of what is only in THE REST, see
some discussion here:

https://lore.kernel.org/lkml/alpine.DEB.2.21.2003090702440.3325@felia/

After a few manual clean-up attempts for files in include, I concluded
that this activity needs to be at least semi-automatically done with
some scripted heuristics and then sanity-checked by experts. I have
not made any progress beyond that, though; it is certainly a good task
for an interested student or mentee.

Thanks again for your interesting article.


Best regards,

Lukas
