Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE411303FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405615AbhAZOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405757AbhAZOKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:10:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A92922B2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611670159;
        bh=dywcinLhnWbCGkwmC7N27KWDoiSsoR2mDWme4MvGMX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lM1fUy6Pf1Ouniobh3R22FFSWZdr8Ds/zPrpGFz7dYQIkwi1K2L3ZTEBXuJ1YX7Bo
         3h8FhPbAihY1lVZ834KbiWSnnYmmyGKV373xPvTG4WZivQ9ZNY7qsSiU24LMwMVrj5
         Gnmvw1skGRFfYNJVtiFl1lEMAg+kkB9slgS/2CVAUZhAdWdUsGR3MCQqGEFeISZZuZ
         aN2wwo2QqqYE4nbJ78CV25cW7Y7dL4sszl1L8BEBcfZmFpBQUaXv5HzF85pW5rWcXb
         LYuPa/g22p4Yuxjb2DAe4pXSt7riXmx8/8yoeww07FrzEFIRwUs7+At4XqRmTgSOKr
         OAqMEouGVBryg==
Received: by mail-oi1-f170.google.com with SMTP id d18so9240916oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:09:19 -0800 (PST)
X-Gm-Message-State: AOAM5315hB9BQtXvJHgRVbs8vS/yuA+YF+/HYt97Eeo/t70WHKwR0Jkp
        r5s98EnMgxjmOPquTR1egZ0iqlVp1MxkLIAqzac=
X-Google-Smtp-Source: ABdhPJzg4s1MsR3KH/HUBStRGQGi14cr6taM6xDfLQvIzDToIyO+J2m+BiSP/UmK0hcWuxTRWlYa8ICOsMJfNKBmOOs=
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr3405012oih.4.1611670158912;
 Tue, 26 Jan 2021 06:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20210125113758.2430680-1-arnd@kernel.org> <20210126080827.GA26654@trex>
 <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com> <20210126114507.GA9282@trex>
In-Reply-To: <20210126114507.GA9282@trex>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 15:09:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0nZSejOkQScYBPnDP+2H_bo2nmtOqxW1j-F4tb6dbLAA@mail.gmail.com>
Message-ID: <CAK8P3a0nZSejOkQScYBPnDP+2H_bo2nmtOqxW1j-F4tb6dbLAA@mail.gmail.com>
Subject: Re: [PATCH] optee: simplify i2c access
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:50 PM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
> On 26/01/21, Arnd Bergmann wrote:
> > On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
> >
> > The fixes tag only describes which commit introduced the bug, it is irrelevant
> > what type of bug this is.
>
> thanks Arnd.
>
> what compiler warnings are defined as kernel bugs? is there a list
> that you use when tracking these?

I consider any warning a bug, a normal kernel build should always be
warning free.

I sometimes send fixes for warnings that only happen with 'make W=1',
'make C=1' or even 'make W=2'. For those, I would only categorize them
as a real bug if they actually cause runtime misbehavior, but there are
some -Wsomething flags that we would like to enable by default in the
future.

      Arnd
