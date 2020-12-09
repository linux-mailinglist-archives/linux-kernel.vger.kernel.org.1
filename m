Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964CC2D3FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgLIKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgLIKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:14:49 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F9C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:14:07 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z11so692151qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rjD7IseveSeNkH6VF4Nm3t/LEPLDkcL2AIVZGOLwaQ=;
        b=bYuZo14ICpkzNIN2VbO0nSMeZMGOGObypWmZnDScE4IKQfy4mYHoZcgftoPAN+UE1A
         8yEkNLgXB4AFkEeX8yrTLyy7c9I9fsZRmybhtJsMPtb1Gm1sEMn9vITJP8Ht5hW03BcV
         CTzKi9lp5VbX1ngvVito4r3LNXJ6laM1+JGNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rjD7IseveSeNkH6VF4Nm3t/LEPLDkcL2AIVZGOLwaQ=;
        b=EBcXNNyaBms7sAXF6S2rKDqrTcb6mi2Aj5Ou982zrvRVgWz/ywncg4pOGELDKZB6Jj
         5yCcuhNwfncML+oNAwJzeub/egiqnQNoM5bziqg1E8/0ztIPlJNovwKkcM1dLCaarHay
         HJ30vjmnwg7D+1bwvUIjsgrnw0EkFR9bntYLCdvIkSBNdCxlfkBtVqfWswnxq0+SK85r
         QwIcSv2cNdB35BtWloG8+NdqRxH6l6ooo/uue4o3XNjv2mbq8b6G1LZC6bmFh5DAuS1G
         YT4QrOAYNhR9Cru3952QR1z8RAdhXA0FsLkEu5CFhFS9jfKqiM/NGr+yC+eO7DgxGspI
         htjQ==
X-Gm-Message-State: AOAM531B8CQVaDHdWSHNxuEJUPSg+KKlWMYXrqnfnS+wAaKU1Oc6Ol/Y
        tG8nwhv++P6poA5KNyZ7nBRMWsCthmTHCI/2V6J9Kw==
X-Google-Smtp-Source: ABdhPJwcx3VJ+/O9OTm1VhxGxVov7pwPjx8v0ff+R6oPDxN+CsTklvE1tvNVoov8YhiobB7/4plhzBsdvvM280GFLbM=
X-Received: by 2002:a37:7c07:: with SMTP id x7mr2165263qkc.159.1607508846374;
 Wed, 09 Dec 2020 02:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20201208164821.2686082-1-paul@crapouillou.net> <20201208164821.2686082-2-paul@crapouillou.net>
In-Reply-To: <20201208164821.2686082-2-paul@crapouillou.net>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 9 Dec 2020 19:13:55 +0900
Message-ID: <CAFr9PX=EgQSXeATLn++DSHkkQar35rpLGh978J5Lnw9jS8XMrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ingenic: Only support SoCs enabled in config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, od@zcrc.me,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and others,

Sorry to hijack this but I actually want to do something similar to
this in some other drivers.
The targets I'm working with have only 64MB of ram so I want to remove
code wherever possible.
Is there any reason to do it like this instead of wrapping the whole
unneeded of_device_id struct in an #ifdef?
For example there is a rule that the compatible strings have to be
present even if the driver isn't usable or something?

Thanks,

Daniel
