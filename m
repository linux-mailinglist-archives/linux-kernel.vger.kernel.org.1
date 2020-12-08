Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922DF2D3242
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgLHSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgLHSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:35:48 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C2C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:35:08 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y22so6332484ljn.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=Rb3yB97rD4Jd09jB1o/7GugG34ZyX32ATZjk4sAGSTpj11Jg5M0x97OA7D/aj1dg8o
         tRtB/Md3dssWMo4XJjaEetlgq5hwf3cnlVq+rgiijO9tpW6gTVdxhrcQ3J58bsnPIlbg
         2+RmSGDu+naDhJQPeAR9B/tFcLahy4KmGnOcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=pKifeq3rxtIrBn//5ZrjlJf1okUSO4xv4fdgEYGw1zePjYAtyFr4VTl8DHmR0eIU3g
         R31PcCF4uuVjLcfc/T5TU4LPWqgWGcyhMQMTP4tqJoECcAMsRzEzAHFFiXUt0pFLceH5
         4Oh98PtD9XXeyOm4Ki6Bw7/u1YbWDIvJm+Vtcqye0wAu31ayhqiZ2MbC+HrZVe8d6mq/
         kVIqwuRqrjN2tY/4F4hIydIg+6aEh0pMdyD6yGXlL7sLy5MjFczeBFwS9q3KdIO3d0bV
         WNofHKk6Nu5p9La4e2T5FdcOdFJ4HAi9B06TM0IV4NOUCfUyiI6efNUDYz0Gmo+liFpH
         X42Q==
X-Gm-Message-State: AOAM532BDagKxU/v/dwPbmv3XZ/HQmR7fxokNJqNwSBX11nOmzgFO6+R
        RQnmbsPZZjmnRrCrudlUGJhoGGI1r8pr0A==
X-Google-Smtp-Source: ABdhPJwPAs8gXigRZnvEV+KGWGXqe4QwBkTL3zxk+HVznJ+os/7OHoT8I1N8x/LPsXH1XoK5qwcKlw==
X-Received: by 2002:a2e:6e06:: with SMTP id j6mr11378559ljc.282.1607452504963;
        Tue, 08 Dec 2020 10:35:04 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f4sm727181ljo.84.2020.12.08.10.35.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:35:02 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id w13so12662502lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:35:02 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr10997620lfb.421.1607452502153;
 Tue, 08 Dec 2020 10:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de> <20201208163552.GA15052@lst.de>
In-Reply-To: <20201208163552.GA15052@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 10:34:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Shouldn't this go to Linus before v5.10 is released?
>
> ping?

So by now I'm a bit worried about this series, because the early fixes
caused more problems than the current state.

So considering the timing and Al having been spotty, I think this is
post-5.10 and marked for stable.

Al, I'm willing to be convinced otherwise, but you need to respond..

              Linus
