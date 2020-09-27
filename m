Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9227A01D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgI0JZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0JZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:25:38 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E3C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:25:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so7667658lfr.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmrerxLsDYMh/bkqTtdxYf9dKZLk+BUPlAAIqmKW+Kg=;
        b=Etk/NQgNueNG3pCn1cP9EiA81EAhV0eo3ir1H8266fAVMeDikRtqsl9O8MVaWrmQK1
         NX1+GgKlMFfd6IzlcAX85tsNL1fa9+WCXPQBnES+bZsPazw47PtGx823CsMoUaz7aw2u
         VbmGSNykeEKeVlkK0yaO/ERmFh2T0BO0reB11t7sVS0RuIQKZVeOwAFHPHMH6ikSA0eu
         aD0HAeG8M5nX7xMOFGFGdX0BU+gQRV2lKlGKpKGjT4o60Xa9IAZ6DGeKHoYK5Nya0f0d
         MhwG9nPq0m2f4QwyJVd/0+uz7BdwE7VDxvkapzLyMTfRkGaHqw4IjQybuVyiIyTegfJx
         wuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmrerxLsDYMh/bkqTtdxYf9dKZLk+BUPlAAIqmKW+Kg=;
        b=HmJSZ1+LqsoNR95f4fqMCofi0f6aGp0D+KdTB2YYp0J4umH/rvPI3tHpaiCXbSySTt
         DixZ0P9OLtteUSKtcFoVfrd5bo8rmMSGGIo9C1FCaRJttgkjiJA1VmD7QRN7Xy/ng4V/
         jtOp6YOZ9EnZykV0l1qvr9aI1Bg+Khi0nvrtxxDu3dyx4NO3kydyNKtj7vzUzdpUUuNz
         p91QpBrirt+jAN78jw1lMuSVEgH3s1r+WZq/5taDXpDIm/ZwE2Hd3V10OwgPomETOLUL
         ThGQqkHBICqiTK214AMWdvYMyAOU9FjPj6tgQ6RPxg3MsqaexJlKd9J+7HyEdclaDMEP
         h6zA==
X-Gm-Message-State: AOAM530euMCcDZ0vPlrPtkAZRRWyHEXysj/Yv6GmPk5SXCp85VLoux0F
        E5witHsSxu2OvR4a8fpmIPRyIaaAaF25v9xr3nuLBA==
X-Google-Smtp-Source: ABdhPJwJULgLjHe/a2sr/LvdH+5pKVGkZaiqS6R8otrTEm/iiiez/V7cPU39RQZ4WnDSRaLXAtulB/9BJtYtlSMuz1Q=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr2074813lfg.441.1601198736857;
 Sun, 27 Sep 2020 02:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-2-arnd@arndb.de>
In-Reply-To: <20200907153701.2981205-2-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Sep 2020 11:25:25 +0200
Message-ID: <CACRpkdYZw11rJce-Wn_b0xfs-SQKNUQiO84UhxGK9MDfSD7M-w@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 5:37 PM Arnd Bergmann <arnd@arndb.de> wrote:

> On machines such as ARMv5 that trap unaligned accesses, these
> two functions can be slow when each access needs to be emulated,
> or they might not work at all.
>
> Change them so that each loop is only used when both the src
> and dst pointers are naturally aligned.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That's a clever optimization idea, nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
