Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A92A6934
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgKDQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgKDQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:15:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA745C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:15:47 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so2851617wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a4M0ec0hAnBu/PVHBPv80b8wAYKFHMKkLCWu0YtHGs=;
        b=bakChsoEHc96DmL1Kn6LOdTPHpv477ZeSxJMxh/hG7zeYCKHwdDjyO9s+y5t/4qCW/
         lPkRGGk+Es+BI5hy9Z+1qkl4GOFbi6aPZ7AVOinm+XQEWd1G6YgvFG9G7NZpwU3HX1T8
         iptpOBieDyPQORtcM900XQJrVmOtaCP4Iz+9DnTjmOROwdy4lNTkIwWpcgjK5zm9s/G8
         RrAQUXeigskrDcoOvG6Db5hGNnGimH05wzONN5IG/K1KZvLlPjjhrmX0WVvx/Vm2FXp6
         gdpvkMbnPA243qbIkF2T1rxRV2UXTuv/N9r0p9cSuTVW3rCM/BOXQXSh69m7wQo7uo0y
         3TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a4M0ec0hAnBu/PVHBPv80b8wAYKFHMKkLCWu0YtHGs=;
        b=ecyV+YLTHuW/KQSmr0w7Rxhu+JAJtcXTcCqPbNDR4dnhhBXkGc5B9t+93BNv+p1Obf
         NODzw7Ar83Y4Y60DijSOETHWKfInTMrkRBd84/JVGQbAMrr6KgU2iFn1e2lCA312Qoys
         /YLEemJi6jO09K+n2Dof/4p0Fp7y9pY7sD3iUpbpoVetPLEx2YXyfiftC9pOQ1vf5Tsi
         y7ZK6QK0qS7BuDiHUG1RmUGZ8PmOCoHXmq61IcHtX/kyZAd2xeBwVgASavNl86jR6w2A
         /ntYIZKyx8xWUI0nYlfiXFFhIQ1uHCMaOkc6cQVZIkbvEdBFIVjHHqhhWH7U4iJ9GDb/
         Xjww==
X-Gm-Message-State: AOAM531oR2F/3Rd6oonhYGeOleiAOlKJY8ZoSztIgwSLVyEG8li8e6a6
        ZNvakmA8DkeSdgzmkI77KzpqkeYADzMcEoFX2sE=
X-Google-Smtp-Source: ABdhPJx2qtvufGt04YbFwpIm/qzyLJW9PPz3J+a6PuK2x2xcOkKWpkqVq/T8zjJPNbSPDLiGPMPxB3jIhPBfuGhxbBw=
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr5384089wme.171.1604506546401;
 Wed, 04 Nov 2020 08:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201103223335.21831-1-yuhaobehappy@gmail.com> <s5hft5plepd.wl-tiwai@suse.de>
In-Reply-To: <s5hft5plepd.wl-tiwai@suse.de>
From:   Yu Hao <yuhaobehappy@gmail.com>
Date:   Wed, 4 Nov 2020 08:15:37 -0800
Message-ID: <CAM0=KiqiY3_+jHoeMSnYNJuK5=W1zoimbJ+cP2JXj6O2Ne-eYQ@mail.gmail.com>
Subject: Re: [PATCH] sound/core/seq: remove useless function
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Wed, Nov 4, 2020 at 12:16 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 03 Nov 2020 23:33:35 +0100,
> Yu Hao wrote:
> >
> > The function snd_seq_queue_client_termination() is only called from
> > the function seq_free_client1(). The function seq_free_client1() calls
> > the function snd_seq_queue_client_leave() and the function
> > snd_seq_queue_client_termination() together. Because the function
> > snd_seq_queue_client_leave() does all things, so the function
> > snd_seq_queue_client_termination() is a useless function.
>
> How poetic, rhymes awfully well :)
>
> > Signed-off-by: Yu Hao <yuhaobehappy@gmail.com>
>
> Applied now.  Thanks!
>
>
> Takashi
>
> >  sound/core/seq/seq_clientmgr.c |  1 -
> >  sound/core/seq/seq_queue.c     | 27 ---------------------------
> >  sound/core/seq/seq_queue.h     |  3 ---
> >  3 files changed, 31 deletions(-)
> >
> > diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
> > index cc93157fa950..f9f2fea58b32 100644
> > --- a/sound/core/seq/seq_clientmgr.c
> > +++ b/sound/core/seq/seq_clientmgr.c
> > @@ -279,7 +279,6 @@ static int seq_free_client1(struct snd_seq_client *client)
> >       snd_seq_delete_all_ports(client);
> >       snd_seq_queue_client_leave(client->number);
> >       snd_use_lock_sync(&client->use_lock);
> > -     snd_seq_queue_client_termination(client->number);
> >       if (client->pool)
> >               snd_seq_pool_delete(&client->pool);
> >       spin_lock_irq(&clients_lock);
> > diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
> > index 71a6ea62c3be..13cfc2d47fa7 100644
> > --- a/sound/core/seq/seq_queue.c
> > +++ b/sound/core/seq/seq_queue.c
> > @@ -537,33 +537,6 @@ int snd_seq_queue_is_used(int queueid, int client)
> >
> >  /*----------------------------------------------------------------*/
> >
> > -/* notification that client has left the system -
> > - * stop the timer on all queues owned by this client
> > - */
> > -void snd_seq_queue_client_termination(int client)
> > -{
> > -     unsigned long flags;
> > -     int i;
> > -     struct snd_seq_queue *q;
> > -     bool matched;
> > -
> > -     for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
> > -             if ((q = queueptr(i)) == NULL)
> > -                     continue;
> > -             spin_lock_irqsave(&q->owner_lock, flags);
> > -             matched = (q->owner == client);
> > -             if (matched)
> > -                     q->klocked = 1;
> > -             spin_unlock_irqrestore(&q->owner_lock, flags);
> > -             if (matched) {
> > -                     if (q->timer->running)
> > -                             snd_seq_timer_stop(q->timer);
> > -                     snd_seq_timer_reset(q->timer);
> > -             }
> > -             queuefree(q);
> > -     }
> > -}
> > -
> >  /* final stage notification -
> >   * remove cells for no longer exist client (for non-owned queue)
> >   * or delete this queue (for owned queue)
> > diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
> > index 9254c8dbe5e3..1c3a8d3254d9 100644
> > --- a/sound/core/seq/seq_queue.h
> > +++ b/sound/core/seq/seq_queue.h
> > @@ -59,9 +59,6 @@ struct snd_seq_queue *snd_seq_queue_alloc(int client, int locked, unsigned int f
> >  /* delete queue (destructor) */
> >  int snd_seq_queue_delete(int client, int queueid);
> >
> > -/* notification that client has left the system */
> > -void snd_seq_queue_client_termination(int client);
> > -
> >  /* final stage */
> >  void snd_seq_queue_client_leave(int client);
> >
> > --
> > 2.17.1
> >
