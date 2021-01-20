Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AAB2FCC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbhATHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbhATHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:53:22 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id d3so5079972uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=Ylwu8MaIfcMtXeRHHcdwBLnRoutC82UYXqkJIBtOivUEMmhWi5MIahULll+FlWnkT7
         JmPX49Txh2CBicmCu1r/uHDoOgGt43Pt6egifpvlG0N9WkQ4sd9dWwhT2XqzPCrYxuFJ
         lvaRyu3cL5u3PMTRSekUykObI3rpbo85ziBNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=Dk2/W3Sxr5NLg+XBfu9lH3B9AcEP7IZ0jUPYCBW9XucvA0F3fZGe5Y2IY3yWCtiemP
         +eQ6K7k8yqRr4fMpLHbOZh1WTh9nhWRXIUOvHrj3YCju+QUuNXEwjIZsxZF6vq0hyoW2
         XApwYXgKgV97+CSsNyz+5/3KdRC/9g3OUxNTuw+3JCKwhZzl5hgoV3HmJSOyZKJwjnf2
         xdoQx7X3AbUfJIYkUL7lKle2YEmWF7yWUFxVsoChy/+BQYoNW1pLGgmMENEZZ6Sst6Pz
         K6LXjoGScwblPGY0yUJ9DZVcLxGLWAElTAS/gyQ/3fUWX2A5krxpT4VlsFiy9TCakjKw
         cmKQ==
X-Gm-Message-State: AOAM533YOv0CVyU7B0y9mfoTLd77G8bQhMemoPPanQ6F7GoP/HyJpRkx
        DnuTIYxquFGwWjEDMsFr2/UqrTgzH2nTYGnzuKksRQ==
X-Google-Smtp-Source: ABdhPJwRciGoD7gQP+crKeuujj3hoGxybSoXTk18gDmGI7WKaAUZHP/lExz5OVrqMvYJynhTLUACKyEZrrtu5fA93GI=
X-Received: by 2002:ab0:7296:: with SMTP id w22mr5234322uao.13.1611129158535;
 Tue, 19 Jan 2021 23:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <87a6t4ab7h.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6t4ab7h.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:52:27 +0100
Message-ID: <CAJfpegvy4u9cC7SXWqteg54q-96fH3SqqfEybcQtAMxsewAGYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:11 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > filesystems (overlayfs and ecryptfs) into account.
> >
> > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Restore old the behavior for ecryptfs that existed before the overlayfs
> > fix.  This does not fix ecryptfs's handling of complex user namespace
> > setups, but it does make sure existing setups don't regress.
>
> Today vfs_setxattr handles handles a delegated_inode and breaking
> leases.  Code that is enabled with CONFIG_FILE_LOCKING.  So unless
> I am missing something this introduces a different regression into
> ecryptfs.

This is in line with all the other cases of ecryptfs passing NULL as
delegated inode.

I'll defer this to the maintainer of ecryptfs.

Thanks,
Miklos
