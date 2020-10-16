Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590F428FD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394336AbgJPD7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394287AbgJPD7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:59:15 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:59:15 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h9so811680ybm.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqjCC1fl8HdGveHada3XB1pWzPR1v6ND3el66guxp/g=;
        b=N3M6PIngpVnByoEPT3tIfuE/WLCZ0ojYq+dDLtcJuV/kYDHSKO2c1Y3in8i7+xEORC
         6UUAPmDRUPOKadw/WFDGMPbigGRD5UU1q9VuPJmZI64qSg5NTUkH6bQUQoPo5E1EN/rM
         H3DHrQUzaxYQmID7HctnQi0psuKaQLLqr5Y3OHdKOJqiz9UhmE6pdoXm3kR3TPO9DWhx
         yZs5+FnQf7bnsfciJtt1IRmkF0EjDeaioioLFBqe3b6u+6IFXg9WgAQv7lpiv5UfccbV
         V56pBNJquyYeHILTy0JecGapcul+2haBz0m49Ru4AF/GaUNKJDSvmepbD45m2Luqbmz3
         NLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqjCC1fl8HdGveHada3XB1pWzPR1v6ND3el66guxp/g=;
        b=N/il5Sx4d+fPTkPz4LTZccx4iGU0dZxl1ELErU0xxXyZDcMhvNqvf533agxLZxIvZx
         I7MV6XT73HL0utMIBp7au9gEIkN+nXJtcisL4iA7Z1lpg3kZYvUaHaTsLtTanw55jcHV
         hqw/yy0S0tuhmwFsPYFOxynDnOZgwANrTZrDroa4VqZDPhuTvx13csxV9YFa8UpwNLqL
         J3xKiZ00CRYtXk+pslvM6ifxtgr9luVLzc1X8XZuINGjAQAzD8bT/i7jZDlhbcCsaNu1
         XVS5v8jTxZywH3fMzmPzgFn9iYG9liTDGLB/PuOzDv637V7bs/R6mpy5a4SD0Fqooupv
         R9+g==
X-Gm-Message-State: AOAM532A23VqQtQ8up5dQ69qAZxzhLum1Y/qQam5IkJbn8BIMuAWFVPW
        qhlsQa8G08m6Nr8+HLqM+uMlnwmjFMEoVe3qoqg=
X-Google-Smtp-Source: ABdhPJxNgVLGbPZlP1/ihtnL4LgUcqG9tSOnhzNXFIblSuOcP+9XwDXnja5LFohBMG3mvztGu1S5gMKitjPFtmEjAY0=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr2452018yba.22.1602820754870;
 Thu, 15 Oct 2020 20:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de>
 <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com>
 <20201006083834.ejbl5itjvkbqbmby@lem-wkst-02.lemonage> <CANiq72=cz-bvbGU_cY+Rwoq_hJAXBEur=Yw4=Cs2APxp5yODAg@mail.gmail.com>
In-Reply-To: <CANiq72=cz-bvbGU_cY+Rwoq_hJAXBEur=Yw4=Cs2APxp5yODAg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 05:59:04 +0200
Message-ID: <CANiq72mhhYYpXM6ROKUGa-QMDd_qqV5Ki7eifo-5rz4=PG9oXQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/32] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 4:33 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Picking these for linux-next (including Rob's Reviewed-by). I have
> spotted a few typos that I corrected -- I will note them by email.

Hmm, I think we should do another round instead, since I found what
looks to be an unintended revert of a previous commit in patch 24.
Lars, can you please take a look?

Also, please take the chance to apply my comments given we have a new
round (and Rob's Reviewed-by too).

By the way, I think you could simplify by squashing the "implement
hd44780_*" commits together (i.e. from 15 to 22 except 20), and the
two cleanups together too (i.e. 20 and 23). I know we asked you to
split things up before, but those two sets are quite similar
(including in their commit message) and easy to understand all
together.

Cheers,
Miguel
