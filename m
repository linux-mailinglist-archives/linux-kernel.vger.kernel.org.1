Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31B026D7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIQJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:40:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:40:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m5so1460308lfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7R+wox6CHCxosACtHi4H1wYbWsO0Eq4eZaw9Hzhzclg=;
        b=pay5FvcdkjLjlD4+XXh86WlhyTEwUPXqLQSr9VtABpDbJMoZi10xIQLQI6zjdzR/Kk
         Ys/dm72mWYzINIumOKDsxaHTQIuV992DsU9G7CQ+SvoPopIpDFtoeJpBT22Xox/W5C85
         yR+bHF2A4o0WWJi3ueUdtbTaLiU61/IaUs6eCmh3+UiXsZyL4/GZboMzUk+p5N8gsP0O
         altaRY9ZgMQI/HvWBFTAdk8GWM+fPhoP3eC8obl5t0+qaZKAGS+1fP0S0u4JjbsKXbm7
         niMd1MspC645gCv8jvRhZi10CFnX9/DiVaScyU4Osu08XO1m+z3sxqPNJXZBiU0YQ1iI
         gFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7R+wox6CHCxosACtHi4H1wYbWsO0Eq4eZaw9Hzhzclg=;
        b=MpsHbYNhb0iC6mztOc6kd/wk9IX+3d9HMKYT7A6Ay94gARGB0hb26bqxGAbEp0JcsH
         1Zil/Svo2RchZ04xLkbmeOBPHRzSXC3DVqREKqxr2hXwhuTcY00RPg+unkwC127hg+9g
         U7+8zmNdLQvNjgXjOEu8lDPalQfdJjIebBkDHz8Go0hPXlDETFzQqUFk8UbGaJ8vRxo5
         S0yNi6Pc5KRh0YzUeJb34kMicw4eFVmOuUTy6ICfqp+nqMv4AiwVFQAjWgrherDelvZC
         M3m/laTZimxZ7jrBb7jb87mW35xEKlX7H84gA0RP1Z8bP95J1ByzM2D5vlTMtCYH86/1
         5DGA==
X-Gm-Message-State: AOAM531hpuJwL7ztESSC4OhXXdIdVqCFU3V2JkWeRxPEF9B6TkNdRlO2
        IdqOHHUJU4xRizgJg+uAhyuNlH9ffxYLy1wZpAA=
X-Google-Smtp-Source: ABdhPJyI0q2mqx62JEKBMhksq1G60Cikhwy9zmdA6w9fOw8tz48KUx2OY8Bnclq4Mcoyjfvk32HeD2eZW8sBy4MAfxE=
X-Received: by 2002:a19:6419:: with SMTP id y25mr8825139lfb.333.1600335615060;
 Thu, 17 Sep 2020 02:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Sep 2020 06:40:05 -0300
Message-ID: <CAOMZO5AxhrU4=gcUfKL3rU-790k_xE6SzVbdZqYr7JCdUZqGWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: fsl_sai: update the register list
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Sep 17, 2020 at 3:18 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> As sai ip is upgraded, so update sai register list.
>
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add new added registers and new bit definition
>   ASoC: fsl_sai: Add fsl_sai_check_version function
>   ASoC: fsl_sai: Set MCLK input or output direction
>
> changes in v2:
> - update commit message for first commit
> - Add acked-by Nicolin

For the whole series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
