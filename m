Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE872C0CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgKWOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgKWOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:02:38 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BC8C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:02:38 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so1711073lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYeuO9CyRYlI74SBnZHsqHkWdQ+mk7sZ3M8nh9IDpXI=;
        b=i0BxWMahO++rC3bV9QEmtNWIGL6rlcn02HBbKIEGje0GBsmG1xjrCtPp8O8PQFjXx6
         ghWblFt+gcW9vtakoAQrk9FnkoRXZR1ATeMwGHD+CEdrrNgNd0eGxIsW1Bvtw7XljlQr
         T1KDU5TzShj/9pHMmbWRlh5Hich+3JfraKw/hBx2irA8SEcqaHyyY3XFN9GdYegtyILz
         XEW3nQZ9pCxyYZKQ7Mg3HrHQuiGfYFhgNnsy2c021e5Oo0JgjXiJTrlEHbBW++O3kXnx
         Z+thkapqjBSXOBwANQ0oQO0qeLXTxFJdC1GQmSeBfxd2aJYzYjdbvx39LaS3dwK4Oycw
         VsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYeuO9CyRYlI74SBnZHsqHkWdQ+mk7sZ3M8nh9IDpXI=;
        b=DbCToj2YTXkSdQDhqQIUDTMhhGS9I9KCv73lLAcNr3MmkKfGhlhp6t6xSbT+yizrmO
         XI21taavphOHiR/Oa9kQkRaFHzsyF2JoqxKtz4yQgYZtoXsPVw/B2o47Uxvcli735l3D
         7JIiBP9PZfUpq/QwrnumRi4RtF3lntY2FLWpnRAZiTgpNCbCXkZV7d2GLaju0ZwOjMdH
         5xmQ1uYxHytFX5UL+XXLqX1w3Q0Nu/z+S7Qov3s3b4YKqxxGsEKmYaLsNXKTeqnMDon8
         PeodLoE7L6w9UHBGFmO0hbd7WJ3nEG4GpSmAZuxdX0gss5BLqPmRX0obxHUzhIv0BUBF
         ZAfg==
X-Gm-Message-State: AOAM531krDDEsOJ8M2d+2ctfT8YURsIHHOjEUQTKlyLYYTqtz5H4ueSS
        cW3uAGmr9cF6zC0plBs7PnJwNhpq2MzJwCSdNCO5Rg==
X-Google-Smtp-Source: ABdhPJzD45bDbtioK3UIuEAtyLLjXaU7Tz6Q0nrcpUO7K1SNhRtDZOExOk2ORy/uMCpMMdKopnEe1kQmAFAMF1N4T3A=
X-Received: by 2002:ac2:528e:: with SMTP id q14mr11971554lfm.34.1606140156521;
 Mon, 23 Nov 2020 06:02:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs9sg69JgmQNZhutQnbijb4GzcO03XF66EjkQ6CTpXXxA@mail.gmail.com>
 <CAK8P3a1Lx1MMQ3s1uWjevsi2wqFo2r=k1hhrxf1spUxEQX_Rag@mail.gmail.com>
In-Reply-To: <CAK8P3a1Lx1MMQ3s1uWjevsi2wqFo2r=k1hhrxf1spUxEQX_Rag@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 23 Nov 2020 15:02:10 +0100
Message-ID: <CAG48ez17CKBMO4193wxuWLRQWQ+q6EV=Qr5oTWiKivMxEi0zQw@mail.gmail.com>
Subject: Re: [arm64] kernel BUG at kernel/seccomp.c:1309!
To:     Arnd Bergmann <arnd@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 2:45 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Nov 23, 2020 at 12:15 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While booting arm64 kernel the following kernel BUG noticed on several arm64
> > devices running linux next 20201123 tag kernel.
> >
> >
> > $ git log --oneline next-20201120..next-20201123 -- kernel/seccomp.c
> > 5c5c5fa055ea Merge remote-tracking branch 'seccomp/for-next/seccomp'
> > bce6a8cba7bf Merge branch 'linus'
> > 7ef95e3dbcee Merge branch 'for-linus/seccomp' into for-next/seccomp
> > fab686eb0307 seccomp: Remove bogus __user annotations
> > 0d8315dddd28 seccomp/cache: Report cache data through /proc/pid/seccomp_cache
> > 8e01b51a31a1 seccomp/cache: Add "emulator" to check if filter is constant allow
> > f9d480b6ffbe seccomp/cache: Lookup syscall allowlist bitmap for fast path
> > 23d67a54857a seccomp: Migrate to use SYSCALL_WORK flag
> >
> >
> > Please find these easy steps to reproduce the kernel build and boot.
>
> Adding Gabriel Krisman Bertazi to Cc, as the last patch (23d67a54857a) here
> seems suspicious: it changes
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 02aef2844c38..47763f3999f7 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -42,7 +42,7 @@ struct seccomp {
>  extern int __secure_computing(const struct seccomp_data *sd);
>  static inline int secure_computing(void)
>  {
> -       if (unlikely(test_thread_flag(TIF_SECCOMP)))
> +       if (unlikely(test_syscall_work(SECCOMP)))
>                 return  __secure_computing(NULL);
>         return 0;
>  }
>
> which is in the call chain directly before
>
> int __secure_computing(const struct seccomp_data *sd)
> {
>        int mode = current->seccomp.mode;
>
> ...
>         switch (mode) {
>         case SECCOMP_MODE_STRICT:
>                 __secure_computing_strict(this_syscall);  /* may call do_exit */
>                 return 0;
>         case SECCOMP_MODE_FILTER:
>                 return __seccomp_filter(this_syscall, sd, false);
>         default:
>                 BUG();
>         }
> }
>
> Clearly, current->seccomp.mode is set to something other
> than SECCOMP_MODE_STRICT or SECCOMP_MODE_FILTER
> while the test_syscall_work(SECCOMP) returns true, and this
> must have not been the case earlier.

Ah, I think the problem is actually in
3136b93c3fb2b7c19e853e049203ff8f2b9dd2cd ("entry: Expose helpers to
migrate TIF to SYSCALL_WORK flag"). In the !GENERIC_ENTRY case, it
adds this code:

+#define set_syscall_work(fl)                                           \
+       set_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define test_syscall_work(fl) \
+       test_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define clear_syscall_work(fl) \
+       clear_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+
+#define set_task_syscall_work(t, fl) \
+       set_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define test_task_syscall_work(t, fl) \
+       test_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define clear_task_syscall_work(t, fl) \
+       clear_ti_thread_flag(task_thread_info(t), TIF_##fl)

but the SYSCALL_WORK_FLAGS are not valid on !GENERIC_ENTRY, we'll mix
up (on arm64) SYSCALL_WORK_BIT_SECCOMP (==0) and TIF_SIGPENDING (==0).

As part of fixing this, it might be a good idea to put "enum
syscall_work_bit" behind a "#ifdef CONFIG_GENERIC_ENTRY" to avoid
future accidents like this?
