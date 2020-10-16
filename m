Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A02908F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409036AbgJPPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408907AbgJPPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:55:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2DC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:55:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so3434087wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uPu7s21uGVHH4Ds8znmWGRC7b4dIQAk9M5zAN/zbV9c=;
        b=UACZys+M5/IfIGGSkw3rjGRumLVfWG1/0Bmpc9hHLj2gpJGSdpBu6IQSQpDDy9KA1D
         R7JjwLL8XX/ZWQZ2ShVSu+WrPP21NQaz02L64vNESD1yJ3uRrC8gudQUN4iRhmBLAPQN
         ORorH8SWpASdPF9UY1x2uZ0HBzD/ncgVAImWSqnjEWX1St0zkdq0iWGWLf0jzoLrOqW/
         FeblMF8Q9XeC6SG0p39v8+/bL5jJvtTE8oXVEa85IHIO7M0FwUurGk8khlK8s6CCeqZ/
         GiKmRGDX8zkFgewcXa414Dvm/vs9VQoqrsM5C2qc04qk41rncbX9B8zBQ6PCbc51iMYW
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPu7s21uGVHH4Ds8znmWGRC7b4dIQAk9M5zAN/zbV9c=;
        b=BDm32NTPSKO41EytJecWaRfjBQ4VBJWuulr819nlPgGCJXJJrY/1DMmNPSyhilS8q+
         bm3QBtPaH4N0zuyiOH//RL6dskso5jLnh//HYfWM6TEZ73k+7w0PGu7sEhlDPqOLFZzi
         I8s9X9rP0nHbNH7H6p3oolTrq6cZesp9Wt/53H/w8u9hrOjaGEd97nkfNfg/3zTHbz2C
         li8f7UgTTrbid4IMLWBGrqwSBh4nFNpfAqA0tDAuTUYGwXJSmYWVnR3kvDwcClRH6Zea
         8aqOMRjZ5W7x/uMWU5w6SlxU+w2zI0kOPR/u8kuOsuUuuSo82gZcGWsQq0XHWccEkUXD
         o50A==
X-Gm-Message-State: AOAM530QJiPpSCKlFvCmvHOnljTCzoJ1Wf5w+jlptmyCerLGUo0EAeYR
        LFs8miUSiZZdHm+YHS7J1Xcsjw==
X-Google-Smtp-Source: ABdhPJyo6H7nom6g6P02iEOhohyxQR/g9mjSToUWmLZKNDYCi89M6RnksM8yvLq8oTc2yMqYTG/hcA==
X-Received: by 2002:adf:f1c1:: with SMTP id z1mr4716324wro.331.1602863723768;
        Fri, 16 Oct 2020 08:55:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id g144sm3462364wmg.30.2020.10.16.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:55:22 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:55:19 +0100
From:   Quentin Perret <qperret@google.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
Message-ID: <20201016155519.GB2426638@google.com>
References: <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
 <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
 <20201016130905.GA2426638@google.com>
 <CAD=FV=VXt_JdYjPdTSJPWpXR2Owz096WhzYrZcQZ8-znmQbkLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VXt_JdYjPdTSJPWpXR2Owz096WhzYrZcQZ8-znmQbkLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Oct 2020 at 07:36:03 (-0700), Doug Anderson wrote:
> The one issue that I started with, though, is that I wanted to be able
> to specify "sustainable-power" for a board in the device tree.  Unless
> you think you'll convince Rob that it's OK to provide a "units"
> property in the device tree then just adding a "units" to the API
> won't help us because you'll still be stuck mixing/matching with a
> value based in mW, right?  ...or are you suggesting that the
> board-specific value "sustainable-power" would also have to come from
> SCMI?  That would be pretty annoying.

Hmm, maybe, but that's the sanest option IMO.

We should fix the PM_EM API regardless of the DT stuff because
pretending SCMI values are mW is kinda dodgy and confusing. And for the
sustained power stuff, then yes you need this in a comparable unit. If
SCMI gives it to you then it sounds like should just use that. And if we
can make that change to the DT binding then you'll be able to specify it
there as well. But if we can't, then we just won't support mixing and
matching DT and SCMI values. So, yeah, either the EM or the sustained
power value will have to be provided some other way, to keep thing
consistent ...
