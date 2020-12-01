Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F602C9577
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgLAC7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:59:22 -0500
Received: from namei.org ([65.99.196.166]:57156 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgLAC7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:59:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0B12wPRU029210;
        Tue, 1 Dec 2020 02:58:25 GMT
Date:   Tue, 1 Dec 2020 13:58:25 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
cc:     "Andrew G. Morgan" <morgan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <20201129211542.GA5227@mail.hallyn.com>
Message-ID: <alpine.LRH.2.21.2012011358200.28022@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL6q8ppuWi3ygY6iqh6SX9pnkVnvJDynTD61K2wUqerahg@mail.gmail.com> <20201129211542.GA5227@mail.hallyn.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1019167516-1606791505=:28022"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1019167516-1606791505=:28022
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 29 Nov 2020, Serge E. Hallyn wrote:

> Hi James,
> 
> would you mind adding this to the security tree?  (You can cherrypick
> from https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git/commit/?h=2020-11-29/fix-nscaps )

Sure.

> 
> thanks,
> -serge
> 
> On Tue, Nov 17, 2020 at 08:09:59AM -0800, Andrew G. Morgan wrote:
> > Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
> > 
> > 
> > On Tue, Nov 17, 2020 at 7:09 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > 
> > > Namespaced file capabilities were introduced in 8db6c34f1dbc .
> > > When userspace reads an xattr for a namespaced capability, a
> > > virtualized representation of it is returned if the caller is
> > > in a user namespace owned by the capability's owning rootid.
> > > The function which performs this virtualization was not hooked
> > > up if CONFIG_SECURITY=n.  Therefore in that case the original
> > > xattr was shown instead of the virtualized one.
> > >
> > > To test this using libcap-bin (*1),
> > >
> > > $ v=$(mktemp)
> > > $ unshare -Ur setcap cap_sys_admin-eip $v
> > > $ unshare -Ur setcap -v cap_sys_admin-eip $v
> > > /tmp/tmp.lSiIFRvt8Y: OK
> > >
> > > "setcap -v" verifies the values instead of setting them, and
> > > will check whether the rootid value is set.  Therefore, with
> > > this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
> > > fail:
> > >
> > > $ v=$(mktemp)
> > > $ unshare -Ur setcap cap_sys_admin=eip $v
> > > $ unshare -Ur setcap -v cap_sys_admin=eip $v
> > > nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
> > >
> > > Fix this bug by calling cap_inode_getsecurity() in
> > > security_inode_getsecurity() instead of returning
> > > -EOPNOTSUPP, when CONFIG_SECURITY=n.
> > >
> > > *1 - note, if libcap is too old for getcap to have the '-n'
> > > option, then use verify-caps instead.
> > >
> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
> > > Cc: Herv� Guillemet <herve@guillemet.org>
> > > Cc: Andrew G. Morgan <morgan@kernel.org>
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >  include/linux/security.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index bc2725491560..39642626a707 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct
> > > dentry *dentry)
> > >
> > >  static inline int security_inode_getsecurity(struct inode *inode, const
> > > char *name, void **buffer, bool alloc)
> > >  {
> > > -       return -EOPNOTSUPP;
> > > +       return cap_inode_getsecurity(inode, name, buffer, alloc);
> > >  }
> > >
> > >  static inline int security_inode_setsecurity(struct inode *inode, const
> > > char *name, const void *value, size_t size, int flags)
> > > --
> > > 2.25.1
> > >
> > >
> 

-- 
James Morris
<jmorris@namei.org>

--1665246916-1019167516-1606791505=:28022--
