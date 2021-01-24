Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFC301E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbhAXS10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhAXS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:27:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF9CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 10:26:41 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b10so12567138ljp.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XXqxxdF8pEH6i4M+pBK93Z9NpVMNWCsTEbZ/h58ER0=;
        b=Qqc/mvyUXMkjP5et3r4aF/o4FRzc/Px/SL7nJmmcZnw692Fr9KuCRLXgZ3o/BLR3cD
         tTRbpO7VIGjagbCJVV/xT3k+5RNQX+b2xxVqfHFOkc6J0H4P9wI9ECWWIkGDkTwXcRsz
         kLY+Bh/WAgFwfKJNqGD18GEmln+N4ZcL1rsqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XXqxxdF8pEH6i4M+pBK93Z9NpVMNWCsTEbZ/h58ER0=;
        b=pe61x3X8dLLslZ89BjItpX+hSI4SrJRi7sDtsdBWLCwO2fDnHQtCy9simUDmckHnsf
         /R+z5LnUnAHHKKHz3sCOfp13D6d2mcXrxJzOVkHAAqS4a27OWAHbudb60JKq71Amly3C
         gcZb8NRV1NvLlcJLcKzW0LhBYi8qf/lUTyOeaC7GlfBnLRdW9tsuX5aJ6PWEOqjNdQ1T
         lKPQ4IO5jN5NJy4AGurROpv3+dfgZJdgMMcipKmHP7ap0+UxHri2DY2TwQ3vYqSfNFDF
         D5S4s7aV7xWBQrAosLMlKtGlVO0MOVRmC2R4IjqhmZ8W3fmn6oA/yS0NxLR8Jaz3Yn2G
         ZEWw==
X-Gm-Message-State: AOAM530hpLEoDncdEKjTN+sDoBdgZajMSYWk6RAQ6WM3SahykAqUcaV7
        aLWHfG8EF+yxDqvTs0f/rdMPjcsLQkCXCA==
X-Google-Smtp-Source: ABdhPJzijCZe816s4XA3cpAcUVQpWaIiAe9oWHezaQHXc/zX2PcNtbiKEv3MAGOkpHgdJQOalV637A==
X-Received: by 2002:a2e:390d:: with SMTP id g13mr769224lja.23.1611512799419;
        Sun, 24 Jan 2021 10:26:39 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g17sm1562365lfb.30.2021.01.24.10.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 10:26:38 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id f11so12550138ljm.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 10:26:38 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr394301ljc.220.1611512798033;
 Sun, 24 Jan 2021 10:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20210124123049.GE2493@zn.tnic>
In-Reply-To: <20210124123049.GE2493@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jan 2021 10:26:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2XRSWkUVbXH23e0ghCjhWV1VbMJ+EGRPQ6ynjRLm05A@mail.gmail.com>
Message-ID: <CAHk-=wh2XRSWkUVbXH23e0ghCjhWV1VbMJ+EGRPQ6ynjRLm05A@mail.gmail.com>
Subject: Re: [GIT PULL] irq/urgent for v5.11-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 4:30 AM Borislav Petkov <bp@suse.de> wrote:
>
> Thomas Gleixner (2):
>       genirq: Export irq_check_status_bit()

Thanks, this was one of the pending things I was thinking I'd have to
do manually if I didn't get a fix for rc5..

            Linus
