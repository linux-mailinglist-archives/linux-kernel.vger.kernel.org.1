Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F257C290B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391980AbgJPSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391886AbgJPSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:34:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CDC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:34:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i12so3311875ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YjEtrYWM+WpdQq5rIA7Cd/jyyjiG9wZFmhoaoHRZ7kE=;
        b=jiImXk5hrhGQ0IWyjxH5N3WPRCnEJhLQ1Ofct0jdl3kYtYfBzOjopzIOhph2ww5ucE
         bHhNCDtjcpingtyfYKihX6S+h49vcZ+57/mKBJMBnpSaFGOunjMInAJrhuiJC8xS0+0x
         nQx95ph8OkadXjGH87uOJL3IrLwB7jDi2JndU/cK2wsIArZW6NkgnXZBo/gu/xYTnY++
         U0i0NQlZXBlsZ/MAUnzcch+FDez1RL6gniJ/Zd6vijE31oclp1Z9GhhyynOWkttp1WUq
         auKq9WKFoTJOuh2S5SZD1gBtou+YoQDnccq5BKI+JpBz7DZZgaLAM9TWWpk3MSQqbKCE
         P3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YjEtrYWM+WpdQq5rIA7Cd/jyyjiG9wZFmhoaoHRZ7kE=;
        b=b+jk8Dp30kAvDNkLCw3q3KhwoZspySdvFcT+6A78/GiG7bmEfoywl8F7k47oP3m6IG
         XtSvbITM7Tz42IwTus9Sre5yUbkgG+3Azi/+yMv0mlqFEHEyaVI5Tl1/cUS/uMvwIqnM
         8chivuu+OJAezNRguoc7CNKO2NzZpYIAFmscAYfIty9j5Tq/U9mKsSIa8K+ZQZ64yszt
         o/R6rdOOxE4siLGSmQ1xjLuiME8syhhvZjzoHkuWGKFwPDYXrqplSXRoRztiYF/BPixq
         O6MDgQOkqlGRXZMvpbHrk5cpt99F3N2s4T+4bXkTBg+zaP8+XEVarFLudfYObGxvPGQx
         YZ6Q==
X-Gm-Message-State: AOAM532GjkPMvj9JZVcBNv2tC+T7HtxZr4p3xTz46cYuPgDYX5hV0LBJ
        IapzpFJdZlQwKZbobEiOdC+TTQxNtVRp1ZRWXm3pcQ==
X-Google-Smtp-Source: ABdhPJw7tjr1fm5GouHDD8zGthbFcVsfrvoic1jX6NFUO/r4ZCIcCnfQDkNxyGdlbwILCV5qg9V+t5ILDyD+A5ctrzQ=
X-Received: by 2002:a9d:2d81:: with SMTP id g1mr3513164otb.352.1602873261398;
 Fri, 16 Oct 2020 11:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name> <20201016082945.GA1722359@kroah.com>
In-Reply-To: <20201016082945.GA1722359@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 16 Oct 2020 11:34:09 -0700
Message-ID: <CALAqxLWtrnYizdDVAQMqy1JmeZ5jUCko1XKaEtAd0zoV6oj0aQ@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Laura Abbott <laura@labbott.name>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Shuah Khan <shuah@kernel.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 1:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 27, 2020 at 09:31:27AM -0400, Laura Abbott wrote:
> > On 8/27/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > The ION android code has long been marked to be removed, now that we
> > > dma-buf support merged into the real part of the kernel.
> > >
> > > It was thought that we could wait to remove the ion kernel at a later
> > > time, but as the out-of-tree Android fork of the ion code has diverge=
d
> > > quite a bit, and any Android device using the ion interface uses that
> > > forked version and not this in-tree version, the in-tree copy of the
> > > code is abandonded and not used by anyone.
> > >
> > > Combine this abandoned codebase with the need to make changes to it i=
n
> > > order to keep the kernel building properly, which then causes merge
> > > issues when merging those changes into the out-of-tree Android code, =
and
> > > you end up with two different groups of people (the in-kernel-tree
> > > developers, and the Android kernel developers) who are both annoyed a=
t
> > > the current situation.  Because of this problem, just drop the in-ker=
nel
> > > copy of the ion code now, as it's not used, and is only causing probl=
ems
> > > for everyone involved.
> > >
> > > Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > Cc: Christian Brauner <christian@brauner.io>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Hridya Valsaraju <hridya@google.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Cc: Laura Abbott <laura@labbott.name>
> > > Cc: Martijn Coenen <maco@android.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: devel@driverdev.osuosl.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linaro-mm-sig@lists.linaro.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > We discussed this at the Android MC on Monday and the plan was to
> > remove it after the next LTS release.
>
> As 5.10 will be the next LTS release, I have now merged it to my
> "testing" branch to go into 5.11-rc1.

Sounds great! Thanks so much for waiting a bit on this, I really appreciate=
 it!
-john
