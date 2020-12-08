Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B388D2D3681
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgLHWxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgLHWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:53:22 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:52:41 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y19so587054lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZplHny7NuMDeOaboy5Ojl3351+q3889Gr1PaS7aPZVw=;
        b=SoCAWoi6D80C376nwcmnYXhMLwlWp/fjLJB5XEgBGVMVfPU3bxnr2Ie6vmImL59rKa
         ZYJf3tAq9nvcbZXxr02MRDrL3FhZN7Z7fnYt9g8LdWhL66pWjHdR+8HvYC7DONcGTj0b
         jtZ8VS7TGo08Svsmicqpx2dbeSy5Ll1P+H440=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZplHny7NuMDeOaboy5Ojl3351+q3889Gr1PaS7aPZVw=;
        b=h0WISHHvyGJrDTeZT+LSTV2y5Ojq7kZFB/XZjjo4c3U3If2awCYVLw+yNU3FV5LJw2
         9ZWbfM4PI1fkPhgN3XOPC0bW3VnEkaR1PJdaYp+LsoJuS+s71eLBdPToJbOn5OSHD09X
         Wwp51TkZ0gmqtWRedNCB20zb/jNmJS4vViAgQnPiZZHCTx/o1rOAaF0yXdldx5wUnVEx
         PIKXtJsaPQT5lVILWe7uJQLnarZPq6H0y00xen24pFp01Lj7TD3obq6NKcQUR+hCUXdu
         VSytop2xGCrafrSqE2azxpjBCIgkTLRRV233qxXmFTHOpSIdyXwxWRIp32Q/1NDhRgzX
         XkRQ==
X-Gm-Message-State: AOAM5324/WcMc8QPc3dsAR7Z0nls27rD/ZUcR6ciVQlEvcDw74O5YK0g
        3+ANwUSrhBwlTgg2SWhYByEm9FmC7F8pgQ==
X-Google-Smtp-Source: ABdhPJy3wirYroK3BGQlQNeKQRrxgjsabYY+yvPL/nXH2mJ2Uv/GHRwqqdDmXQfuGGxc7+YllOQUng==
X-Received: by 2002:ac2:5145:: with SMTP id q5mr1150711lfd.626.1607467960069;
        Tue, 08 Dec 2020 14:52:40 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r16sm2419ljj.52.2020.12.08.14.52.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 14:52:39 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id m13so66926ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:52:38 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr1414834ljm.507.1607467958621;
 Tue, 08 Dec 2020 14:52:38 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com> <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com> <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2012082339470.16458@hadrien> <ca63ada5-76a6-dae9-e759-838386831f83@kernel.dk>
In-Reply-To: <ca63ada5-76a6-dae9-e759-838386831f83@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 14:52:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikp9x+nz=9CHc+70aO11V0a0Ga=WSpRTySqr_r6dpiOw@mail.gmail.com>
Message-ID: <CAHk-=wikp9x+nz=9CHc+70aO11V0a0Ga=WSpRTySqr_r6dpiOw@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:47 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On Tue, Dec 8, 2020 at 3:42 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > This solves the problem.  Starting from 5.10-rc7 and doing this
> > revert, I get a kernel that boots.
>
> Thanks for testing! Linus, do you just want to revert this, or do you
> want me to queue it up?

I'll just revert it in my tree directly, but you (or Martin) might
want to make sure that it gets re-enabled in 5.11.

           Linus
