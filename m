Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B4300A17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbhAVRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbhAVRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:32:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69CEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:31:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bx12so7438637edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ED60FKhK96gry/rcTB0tBDnaMgHxP/KjvgwSiQKPbwI=;
        b=yhzK1C4t0XWFQVUQ+oPgOQKxSNmOi6vE4RMwltus5SaRYSh5C0HSpuBs5xY6vyrDIQ
         /3SYnzB2307OjW0sfyJc6yOartU7mJAGD3KlnFIZcFczvUzjdYy7EWNRtqQeLCKHb98e
         pNKvF4yB9Df2ozHsHBh+RUO0tKJpaQg0onRpiT5dpwfLlCMEAFCSImhdUVbhALDLF63i
         urjpahFufkbl7ax1WBagy5WMGodTigLXIfnpw9dP0oKAYwhrnq3X8k+Ebcc2UWJyaAau
         AtUWwzWK0qayLP7b2NO8K4fGkAySs3+mkD41qtsk3VFxVtAgL1MF5qBLYLvb0tf9cpiG
         tvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ED60FKhK96gry/rcTB0tBDnaMgHxP/KjvgwSiQKPbwI=;
        b=VLbnJXSTAgXebaJG6rutmRvNEHOnqNQqzbSz0PBUi47b3VXzpSrgD6IzcudnxFNK5K
         pTJSTCi9xr7e2upmwnw1S0MO0byEy/SIwRpbaxrcojg0QoIHnrpG8S7XoMttEJNwerQS
         1d6noUtViILlkoKGQ3gRQzHbFmiiv0s0m3M3at17wMM2kRa/ugvAN/DmEM+BI7oiS+lq
         z+HCHxZOiI0fCePYbs0gYJl0bqwi4m17OlI70lNsBlO88iMF9DCm4RxAWsaPtJ0U3D4t
         Kbl3OcsXLaV0y//4O61RaR5JPxtFyLKNO9l4lltQmIpETAxn48C6jwOlr0ECU00Hkadi
         VY3Q==
X-Gm-Message-State: AOAM532KlRp+m+DABDA2lLZXksBZ/E6l4gqax60fJhDWtpAZn4vLan+v
        y+qMLiWNVM2Al3mavJnD7I+tZYRR3TCm8tUS1DRE
X-Google-Smtp-Source: ABdhPJzZ2xbtnN29pvDRZOKvuQdspEPAK6EgCyF9t5NDUH8h5QSRcpwg4Uzy2BwRqyvnTNve4UYWqCcM6nUhPmFSG90=
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr4120649edc.164.1611336695427;
 Fri, 22 Jan 2021 09:31:35 -0800 (PST)
MIME-Version: 1.0
References: <202101212225030936472@zte.com.cn>
In-Reply-To: <202101212225030936472@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 12:31:24 -0500
Message-ID: <CAHC9VhSawMHjRsEuHCDhSq2JEpLxvQZ1u1tEg=cy4y9Ays4ogg@mail.gmail.com>
Subject: Re: Fw:Re:Fw:Re:[RFC,v1,1/1] audit: speed up syscall rule match while
 exiting syscall
To:     yang.yang29@zte.com.cn
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 9:25 AM <yang.yang29@zte.com.cn> wrote:
>
> Thanks for reply, I have sent a new patch with better performance.
> The v1 patch uses mutex() is not necessary.
>
> Performance measurements:
> 1.Environment
> CPU: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> Linux kernel version: 5.11-rc3
> Audit version: 2.8.4

...

> 2.2 Syscall absolute time
> Test method:
> Use ktime_get_real_ts64() in do_syscall_64() to calculate time.
> Run command "chmod 777 /etc/fstab" with chown rules. Each test 10times and get average.
>
> do_syscall_64() time with 100 rules:
> before this patch: 7604ns
> after this patch: 5244ns, reduce 2360ns.
>
> do_syscall_64() time with CIS rules:
> before this patch: 6710ns
> after this patch: 7293ns, increase 583ns.
>
> do_syscall_64() time with 10 rules:
> before this patch: 5382ns
> after this patch: 5171ns, reduce 211ns.
>
> do_syscall_64() time with 1 rule:
> before this patch: 5361ns
> after this patch: 5375ns, increase 14ns.
>
> do_syscall_64() time with no rules:
> before this patch: 4735ns
> after this patch: 4804ns, increase 69ns.
>
> Analyse:
> With a few rules, performance is close.
> With 100 rules, performance is better, but with CIS rules performance regress. Maybe relevant to certain syscall.

These numbers aren't particularly good in my opinion, the negative
impact of the change to a small number of rules and to the CIS ruleset
is not a good thing.  It also should be said that you are increasing
the memory footprint, even if it is relatively small.

However, if we take a step back and look at the motivation for this
work I wonder if there are some things we can do to improve the
per-syscall rule processing performance.  On thing that jumped out
just now was this code in __audit_syscall_exit():

void __audit_syscall_exit(int success, long return_code)
{

  /* ... */

  /*
   * we need to fix up the return code in the audit logs if the
   * actual return codes are later going to be fixed up by the
   * arch specific signal handlers ... */
  if (unlikely(return_code <= -ERESTARTSYS) &&
      (return_code >= -ERESTART_RESTARTBLOCK) &&
      (return_code != -ENOIOCTLCMD))
    context->return_code = -EINTR;
  else
    context->return_code  = return_code;

  audit_filter_syscall(current, context,
    &audit_filter_list[AUDIT_FILTER_EXIT]);
  audit_filter_inodes(current, context);
  if (context->current_state == AUDIT_RECORD_CONTEXT)
    audit_log_exit();
  }

... in the snippet above the audit_filter_inodes() function/rules are
given priority over the syscall rules in
audit_filter_syscall(AUDIT_FILTER_EXIT), so why not first execute
audit_filter_inodes() and only execute
audit_filter_syscall(AUDIT_FILTER_EXIT) if necessary?  It may be that
I'm missing something on this quick look at the code, but I think it
is worth investigating.  It's also possible there are other similar
improvements to made.

There is similar code in __audit_free() but that should be less
performance critical.

-- 
paul moore
www.paul-moore.com
