Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88492A0E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgJ3TWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgJ3TVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:21:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFAEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:21:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so7617400wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IE0MVk7EQc0SlC+5nlJcr3By1j+rEqWin4sBQ/kMK1w=;
        b=WbIyGOe9UOMKjTTFKXttYo+9ZcHHcvG1eBzu3LM8HHS+Er8yFUh+M6p2MxN4/cmQ0q
         AWwcLhC2mrACVhSwMCPt5nf6VjMy9EG2QZ8mZyOs92TO0qO5FpsY3FJSunFSe0y8knxt
         im5yJfsBs3nzoeOmt+7oTuK2XcMOruClj7UDHnO6f3I61IttoiknbVT/KOQeoOs4GT06
         8sPh3fovXB+IMYYHspNljyiKeSVC7c0Ur/8cPRZYx2xBzxdw4OyyBbI7LKKNskPd5kJ9
         bVptsQkvjDq2se/d0XcgtMzzk/WbwGPa0Uiuggev+s5grwQNDOwdmayKTFfHcBEnFvmj
         k0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IE0MVk7EQc0SlC+5nlJcr3By1j+rEqWin4sBQ/kMK1w=;
        b=Up0+xBnqPmen8XUtAbg6BMhwhJF8XylfvLmWfcUq/whR2KnGlYzXR9TPIjpY+fKjEt
         avY1mjfxNhBTDF1bWb840YTtffk5DdF3PkQ8x8QIRE7WCoHJifQYL25wzBt9GMe6Vqqp
         adOql2MkTbtZf8X0pzvY3dZk878XIzcdDzR6126W6WyjdvY8ZJ9hnEy4a8OPOOQUWqkA
         EA8jxcF7Ks0fhyXXuGT2JVMHdpfBpQqdEs7izMDniXABFWytqMh5dw28RKiNjdafIF+K
         KS0wrym4szdSQMFAFrQXO1qVRGO0uqPQFaPAS4EDHV01mHDGckjE5/1qKEGsxGRwzGsC
         tvdA==
X-Gm-Message-State: AOAM531vRQrBSBG/fM1gqEUsmoclYJBlbiHiLuD6p2+cPEnudxMo4Mxr
        XBK/hvfASvUM8RXQKfyu4ENspzbUAe0slA==
X-Google-Smtp-Source: ABdhPJzPyjEc6NUIgzxYnfMknv3KqHndOcZiHGulHtMmRFW3HSmi3cSIQXi5DSGpVStErAMmr/fnTg==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr5185570wrs.156.1604085665716;
        Fri, 30 Oct 2020 12:21:05 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id z191sm6007104wme.30.2020.10.30.12.21.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 12:21:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20201012134444.1905-1-jrtc27@jrtc27.com>
Date:   Fri, 30 Oct 2020 19:21:03 +0000
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <159B3D01-132C-4F56-ABF0-72A8D5958A29@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
To:     linux-x86_64@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12 Oct 2020, at 14:44, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>=20
> POSIX specifies that the first field of the supplied msgp, namely =
mtype,
> is a long, not a __kernel_long_t, and it's a user-defined struct due =
to
> the variable-length mtext field so we can't even bend the spec and =
make
> it a __kernel_long_t even if we wanted to. Thus we must use the compat
> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
> msgrcv respectively.
>=20
> Due to erroneously including the first 4 bytes of mtext in the mtype
> this would previously also cause non-zero msgtyp arguments for msgrcv =
to
> search for the wrong messages, and if sharing message queues between =
x32
> and non-x32 (i386 or x86_64) processes this would previously cause =
mtext
> to "move" and, depending on the direction and ABI combination, lose =
the
> first 4 bytes.
>=20
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---

Ping?

Jess

>=20
> I have verified that the test at the end of [1] now gives the correct
> result on x32 ("PAYL" not "PAY" as I erroneously claimed it should be =
in
> the above email) and that both i386 and amd64 give the same output =
with
> that test as before.
>=20
> [1] <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
>=20
> Changes since v1:
> * Uses the same syscall numbers for x32 as amd64 and the current x32
>   rather than (further) breaking ABI by allocating new ones from the
>   legacy x32 range
>=20
> arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl =
b/arch/x86/entry/syscalls/syscall_64.tbl
> index f30d6ae9a..f462123f3 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -77,8 +77,10 @@
> 66	common	semctl			sys_semctl
> 67	common	shmdt			sys_shmdt
> 68	common	msgget			sys_msgget
> -69	common	msgsnd			sys_msgsnd
> -70	common	msgrcv			sys_msgrcv
> +69	64	msgsnd			sys_msgsnd
> +69	x32	msgsnd			compat_sys_msgsnd
> +70	64	msgrcv			sys_msgrcv
> +70	x32	msgrcv			compat_sys_msgrcv
> 71	common	msgctl			sys_msgctl
> 72	common	fcntl			sys_fcntl
> 73	common	flock			sys_flock
> --=20
> 2.28.0
>=20

