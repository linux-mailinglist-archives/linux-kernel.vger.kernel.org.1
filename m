Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426752CF920
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgLEDKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:10:19 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40096 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:10:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E040F2B616;
        Fri,  4 Dec 2020 22:09:35 -0500 (EST)
Date:   Sat, 5 Dec 2020 14:09:40 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/adb-iop: Always wait for reply message from
 IOP
In-Reply-To: <CAMuHMdX5yUaCWYsM7WgatYSDLZMcSckugOQxBBnBZOB_eJm=1g@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2012051342400.6@nippy.intranet>
References: <0f0a25855391e7eaa53a50f651aea0124e8525dd.1605847196.git.fthain@telegraphics.com.au> <CAMuHMdX5yUaCWYsM7WgatYSDLZMcSckugOQxBBnBZOB_eJm=1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Fri, Nov 20, 2020 at 5:54 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > A recent patch incorrectly altered the adb-iop state machine behaviour
> > and introduced a regression that can appear intermittently as a
> > malfunctioning ADB input device. This seems to be caused when reply
> > packets from different ADB commands become mixed up, especially during
> > the adb bus scan. Fix this by unconditionally entering the awaiting_reply
> > state after sending an explicit command, even when the ADB command won't
> > generate a reply from the ADB device.
> >
> > Cc: Joshua Thompson <funaho@jurai.org>
> > Fixes: e2954e5f727f ("macintosh/adb-iop: Implement sending -> idle state transition")
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Thanks for your patch!
> 
> > --- a/drivers/macintosh/adb-iop.c
> > +++ b/drivers/macintosh/adb-iop.c
> > @@ -84,10 +84,7 @@ static void adb_iop_complete(struct iop_msg *msg)
> >
> >         local_irq_save(flags);
> >
> > -       if (current_req->reply_expected)
> > -               adb_iop_state = awaiting_reply;
> > -       else
> > -               adb_iop_done();
> > +       adb_iop_state = awaiting_reply;
> >
> >         local_irq_restore(flags);
> >  }
> > @@ -95,8 +92,9 @@ static void adb_iop_complete(struct iop_msg *msg)
> >  /*
> >   * Listen for ADB messages from the IOP.
> >   *
> > - * This will be called when unsolicited messages (usually replies to TALK
> > - * commands or autopoll packets) are received.
> > + * This will be called when unsolicited IOP messages are received.
> > + * These IOP messages can carry ADB autopoll responses and also occur
> > + * after explicit ADB commands.
> >   */
> >
> >  static void adb_iop_listen(struct iop_msg *msg)
> > @@ -123,8 +121,10 @@ static void adb_iop_listen(struct iop_msg *msg)
> >                 if (adb_iop_state == awaiting_reply) {
> >                         struct adb_request *req = current_req;
> >
> > -                       req->reply_len = amsg->count + 1;
> > -                       memcpy(req->reply, &amsg->cmd, req->reply_len);
> > +                       if (req->reply_expected) {
> > +                               req->reply_len = amsg->count + 1;
> > +                               memcpy(req->reply, &amsg->cmd, req->reply_len);
> > +                       }
> 
> So if we're not expecting a reply. It's ignored.
> Just wondering: what kind of messages are being dropped?

I believe they were empty, with flags == ADB_IOP_EXPLICIT|ADB_IOP_TIMEOUT.

> If reply packets from different ADB commands become mixed up, they are 
> still (expected?) replies to messages we sent before. Why shouldn't we 
> depend on receiving the replies?
> 

It turns out that the IOP always generates reply messages, even when the 
ADB command does not produce a reply packet (e.g. ADB Listen command). 

The commit being fixed got that wrong.

So it's not really the ADB reply packets that are being mixed up, it's the 
IOP messages that enclose them. The bug goes like this:

1. CPU sends a message to the IOP, expecting no response because this 
message contains an ADB Listen command. The ADB command is now considered 
complete.

2. CPU sends a second message to the IOP, this time expecting a response 
because this message contains an ADB Talk command. This ADB command needs 
a reply before it can be completed.

3. adb-iop driver receives an IOP message and assumes that it relates to 
the Talk command. It's actually for the previous command. The Talk command 
is now considered complete but it gets the wrong reply data.

4. adb-iop driver gets another IOP response message, which contains the 
actual reply data for the Talk command, but this is dropped (the driver is 
no longer in awaiting_reply state).

Please go ahead and add this analysis to the commit log if you think it 
would help.

> >
> >                         req_done = true;
> >                 }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
