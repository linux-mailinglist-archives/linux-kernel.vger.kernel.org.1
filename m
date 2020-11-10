Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB72ADB47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKJQIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbgKJQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:08:07 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB85C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:08:07 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so10843788ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdXpjX2fMBvN29YoOyMaOI1PARSVc0VzhKJzQ6c/jNY=;
        b=RejgqHVrBZZu4n1N0vlVzMwLbdbQEz7KDOjszF61G4q8FnDRgS6MlMMKiWMrZXVwRi
         C8H+ONHnQK3GJnpwFCGrj7Fjjj5F4RE4KtWhAayffxNUeXtlvMXbToJGo2vgtLLcaJqY
         peRHc6Z8Ayw2KbWU+aISfdBvaP/YrBNtZpBsI0qEWF4/hqkHjLL4F8T+mRom6j/cota6
         TQSbE1NjoQJKPX856Cxow92rdGCYIcyrktxvr8p8+99382ZchOXMvY62mC+8arBWtKey
         5U+z/S5+mUycsJXW9CjMbci8JwbcUuiXsjlR3nZ4kRBOE4I8I+YIImyCVntI7tSyibnb
         GUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdXpjX2fMBvN29YoOyMaOI1PARSVc0VzhKJzQ6c/jNY=;
        b=Lpi0TXrWoAWQxszWiemkrzngNdZjYLvPeqPJDwMTcysG3Rfm6j2gujLetoRJE6Jl8m
         44e8Y1JEoiJl4vFXNKpeni8rrHvPG9viwyunqY9srHEh8AdYJcpZHZEbs92ebxL+byji
         Kbc0SzSvXsMoG5voXMjHdD5usU3DB47YCMEeqXkkleMojK7lncrM9NdjhlvQ9zxgz5gR
         4ti/ffngH4ULdlym5b9NgSCL87rLQMCrP5HjCLKmYs9WVPE6A6/0QxNPDTrwA4kZwZIb
         bF1A5ZY1aT6D9gwj5mIGbMajzXDp+iqb0J/vl7S01cS0BKCuaXRqHy6wr5NpEZijb6aQ
         nRnw==
X-Gm-Message-State: AOAM530MWj9Q7CRPUzWJMFhzTdJnymULA/0iPSOzZIjZDgK4gHIF5CA3
        jWAcXZoisWFVSrMaVpG8T4NJX8Butq5TZJ9UBJKhMpG1DQvBaYOl
X-Google-Smtp-Source: ABdhPJx+3OPv/DyILoTWnWz5YCDXJQRkrl7b/kpZjceXJV8+4bcdHjQXNz+aJr98/86fydWiNskQFSAqwT5vTI8Eyk0=
X-Received: by 2002:a2e:9449:: with SMTP id o9mr8049890ljh.457.1605024485448;
 Tue, 10 Nov 2020 08:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201106061433.1483129-1-ajye_huang@compal.corp-partner.google.com>
 <CALprXBZCthdkxGbJBZZ+ESJRDBHY879FZMpB_4Mgpq1YAJun2g@mail.gmail.com> <20201110115631.GA5957@sirena.org.uk>
In-Reply-To: <20201110115631.GA5957@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Wed, 11 Nov 2020 00:07:54 +0800
Message-ID: <CALprXBZKnJGzFCLp0=UxJQp423QuaiPiaPzyY3-662k1gHUk-g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Modify documentation and machine driver for SC7180
 sound card
To:     Mark Brown <broonie@kernel.org>
Cc:     Ajye Huang <ajye.huang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-yi Chiang <cychiang@chromium.org>,
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

Hi,Mark

Thank you, I already understand, sorry for causing you trouble.

Ajye

On Tue, Nov 10, 2020 at 7:56 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 10, 2020 at 05:40:40PM +0800, Ajye Huang wrote:
> > Hi, Mark
> >
> > Could you please kindly review the series patch v6? And may I get your
> > approval if the review is done.
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
