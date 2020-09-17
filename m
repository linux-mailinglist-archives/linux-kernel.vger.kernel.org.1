Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07026DF97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgIQP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgIQPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:25:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2EC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:25:11 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so2661371ilp.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFFaAiUYQGx/B/LQ4VmSRn7rzjJpXStmCMvHShYB6Ug=;
        b=QZeRmYehLIc7meVnuqibRbPZMvp2rsT2Zwr2pFBBsmMNUi3jV3/JqKEb5ojpLHNaOd
         PAKCJKTW91q/lcDCiI2nN57WoTjnaprxx2n4Ao2+uM9Ivz1GhDMFEKkJ447D3oJwUMc/
         F2H485GOMU7HmmbazeFlvK0pZHcrL0O+f+LP900wn7V+YoYnJOkk8pODOuJDEXrFe5VH
         pWJQOUSxWk3RzBGRHzzr89TvrRZnpMbOpPeQ46k7ju5/7yDGRlwgKzsCNr17TLN/kw+v
         q1js1exW5eRtGhxFvNpuDb5xHyjQUKuuBj/l6jXoPpwIdsr2sGJRdTZj0ABhmV0jhYoj
         COYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFFaAiUYQGx/B/LQ4VmSRn7rzjJpXStmCMvHShYB6Ug=;
        b=fmnMqoXuIvYLOq+96TewpgS+HMuh8XWXbTvi5La6xL4G3VdW2pvZGbA8iYsbZlYc6f
         Fzutc3iaVF7FDb78IDTM5k7KYny3BnHt8Z0XmYXRSiDTU4REqj2oioVndzEsBD7YIY7J
         tX/U/AFupZi2CrWyRn0BKQe5PZSvyK0UjcAQT3iQVgEyFpVzhf1HJsWl4CTqvCoCG0fR
         UoytmpLwNRKEeKOG4n7N9C0IKXsl2XaPLT6WbqHykWTRAT8XHyZFpC2FvV2cJWNhjHad
         SwHoemmYb6uLEu6+uKZE9kelHwhmD4MWqs+zwR6z3oHJ6kmznNzU3LYFIh1At+N5xnY7
         Ws+A==
X-Gm-Message-State: AOAM532VHoQveymApdJmGqZeNL0zH6kFkG7+dSjtE3g+2F+U1rs6aBE7
        t+J0scSjAoq90FtUR7nCAiTE+61zHVhXGCyip7Q=
X-Google-Smtp-Source: ABdhPJxb4aw3x4OPxv5mugv8+g2gLOkcsWi99lTIO1oOop9Mrfbyxyq4HLv9Nn3Z4dC7+v/GvtHZmsYhuhGFF5dlIDs=
X-Received: by 2002:a05:6e02:c07:: with SMTP id d7mr26601655ile.301.1600356310371;
 Thu, 17 Sep 2020 08:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200917082651.GA4595@lst.de>
In-Reply-To: <20200917082651.GA4595@lst.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 17 Sep 2020 11:24:59 -0400
Message-ID: <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.. OK. Any suggestions on how to fix this?

On Thu, Sep 17, 2020 at 4:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 16, 2020 at 11:36:05AM -0400, Tong Zhang wrote:
> > if a nvme controller is not responding during probing, a use-after-free
> > condition could happen
>
> This now leaks the queue for the regular teardown path.
