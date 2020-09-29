Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D527CCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgI2Mjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbgI2MjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:39:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:39:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d15so5287172lfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pO3zqsQYI2N/eYjowpxSiobXk5D5lO4UhUmAmNb1cfA=;
        b=z1MHUjfGRzU82Dtosh2a8opmMrq1Eg71HqIxEIq6S2Oeuu/nsS6zdTyTtExJ79csrj
         Hd5OjTMiUyFNiqAa6fiiQ7jrBG7t62SQ4kdaSZSh0Ahc8eJ08HqghIswg+N8FK7A3+LU
         NlAJQZ8H29Z6/LqvcgqimfZKahDzN2b9FvaiyKY/M5NKqL1cBCmuaYunJk4uqxKpFFUd
         QVYGkiFbTiXZle/0YxBFdH754wluYB3EDid1vcbqmTvWKh02vstPT9ydsSh6wyiGErXm
         dJ77L067lcfMDTKYcSEpYfoJjyVKxs9UE40ag7Clnf/Xrb/ApF7BLWRi0Gp9mdTHuMIe
         6Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO3zqsQYI2N/eYjowpxSiobXk5D5lO4UhUmAmNb1cfA=;
        b=SFcufVYjJWLuDqeXSEAYCEnk3n/TAjYngjur4HToIxpZTeiWfMdHFTWC4Aq5BwMvgA
         BDrbmwFA6652/tYApP0j3EVcTNRXG7u3O13OywB9ofLoVjJjNgSEYM0xNe+4D/kJCZI+
         8muYEIzJStOFLjtA2GfmsgmNcwFUj8gH//jqmsbxUloAsuqyCpauaMHL1X1kmtUtAhUp
         QcW7BFbh5Z4mvYnqgVkDp+eYrAZ+UM6U/ew4gG3wBoH0MEsjITztjGXYZFj91qR0Wsrg
         gxByGOEDIptS5imdm4fTfo8V4oKK4vTTQqiW4uVV8w0f7cejh2dfOQ5Lqn3XhFkDH5hf
         UPiA==
X-Gm-Message-State: AOAM533zQiKTbLDqIk923ok5eDMbBAJnCowE9mAvPqHjBi+67DRGlzKK
        RvQ0sc8KDpaIhC9w8GbqFbdjZ9p8e6Z9EUYF4/xKlA==
X-Google-Smtp-Source: ABdhPJzm7gNVSpq1WdNCNfqImJcd5pprrHt5u1gKhkFTU0RbDTB5uGa1psjLfZ+O81pjELct2ciXh3fSJYmXc0pB6gs=
X-Received: by 2002:a05:6512:20c3:: with SMTP id u3mr1054711lfr.572.1601383161918;
 Tue, 29 Sep 2020 05:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200910025631.2996342-1-andrew@aj.id.au>
In-Reply-To: <20200910025631.2996342-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:39:10 +0200
Message-ID: <CACRpkdaqtcPsinURk88GFYyPcDr2SdoRXWUCHMMn2cQtbBYyog@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: aspeed: AST2600 pinconf fixes
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 4:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The AST2600 pinctrl driver was missing support for bias control on the 1.8V
> GPIO pins, and in the process of resolving that I discovered a couple of other
> bugs that are fixed in the first two patches of the series.
>
> v2 Tweaks some of the debug output and adds Joel's Reviewed-by tags.

Applied this v2 instead of v1.

Thanks!
Linus Walleij
