Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38A275DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWQlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:41:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98134C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:41:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d190so169383iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dsh5kVcL0Zz/uaeUu7RBOwQv289afFMLyYlaCd/5qzg=;
        b=OC6bVAwXdTVVp2Ujo5E2D27IUKBduif4l7gS+lm8rNKZ23HhFjma0l3k6LTHvc05LD
         wu4wlocPR8bXhJbP5kcs/5Jb0861sIHTD1zzrHmwyVMGkJTg5xdlP1JHoyAluRqMwDSq
         PMZqHfzEdnP6ZYcLzcmeL6S5MBW983kb7H7Dqf/HxAgrDXYF3Xc+9WM/iOkl/mpRa2ii
         4W9hAL2LGD/O5XOSRybSP7auxmHuZT9MX6UrWyKzOK/gJhF3S2zcD6dcKS8NXbvzYhlu
         UABwVR4RQD/hWU5OCt/AbiNEjwCr5pmhM0QHVprhJtXa8A1Mtmf2cvcURrDCVzDu21yT
         XIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dsh5kVcL0Zz/uaeUu7RBOwQv289afFMLyYlaCd/5qzg=;
        b=PsrlHm4Ntq3cuEsbMR2de5JfnRBzeE7RYfzOry8Eq9O7qM/6oIWvRa3zXdCD5ygq7i
         YFKsXNaCxgrseK0zIez7sERGp8tCnQxg3Ub5AOq4Cui1GyMOfcW85TeIo//KKxZihdpP
         ptN3hv1N1b1BPRc3QnELO24/h6eB6dDACeTzHTvKp6fKNg5kt9mpKNOrgHKA/y5qOGFn
         A5BDXuOtmwKSlrNQ8o40YGecS4LKKM06xLXgQ9DcGkxMfE0nWNbZAyEseNt2tT4jGIMr
         cr2SO38DxmaoocLODhNw2NeM2piq+38uV8HX/NohUfYu4MGypHAY7RgkBQPukqZi1mRd
         tkKA==
X-Gm-Message-State: AOAM532vN/yuGFuRCW9hOc7hMUmnbRtHELjpCraKf6o8GvxGsM1th7xq
        jTV8zFtEpjBHj8sd4/WQGYPFRWZ5gmeaSO1YYo0=
X-Google-Smtp-Source: ABdhPJwDDwo+YLGCIxjT3ydOvfjQ8egO8Z64SUNEUKOYFAs4VOAUXFLtQ2WDzgWOnzI1D+2yl7GUoWKyTWEisdb9NY0=
X-Received: by 2002:a6b:908:: with SMTP id t8mr320427ioi.124.1600879265871;
 Wed, 23 Sep 2020 09:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de> <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
 <20200923050641.GA14878@lst.de>
In-Reply-To: <20200923050641.GA14878@lst.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 23 Sep 2020 12:40:55 -0400
Message-ID: <CAA5qM4AuYn4XEHWv5TcHpr77-4yd5os3ykC0FY-JGE-i1McR8Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, WARN_ON_ONCE() looks ok to me. as long as it won't crash the
system or lead to any memory corruption issue.
We can talk about the reproducer offline if you are interested.
- Tong

On Wed, Sep 23, 2020 at 1:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 22, 2020 at 04:34:45PM -0400, Tong Zhang wrote:
> > Hi Christoph,
> > I modified the patch a bit and now it works.
>
> So you're still hitting the WARN_ON_ONCE?  I think we need to fix that
> as well, but all the ideas I have will turn into a bigger project,
> so I think I'll submit this one to Jens, and then do things
> incrementally.
>
> Can you share your reproducer?
