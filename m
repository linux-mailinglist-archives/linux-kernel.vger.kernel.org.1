Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785452CF15F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgLDP7N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Dec 2020 10:59:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbgLDP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:59:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so4199612qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Va60PHKbXcNtcvtJiWN0ujbNwxJ04G9rj4CXUNzPJ2U=;
        b=UXJF4+qirH48LGvYnES34iTvcKLrC6oFIyeFJVNyl5n9TGJAU0LzVUMJ05InxPeeJ4
         XDBDSLDehlsBL3Q5/3CzelkrlmdU9Lb1mTFWDGNSOO8kSB/HzflZ9SFJt4W3VQISKCKw
         NbtRX6o3CWbGUyJK5cydCfmaFdjH9AJWuiQEpovzI+J8Q5XW9zgemDIpZ+ZYZxBng6Hh
         l5fb6vt2FGKoM7X7HuvkSw/V0IH/umyzW18gvY1roJoyg2FVueny+T0oi/lt3UXoEzqj
         6yjmY1edIdnfwQDVMcVM4OUxELSLnPwrYGnG5v8cEVa/dSWiRg/HiYyAtMiUZNIhA1UA
         3apQ==
X-Gm-Message-State: AOAM530JI3dN7ZnYVW8dWqKV1k9CAyB9327LRJLJgwfBOzsz6BDKy4h/
        rl8YXGuHRd+9+FqkW6A0VI5p67SO5xg+CPR42Xmdaz94xu3ddQ==
X-Google-Smtp-Source: ABdhPJywpOvyI7iOQDJ+mUJGbzqYAwXQLLwSMM1UfOI4dGin0v7FrVDLLt728dydlLp8kMcONJjV8OHjrplm/UgqXUs=
X-Received: by 2002:ac8:d0e:: with SMTP id q14mr9764842qti.37.1607097505622;
 Fri, 04 Dec 2020 07:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL6q8ppuWi3ygY6iqh6SX9pnkVnvJDynTD61K2wUqerahg@mail.gmail.com>
 <20201129211542.GA5227@mail.hallyn.com> <alpine.LRH.2.21.2012011358200.28022@namei.org>
In-Reply-To: <alpine.LRH.2.21.2012011358200.28022@namei.org>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Fri, 4 Dec 2020 07:58:14 -0800
Message-ID: <CALQRfL6OQKuBqbUoC7_yH7W4qabYSamRYUqjM-HE1gj2r_CaHQ@mail.gmail.com>
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Herv=C3=A9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct bug reference for this patch is:

https://bugzilla.kernel.org/show_bug.cgi?id=209689

Reviewed-by: Andrew G. Morgan <morgan@kernel.org>

On Mon, Nov 30, 2020 at 6:58 PM James Morris <jmorris@namei.org> wrote:
>
> On Sun, 29 Nov 2020, Serge E. Hallyn wrote:
>
> > Hi James,
> >
> > would you mind adding this to the security tree?  (You can cherrypick
> > from https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git/commit/?h=2020-11-29/fix-nscaps )
>
> Sure.
>
> >
> > thanks,
> > -serge
> >
> > On Tue, Nov 17, 2020 at 08:09:59AM -0800, Andrew G. Morgan wrote:
> > > Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
> > >
> > >
> > > On Tue, Nov 17, 2020 at 7:09 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > > Namespaced file capabilities were introduced in 8db6c34f1dbc .
> > > > When userspace reads an xattr for a namespaced capability, a
> > > > virtualized representation of it is returned if the caller is
> > > > in a user namespace owned by the capability's owning rootid.
> > > > The function which performs this virtualization was not hooked
> > > > up if CONFIG_SECURITY=n.  Therefore in that case the original
> > > > xattr was shown instead of the virtualized one.
> > > >
> > > > To test this using libcap-bin (*1),
> > > >
> > > > $ v=$(mktemp)
> > > > $ unshare -Ur setcap cap_sys_admin-eip $v
> > > > $ unshare -Ur setcap -v cap_sys_admin-eip $v
> > > > /tmp/tmp.lSiIFRvt8Y: OK
> > > >
> > > > "setcap -v" verifies the values instead of setting them, and
> > > > will check whether the rootid value is set.  Therefore, with
> > > > this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
> > > > fail:
> > > >
> > > > $ v=$(mktemp)
> > > > $ unshare -Ur setcap cap_sys_admin=eip $v
> > > > $ unshare -Ur setcap -v cap_sys_admin=eip $v
> > > > nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
> > > >
> > > > Fix this bug by calling cap_inode_getsecurity() in
> > > > security_inode_getsecurity() instead of returning
> > > > -EOPNOTSUPP, when CONFIG_SECURITY=n.
> > > >
> > > > *1 - note, if libcap is too old for getcap to have the '-n'
> > > > option, then use verify-caps instead.
> > > >
> > > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
> > > > Cc: Hervé Guillemet <herve@guillemet.org>
> > > > Cc: Andrew G. Morgan <morgan@kernel.org>
> > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > ---
> > > >  include/linux/security.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > > index bc2725491560..39642626a707 100644
> > > > --- a/include/linux/security.h
> > > > +++ b/include/linux/security.h
> > > > @@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct
> > > > dentry *dentry)
> > > >
> > > >  static inline int security_inode_getsecurity(struct inode *inode, const
> > > > char *name, void **buffer, bool alloc)
> > > >  {
> > > > -       return -EOPNOTSUPP;
> > > > +       return cap_inode_getsecurity(inode, name, buffer, alloc);
> > > >  }
> > > >
> > > >  static inline int security_inode_setsecurity(struct inode *inode, const
> > > > char *name, const void *value, size_t size, int flags)
> > > > --
> > > > 2.25.1
> > > >
> > > >
> >
>
> --
> James Morris
> <jmorris@namei.org>
