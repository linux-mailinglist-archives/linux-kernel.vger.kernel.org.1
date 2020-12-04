Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3A2CF41F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgLDSda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLDSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:33:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A9C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:32:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so3590823plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSJeJ0UkLS/WLnxupknlcIne44SftCLJvoqXzu+dreo=;
        b=TlFzq3UVBMqBrRYns2qnwb5pPddbcmoOkHuav/swZIGdYnJf6Ie/c4Muc0YOTvNJ4D
         4WQClPq9+dOqX3wEayHa2Tpb0zQRuMMZIC8H2OkEjjPwnwHv0jYRaIZESHzcqfMxNjE0
         JgBd02i8C5tMYyajUDpzQtr738Wr4wE43S7kGKncdSwXZycmQ8G+BXK2kzQrWM1OW5bx
         GcMqaimTsZCdJ49ynILBGFE+DBGLCTh2bZFhhUvQg8K8YVutBA207roD95uTQEziq64w
         iu2RBun6YlGUXeaZJYqXfZz9eVHofsvYYIBRd/rAT4sq5G2vPqs5kp1ehWwVclw1yHkT
         wnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSJeJ0UkLS/WLnxupknlcIne44SftCLJvoqXzu+dreo=;
        b=EhfYr7/eQSL20JRuct+bWPUifStpcVybmnGcUDpZ8Jn9dygjxIXbsoH8kJnCPzV6Ib
         P8oTs1pj25i6VrTBY3be3YBLNmd9fFSf0SACNOp0L17KrDHm8hO0A2vAchYkRfH8IiT1
         4+nZt5fVlg7W+lR/mEebfpiOoZo+IxSCz8qJsAIaFM6/O0Xux3OwQC+du0NEpbAYQjfe
         CBVdZ8v9CKzJ9Xd3a+OVBYKnrhtjz5J9Qoujb01qFc44w/gcLOgGuKK77Y8UZcN2+lkI
         kpPSCERd4B7+C34WcqbaR0/3LEIuNNuACeBvlebPnrDkBrqmXmOWgA25jMLYaM2P7CFQ
         237Q==
X-Gm-Message-State: AOAM532KkxhSIMcxIKekUEKCFxmuNBrNpuqFhx9Ov45T49n+JS27sUzn
        TR2Z/HilNvkuIdrZNX7Z2LU=
X-Google-Smtp-Source: ABdhPJzS6jl1rzQAorAPhG7zgQTIDaCe4p8RhrF44St7ZMc47skeFcL/RQY9IlNCPpWfzohIbqPaWg==
X-Received: by 2002:a17:902:9f86:b029:d6:d25f:7ad8 with SMTP id g6-20020a1709029f86b02900d6d25f7ad8mr5234807plq.4.1607106769609;
        Fri, 04 Dec 2020 10:32:49 -0800 (PST)
Received: from ip-172-31-62-0.us-west-2.compute.internal (ec2-44-230-211-174.us-west-2.compute.amazonaws.com. [44.230.211.174])
        by smtp.gmail.com with ESMTPSA id w200sm3397331pfc.14.2020.12.04.10.32.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Dec 2020 10:32:48 -0800 (PST)
Date:   Fri, 4 Dec 2020 10:32:47 -0800
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Minchan Kim <minchan@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH] pid: add null pointer check in pid_nr_ns()
Message-ID: <20201204183247.GA24887@ip-172-31-62-0.us-west-2.compute.internal>
References: <20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal>
 <875z5kceh9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5kceh9.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:19:46AM -0600, Eric W. Biederman wrote:
> Alakesh Haloi <alakesh.haloi@gmail.com> writes:
> 
> > There has been at least one occurrence where a null pointer derefernce
> > panic was seen with following stack trace.
> >
> >  #0 [ffffff800bcd3800] machine_kexec at ffffff8008095fb4
> >  #1 [ffffff800bcd3860] __crash_kexec at ffffff8008122a30
> >  #2 [ffffff800bcd39f0] panic at ffffff80080aa054
> >  #3 [ffffff800bcd3ae0] die at ffffff800808aee8
> >  #4 [ffffff800bcd3b20] die_kernel_fault at ffffff8008099520
> >  #5 [ffffff800bcd3b50] __do_kernel_fault at ffffff8008098e50
> >  #6 [ffffff800bcd3b80] do_translation_fault at ffffff800809929c
> >  #7 [ffffff800bcd3b90] do_mem_abort at ffffff8008081204
> >  #8 [ffffff800bcd3d90] el1_ia at ffffff800808304c
> >      PC: ffffff80080c20ec  [pid_nr_ns+4]
> >      LR: ffffff80080c231c  [__task_pid_nr_ns+72]
> >      SP: ffffff800bcd3da0  PSTATE: 60000005
> >     X29: ffffff800bcd3da0  X28: ffffffc00691c380  X27: 0000000000000001
> >     X26: 00000000004ce8e8  X25: 00000000004ce8d0  X24: ffffffc00691c3e0
> >     X23: ffffffc004e8c000  X22: 0000000000000000  X21: ffffffc00b042ed2
> >     X20: ffffff800876a4f0  X19: 0000000000000000  X18: 0000000000000000
> >     X17: 0000000000000001  X16: 0000000000000000  X15: 0000000000000000
> >     X14: 0000000400000003  X13: 0000000000000008  X12: fefefefefefefeff
> >     X11: 0000000000000000  X10: 0000007fffffffff   X9: 00000000004ce8b0
> >      X8: 00000000004ce8b0   X7: 0000000000000000   X6: ffffffc00b042ed2
> >      X5: ffffffc00b042ed2   X4: 0000000000020008   X3: 53206e69616c702f
> >      X2: ffffff800876a4f0   X1: ffffff800876a4f0   X0: 53206e69616c702f
> >  #9 [ffffff800bcd3da0] pid_nr_ns at ffffff80080c20e8
> 
> I just skimmed through the callers of pid_nr_ns and now I am very
> puzzled. I don't see any of them where the namespace can be passed as
> NULL.
> 
> So I really suspect you have a larger but somewhere in the caller of
> pid_nr_ns.  Perhaps the memory was stomped and you were lucky it was
> NULL.
> 
> Without some more details I really don't think testing for a NULL
> namespace is useful or productive.  At best it will mask bugs in the
> callers
> 
> Eric
> 
Thanks Eric for your time. I do not have any evidence of memory
corruption yet, but I agree with your concerns about not needing a null
check here.

--Alakesh
> > Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  kernel/pid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index a96bc4bf4f86..3767b9e1431d 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -474,7 +474,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
> >  	struct upid *upid;
> >  	pid_t nr = 0;
> >  
> > -	if (pid && ns->level <= pid->level) {
> > +	if (pid && ns && ns->level <= pid->level) {
> >  		upid = &pid->numbers[ns->level];
> >  		if (upid->ns == ns)
> >  			nr = upid->nr;
