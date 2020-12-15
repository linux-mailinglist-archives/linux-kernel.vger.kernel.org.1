Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0142DB794
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLPABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLOXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:48:48 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84153C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:48:06 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m12so43880268lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA8LT3qUkWd0k1wXY1hka6HeU3KJbONc0lhdJ7FR81I=;
        b=GJ0NPhCDbhcFKzWiFORq+0REow2ggwYdGqObnZxfrrrWy4MD39DKOYH3of+d1OjHlz
         oq7rqK6ReOuMThpI3w6PKlVhqcHtYJdjmQ9afOczz16kK3e2YgoOO9R3lsq0uJ9P2Ul0
         4Dn4M0/TIMwSjZvRmykpxL2xC2sqtcRsE7jzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA8LT3qUkWd0k1wXY1hka6HeU3KJbONc0lhdJ7FR81I=;
        b=HX/EBPS5tWTuoaL1zOhEF4XyxsfMJWCbbPwXHw9X7SoH048FoQnA4ayaFCx2kVum56
         ZhHwe10vry9ws7xIpesGqzrEtrbWPmBwofAHYT/9jd/a+LVRHMcTxcj4LagwJI/Kpkfd
         PnQJivE1ymuF1eJ68kQj0/aQWir3PFVJFGT1uusOv1ShkaRp2x3Oi2uK2YhxJy+CwT1S
         B0tJ/R3nnmj3TQ56Csl5reUFenVsliFWLFlMwMmAhvgooKosMcCvwJCeuKR7FuX9qfnD
         3Pb6yfZSOPjBh43h9gACYMKne1rqSHBrfjIy7FevfZSkCe5sWK//6Od3wE3V/I+oN9st
         Hn2A==
X-Gm-Message-State: AOAM532/rAvatl25TGMrwiPMcotAvXiUyF7tI5Dwlbw6b0WYTk8WHMPB
        9tehtuY4KkScvJksHYpYbQwPcFAdvpiENA==
X-Google-Smtp-Source: ABdhPJxlzI9JlCILhwyX0bkx5GzxzzHtSo43oKBB/bt5etEUKjdb4WEsqpXKVbmjz96jV+pVUR+QHA==
X-Received: by 2002:a19:f203:: with SMTP id q3mr327828lfh.166.1608076084716;
        Tue, 15 Dec 2020 15:48:04 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q21sm47169ljj.31.2020.12.15.15.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 15:48:03 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id x20so24313978lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:48:03 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr13647767ljc.411.1608076083339;
 Tue, 15 Dec 2020 15:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20201214144753.1DA3B22B4B@mail.kernel.org>
In-Reply-To: <20201214144753.1DA3B22B4B@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 15:47:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOwGP7G-6rn8ZPwQJHhGiS1MxW06n7YY0TO=P8xHwf8A@mail.gmail.com>
Message-ID: <CAHk-=whOwGP7G-6rn8ZPwQJHhGiS1MxW06n7YY0TO=P8xHwf8A@mail.gmail.com>
Subject: Re: [GIT PULL] regmap updates for v5.11
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 6:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> There was also an addition and revert of use of the new Soundwire
> support for RT715 due to build issues with the driver built in, my tests
> only covered building it as a module, the patch wasn't just dropped as
> it had already been merged elsewhere.

Ok, this made my diffstat look very odd and very different from yours
- because I had already gotten that driver from the sound tree, so my
diffstat looked very different from the one you have - and instead of
being the no-op that it was for you (add and then delete), it showed
up as just a delete for me.

I assume you've synchronized with Takashi so that this isn't a big
surprise for him..

              Linus
