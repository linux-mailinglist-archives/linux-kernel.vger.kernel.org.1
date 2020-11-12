Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A52B0C69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgKLSPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKLSPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:15:21 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E50C0613D1;
        Thu, 12 Nov 2020 10:15:21 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n89so6504735otn.3;
        Thu, 12 Nov 2020 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3o5lzi63AWwtdCMieOu/FrstqLHaPIaK4QSxL42Cno=;
        b=QDxozASeWbcmTjc+w57C/knk37xRkoo+MvYxL+sQV9W18rnxH4GGAG1piO4Zw5XDgQ
         +rAYArioiloQStX/jNF+9wheXRZytUtzNrtEIfdLeG9SO5r4Jnx/0pzU1pR/pIY7Nw+I
         5Wu7KPh4vV5wvr2j4i4PfSGEWrleCWxMrdjj6z3r8TJCqOqEKUfK1bYX5kNa4P6VlEvO
         JOA4ZjXoVQCh+QjzCOTXzz775qBt04gVhnXmhleHGvSL/ZLkqDvLc/aUR/SywJto+RdV
         9Ov6YgTGqaeQEg4kG/BtgYffKKXmpzONm6KK05ETGdMEsrQa/YuNnORK520Mp9KZ7aXR
         RtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3o5lzi63AWwtdCMieOu/FrstqLHaPIaK4QSxL42Cno=;
        b=LwU/vGlMVtCMG2qChKR6kEjNsCh20fELV4J2Yb6Pqnu4DsEHmfj1w/F+bWa5gO0BbY
         uTLh4k+5Il86Cc29iefymHKbPFurkcHKURtY+Urv6MalOk7z3RiSayfuHtCr0Boe5Vmv
         cWjLWt2TYs1FeIwT8SvquCC+9kSPpHdFvGZcTEekyrgnT7u9swbHxsiCCGGbmo3t4mbi
         1tesl3ulLDqRwvFJQrWF/NstNekTdEt8+d1mEXnhRkSk1vQU1gJ/QZ3hj7mGdGspITs/
         ZEAVY8o6JzVZw6dZaFtxc7IRDtHWczS9WetexXYQFZCPt0Pn/Hly9aQLkuRIdt0t5BIn
         EWoA==
X-Gm-Message-State: AOAM533Nn0FVh5mPoLsopdOf7VJjaqMOlHk+YcGByRIV5bjFkPx540+k
        xkjUuD6xi3JpKaQJ5NWyQg/MRkPuW2t4eeJFpIo=
X-Google-Smtp-Source: ABdhPJyxsWAfmHK5xHd+pEUuO3NtX/LYZrfjHwiSFS5EqKfkhYLBWxmaHwr/S2zxZMOZJm1xksiExMhqNitp5chygHU=
X-Received: by 2002:a9d:3ef7:: with SMTP id b110mr308139otc.333.1605204921041;
 Thu, 12 Nov 2020 10:15:21 -0800 (PST)
MIME-Version: 1.0
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com> <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
In-Reply-To: <X613chtPVIg8kquH@kroah.com>
From:   John Boero <boeroboy@gmail.com>
Date:   Thu, 12 Nov 2020 18:15:08 +0000
Message-ID: <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then why does line 278 right below it check for NULL?

On Thu, Nov 12, 2020 at 5:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 12, 2020 at 05:13:30PM +0000, John Boero wrote:
> > Yes the patch is backwards sorry.  Testing alt proposal from
> > stern@rowland.harvard.edu.  It may be a buggy driver
> > but it would be nice if a buggy driver couldn't bring down
> > the entire usb core. lsusb hangs until reboot or reset of usb.
>
> buggy kernel drivers can do anything, including deleting the contents of
> your disk.  We don't protect the kernel from itself, sorry :)
>
> good luck!
>
> greg k-h
