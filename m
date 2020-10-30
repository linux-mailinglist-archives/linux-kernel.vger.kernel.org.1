Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479192A03F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgJ3LTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJ3LTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:19:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBFC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:19:37 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z5so7131645iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RA/dTcPLcLSjFsM4pTf8628QTB+ljlVPvTwaOAvSI8=;
        b=vPF6leW+6gfiBr1s7qfSqOlKqUhfUMZVxmg71BGMeoJBHzeltWCTbYEuXa0oT2dpud
         wFpsNu4u69HfrJAKI0EOaTm6zsS8jIGH3m+9HVCNWrLlCCPoSjJqD2wE8IxwVeOWCTT/
         s9zIz/l9hy6s0sd/GXp4XfEvSvKGZqcAbjIb+9V91QPh/+m5tmqwRgj69T+okuTdts7j
         f8Rb2Xhxxuv3wU2FnzTR+xffJLffig2bPxtSDt6/d+Kun2cCrXvDLDclwQ1mGchUWUEe
         kh7V2O04DMTgLQ+QNYBQpIuNOLClV0FN3U+CjlNZaGC2yFYQ9Oo0c77oTqWY7rM+3aR7
         b19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RA/dTcPLcLSjFsM4pTf8628QTB+ljlVPvTwaOAvSI8=;
        b=HmK8CMg2TzrZWbKn6nzR93wDDHBmDh7Jf5JILHAnVBIjyKTAwULcSq9Lfut1QhEhiu
         pel2iqa+GjRWDBLVhV5XeI58hAerJPUFTsiDQCrJJBqxJlTosuJCKt8MzVakD3uTdiY1
         OT8bKFYqZkCF2xxQrJErL3pT4At9rBcD1SMCu3FH6Jl2mu46OxLFAAYDOOA8hEWqQ5dX
         +vDSBWmSxYeJOayEC9pUAO8njzIQKcVysIa7O6SjYbyFJJzwqKLeDYrGLIlx77ggNeCL
         boBthP3wsJWm/OEN5VAkIHhVULT3mizKbkTeT3z2i88cqFdGns0GeeVqmko1X6Ona87M
         1oAA==
X-Gm-Message-State: AOAM533FDTrIMG23TX0O+eaK+GibIqMzezJZdCTw4Aq4U7c8Fy3Uv4Zb
        IqMWhoL4QfuVlhJ3k4lnlfvowfciOUnJIgI794WX/KFbnh2Aep6q
X-Google-Smtp-Source: ABdhPJy/oufOebW5MWlnuf1Ro28TfvpmK+4mcN6r8qxQ28XDMOnf4ekL4Po96CPF9erK2pQu3QvP3fFFwmkHIFBVjmc=
X-Received: by 2002:a5e:9244:: with SMTP id z4mr1374790iop.53.1604056776404;
 Fri, 30 Oct 2020 04:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075724.1616766-1-ajye_huang@compal.corp-partner.google.com>
 <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com>
 <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com> <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
In-Reply-To: <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 30 Oct 2020 19:19:25 +0800
Message-ID: <CA+Px+wWouXWS2F+Bqs3MkJxCuXORhpXcUF5ZuSHo6exprBF4hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Ajye Huang <ajye.huang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 6:55 PM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
> But dmic_get() will need dmic_switch, should i keep dmic_switch?

I see.  I overlooked it.  You can keep the dmic_switch for this
purpose or just call gpiod_get_value_cansleep().
