Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDC21C1C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 04:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGKCPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 22:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKCPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 22:15:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9234C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 19:15:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d18so8056262ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 19:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjujC8EH7ARbkTUTNO0AnrUD5+VGBwJEBYZspc6WjII=;
        b=ogPQ8EyRhdkSFdL4/cDqfRJ+oKbAdByvqCcZYxlgLBEmMyi+HEHU8wRGgxuprzVVfY
         Bk1ZSYF2URTiVY8EVPE7fqvC8bi2DNhOT+eqsK3HKU/xrB/zyr2JwTbsw561w/YLQrA3
         yNBxzFaWea5ly8yDOt2/yYjTY+PaTreGReehSovEpKdc1lH73Ms5pqngmKMMYTKmOqkW
         2MWalwH9UzuIsiHH79iVhu43Z0mc8Wdd+AYVbmpCFX8DCBvaKqX8INi1y41NAfVeUI7Q
         cStYIJ6QfULNlB1FThzTnAl+5mdHjdiL52SP+ftsBkIJqWi0yhKhzbaG2uKs0Vra7q6a
         rISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjujC8EH7ARbkTUTNO0AnrUD5+VGBwJEBYZspc6WjII=;
        b=B9lWWcg43hsfdQvDf9PWJ+p6tXF1Q4zF5PR0QBpHN+1VPAVHFAW7/7kqUFNro0qU9T
         aarvJHpM2472xVyvx3uO2e7b8I0rqVFpU8bPPR4r2/qmIxqzXuZfVfWv4e4TZkBCZp/T
         jxvX3WqyuaAOjgyqdbR79aX1c5O2/MrPOn0QhmuiFTbOhCQizglssgxIDf0cTmTMlQl8
         b6FN/jojVlKPr91rOMBkbefRF1PvXr5xAbjBfPsR2PY+mjbnifsjaKNcFUSaObwkj/3R
         IFxNRZV2vLZ3bJMXMN8fCc83pN4J4+eHrGLvC9q4llbKZVZNLEOGwdty0AhOzfmbOL+I
         bzKg==
X-Gm-Message-State: AOAM531aXPzJyuThilZwycvIDIDgre3SaIZq9SZJwLFt6PtlRwNPLgvO
        8GTEPYVweBo5k7hAmMfYs8U=
X-Google-Smtp-Source: ABdhPJx3s/y39L1YC094wxBEPYNA4rZAtO5WqYE00tjIt/gDBMl/W96XJHcl57GcxXrNQoXEZ4lgPA==
X-Received: by 2002:a6b:8f09:: with SMTP id r9mr49792526iod.168.1594433743667;
        Fri, 10 Jul 2020 19:15:43 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([107.152.99.41])
        by smtp.gmail.com with ESMTPSA id s10sm4387816ilh.4.2020.07.10.19.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 19:15:43 -0700 (PDT)
Date:   Fri, 10 Jul 2020 19:15:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] mips: Remove compiler check in unroll macro
Message-ID: <20200711021540.GA4337@Ryzen-9-3900X.localdomain>
References: <20200709221102.323356-1-cesarb@cesarb.eti.br>
 <20200710223441.756320-1-natechancellor@gmail.com>
 <CAHk-=wjb_WVt2Dxe6GUVcMzgms1od7Qt83dOShQ1-ux+tp1RsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjb_WVt2Dxe6GUVcMzgms1od7Qt83dOShQ1-ux+tp1RsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:43:43PM -0700, Linus Torvalds wrote:
> On Fri, Jul 10, 2020 at 3:34 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang 8 was chosen as a minimum version for this check because there
> > were some improvements around __builtin_constant_p in that release. In
> > reality, MIPS was not even buildable until clang 9 so that check was not
> > technically necessary. Just remove all compiler checks and just assume
> > that we have a working compiler.
> 
> Thanks, that looks much nicer.
> 
> Applied.
> 
> I think we could probably remove the (unrelated) clang-8 check in the
> arm side too, but I guess I'll let arm/clang people worry about it.
> 
>             Linus

Yes, we probably should. I'll comment more on that in the other thread.

Thanks for picking up the patch quickly!

Cheers,
Nathan
