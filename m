Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8B27CEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgI2NVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgI2NVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:21:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D5AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:21:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so5512592lfj.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GI4Au8HNgydrHkFYfCOOBRMzO30t6Rvii7RP3gaHfYQ=;
        b=BY7TTFgSdO4pektZ06bqcNuRWZcl2fl67OsMeAWmBlrSzLaYO1ar/ipey6z1peIH1R
         6qpkI47lOJQ/EVZm9BGf6bVFUXLwmHrLqD2osNWTTUKjISuc7jfmUpr+uJvAlDa1bKVM
         NgiAY0zEHrkBkjRg9o+tnJ1na0aJfHawc2W+oAspRFbqDnfGwu+pC+fbhSiqcfQNHzEL
         28CBRn39hWS3ZvphliGjL5AJgiLMHwdCe2VJ/w8W5PQTMlkxraFYQypnl3oArvNOuSR5
         HXDXaECiOgaq3VP5YF3tQnr/fQ303RRNt7BQlJoQijq/AlqGs7shGKN7w0KAFLvLOfLU
         igNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GI4Au8HNgydrHkFYfCOOBRMzO30t6Rvii7RP3gaHfYQ=;
        b=aNR3Z7bkk2MYM/ovMoj44OsI9LYRPaj02+iCf2zXvqSs1oImRtVnFeyXE/RdVVdisA
         ymh8tFtG+v37a+FEIc4RiEcgwZvukgo0R/X3OcWAJNPL7wVoi1R+4B3eaPMdLQCTY7ss
         tUA7hvaZNu6kNedfYw2CzN0Ft+kirsTklVw4YOdwTkx8kn+Ekjtq65ECPmW00bLyin6i
         5lnqUoEWYE+IXZQZEoXGKPLJEuMHsnSpsnD6XoDT4GvIbKQGW15DrtS/tXgeYQlO+OJC
         KUi8Mn+M/86lW81kahIxcVLPWDVpYEnHzWVdPcsOwlt86v7ff2JPcYh8J1uQq23vd5xI
         eTaQ==
X-Gm-Message-State: AOAM531+0x5THDwcMpVX+RVbt0KprKRIojTqWBEfHDe1kdm+BDrnvTGG
        2gPk2bBv8R53CvAJ0fkTbZ0d6iisxPHL5dinc7P5Ug==
X-Google-Smtp-Source: ABdhPJzarkzRwPkBBa9BbWZJ6AWXbapY3ZMmRZddaMoA60g5JXWhuytPgpaen9owcVGF4VsPdPKFJLK5+HPavYp0lSU=
X-Received: by 2002:a05:6512:20c3:: with SMTP id u3mr1117636lfr.572.1601385671684;
 Tue, 29 Sep 2020 06:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200907025927.9713-3-jay.xu@rock-chips.com> <20200914003847.10341-1-jay.xu@rock-chips.com>
 <5373086.oXRXx9yCqB@diego> <7244527.mGzxE9Z0Hj@diego>
In-Reply-To: <7244527.mGzxE9Z0Hj@diego>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:21:00 +0200
Message-ID: <CACRpkdYAxpyB+y88eC4iuvHRqttPSFdaMHAZdr6y8jfTr0Qong@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: rockchip: make driver be tristate module
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:18 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:

> It seems I've reviewed all patches of this series now, but I think
> you might want to resend the series a final time as v3 in a cleaned up
> state (drop patch1 and just post patches 2-5 in a full series) so that
> we don't confuse Linus too much with the reposted patches we currently
> have.

Yes please send a v3 like that so I can apply it!

Yours,
Linus Walleij
