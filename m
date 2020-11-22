Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8215E2BFCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 00:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKVXOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 18:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKVXOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 18:14:52 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557DDC061A4A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 15:14:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lv15so14924638ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrIV9Yoc1RpsJtPIVkFbz+NHNkiiYsOXEJ2yAt4fGM4=;
        b=eAEDg4gusJ5cOG8GkLEsF1ZAHwn37356W/f3uiaob29/5FsdO0PDffI2+hWwsDxZNd
         IoRtJkaNfBfkGTP4NOV0G9+ugO7r3kiZMr8CkVIMb9DdojQ6fOpVEvHw8ghAxUfFidiB
         3i/pCAl+sd97icqGYzZ4sxJ4xe78yjP+jYSeQ3D1zKHG4dsYL3FAwtlPvQZReuDHK5jO
         hHSGXkq/iD6nhrc5hp/rvPgIghfCSCLczJjsoWKaEphQRrTEy/TcIqI104ww2/q8PwKs
         JWW/9SOxNKFPAqANRS6zH7/zQX6N/KvAvsVuVwldrwARApU7P/vVSrc/s8UgwcofPJqo
         YyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrIV9Yoc1RpsJtPIVkFbz+NHNkiiYsOXEJ2yAt4fGM4=;
        b=ARyB8BRfCv0zuPzdhDvA3i+JvOs9Zeh6TWnApjuA1AU12oOF4uwGcHgtNb0t6MhHQN
         YxFphGT2iGPqUbTHX6g1ylnTJ3EY0uWbKQKFFEcrVrXwfoBJamgF5ejOmLvimkG6akPS
         pIl9mMMjtIBr+ndxxnz087LqB5Lbwas+V3NzdFPv2f6DbkbXTzcR59JVs6IrRRCTo8E8
         9P07MiOZLhGmIwsWboUtinFXgj0lXdKBRCsX2NUtc8iaPbPW1bfz90yzyYnGD59rbHP3
         3Aohq/qFbHT5u3659WI/qmHs+DPpY+hLDR3GMyODKpo621RJ2pBza4XDSgwLhUBTbUkr
         TWPQ==
X-Gm-Message-State: AOAM531AYBsvPILKu4jZU2KD/HKJDSE27jBNiG85NoswsE6sQhAWFinI
        aljnD3PF3jjv7KVCwtaAX6N156Pi2lfNEZGqUb/p
X-Google-Smtp-Source: ABdhPJxM8SoW5yL7VRfbqEbtaHLQg1xbRH2fsuHa1EhDIBWdhMTb0dsDtHUGa29ucrvGj8macTSk07Y8ott2k+Y4Zrs=
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr40380124ejz.488.1606086888699;
 Sun, 22 Nov 2020 15:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
 <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
 <CAHC9VhQJvTp4Xx2jCDK1zMbOmXLAAm_+ZnexydgAeWz1eGKfUg@mail.gmail.com>
 <CA+EESO79Yx6gMBYX+QkU9f7TKo-L+_COomCoAqwFQYwg8xy=gg@mail.gmail.com>
 <CAHC9VhSjVE6tC04h7k09LgTBrR-XW274ypvhcabkoyYLcDszHw@mail.gmail.com> <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
In-Reply-To: <CA+EESO7vqNMXeyk7GZ7syXrTFG54oaf1PUsC7+2ndEBEQeBpdw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 22 Nov 2020 18:14:37 -0500
Message-ID: <CAHC9VhQn-E+kTzzwwAiSLLQVtm5u=m5bOz2n-q+oA+8quT2noQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
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

On Wed, Nov 18, 2020 at 5:39 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> I have created a cuttlefish build and have tested with the attached
> userfaultfd program:

Thanks, that's a good place to start, a few comments:

- While we support Android as a distribution, it isn't a platform that
we common use for development and testing.  At the moment, Fedora is
probably your best choice for that.

- Your test program should be written in vanilla C for the
selinux-testsuite.  Looking at the userfaultfdSimple.cc code that
should be a trivial conversion.

- I think you have a good start on a test for the selinux-testsuite,
please take a look at the test suite and submit a patch against that
repo.  Ondrej (CC'd) currently maintains the test suite and he may
have some additional thoughts.

* https://github.com/SELinuxProject/selinux-testsuite

> 1) Without these kernel patches the program executes without any restrictions
>
> vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
> api: 170
> features: 511
> ioctls: 9223372036854775811
>
> read: Try again
>
>
> 2) With these patches applied but without any policy the 'permission
> denied' is thrown
>
> vsoc_x86_64:/ $ ./system/bin/userfaultfdSimple
> syscall(userfaultfd): Permission denied
>
> with the following logcat message:
> 11-18 14:21:44.041  3130  3130 W userfaultfdSimp: type=1400
> audit(0.0:107): avc: denied { create } for dev="anon_inodefs"
> ino=45031 scontext=u:r:shell:s0 tcontext=u:object_r:shell:s0
> tclass=anon_inode permissive=0
>
>
> 3) With the attached .te policy file in place the following output is
> observed, confirming that the patch is working as intended.
> vsoc_x86_64:/ $ ./vendor/bin/userfaultfdSimple
> UFFDIO_API: Permission denied
>
> with the following logcat message:
> 11-18 14:33:29.142  2028  2028 W userfaultfdSimp: type=1400
> audit(0.0:104): avc: denied { ioctl } for
> path="anon_inode:[userfaultfd]" dev="anon_inodefs" ino=41169
> ioctlcmd=0xaa3f scontext=u:r:userfaultfdSimple:s0
> tcontext=u:object_r:uffd_t:s0 tclass=anon_inode permissive=0

-- 
paul moore
www.paul-moore.com
