Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0D19FD41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDFSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:34:42 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40637 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:34:42 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so217343pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/dspoEoWnYI+heauRr8Q8cHMWCjgfmX+vnk8OEljeE=;
        b=dBq9AGQHM2g63y+/5cBUn7yb2f12do0AomT/ScibebOdvT75mYUTsu8u06NtoKwNE3
         mOrU/BRgiSTH7S//rFCkOuwCi5vNLxE8HSuc2LAscHVghrJyJ65sDoyFxklRYLDDH0aS
         +5YxXgkl5EGr5HJgESWCiNRVIZLnkPuxzJq1MZPVUJQ3DIX1k6RupEp+SB8Pz9xR0jTg
         gQHsHls7mQr8xN1I2uYDBaxeRC/Pg1r/BI6uGfhi0c/XfkUc+yMQmLYIQfrSnZidOKN/
         zZm2/ehc9n9lq3dsd5g249dBEKpQMa7o2m46rU/C5UirqhpglYeqepX3Ul8rGIn6xbEE
         ub3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/dspoEoWnYI+heauRr8Q8cHMWCjgfmX+vnk8OEljeE=;
        b=mrqlB2i81n2AUbKHIw15yKUNgsuPgZ4q0soTuZ5E7QKEAXKX32MpKtVxC6oxsfYzcr
         ZrO3cRIx25qIZJTVWhUU/lycHM4xkV/gCMU5tOiWemGhu3q2UGDMoXFKtuK+e+pn9guM
         qciyCq9tPvDeGG0PIDhYJOWjhFu8Ix9RPce/XvggW8kIv8IYcXlXceXNJ+mI05cgfeSU
         kfFjn7wkfIdhSCdrpb7J1cT7Sejkw3O/SY0OXX8qCrod1hpZ1I+//X9i55EJ6KlmTOTp
         0DGvWFcMkyvlHWrX7j9mjdUSLVa83JR8ZticI5v1zMJLdXxoeKosUwf2uqN3+TDn6Aqu
         +A8w==
X-Gm-Message-State: AGi0PuZZClQazD3DSMFwrYMJoFrI7lujvgmgeIlRIkNWugYfT8WbBgFW
        CsjTGW2i3OkzRH+iKrpEs2dnk8lyHN/A1rWidvAkTA==
X-Google-Smtp-Source: APiQypL7C2NnDvvmxN6QF37+5u6JMM66Bj2tvsHUOKW7pdWEZqhfz0x24lDj/7keXzpIx61IbjQhIHdAIDIcq55d0yU=
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr756068pjb.90.1586198081246;
 Mon, 06 Apr 2020 11:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <178e01023f2e6664908f7c9660fa6527a55a22d6.1586191134.git.andreyknvl@google.com>
 <Pine.LNX.4.44L0.2004061417050.19877-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004061417050.19877-100000@netrider.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 6 Apr 2020 20:34:30 +0200
Message-ID: <CAAeHK+wdEByqpv90WCtb2=E9Xx6WpkDxn7xq__8JwSh8ROZn7w@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: fix raw_event_queue_fetch locking
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 8:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 6 Apr 2020, Andrey Konovalov wrote:
>
> > If queue->size check in raw_event_queue_fetch() fails (which normally
> > shouldn't happen, that check is a fail-safe), the function returns
> > without reenabling interrupts. This patch fixes that issue, along with
> > propagating the cause of failure to the function caller.
> >
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >
> > Greg, this should apply cleanly on top of Dan's "usb: raw-gadget: Fix
> > copy_to/from_user() checks" patch.
> >
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index e490ffa1f58b..1582521ec774 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -81,6 +81,7 @@ static int raw_event_queue_add(struct raw_event_queue *queue,
> >  static struct usb_raw_event *raw_event_queue_fetch(
> >                               struct raw_event_queue *queue)
> >  {
> > +     int ret;
> >       unsigned long flags;
> >       struct usb_raw_event *event;
> >
> > @@ -89,11 +90,14 @@ static struct usb_raw_event *raw_event_queue_fetch(
> >        * there's at least one event queued by decrementing the semaphore,
> >        * and then take the lock to protect queue struct fields.
> >        */
> > -     if (down_interruptible(&queue->sema))
> > -             return NULL;
> > +     ret = down_interruptible(&queue->sema);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> >       spin_lock_irqsave(&queue->lock, flags);
> > -     if (WARN_ON(!queue->size))
> > +     if (WARN_ON(!queue->size)) {
> > +             spin_unlock_irqrestore(&queue->lock, flags);
> >               return NULL;
>
> Suppose the WARN_ON triggers, and you return NULL here.  Then where do
> you reverse the down_interruptible() on queue->sema?
>
> > +     }
> >       event = queue->events[0];
> >       queue->size--;
> >       memmove(&queue->events[0], &queue->events[1],
> > @@ -522,10 +526,17 @@ static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
> >       spin_unlock_irqrestore(&dev->lock, flags);
> >
> >       event = raw_event_queue_fetch(&dev->queue);
> > -     if (!event) {
> > +     if (PTR_ERR(event) == -EINTR) {
> >               dev_dbg(&dev->gadget->dev, "event fetching interrupted\n");
> >               return -EINTR;
> >       }
> > +     if (IS_ERR_OR_NULL(event)) {
> > +             dev_err(&dev->gadget->dev, "failed to fetch event\n");
> > +             spin_lock_irqsave(&dev->lock, flags);
> > +             dev->state = STATE_DEV_FAILED;
> > +             spin_unlock_irqrestore(&dev->lock, flags);
> > +             return -ENODEV;
> > +     }
>
> Not here, obviously.  Does the semaphore ever get released?

If this warning triggered, something has already gone horribly wrong,
so we set the device stated to "failed".

But even if we ignore that, should the semaphore be "released"? The
initial semaphore's counter value is 0, so one up()+down() sequence of
events leaves it with the initial value. So it's the down() event that
brings it to the initial state (unless there were multiple up()s of
course). Unless I misunderstand something.
