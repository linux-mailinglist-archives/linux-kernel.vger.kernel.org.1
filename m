Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B32CD41F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgLCLAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLCLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:00:46 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046DC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 03:00:06 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id p5so1478447iln.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 03:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCBJlUWH+dW7aWaKcrrL+ZaUSjhi3vUF7NMntXueVo8=;
        b=r8Sr9p4jQrUiKkGT1lccCyvzLSPvC/tFZoa3kvBITuDo0aNqqwYyEBr4ZX57brV2TI
         8ggs1nRgefvljtaew03Sgh2Edd5GsXUTZL6yebMypz2YncmNkHUvmN7BEXv0kild4ABX
         Wycb4OF1hTuFuNb5GiD8GAP9dx+NYaUX/1UvgGS7wQqugmc2WHnWflsuTY0rKenU1NNU
         LZ83vNj0dbj4kWWF3kPxv45BsR0eiiblOrp3MHuldTW2iarz6/oNlXqR/Z++sNK+ckk6
         yDUySjZc0bx725eOCu+b0TNXkvl7hukrIHn3zE304gfAPa89JlCZuPBp0HIdLJE0mAGp
         IIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCBJlUWH+dW7aWaKcrrL+ZaUSjhi3vUF7NMntXueVo8=;
        b=uSldumgrQVLWnTPs7lbKgqWOL+PO9pxcxLo29o1XyHFX9twTUW/er9NnoylLkjVIy0
         zcXusJ4NWe5V4/qvTCL/fNuUjrocnNRT3MFfM1vq19joOrumRHgnyyoOdEddyd8KEoVH
         C41z9n4H7wVTP+eeWxf2IBmG72YhVqo3dDUtqG1o/M1EhU/nGl8r/ARYd0XUMznzRONd
         8LHZsDH0ZHn4UJnZkh9/J+j/cHf9WFDYn4av17NryoiRNWKOG1I9a1qyHU5dygXAtRqm
         /prRqV5eP+NaqUo2tVEPvOyjCoJ7Vh2wp7ATOVE+ZltBunoSVmRKOdFsgjN/T3wuFIt7
         Iglg==
X-Gm-Message-State: AOAM530zlP8n2kNdKkIx7yVbW0Hl27fNA2KXG7lwqVhOgAcVyTB/EXiM
        mnW6FupJ0bbTpmuAR1bPjq+Qw5M7LNhC6Bg7Ygpp/NpluFo=
X-Google-Smtp-Source: ABdhPJwf0+pHYWwFyNweDxYeQYaI7uM/O1LxJXxJ1BGQmbhiDeF70u0g5K94a7ixSkKBIAzsSQcrRGg8eALz5YE9I+0=
X-Received: by 2002:a92:8587:: with SMTP id f129mr2473789ilh.251.1606993205259;
 Thu, 03 Dec 2020 03:00:05 -0800 (PST)
MIME-Version: 1.0
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
 <20201202183045.9309-1-yashsri421@gmail.com> <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
 <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
In-Reply-To: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 3 Dec 2020 11:59:54 +0100
Message-ID: <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
Subject: Re: [PATCH -mmots] checkpatch: add fix for non-standard signature - co-authored-by
To:     Aditya <yashsri421@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 10:59 AM Aditya <yashsri421@gmail.com> wrote:
>
> On 3/12/20 12:26 am, Joe Perches wrote:
> > On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
> >> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> >> non-standard signatures.
> >>
> >> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> >> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> >> tag, which may seem correct, but is not standard.
> >>
> >> The standard signature equivalent for 'Co-authored-by' is
> >> 'Co-developed-by'.
> >
> > I'm not going to ack this as I don't mind non-standard signatures.
> >
>
> What do you suggest?
> Should I drop this patch and move on?
>

Joe does not ack this, but he also does not nack it.

You either move on (which is perfectly fine), or

you either wait that Andrew Morton reviews it and accepts it because
he thinks it useful, or

you reach out to the git committers that have been using
Co-authored-by in the past and ask them if this kind of feature would
have been helpful for them and you get an ack from them that convinces
Andrew Morton to pick this.

I hope this helps. If nobody thinks it is a useful feature, move on to
work others acknowledge as useful. We have enough stuff to work on.

Lukas
