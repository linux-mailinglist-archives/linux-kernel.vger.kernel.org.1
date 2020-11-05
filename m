Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E292A73DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgKEAfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:35:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:45328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKEAfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:35:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AC2DAC3F;
        Thu,  5 Nov 2020 00:34:59 +0000 (UTC)
Date:   Wed, 4 Nov 2020 16:13:07 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201105001307.lelve65nif344cfs@linux-p48b.lan>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201104162534.GY4085@localhost>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020, Johan Hovold wrote:

>Hmm. I took at closer look at the parport code and it seems the current
>implementation is already racy but that removing the tasklet is going to
>widen that that window.
>
>Those register writes in restore() should be submitted before any
>later requests. Perhaps setting a flag and flushing the work in
>parport_prologue() could work?

Ah, I see and agree. Considering work is only deferred from restore_state()
I don't even think we need a flag, no? We can let parport_prologue()
just flush_work() unconditionally (right before taking the disc_mutex)
which for the most part will be idle anyway. The flush_work() also becomes
saner now that we'll stop rescheduling work in send_deferred_urbs().

Also, but not strictly related to this. What do you think of deferring all
work in write_parport_reg_nonblock() unconditionally? I'd like to avoid
that mutex_trylock() because eventually I'll be re-adding a warn in the
locking code, but that would also simplify the code done here in the
nonblocking irq write. I'm not at all familiar with parport, but I would
think that restore_state context would not care.

>On the other hand, the restore() implementation looks broken in that it
>doesn't actually restore the provided state. I'll go fix that up.

How did this thing ever work?

Thanks,
Davidlohr
