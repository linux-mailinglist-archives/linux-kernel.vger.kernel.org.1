Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82027E3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgI3I3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3I3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:29:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:29:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y11so1102647lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m989BjzdNWBUQv8KIho7qjR9BxP0IepkawJx1H/XAnI=;
        b=I/9Wyw3T3aSsnU2k68PFKT6j9HxBNIxap5h74Ug9ociWfVd1W1g/el8JT16tp4BJk0
         xF+pMZ1NnGz2R6XMvCQNSzxsN2oiRsKK8XeZr5sMUpFZ4xYJ4Gb6SVko9p3Yd+ub2qhB
         4rREnF+ym6uJI90GAeOql6DdwKHq5+5nAU/u7jegFfxCoLWQknC2NeOOT13v83sbWtsz
         Xd0GMWnxhEwjqXi4HNPlnF9f9rE263x55F6CYP98FEpDQaRcIrIvyZPDS8gq02jkAfei
         aD55Lxy4phqDfZ8A4ZTe7ve8o69sV2pYOpFeMn/2nQj/MjzUqL+aWL0C8fZN7dYhzsHs
         lGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m989BjzdNWBUQv8KIho7qjR9BxP0IepkawJx1H/XAnI=;
        b=p5441WBAzbWTOPoo6bK/nEhql1JMpSj3Pmu9EVcVbE6ZysTy8draPlmYT+rvf7REOo
         g0Or6GItn40Nzh78a+7s/uDmsbou99ebI1eBLHieavmUjqketxa8A9GIdCuxqwonm8jg
         F+zjdSOyjDblyUrSLQJNQMag+ajueOM4Re6SXerAYEb8oUDAY3xlD4/x042FmuA2yat8
         Fcfyex3V1KLZvsGffkuU8WyHaFdoeKdDF0vTWl0n+tqRsMrdbDPTQ/xnflPItDu+PKF1
         aMXFBOsf6V/kAVa/yC9s3fS358KWk/Ga5n0J0VNlFQnqFBcc3qhz7OmwXFQBGCsLldwI
         SU5w==
X-Gm-Message-State: AOAM532QJBTdAVhtRgf6NnjshCRbwis8PGU/os7AkvDne7H15iwMMxd4
        qBIwqwOi6E/4+V/4dOgAetfye0oVQS1MIU6lW4SDUBigmrarjNiA
X-Google-Smtp-Source: ABdhPJykWeCHKU6801hbG6QFjbaNwzGLKpK+cbzCsC8IiwoQS7Ni+If5cGT6/obu2/Uu81On/dmaWKRcoLv9K8FvlLs=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr453556lfr.571.1601454560622;
 Wed, 30 Sep 2020 01:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200925235541.GA28030@agrajag.zerfleddert.de>
In-Reply-To: <20200925235541.GA28030@agrajag.zerfleddert.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 10:29:09 +0200
Message-ID: <CACRpkdbCper3P818HoHOAP0UyM1uFn7cK5UUbhh6cvzDK_eZJQ@mail.gmail.com>
Subject: Re: [PATCH] bus: arm: integrator: fix device node iterator leak
To:     Tobias Jordan <kernel@cdqe.de>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 1:55 AM Tobias Jordan <kernel@cdqe.de> wrote:

> In the for_each_available_child_of_node loop of integrator_lm_populate,
> add a call to of_node_put to avoid leaking the iterator if we bail out.
>
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Signed-off-by: Tobias Jordan <kernel@cdqe.de>

Incidentally, Sumera Priyadarsini has already fixed this.
Thanks anyway!

Yours,
Linus Walleij
