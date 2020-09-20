Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5227185B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgITWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:03:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74054C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:03:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so9472701lja.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ri07SWB636BQu9HeTZXldjDnXsp6QhYO/5gj4FXNUIo=;
        b=ehY/ZfgBKBZu+aLDoJAH14zbHNeQQ4gPKz81o3C3zMJoYWW+yWIZcVreq3Bx9P2Kbq
         B4WYpqJ4sY4sPF0L4iVeGXgGQYf4oxxPGdpLAEYNYEBQrbTiD3o+Bh45zKmRlQcOmARx
         jtQ+yhKP/y6+y2YXVRrsKT1ot1Q5AvF0e2b7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri07SWB636BQu9HeTZXldjDnXsp6QhYO/5gj4FXNUIo=;
        b=NgES0xWAEJE928REi4V2Ju5fknSbkUZqSDjE7v+KkBCut4IxEHb6Cb88vGy5H0hYAX
         poBxcPVFmJfGSjzhDFzt3Vdi3s8o9eBLnf0he6NODzrsmcHRP4iNuCoM8788/a+JzZNn
         0y1sSlEgXiGMnfuIBeXgWy2Q05zcWuQeRKwoD3f7jzSkPg0SGZWRQw7E6cBpA61a1zpN
         bROAKCLD8BJofI1otkIk6j3aVJ5EjNPoTKNDH12LLxr3qPYo1KADK6XZTa7BND9/r1QV
         ilUM+4Xr7txPwevBRWUDZeNWE6Zhkn9+tOJI1G8Kup6V20DvCU93x4a9Wmt1Cl/3PNyu
         cS+Q==
X-Gm-Message-State: AOAM531nxY9hVoUl76Q7s/fr6XSg6az1o2AsVZFN1vZX7qNtun4VUEUa
        GBxg3NQF1MnUmAIhX1XS1LlsPdVuODTbUw==
X-Google-Smtp-Source: ABdhPJwQOOPSDc00zLPNReIUU2ILvk2DqJnZ5eY0oBuKy1lRt/nWhQpfDV4DWazTi/HpkAkSO2QLwA==
X-Received: by 2002:a2e:810e:: with SMTP id d14mr16596624ljg.100.1600639434443;
        Sun, 20 Sep 2020 15:03:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z7sm2055914lfb.221.2020.09.20.15.03.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 15:03:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u4so9469210ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 15:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr14128964ljp.314.1600639432685;
 Sun, 20 Sep 2020 15:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
In-Reply-To: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 15:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuR1ZHV4c6a7d3EmgRBFfQfYGckD2t1kQXDpwnf50ATA@mail.gmail.com>
Message-ID: <CAHk-=whuR1ZHV4c6a7d3EmgRBFfQfYGckD2t1kQXDpwnf50ATA@mail.gmail.com>
Subject: Re: libnvdimm fixes 5.9-rc6
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>,
        Jan Kara <jack@suse.cz>, Adrian Huang12 <ahuang12@lenovo.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 11:56 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
>    You will notice that this branch was rebased this
> morning and it has not appeared in -next. I decided to cut short the
> soak time because the infinite-recursion regression is currently
> crashing anyone attempting to test filesystem-dax in 5.9-rc5+.

Thanks for the explanation, all looks fine.

             Linus
