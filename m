Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83522FF61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgG1COk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgG1COj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:14:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20880C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:14:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so19090476eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntpZED/bDicwQAEOYBBXCb0Vf/5An8qRDW4/uB32sUk=;
        b=AX0JUaJRVAWwPRhZXFl39tXHNZFQXPlYY4M/KcRVwsM1iOLno5M25//lHOUHgBDrMW
         6PIKCAHwgT8eYyTp1Q6JkjIBBqN66b4nxk7K0W7wCX519WVYE0Uf1mKA6+maOFpC/TV3
         rIBlospISlu1bJfl04H/Hv+QIePz+9S2YtUSAmN3qi6zne/qEzrLw8eT4v5KpiHz4gFW
         f3oy3e3YuUYnviu+BM3uG98iDsPg/RWJtctm7ZHvbSCLuDne36VEKIfzgCUneJnvt+ce
         w1W7ClvKoA1Azu+NJRG6RIGlu/WeIy3ujf3+EUQxBvAeJJ889wNLe8NJIQC3h934yjyU
         5yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntpZED/bDicwQAEOYBBXCb0Vf/5An8qRDW4/uB32sUk=;
        b=dCXcHBK0g2m+KfF2PiJsU86aQ3Ieja9PDd8zmn/OuQBq071EPkMeAilpoEOH3FhQHu
         8NISKhBDjY7342ow7NQZM1POeMLg0x4Q8mNgraj7EK7mD/+H7cluyTmfmyxejB//KIFn
         lH6ICAZPmyNSU4BvAGFdYIoEEE/hHpVwXTjGkjHI23mIxHVLESVD55HrTbyK1j60Z1p4
         Dm7Pk9CAdEMk2qXZHx6nKm/yps201o7B9omX/1BWJTEzFZgUe5nn4Lw2nB4I44QbZRhG
         NK+J1IYjuygCXTKkLVGm5OgcmvDfBziKJ9nZYOpoz7+KYFhga8WSAvFqx5YfM4Dil8cR
         Lf0Q==
X-Gm-Message-State: AOAM532FSdDrv0hc2T+lmHMJr61qec+QqCy65cTYeifw1KkAfxfwoNDa
        hMgsLfHQ+F82PyJQQS6rdzrkFfI3w911mNfL7pop
X-Google-Smtp-Source: ABdhPJwc8DqsJGPgarb7e3Hd57xYvw4BfDWTZIFWsDfO8+3vYv71T/BGXu4iQOxPjuRAY3Ia1prjQmG8/cVecbd70J8=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr7595815ejn.542.1595902477608;
 Mon, 27 Jul 2020 19:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
In-Reply-To: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 22:14:26 -0400
Message-ID: <CAHC9VhSx23JiN6GprskxdEcs9uftJOp03Svh7YJbQLOV91AMiQ@mail.gmail.com>
Subject: Re: [PATCH V3fix ghak120] audit: initialize context values in case of
 mandatory events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 5:30 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Issue ghak120 enabled syscall records to accompany required records when
> no rules are present to trigger the storage of syscall context.  A
> reported issue showed that the cwd was not always initialized.  That
> issue was already resolved ...

Yes and no.  Yes, it appears to be resolved in v5.8-rc1 and above, but
the problematic commit is in v5.7 and I'm not sure backporting the fix
in v5.8-rcX plus this patch is the right thing to do for a released
kernel.  The lowest risk fix for v5.7 at this point is to do a revert;
regardless of what happens with this patch and v5.8-rcX please post a
revert for the audit/stable-5.7 tree as soon as you can.

> ... but a review of all other records that could
> be triggered at the time of a syscall record revealed other potential
> values that could be missing or misleading.  Initialize them.
>
> The fds array is reset to -1 after the first syscall to indicate it
> isn't valid any more, but was never set to -1 when the context was
> allocated to indicate it wasn't yet valid.
>
> The audit_inode* functions can be called without going through
> getname_flags() or getname_kernel() that sets audit_names and cwd, so
> set the cwd if it has not already been done so due to audit_names being
> valid.
>
> The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
> missed with the ghak96 patch, so add that case here.
>
> Please see issue https://github.com/linux-audit/audit-kernel/issues/120
> Please see issue https://github.com/linux-audit/audit-kernel/issues/96
> Passes audit-testsuite.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c     | 3 +++
>  security/lsm_audit.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6884b50069d1..2f97618e6a34 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -929,6 +929,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
>         context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
>         INIT_LIST_HEAD(&context->killed_trees);
>         INIT_LIST_HEAD(&context->names_list);
> +       context->fds[0] = -1;
>         return context;
>  }
>
> @@ -2076,6 +2077,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>         }
>         handle_path(dentry);
>         audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> +       _audit_getcwd(context);
>  }
>
>  void __audit_file(const struct file *file)
> @@ -2194,6 +2196,7 @@ void __audit_inode_child(struct inode *parent,
>                 audit_copy_inode(found_child, dentry, inode, 0);
>         else
>                 found_child->ino = AUDIT_INO_UNSET;
> +       _audit_getcwd(context);
>  }
>  EXPORT_SYMBOL_GPL(__audit_inode_child);
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 53d0d183db8f..e93077612246 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>                                         audit_log_untrustedstring(ab, p);
>                                 else
>                                         audit_log_n_hex(ab, p, len);
> +                               audit_getcwd();
>                                 break;
>                         }
>                 }

I understand the "fds[0] = -1" fix in audit_alloc_context()
(ironically, the kzalloc() which is supposed to help with cases like
this, hurts us with this particular field), but I'm still not quite
seeing why we need to sprinkle audit_getcwd() calls everywhere to fix
this bug (this seems more like a feature add than a bigfix).  Yes,
they may fix the problem but it seems like simply adding a
context->pwd test in audit_log_name() similar to what we do in
audit_log_exit() is the correct fix.

We are currently at -rc7 and this really needs to land before v5.8 is
released, presumably this weekend; this means a small and limited bug
fix patch is what is needed.

-- 
paul moore
www.paul-moore.com
