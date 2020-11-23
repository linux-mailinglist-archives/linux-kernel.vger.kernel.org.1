Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3989B2C1470
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgKWTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKWTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:21:13 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE78C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:21:11 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gj5so24945010ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 11:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDXip25iFNJyM0PQT3UUP9BSDp/9JtkjedehC7iQYgI=;
        b=Yw2aQU9xEKztBeZFpgzdcCIMM0F7lTQYAdM0JHnjP4hY6mpUB8V8tRh5WOa76T2xZn
         B1D9HaFeGSXAB9IPtUy8gP8yQitPaU5Epa1pIMOyO5nxNi6mRbogZsDTpv9Xhkhfuuvs
         b8Z1itlSu7vABBV16xIdb7eU1FLhji8NhNjQSxzdcfbvlhMTsd8UqbT1OdabZJyBZbAW
         Kg75RcoHpXHQJ+ndeWLo8CW6muNIxihUQo+Yrmmixvw+Q0ZLz5L3ZZXM7cXtigdf5XkT
         Zmps8vvpm9sg4emPXqNaTMqnyULRtHIDz98Qt8GVJP7KqgH6Al67RYpPbOZDRLiVCGPZ
         PX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDXip25iFNJyM0PQT3UUP9BSDp/9JtkjedehC7iQYgI=;
        b=s8M+EghXN1DeujYh4kxzI89xGvgisB9+KUFMYe04biCtjWOBQTc9dy61eHFAuHTIFO
         lDmHk0DnZyq3xHmb6YeXuTrDUDiYH/T7YP64lXr14EXd1H1z+St0UkC8Wwp/OlMOYw1S
         WxrPfW35W4QU2YL/WqeM47yEkpn/Aba/WQEaI90APA5PV+a/as6+p9KHzPy94afIyZHd
         qx+QH58vegj4KLxmmUcKYxQQOn/fwukE6BcF7MEFfqObHYdviDQwrpvspqJ3/zNf2O+Z
         nRBtv+H4AAWdopJK9tnAeUOWM8imxwLPWFspFZykasrtSYfi7XCmX/tXdnHdgaMZs65r
         jtjw==
X-Gm-Message-State: AOAM532z1Saz5V6lt+Ke6PKLYc6OGBO/6DOQef8K4UT6aYwshpeNXlyB
        gGiZw7q7HSBRslMJrprNZrpGtxjjB+fMVLh+4pv9XA==
X-Google-Smtp-Source: ABdhPJyAk0qU6rtTXOSnzSdut6i2VQ3kE6QNCZM4uiHTEAQJ9L6iAGGfXL9N+fu/hljow+r8JVhLjzMnXPAJLlg5eHc=
X-Received: by 2002:a17:906:c312:: with SMTP id s18mr1030453ejz.185.1606159269816;
 Mon, 23 Nov 2020 11:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com>
 <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com> <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 23 Nov 2020 11:20:58 -0800
Message-ID: <CA+EESO6qfCCZ5K1sWWrcBm6VM0w3LWkiOfAh3dhM-eVigVYYWA@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > I have created a cuttlefish build and have tested with the attached
> > userfaultfd program:
>
> Thanks, that's a good place to start, a few comments:
>
> - While we support Android as a distribution, it isn't a platform that
> we common use for development and testing.  At the moment, Fedora is
> probably your best choice for that.
>
I tried setting up a debian/ubuntu system for testing using the
instructions on the selinux-testsuite page, but the system kept
freezing after 'setenforce 1'. I'll try with fedora now.

> - Your test program should be written in vanilla C for the
> selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
> should be a trivial conversion.
>
> - I think you have a good start on a test for the selinux-testsuite,
> please take a look at the test suite and submit a patch against that
> repo.  Ondrej (CC'd) currently maintains the test suite and he may
> have some additional thoughts.
>
> * https://github.com/SELinuxProject/selinux-testsuite

Thanks a lot for the inputs. I'll start working on this.
>
> > 1) Without these kernel patches the program executes without any restrictions
> >
> > vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
> > api: 170
> > features: 511
> > ioctls: 9223372036854775811
> >
> > read: Try again
> >
> >
> > 2) With these patches applied but without any policy the 'permission
> > denied' is thrown
> >
> > vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
> > syscall(userfaultfd): Permission denied
> >
> > with the following logcat message:
> > 11-18 14:21:44.041  3130  3130 W userfaultfdSimp: type=1400
> > audit(0.0:107): avc: denied { create } for dev="anon_inodefs"
> > ino=45031 scontext=u:r:shell:s0 tcontext=u:object_r:shell:s0
> > tclass=anon_inode permissive=0
> >
> >
> > 3) With the attached .te policy file in place the following output is
> > observed, confirming that the patch is working as intended.
> > vsoc_x86_64:/ $ ./vendor/bin/userfaultfdSimple
> > UFFDIO_API: Permission denied
> >
> > with the following logcat message:
> > 11-18 14:33:29.142  2028  2028 W userfaultfdSimp: type=1400
> > audit(0.0:104): avc: denied { ioctl } for
> > path="anon_inode:[userfaultfd]" dev="anon_inodefs" ino=41169
> > ioctlcmd=0xaa3f scontext=u:r:userfaultfdSimple:s0
> > tcontext=u:object_r:uffd_t:s0 tclass=anon_inode permissive=0
>
> --
> paul moore
> www.paul-moore.com
