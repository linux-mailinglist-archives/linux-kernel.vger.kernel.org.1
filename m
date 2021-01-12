Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648042F24D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405267AbhALAZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:19 -0500
Received: from pi3.com.pl ([185.238.74.129]:60368 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404257AbhALAQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:16:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 4EA244C0DF8;
        Tue, 12 Jan 2021 01:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610410562; bh=OHpR0K0IgBU2a06QtHh8pGoN8dPNwrLGRPh/L04z/E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQp5oGgzsYuG+dCD1BCYRyR7+n6y1icUn8NgMMmGp0frXnPlPfiwiVNqzHpT3vl6y
         WB/PvMn3W4laZNosIPeIVMjL0uZRKUclGcu1iHJYKAM6BPO6hFy1gVaim6hhaRoPnH
         GyqShoFgvVoi/Grz0D80CKKfCzzS6zRbC4QzJdk6XWb2vZh4ANrGZngBHWVHc6n0Qs
         dcTWRw/91XOYyltcS2GsM0ML4jpNMHAEGTr2AVotA8Hkdq2YunTuSm2Cj0d6Ei53Sy
         uSO2aVNS0pAaeoFTZce7O6EO6Y8+Yk8xCXXNH1cIJRgi02iQjCdtL2NU9EqSbeJRht
         1wzMWXulb+/kg==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 389cfCoIXqaD; Tue, 12 Jan 2021 01:15:59 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 767834C05F3; Tue, 12 Jan 2021 01:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610410559; bh=OHpR0K0IgBU2a06QtHh8pGoN8dPNwrLGRPh/L04z/E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtHMMF1Z+8dHgAmYNK+hizTexGKtxHpi5AZboFoOmIbjrnxiwCElkOE9xPsx2X1zP
         jKV2l8wDHgNDmxBQ8awKxrwIr3krDZdCVQBv0L9/Ziuie1HssxYhDM05Hp6QmE5UKP
         CwvbXQ8kjCugiEeQIYWHq1ZTq2lIxYMnc3zw6pGZdbnVbn7PIxEL31pJrImeIf5QVs
         40qJrD6TfiG8A9v2bqrQvQ3Nlae4Id5J+74qsAtsqkErcHuumGibxzWJx8Sdi/lDdB
         38dDzcje6sPfr1GiZP6Xk27wmXquziRmPiQb2P4yNHr6JtqC5A86AdAgjSfgKwDzt3
         QyEfhga6MyFsQ==
Date:   Tue, 12 Jan 2021 01:15:59 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: Linux Kernel module notification bug
Message-ID: <20210112001559.GA20073@pi3.com.pl>
References: <20210110175401.GB32505@pi3.com.pl>
 <20210111142048.GA27038@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111142048.GA27038@linux-8ccs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 11, 2021 at 03:20:48PM +0100, Jessica Yu wrote:
> +++ Adam Zabrocki [10/01/21 18:54 +0100]:
> > Hello,
> > 
> > I believe that the following commit does introduce a gentle "functionality
> > bug":
> > 
> > "module: delay kobject uevent until after module init call":
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/kernel/module.c?id=38dc717e97153e46375ee21797aa54777e5498f3
> > 
> > The official Linux Kernel API for the kernel module activities notification has
> > been divided based on the readiness 'stage' for such module. We have the
> > following stages:
> > 
> >        MODULE_STATE_LIVE,      /* Normal state. */
> >        MODULE_STATE_COMING,    /* Full formed, running module_init. */
> >        MODULE_STATE_GOING,     /* Going away. */
> >        MODULE_STATE_UNFORMED,  /* Still setting it up. */
> > 
> > LIVE means that the kernel module is correctly running and all initialization
> > work has been already done. Otherwise, we have event 'COMING' or 'UNFORMED'.
> > 
> > In the described commit, creation of the KOBJECT has been moved after invoking
> > a notficiation of the newly formed kernel module state (LIVE). That's somehow
> > inconsistent from my understanding of the kernel modules notifiers logic.
> > Creation of the new objects (like KOBJ) should be done before notification of
> > the stage LIVE is invoked.
> 
> I'm confused. We're not creating any kobjects here. That is all done
> in mod_sysfs_setup(), which is called while the module is still
> COMING.  What that commit does is delay telling userspace about the
> module (specifically, systemd/udev) until the module is basically
> ready. Systemd was basically receiving the uevent too early, before
> the module has initialized, hence we decided to delay the uevent [1].
> 

Sorry for the confusion on my side. I was referring to the internal state of 
the KOBJ itself which is being actively modified when uevent is sent. During 
the module creation KOBJ_ADD modifies 'kobj->state_add_uevent_sent'. Until 
recent commit, kernel didn't modify KOBJ after sending LIVE notification.

> > This commit breaks some of the projects that rely on the LIVE notification to
> > monitor when the newly loaded module is ready.
> 
> Hm, could you please explain specifically what is the issue you're seeing?
> What projects is it breaking?
> 

I'm specifically referencing these projects which are tracking kernel modules
for integrity purpose (e.g. anti-rootkit tools) like Linux Kernel Runtime 
Guard.
It is possible to modify these tools to adopt and take into account 
modification of KOBJ after LIVE state notification. However, from my 
understanding of the kernel modules notifiers logic, KOBJ should be fully 
formed at this stage.

Thanks,
Adam

> Thanks,
> 
> Jessica
> 
> [1] https://github.com/systemd/systemd/issues/17586

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

