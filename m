Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE84F2B6994
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKQQLu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 11:11:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40008 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgKQQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:11:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id y197so20843109qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4jQUk+uUdUDMuBpooa0vLGDCE03iHWsS7jO3tfLTcGg=;
        b=avCj0kArPnH5IYX1Dg5Qrm1oOcfBRUXPBHC6DEAbrHy4S6tKBMp6Gw51H/J9rMF/sx
         uWCWEdmDz0ZV0NpTynLdXxIxeMjqOxTnKwLSMzBjb1+Qpo7yIuZP/QEhDJ4a6NtYnXjs
         fPR0aw1FJFIiM+NuWE5UO1sc6DHfoxfNlYUmX5QxopYc5PCfNMpBVzi2JWMYZNV1aK5k
         k/WYSlO0mZZAeMj0yzoL3xK1VQPAeyrY0vo2LCyzELCr3F2mpCSWxetsrj8QwW73vp9K
         SUBirg787U5ADHUbI/YOiniQoSRsDeyw1T0TBdDGxfNkbERh22cKshlhA7OG1fIvPpye
         44fQ==
X-Gm-Message-State: AOAM533F1QAdlraD08TnLGudmdvSXmvT0qEML2b1v8vuG4T/Lne1vSgs
        cMcc8YHd5/DLDWQAxDmmuFYjk4c3N0dP5v0QpY6gWA==
X-Google-Smtp-Source: ABdhPJy0Jve5BCweZh1H+wHNiYQj8kf0zBPe07AYUTmIZ2kjuY3FW71wI4aU48sTEGgglj1eU1KjWcEwW819X9ywc2c=
X-Received: by 2002:a37:a249:: with SMTP id l70mr245194qke.79.1605629508326;
 Tue, 17 Nov 2020 08:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20201117150856.GA12240@mail.hallyn.com>
In-Reply-To: <20201117150856.GA12240@mail.hallyn.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Tue, 17 Nov 2020 08:11:37 -0800
Message-ID: <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Herv=C3=A9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew G. Morgan <morgan@kernel.org>


On Tue, Nov 17, 2020 at 7:09 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> Namespaced file capabilities were introduced in 8db6c34f1dbc .
> When userspace reads an xattr for a namespaced capability, a
> virtualized representation of it is returned if the caller is
> in a user namespace owned by the capability's owning rootid.
> The function which performs this virtualization was not hooked
> up if CONFIG_SECURITY=n.  Therefore in that case the original
> xattr was shown instead of the virtualized one.
>
> To test this using libcap-bin (*1),
>
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin-eip $v
> $ unshare -Ur setcap -v cap_sys_admin-eip $v
> /tmp/tmp.lSiIFRvt8Y: OK
>
> "setcap -v" verifies the values instead of setting them, and
> will check whether the rootid value is set.  Therefore, with
> this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
> fail:
>
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin=eip $v
> $ unshare -Ur setcap -v cap_sys_admin=eip $v
> nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
>
> Fix this bug by calling cap_inode_getsecurity() in
> security_inode_getsecurity() instead of returning
> -EOPNOTSUPP, when CONFIG_SECURITY=n.
>
> *1 - note, if libcap is too old for getcap to have the '-n'
> option, then use verify-caps instead.
>
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
> Cc: Hervé Guillemet <herve@guillemet.org>
> Cc: Andrew G. Morgan <morgan@kernel.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bc2725491560..39642626a707 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
>
>  static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
>  {
> -       return -EOPNOTSUPP;
> +       return cap_inode_getsecurity(inode, name, buffer, alloc);
>  }
>
>  static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
> --
> 2.25.1
>
