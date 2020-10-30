Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86172A03EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJ3LRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgJ3LRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:17:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CFC0613D2;
        Fri, 30 Oct 2020 04:17:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h6so4928561pgk.4;
        Fri, 30 Oct 2020 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VMT4CA+QCVxlid18luMuK/yjM388IDll1v1b84MHtk=;
        b=sFPqW8TwjKrvBR1tlV4pRHQuuTyk2oStCCWtGYb8gsTOY1V1ljLrGH2X6EULBXZEfm
         KkZrUF42rxAPV6uSaqhIhpdgI2RUvrOWpH0cYjI9+ahr6e/NoIiCILlAiGF5+0QioY0A
         vrgBlNZB7c0h8H5xW2C6tBMpllNEQIcxjhLeHvSt6vQ6Q07ZQvHtbeo1dTDbPIW7kKcM
         pBuktBXELgrJII46EGCacDZni5Z5W72wJYIHXFtjj+ZS0IDOa3k4d9TxAQoHyU0rK6W8
         k5s0TPOYsP7BkVL6D/qOy7vqzR2xApOSBjvR6i4ZXy4eb+Uf3EMd4QH/lRcw+9Q/ispZ
         xB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VMT4CA+QCVxlid18luMuK/yjM388IDll1v1b84MHtk=;
        b=FkP/k+38v5xuetNfj4UyPVbxQI7w69O+Afj+ri+ulQl3etYPXfgu8Mexl71QnirBLt
         00oBmJ5qQkgX/i0gUrQTqHxxLFsR1zt08tPx9YQBDcSYIPffJlQ1b18Z/IqDvdGCoTO/
         ydFEY05+Kpx1LwGud17Qm0qeUfJFoBWKvHBMzE+AS+QtpGyTFFByOj07cR1YTcHKN8hj
         QV9g4VlOdVmydwGUkaQ5J2AFmZuh/oTaITptAkQ8nnHnmmP99qbfMQC/1XYL8WxCk5YN
         2vuNdnzXSgxZEbiKbgD/U898MheeJQBxoZ0q0p5aR8V30GiBQhjUhF4DOZisSinN2Ns3
         JNZQ==
X-Gm-Message-State: AOAM532j6g9uPDZ5QFhEr43QCWDqshRU6I9lSuZyyN6yCybxOgmpg/yo
        ZvRGZkbGY8eFU1qMwrfkTIWOOPI9cDJS2hx/FSs=
X-Google-Smtp-Source: ABdhPJzBLHkNnl98vRvJBX+/lswB2MHyw4hNtL/2C+MU2oZ6OU0SEjL1SBk975zV8P7EdAI07yy/WADqN4iqLJrJpyo=
X-Received: by 2002:aa7:942a:0:b029:164:a853:f0fc with SMTP id
 y10-20020aa7942a0000b0290164a853f0fcmr8426433pfo.40.1604056664576; Fri, 30
 Oct 2020 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <1604050097-91302-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1604050097-91302-1-git-send-email-zou_wei@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Oct 2020 13:18:33 +0200
Message-ID: <CAHp75Vd46nO9nXAZZ5-XKZR3_wq-o37MdmLNm_KUTSvhsq+whQ@mail.gmail.com>
Subject: Re: [PATCH -next] usb: Make sync_all_pins static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:18 AM Zou Wei <zou_wei@huawei.com> wrote:

The title can be more precise.

> Fix the following sparse warning:
>
> drivers/usb/misc/brcmstb-usb-pinmap.c:219:6: warning: symbol 'sync_all_pins' was not declared. Should it be static?

Do we really need to know the path?

> The sync_all_pins has only call site within brcmstb-usb-pinmap.c

sync_all_pins()

> It should be static

Missed period.

-- 
With Best Regards,
Andy Shevchenko
