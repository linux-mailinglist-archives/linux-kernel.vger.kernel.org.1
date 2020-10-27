Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1934629A95F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897743AbgJ0KSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:18:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409760AbgJ0KSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:18:13 -0400
Date:   Tue, 27 Oct 2020 11:18:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603793891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YmHjSKwqafIy3Vu89uB9RaJ8SF/KkvKybgYzmgth3g=;
        b=LpRWqwR41JfItfv9uK21p/mufRc/JwNJ40B0PZBwnpRKMEWBhWTLq7EGWaXZqgxC5r5rIJ
        x7PgQ3uJHG6Lx2GWDkZQVxUr0NXR7xeO/+OAs2i9HfA6OGahx90Vzw2bvaxdeFAfVaIriZ
        llCEWvzoFyiiHJoSgC1rnHA7r/Ygbzk10sJ4QqSOQmiIVJpPpednu1MM+7cHZVzm0lD7d3
        NjdmqYkJZknbcXNcpXvOESc4phJEbn/uSp/g1VaoOsUd3IyMZs1dcaCSVpDvyDCXW4Obg4
        FPA827nmcBetxQB5SYpqjXhS1NAe7ZgCp2FlhPYoUMqV1HtOP5nMvxS4KA+zbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603793891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YmHjSKwqafIy3Vu89uB9RaJ8SF/KkvKybgYzmgth3g=;
        b=Xzs7/BURSrRQCa3+4rSEmEUENzlEng5scCdPQyZs7xSa4ZHF3PS4o/8v5SOwnvhQbtizH+
        z835W3rTaj1yJaBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201027101810.pk5liej6xmbjcwem@linutronix.de>
References: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
 <20201026173107.quylcy6fgjvrqat6@linutronix.de>
 <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
 <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
 <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
 <20201027090019.3vteojm43ljqqe33@linutronix.de>
 <7bbfce68bdd01e1d48d3d2c6f9581654e380bf2d.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bbfce68bdd01e1d48d3d2c6f9581654e380bf2d.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 11:14:34 [+0100], Mike Galbraith wrote:
> On Tue, 2020-10-27 at 10:00 +0100, Sebastian Andrzej Siewior wrote:
> > Let me try if I can figure out when this broke.
> 
> My money is on...
> 710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5317)       if (pi)
> 710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5318)               cpuset_read_lock();
> ...having just had an unnoticed consequence for nouveau.

but that is over a year old and should be noticed in v5.4-RT.

> 	-Mike

Sebastian
