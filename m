Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3A2D7CED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405130AbgLKR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395280AbgLKR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:29:35 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:28:55 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l200so10616248oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sSJHPJe3MFYStD07r1Nml7vKRxVIpk3+p21II/s3xbo=;
        b=r7DDycYYX0LMX/+66GJ6Z9/7/fO5eBTI9aQ6KYtJoMP5wAWQBUlhSVtJ5u1IZ82JpJ
         Qlta1OAY1fgM1dWnP5bbwtdy29jED9TtGheUfzamlfwKLxdBQdqW/c3AfOV8i4IDoDY8
         nPFAL61U2gawgLsHQTS/mXJ7Azd2OpbrFqF+/DM/4gzv/aA8Mo0/z+g/LQUimv9zS+ac
         Flng9UZ7fuM4XK+CZAp8BrxIrXYpWsiVbAaPzxvJbDQJjl0nBe052DmeG/Sz/2hVyisC
         Jpij7L3x4A3QgNT6xBgQyFJ9l3myD346tMI7kqabZAtgLce05YP6LG9++gSByKdTplCm
         SPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sSJHPJe3MFYStD07r1Nml7vKRxVIpk3+p21II/s3xbo=;
        b=cK68GJtzS3qNYyg8lvEcLtzhyQvVbPMlMqKyR3aWqDbxJPXuuagUWwWQcEjD3DWiuJ
         t11r4bFI8m5ccZRD38THfEsvIGBZ+/RMn++A4njmu33RzCummZWcl8gy0CTRMNooQkJf
         5vkUZjw5mivdPwenYHHgYiyIBj/SvOfmifowFCmn3VFBbMKvP0Jukfy24fqh3Yk/v4y8
         8gcjIjDtiqLRXPwQfOK1VrmRcadlRBqgaRdmuzeAtVYuKDphlN7RN6gPRDbDYTUf4ZH0
         6dvb4vjyncdX7X56A2FjzCfyY2era8CcHXD9y6n7Oj4XxXt6jlyqxpfSr4jvXYWiih5K
         2LFA==
X-Gm-Message-State: AOAM532XaM5wxA4R2WL/DaFduODkVh76sRXDBLre4yK1fEbs/rxn8ITw
        BTM0zQP3Kd154AyZISsnGdTbGg==
X-Google-Smtp-Source: ABdhPJwPUqlIow/ucIFwTGjHoFIr+G7PFLWcq43Prb9Uuh9Wc2pIGVsTxjTzImIJOQWtrSe/DSXO8A==
X-Received: by 2002:aca:728b:: with SMTP id p133mr10189133oic.125.1607707734151;
        Fri, 11 Dec 2020 09:28:54 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h2sm1964289otn.15.2020.12.11.09.28.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Dec 2020 09:28:53 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:28:41 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Amir Goldstein <amir73il@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next fsnotify mod breaks tail -f
In-Reply-To: <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2012110921180.1017@eggly.anvils>
References: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils> <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020, Amir Goldstein wrote:
> On Fri, Dec 11, 2020 at 1:45 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Hi Jan, Amir,
> >
> > There's something wrong with linux-next commit ca7fbf0d29ab
> > ("fsnotify: fix events reported to watching parent and child").
> >
> > If I revert that commit, no problem;
> > but here's a one-line script "tailed":
> >
> > for i in 1 2 3 4 5; do date; sleep 1; done &
> >
> > Then if I run that (same result doing ./tailed after chmod a+x):
> >
> > sh tailed >log; tail -f log
> >
> > the "tail -f log" behaves in one of three ways:
> >
> > 1) On a console, before graphical screen, no problem,
> >    it shows the five lines coming from "date" as you would expect.
> > 2) From xterm or another tty, shows just the first line from date,
> >    but after I wait and Ctrl-C out, "cat log" shows all five lines.
> > 3) From xterm or another tty, doesn't even show that first line.
> >
> > The before/after graphical screen thing seems particularly weird:
> > I expect you'll end up with a simpler explanation for what's
> > causing that difference.
> >
> > tailed and log are on ext4, if that's relevant;
> > ah, I just tried on tmpfs, and saw no problem there.
> 
> Nice riddle Hugh :)
> Thanks for this early testing!
> 
> I was able to reproduce this.

Oh good!

> The outcome does not depend on the type of terminal or filesystem
> it depends on the existence of a watch on the parent dir of the log file.
> Running ' inotifywait -m . &' will stop tail from getting notifications:
> 
> echo > log
> tail -f log &
> sleep 1
> echo "can you see this?" >> log
> inotifywait -m . &
> sleep 1
> echo "how about this?" >> log
> kill $(jobs -p)
> 
> I suppose with a graphical screen you have systemd or other services
> in the system watching the logs/home dir in your test env.

And great answer to the riddle, Amir: yes, I was testing in
my home directory all the time, except when I tried tmpfs.

> 
> Attached fix patch. I suppose Jan will want to sqhash it.

Yes, I confirm that "tail -f" is back to normal for me
with this fix. Thank you both.

Hugh

> 
> We missed a subtle logic change in the switch from inode/child marks
> to parent/inode marks terminology.
> 
> Before the change (!inode_mark && child_mark) meant that name
> was not NULL and should be discarded (which the old code did).
> After the change (!parent_mark && inode_mark) is not enough to
> determine if name should be discarded (it should be discarded only
> for "events on child"), so another check is needed.
> 
> Thanks,
> Amir.
