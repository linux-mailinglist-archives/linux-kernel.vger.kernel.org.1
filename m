Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F12AD74A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgKJNRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:17:19 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A8C0613CF;
        Tue, 10 Nov 2020 05:17:18 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so11944244ilp.2;
        Tue, 10 Nov 2020 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//LSi0PXIJ17WBRAkI26ybe4Dc39IqnF1jCBzmcT364=;
        b=U+kh+OP0W80QnkF+j8qwROAWG0YuW1QUw3J5Nbd/18M7l8+VgTQyQx2Hc/d/Ub7p6H
         waMHq87As6jJm+NH4MMewacYkMZFV+T+Z96dnrXxfULt83Dlgsn/6UNsaJSIyHeQA1o8
         BVdKH036FuMoeVest+3z2lm5WNFunFM3oJFoLc3RfqB3Fk4q+XQyYJeNUvX58pbMGrmo
         UDfxtZk3I4s+cB1YZ5kysLUGGrmgE+s5RanrjBFikIXecKcjsI4yjzsU9FOSi47YXt3n
         gizIABIc/MxYWJkTMLFwqBD/Xc73TksV+sss5uQsu/nIMZFsuqgaOEghxnf1JvlxocZR
         Klqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//LSi0PXIJ17WBRAkI26ybe4Dc39IqnF1jCBzmcT364=;
        b=p9ceFj3YjwNfUAxLUVsDKXadZlkuAtlpvYkV5gYCrz3U3Ecja0g2NkV0idTMHSjGKp
         4XcIPadIiIvLdofXiJbz1xRn+rHaHnXpfQSc+vH/Om83oLbk8+1OTG3RNA8bIeeAjPzL
         X1TKGyg/ZA73iVVjDa2b4D/S6LPBfLpk6uk28mrYU7HFmgQfhiyu26G5CGAz4yQcSYfE
         qs1oRZS/qqXNqb3GadBBJdjnz8PQuXniNiDniCAUf0VJkKzYDObjg3M858p0Faq4k2r4
         oTI2E8mVorhPZz0w2pNHzWal5IkYFFlXAd6bbFt7xDn+++4+CdSJP1Z7ewft/138CB9R
         rnpA==
X-Gm-Message-State: AOAM5307mJCpiCxFh4Tv22XpzZdY6cQeCxs1RhjT9N4Mpy4QzF/NWxqs
        zR9KmIcymokbzztqgkPbCpEe+TlLSJCotrLbswQ=
X-Google-Smtp-Source: ABdhPJz2VnAAI1N1A9l4TsfVyXMNdSNHe0DsyM9fUXWhTWuOg8A7gER+iGP+S7Fahfp1mvHKdv4+9xzumMCnHx0xFS4=
X-Received: by 2002:a92:aa53:: with SMTP id j80mr8088716ili.88.1605014237776;
 Tue, 10 Nov 2020 05:17:17 -0800 (PST)
MIME-Version: 1.0
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com> <20201104202952.783724-3-npcomplete13@gmail.com>
 <20201109172420.711965-1-f.fainelli@gmail.com>
In-Reply-To: <20201109172420.711965-1-f.fainelli@gmail.com>
From:   Vivek Unune <npcomplete13@gmail.com>
Date:   Tue, 10 Nov 2020 08:17:09 -0500
Message-ID: <CAChtp774Xw2ofzFMLiw75AWMMQP8dooo=AmFoZ6LrN5avo4jZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 12:24 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On Wed,  4 Nov 2020 15:29:52 -0500, Vivek Unune <npcomplete13@gmail.com> wrote:
> > Now that we have a pin controller, use that instead of manuplating the
> > mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux
> >
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > ---
>
> Applied to devicetree/next, thanks!
> --
> Florian

Thanks!
