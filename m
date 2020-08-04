Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452A23B50C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHDGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:33:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:33:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so11962909ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOw1vNO+rBAdfNfXbQHgCWtEAvgqAeThDHj8plQEESM=;
        b=EUL5ylNHBLe44agjMa/72UTje/FpJoetElyd/AsVw8fo8LyPg4TcMM2GNtk5RBJI8x
         90zB0xpK0FBsZ2oEQI5oO5LBCyeE6aTvIuJ4skQNVAsL3gVbH4ntEBkAVWbQyZ5JJ2TD
         dO8NEgOz1WDVOYeDHhhuCXPk49mEL5WyoSl8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOw1vNO+rBAdfNfXbQHgCWtEAvgqAeThDHj8plQEESM=;
        b=QzaLwm0vOsPx6HBiB3TD5H1fLtb316qF1AwfREPB8014zTJWSVNSeE0vZMfVeLsIdi
         //mAyRi6TBfDTJJswzWCNgFooDNf4WOVDM6FgC04QLB24yP1RiEIevq+LCjWbgoOITTj
         4VtJt+tKEJzl/EWUtVMfFxVK5ozRqSR4ZhD5IBqQOQsJRenV+M9cFMl9sTE5HsfkUCW4
         QqhRAjETInz1WoWQVEzFNZBJbSIvaPlZYqmd7soUdts5bBxCvlOmFt5l3ZYzrFeQmhfT
         RgMulTMXMaz7vBF24sGRkjSCfJE45q2R/kFmAvKjR7gEdKtnh1IlK62IKjhezg9fnvvO
         tvkA==
X-Gm-Message-State: AOAM533N8TZ63DhIv7S27REb1bwyaaFov8MjJ+L0pfXp+o5j133eps4/
        3/ainyeK1XsUhk129+LVPDZ+yWTQvVg=
X-Google-Smtp-Source: ABdhPJxwwIjf+BfpXdGSFPXsEzkp+aa0jyFAXhOopeGPQA4uVTDbJv6CxijGiCoSaB0zZ/ezb0vrOw==
X-Received: by 2002:a2e:9888:: with SMTP id b8mr9984613ljj.383.1596522837409;
        Mon, 03 Aug 2020 23:33:57 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u5sm5837862lfr.3.2020.08.03.23.33.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 23:33:56 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w14so12446024ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:33:56 -0700 (PDT)
X-Received: by 2002:a2e:9252:: with SMTP id v18mr5717733ljg.70.1596522835731;
 Mon, 03 Aug 2020 23:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200803121902.860751811@linuxfoundation.org> <20200803155820.GA160756@roeck-us.net>
 <20200803173330.GA1186998@kroah.com> <CAMuHMdW1Cz_JJsTmssVz_0wjX_1_EEXGOvGjygPxTkcMsbR6Lw@mail.gmail.com>
 <20200804030107.GA220454@roeck-us.net> <CAHk-=wi-WH0vTEVb=yTuWv=3RrGC2T28dHxqc=QXKkRMz3N3-g@mail.gmail.com>
 <20200804055855.GA114969@roeck-us.net>
In-Reply-To: <20200804055855.GA114969@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 23:33:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguY19e6_=c3tGSajC6zxivJ6vH+MsbGDUzSMe5NFkJeA@mail.gmail.com>
Message-ID: <CAHk-=wguY19e6_=c3tGSajC6zxivJ6vH+MsbGDUzSMe5NFkJeA@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/120] 5.7.13-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:59 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks.

Greg, I updated my internal commit with Guenter's tested-by and some
more commentary (I had tried to break out that file entirely, it gets
ugly).

So it's now commit c0842fbc1b18 ("random32: move the pseudo-random
32-bit definitions to prandom.h") in my tree, and I've pushed it out.

               Linus
