Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4828627CF13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgI2N0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgI2N0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:26:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68865C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:26:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a22so4001379ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+suD/UKCVwZ5/9vCLHfVIVUw8ZqdLjq+I4JDrjqAHjU=;
        b=fsD9nzfHpx7Jn5l+QguvDo0wYYEB5/qwGs0CB/GBvaj+fztlpDqOLpTizBF2MehcAz
         iEmyBDwD+OQUImfx4+wsxPh82JqX26sKSPxiwUbRAAP79dLY1k5pnyMj9iBkoYZINsel
         1b29Yv6gRVsQb4c8dAXrUiJPg+M0qcM4qK5ukKpT/Iv8gSgs4nQojxDvPMy1Zzd696lC
         ulaz6k7vx1BlA6PQCUl+uQBAqv4+oPP/wLh/c2gzl54IJwHEfKW+Pe1aXwbQPsCvRBGz
         BYRNrCb9iH+4TZ0NEN3IuJ1dTB8/pjv26Ocnu7XlqX9KziOFe2lxjHlpbAIMvLdi//Zx
         7TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+suD/UKCVwZ5/9vCLHfVIVUw8ZqdLjq+I4JDrjqAHjU=;
        b=WzPX936kePtgfHxPwn2Cf4jgHEl3m7XIjbttFsIixUxZLttbOM/YgcGH/sz7nqMI/H
         Kdr4s1WLEWTXLNp/D0KriJ/nFEZODUCXWHgUF+6VHUL5BDV6TzL41Lhjbjwx/wqbrqk3
         uPROn1/i3TBUefeFpH9rZHG1tCOiZr/XYxP4o3ievJS/mWlw/DfNEU/Lp0dEqhPERYxj
         z3wvv8UKij2Ayyv/mPgMdCKrGbjpxIxaW9tnzbhyjHSlIqrjBA9jPmVq7aBXNk5GWUW4
         knh/QWmJUmuiJ0JR78qdMUMYs5ThF7at1cJYShjeRgXtVZQJe67/jtF61xRRtBEJ7aVt
         6vRw==
X-Gm-Message-State: AOAM530up5rdvwxUnlHRGNR1cKMSjPX+duLe9ahPZJsGnzOqvn4j4v+y
        z0IZbEPIJPL5LUBIY7kfz8Y4z3NP+qdw5eAtdOMLdw==
X-Google-Smtp-Source: ABdhPJy8FrE4DtZvE+N7M9IrW1DBMhLoFcKMrK7A+HJ4VoFzBay3c/Eh0NVo0tnOfR5YWTA63NUy3ZB6y/PFP1Rl3n0=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr1140504ljl.104.1601385960779;
 Tue, 29 Sep 2020 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200921082448.2591929-1-liushixin2@huawei.com>
In-Reply-To: <20200921082448.2591929-1-liushixin2@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:25:49 +0200
Message-ID: <CACRpkdYroSeoVrvSg-cUqyaGEknOCa7fiA-jNP2fgrXFvU5ZYQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: spear: simplify the return expression of spear310_pinctrl_probe
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:02 AM Liu Shixin <liushixin2@huawei.com> wrote:

> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Patch applied!

Yours,
Linus Walleij
