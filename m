Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555E2DAE97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgLOOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgLOOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:09:13 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB07AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:08:32 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so15290966pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXP/yhOW54OxUPCaKQTwSdM8hA0xiTwzdIp/RAARgOk=;
        b=sVeEouWwtVMGU4TMvuHzskNDquHq7/vzt0XJ/Yu+j8IUfuclj6x5PFEo+9ohwGfmCr
         hz9LBVeDcJRINDcgaPOPCvE2vatr+COFpg4O50V3cL6TP6rebx0kLFrYS2ZLlGCKiPtY
         DZyWxIB+sMoP0+TacKBBd0qLkbYk1hvEbrzznwpPpKy83RAmlj5TUPB8xJYVSw4DYEGC
         h8wrgwMxqRqcKslRry75pwwSFli3pP3/oE6/fO8qAtJ8y9FJLXqnqBQTzr3MCQG5RFZD
         ua52XIC8RQxKry30ToIrn/rZJV+Mw/T9Nv4DoJvFUNcoIUW4vh+C8/bGa8I2J4KBlVfu
         WF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXP/yhOW54OxUPCaKQTwSdM8hA0xiTwzdIp/RAARgOk=;
        b=KmNejvljfDgaBZFEo7iZ9ROkD2Ckts/el78kkwISRsC95bA6WgxQ+8tRXcG3ovTZai
         I9ZEVoebn4ndinCg3aMwrvE0VWpNB54sb6lGzv4TlEsQXplEny0mTYJ6Wpoo7Gk+rqSP
         JWn+cOb1jbRI6e18fO+aNmeYMirUTKmtVZLa6WDx1PdP+JCtJlR9JbOzNwZP+KGtZcO3
         rflj0F6fyPmZfHDdA3bbqeHRP/zyjgX6qrBlGxUaztJrUTxYoQCZ76b4PQQcNAqbQleP
         DuUzIFiYFQcFdBAsgu61Ek489/Njnv89tuQyQUStpUl7YPhnjdUKxhioZvzrPjagXwX3
         Sxgg==
X-Gm-Message-State: AOAM5337woQkmwDzhPmOuG9gVkBg7ZkR870ySVdwOo3jdbZAu/vZvbZO
        8vhpQUwqYjJq6/KYyjVVnXieYCyMGQR/sBbzvyRTrw==
X-Google-Smtp-Source: ABdhPJxoL7C6qilFV7beONl+ZdVTIU8HmH7/4XMT5rkMY+IKck7dbKj0qy7e/51skojZaAK8j2io0oWHB/vzEWucRcE=
X-Received: by 2002:a62:3205:0:b029:197:f692:6a8b with SMTP id
 y5-20020a6232050000b0290197f6926a8bmr28471199pfy.2.1608041312046; Tue, 15 Dec
 2020 06:08:32 -0800 (PST)
MIME-Version: 1.0
References: <X9dDkwlOTFeo9eZ6@localhost> <000000000000af6ec005b66dbaa2@google.com>
 <X9d+dZq/IA+tiw5v@localhost> <CAAeHK+xLiLjGMJLuWpyPHMO=zD6k33s5VYSBDMMbTkAEauF3dA@mail.gmail.com>
 <X9eB5ZZMq6q5j4eW@localhost>
In-Reply-To: <X9eB5ZZMq6q5j4eW@localhost>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 15 Dec 2020 15:08:20 +0100
Message-ID: <CAAeHK+zLXqHSxr+e_WRVaYWtnLU8u_8Y=uHGmGfQHLYXqKmTYA@mail.gmail.com>
Subject: Re: WARNING in yurex_write/usb_submit_urb
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 4:16 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Dec 14, 2020 at 04:06:49PM +0100, Andrey Konovalov wrote:
> > On Mon, Dec 14, 2020 at 4:02 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Mon, Dec 14, 2020 at 06:48:03AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > WARNING in yurex_write/usb_submit_urb
> > >
> > > It appears syzbot never tested the patch from the thread. Probably using
> > > it's mail interface incorrectly, I don't know and I don't have time to
> > > investigate. The patch itself is correct.
> >
> > Hi Johan,
> >
> > I wasn't CCed on the testing request, so I can't say what exactly was wrong.
>
> Here's the patch and the "syz test" command in a reply:
>
>         https://lore.kernel.org/r/20201214104444.28386-1-johan@kernel.org
>
> Probably needs to go in the same mail, right?

Yes, both the syz test command and the patch must be in the same
email, which is sent as a response to the initial report.

> How about including the command needed to test a patch in the syzbot
> report mail to assist the casual user of its interfaces? I had to browse
> the web page you link to and still got it wrong apparently.

I think it's deliberately not included to not overload the report
email with too many details.

> > Could you send me the patch you were trying to test?
>
> Does this work better:
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

This worked :)

Thanks!
