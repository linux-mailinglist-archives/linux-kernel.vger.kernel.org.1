Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1946D2B0EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKLUCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgKLUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:02:36 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADEC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:02:36 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so10269008lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qR0IUP6IVaE1RvdjaglCpziTVWplPEcUYsh9Hsh3APM=;
        b=VLrQwsGEaVVIbZE6uh58ehLoeWzPeBMn+fJYn8cOL9JDxuxAXq4my6t/KjjMP3sDRt
         EcUGpb3WsRCEHqPq8QoQBKpo/nIDGjWZiRCZawbnM7DpYIv4xfM93fL1vl4cmDGyaHj4
         BRCZW0l41NN5sXvHi5rAGOtiwM5z74JrVtIvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qR0IUP6IVaE1RvdjaglCpziTVWplPEcUYsh9Hsh3APM=;
        b=J3HuXH96lpybV8SQEqSQmRHqXosfr0cVDtj9G9j5tr+MdNCmz3sgzC6BbfO0ebGjNG
         x2x1Xf0pGmMo/dokbueZ1pqSpdwCfIvAZ+dvFi8F6QGZjUi7Gaq26Vsdl+JpxrC/Z7Cu
         JAYtrjBAr5N93DaYFpBN5pRoOY3izJi1C/uEeGNQuz4s4t3+eXciMEQtE2eCEC2WieM5
         6HM40pI6azduZFpHEVeAadR9HSP/XpJFrCt08S4QqKMvfxHPN3cG8iISe6tzv9BD6tmM
         HmvZLW9N1EU9j/gdTTb9CqGFKgPVK/ougxrsznLghK5JzA5W98fAOxO3ee4nHy00QgFg
         QMxA==
X-Gm-Message-State: AOAM531mowK9VdpTmiuG65WKi9hiJbWcZ+o1tNCB5EKCZhiMSzahOlnL
        UNPLwEPXlUKQld/39rR1hMFVWAPTq1JM1Y9afDUL5w==
X-Google-Smtp-Source: ABdhPJxQBmu4mBPDxVehaQ75/6jtk2VGWuq3jwJ+5tJbc48YyvqLC0VqFJgbn3GhAsBRr8SysH6Dm0odMC5gDigsgSM=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr387091lfg.562.1605211354583;
 Thu, 12 Nov 2020 12:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20201112171907.373433-1-kpsingh@chromium.org> <CAEf4BzZNg98qBmddzmw_HnzhqKJSJxEvAkfcFjz9hB8STaxvfw@mail.gmail.com>
In-Reply-To: <CAEf4BzZNg98qBmddzmw_HnzhqKJSJxEvAkfcFjz9hB8STaxvfw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 21:02:23 +0100
Message-ID: <CACYkzJ49EkB7AFtmapXskM1n+K1qmReRpDK2Ke9+CGt5xz12sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Augment the set of sleepable LSM hooks
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 7:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 12, 2020 at 9:20 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Update the set of sleepable hooks with the ones that do not trigger
> > a warning with might_fault() when exercised with the correct kernel
> > config options enabled, i.e.
> >
> >         DEBUG_ATOMIC_SLEEP=y
> >         LOCKDEP=y
> >         PROVE_LOCKING=y
> >
> > This means that a sleepable LSM eBPF prorgam can be attached to these
>
> typo: program

Fixed.

>
> > LSM hooks. A new helper method bpf_lsm_is_sleepable_hook is added and
> > the set is maintained locally in bpf_lsm.c
> >
> > A comment is added about the list of LSM hooks that have been observed
> > to be called from softirqs, atomic contexts, or the ones that can
> > trigger pagefaults and thus should not be added to this list.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/linux/bpf_lsm.h |   7 +++
> >  kernel/bpf/bpf_lsm.c    | 120 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c   |  16 +-----
> >  3 files changed, 128 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 73226181b744..0d1c33ace398 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -27,6 +27,8 @@ extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                         const struct bpf_prog *prog);
> >
> > +bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> > +
> >  static inline struct bpf_storage_blob *bpf_inode(
> >         const struct inode *inode)
> >  {
> > @@ -54,6 +56,11 @@ void bpf_task_storage_free(struct task_struct *task);
> >
> >  #else /* !CONFIG_BPF_LSM */
> >
> > +static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                                       const struct bpf_prog *prog)
> >  {
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index e92c51bebb47..3a6e927485c2 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <net/bpf_sk_storage.h>
> >  #include <linux/bpf_local_storage.h>
> > +#include <linux/btf_ids.h>
> >
> >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> >   * function where a BPF program can be attached.
> > @@ -72,6 +73,125 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >         }
> >  }
> >
> > +/* The set of hooks which are called without pagefaults disabled and are allowed
> > + * to "sleep and thus can be used for sleeable BPF programs.
>
> typo: "sleep" (both quotes) or no quotes at all?

Fixed.

>
> > + *
> > + * There are some hooks which have been observed to be called from a
> > + * non-sleepable context and should not be added to this set:
> > + *
> > + *  bpf_lsm_bpf_prog_free_security
> > + *  bpf_lsm_capable
> > + *  bpf_lsm_cred_free
> > + *  bpf_lsm_d_instantiate
> > + *  bpf_lsm_file_alloc_security
> > + *  bpf_lsm_file_mprotect
> > + *  bpf_lsm_file_send_sigiotask
> > + *  bpf_lsm_inet_conn_request
> > + *  bpf_lsm_inet_csk_clone
> > + *  bpf_lsm_inode_alloc_security
> > + *  bpf_lsm_inode_follow_link
> > + *  bpf_lsm_inode_permission
> > + *  bpf_lsm_key_permission
> > + *  bpf_lsm_locked_down
> > + *  bpf_lsm_mmap_addr
> > + *  bpf_lsm_perf_event_read
> > + *  bpf_lsm_ptrace_access_check
> > + *  bpf_lsm_req_classify_flow
> > + *  bpf_lsm_sb_free_security
> > + *  bpf_lsm_sk_alloc_security
> > + *  bpf_lsm_sk_clone_security
> > + *  bpf_lsm_sk_free_security
> > + *  bpf_lsm_sk_getsecid
> > + *  bpf_lsm_socket_sock_rcv_skb
> > + *  bpf_lsm_sock_graft
> > + *  bpf_lsm_task_free
> > + *  bpf_lsm_task_getioprio
> > + *  bpf_lsm_task_getscheduler
> > + *  bpf_lsm_task_kill
> > + *  bpf_lsm_task_setioprio
> > + *  bpf_lsm_task_setnice
> > + *  bpf_lsm_task_setpgid
> > + *  bpf_lsm_task_setrlimit
> > + *  bpf_lsm_unix_may_send
> > + *  bpf_lsm_unix_stream_connect
> > + *  bpf_lsm_vm_enough_memory
> > + */
> > +BTF_SET_START(sleepable_lsm_hooks)BTF_ID(func, bpf_lsm_bpf)
>
> something is off here

Oops. Fixed.

>
> > +BTF_ID(func, bpf_lsm_bpf_map)
> > +BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
> > +BTF_ID(func, bpf_lsm_bpf_map_free_security)
> > +BTF_ID(func, bpf_lsm_bpf_prog)
>
> [...]
