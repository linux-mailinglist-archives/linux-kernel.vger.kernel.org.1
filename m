Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF042BBA74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgKTX7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgKTX7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:59:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7798FC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:59:17 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id e139so15881503lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=F7GS0CnZoLQZsd60ze5qvCDpXMSLI40/SpzvFW2rlnL2ZGQsu9FP2VdHFJJcXSc/Mx
         ywQViQeQUDiVRYnXhOndM5IYUrsZOLGAJjBoQXUcy4dOA6BiQjBOf3l0N81v74uaIp5Q
         /AlhPw10MHseYMV2hIMrFXL3A+9XwPIxX2AA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=Zd4ER/LAwC/45HZIq+Jly4lInmkowVtSs4z5cBNMKGBYrzNhv3Ui4Bio+CrZA7JtBE
         JTAvh1rvsIYMHTYaGKUNMrvhQI07FxclRfDyztVWq1n1bp1j4lPlDLv9/0WcUVew8+xi
         BzOpWNoEgfxblqwwulHTqQ4Ly8unQZe7HiEOG6S7Sbvk1uiq6IfOHiiU5b3rmKhGoKCA
         5F8p4UMQQqj1lLXSNwNmP/TKacooIXjHFBAGoRnb6wPgQEfRN0Shx4BOKJE6uY7kCSxZ
         5FriZzTIpYlgEWCnX1f+6X4JxF7yorxGCvG2GESJUD3wOYXmMHLn/NIWLIeFsZ9+UBiM
         PVjw==
X-Gm-Message-State: AOAM533sniD17bPjBtzrjBiNbGByFno/xKxXaDKbfOZjO4yuS2uy7DaK
        A03HGhtG6NbYdZoQhCVGvf5SeNqeexZxMQ==
X-Google-Smtp-Source: ABdhPJyabp+9FKGc/UlEIHhfb59yAKj7WJJoVux88ztRD/yB6UfjuasWOFjR5j76H+7i4YTh0Ws6nQ==
X-Received: by 2002:a19:94:: with SMTP id 142mr9072495lfa.401.1605916755113;
        Fri, 20 Nov 2020 15:59:15 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a30sm423742ljd.91.2020.11.20.15.59.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 15:59:13 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id s9so11796953ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:59:13 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr8560585ljo.371.1605916752808;
 Fri, 20 Nov 2020 15:59:12 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-1-ebiederm@xmission.com>
In-Reply-To: <20201120231441.29911-1-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 15:58:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] exec: Move unshare_files to fix posix file
 locking during exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 3:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> @@ -1257,6 +1258,13 @@ int begin_new_exec(struct linux_binprm * bprm)
>         if (retval)
>                 goto out;
>
> +       /* Ensure the files table is not shared. */
> +       retval = unshare_files(&displaced);
> +       if (retval)
> +               goto out;
> +       if (displaced)
> +               put_files_struct(displaced);

It's not obvious from the patch (not enough context), but the new
placement seems to make much more sense - and it's where we do the
de-thread and switch the vm and signals too.

So this does seem to be the much more logical place.

Ack.

      Linus
