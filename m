Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CD226EA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgIRBeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:34:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:34:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so4922290ioj.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMfYmzq61BMVuIay6MAmJ92sX7yw34AC1En4dJC49nM=;
        b=ExnwxyuOZ5QMOqFjrHje1iqNp6G4EN6OIn/hhbVXhERcc2Hj8jQQiDqUgfcjXqbKJR
         nJC6Iap4LGotN7XE+YqDuuwkJusdLs1MoPK67eMhwgsxsxdb9iVWcyUiJxWREwjcA3BQ
         2D7GL9kz6Uw4uAtVWDLsPTZO6/5Vei+rvdiA8Fmit419cA8HElorA4GgkoWcfxv5knOe
         c8JqlY1WTGcOHnr0Fa8ouqQd0wNtZEgRFFMHM80XqZ3sgimqtx20knjoAmd9Fj16mckd
         5hhZoUa1rs/NlRAVfzkDmNM+D8g9FPIcEXYyGYmM6NzLkl13Xkt5M99Ds5lDAe9gS99E
         xHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMfYmzq61BMVuIay6MAmJ92sX7yw34AC1En4dJC49nM=;
        b=hVE0bppxCOJAv6m2mXc28D7pF/BGPwCtMQl3I8pu05iKJRmAxvK6z+SL9I+RI+7ONe
         As5Zn4vqtYNTEA/LbtvtXD5sur0hMtTIFBsTngAwNb0mxmOYOyKuvBVI9tF9cPy1Lccw
         KrKHcNjLIGmO77tVNmlsb1K+a2GNDJ9D26Gn0I9G/+r7ItX6yweC2jWWrwOBIcCPbwlT
         53LajePCnvruNkVj89oITPcSzkOqHRbRVE6egnXHH72VMOGrGgeWkjJXe40oIta5lvMu
         bNDchrrzZHfREuuHQuJXeN2HaukXdfHp4sS8sEytnGT6SfcBi0oGnbUkRT2JGixGollh
         uhDA==
X-Gm-Message-State: AOAM532SxndBNmui2AQ9WL9ClYFq3WzlHS9wXDfw5iaHr0sKwW0w8XHY
        eALC/noo9fWm8cdH+bgHuM9kONRiMAisi156FhoPKw==
X-Google-Smtp-Source: ABdhPJw66SDlFRYI+47lgkH0zEhjVFqIUONt1+UdZYGerOhsCrn5ST22s+desHXe8eF/5qzEZsphVeuuWKzN1TY5lIg=
X-Received: by 2002:a02:605c:: with SMTP id d28mr28107291jaf.12.1600392870588;
 Thu, 17 Sep 2020 18:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200917063047.2875693-1-pihsun@chromium.org>
In-Reply-To: <20200917063047.2875693-1-pihsun@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 18 Sep 2020 09:34:19 +0800
Message-ID: <CA+Px+wVLBgzXm7FucaPpHRZ4+XeH629fPZYBZ33RtPSkaN9Fsg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc/mediatek: Add support for mt8192 SCP
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 2:31 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Add support for mt8192 SCP.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Has done 1 round review on: https://crrev.com/c/2297082

> +#define MT8192_CORE0_R_GPR1            0x30044
> +#define MT8192_CORE0_R_GPR2            0x30048

Remove them because these 2 macros are unused now.

With that,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
