Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB461ED880
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFCWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgFCWSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:18:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE3C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 15:18:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x27so2313493lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgGugU/qZe89+gnbp+elpA+XCgk1PYAAGN28MPGcHz0=;
        b=MVmmI7ix4V8oho44hahkegOWPRfUVyUUkybcOxtxGA2m1t2HeY9FGNqyy7EikWYv+2
         qanLD+tjEKv8FTonAzfz6Ft80BoAp0v95PUrfHTPvHdDk2LPAp1Ol8OwmHlFA0tw6wck
         gzZoZAzg/XMjnhNCsRrTro/QpUoORyeMuk8qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgGugU/qZe89+gnbp+elpA+XCgk1PYAAGN28MPGcHz0=;
        b=BzD3g4pUCQe1h0GjqTkHZ/yqFy0j/GRYF4DbXv8m+uIZ7FHjZVjnFHbyi31+qhyD/0
         PLoKldPS1xxm0W7R8oi0qYuVeECrApaK24FBIJuKFs+CQmibPWbYme7wcdvKlJeuaJ0b
         OCdHYtPaC60py20Ms7oA6W1YdTTLIWK/2HOVB2BIgXnfs5Pnf3yHjOhJQ9NqIwWax5+c
         5VdFItr6JzxX0y0of4A6i3RFDiKgSPdgjc7Ho1WDATQ1ZJ+f+kB2Y56aA/oRK9m1TUVw
         bBmwcW3bjqMLR214IcxQcvlBVkKEaticn7XABU1lZiThmMjHC8jSlELDBDwZptkorGSM
         c5UA==
X-Gm-Message-State: AOAM530H0gakdEw+GGjfpTT08Q+82vjeI7sFT85/6aAN2UIL8G37wivT
        +cNJCKqVHIP8AY7bxXO4XsPC03sX5RI=
X-Google-Smtp-Source: ABdhPJzifftP9jPe1pdo6Du+3zh0Wiu92LfM6/axsoGDZXDA8coeykOoui7Kzb30qi3ARyyv9ltnHA==
X-Received: by 2002:ac2:4562:: with SMTP id k2mr838103lfm.5.1591222695786;
        Wed, 03 Jun 2020 15:18:15 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v23sm164305ljg.122.2020.06.03.15.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 15:18:14 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e4so4806511ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:18:14 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr601781ljn.70.1591222694044;
 Wed, 03 Jun 2020 15:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200603173857.1345-1-pbonzini@redhat.com>
In-Reply-To: <20200603173857.1345-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 15:17:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC21siUGvy9zpVOHfLRe4rwiT-ntqqj3zN73qtveKjpQ@mail.gmail.com>
Message-ID: <CAHk-=wjC21siUGvy9zpVOHfLRe4rwiT-ntqqj3zN73qtveKjpQ@mail.gmail.com>
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 5.8
To:     Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 10:39 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> There could be minor conflicts depending on the order you're processing 5.8
> pull requests.

It would have been good if you had actually pointed to the reports
from linux-next.

As it was, the hyper-v pull request did do that (thanks Wei Liu), so I
could verify my merge against what had been reported and this didn't
take me by surprise, but it would have good to see that kind of detail
from the kvm pull too..

             Linus
