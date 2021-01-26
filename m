Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAB303B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392456AbhAZLY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:24:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390952AbhAZJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:11:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45CB323103
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611652233;
        bh=zdTPmAwairV8shigFDysbCEYxemi0qlu/sQye+3VPYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tKqe587tHfpvaAQFSLXLgTclXh9avJ/FnPf4SgciABCZLRIAyPYS+rQ24zuAUG1sf
         TW31GrsV9EuW64SHttbC0/HbkMIY8/yPV3eTEILeaD2+i05kKg6XfZXc/rolPfWa/7
         ES7qmfG3dVAKsIKh/xVYPwsAIk3V5GeH6tjIjiR9Tk3+sebG0j6tTtiIoMw1vJSvoP
         CP3VHJvgJQk+6ThvO8jcZtSJr6lvb22OAM8T6+KufWasEtb6RDb0W5gsGJF88MDq1R
         jdHIQLE+5ieYWrCq4gddf4LGCrMwgQA0dwMhJ765yxo9JvknH5xRJ5N5KujGe3FAes
         ktCC4FcJ/v2bQ==
Received: by mail-ot1-f50.google.com with SMTP id d1so15540569otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:10:33 -0800 (PST)
X-Gm-Message-State: AOAM533Htwcegqapmyc7M4fDdCK5eqn4H6btvabNtJEJvlb9z+CgBg8A
        NQoWiSAyKnZz2ZIYkSSE57QvMy75EZT2mBkuo5o=
X-Google-Smtp-Source: ABdhPJyjhX3hTJI1kwWboGAAj6FivjPq5tnnbuHH5upXXVVWougCo+rrv37dyOwnHgZd1eYW5AdqtoDY3+5RgSlgtJU=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr3427905otc.251.1611652232487;
 Tue, 26 Jan 2021 01:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20210125113758.2430680-1-arnd@kernel.org> <20210126080827.GA26654@trex>
In-Reply-To: <20210126080827.GA26654@trex>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 10:10:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>
Message-ID: <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>
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

On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 25/01/21, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Storing a bogus i2c_client structure on the stack adds overhead and
> > causes a compile-time warning:
> >
> > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> >
> > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > open-code the i2c_transfer() call, which makes it easier to read
> > and avoids the warning.
> >
> > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
>
> does fixing stack-frame compile warnings need a 'fixes' tag?

The fixes tag only describes which commit introduced the bug, it is irrelevant
what type of bug this is.

      Arnd
