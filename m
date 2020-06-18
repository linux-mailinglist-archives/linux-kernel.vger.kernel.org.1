Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C751FFC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgFRUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFRUNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:13:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5817FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:13:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so1019953pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXh+yh53BzWcVX/QSWd/KMGYLJEd9W2Aq0rZcysTQP4=;
        b=FsxI+GezYcq5Or+8LsyorXmnP7DpX4UiDy+yK2n1mRa4jblk1OUuhBfwLlpOjHyQqp
         C6V9+4Qv73F1H1QEepi3l+DsjRE/Yl2ZyJ+uOnEqfoaKaafcdPEUmhUCBv5W6FnPX6Jc
         GM0vUU2Qj7gRcd5fGdIsu83QlptQgL4TRyn7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXh+yh53BzWcVX/QSWd/KMGYLJEd9W2Aq0rZcysTQP4=;
        b=k9BFDlv4F6SjxrGRSGOhTaKIbteLL8AiNQIPrv3/LW0XRKdKt09XU1O/j6pk56ypu4
         SxjK5gr8HAbMZ6NBy6W6AshpSzJcS+dFFvkbtDiOYy75Zatnbota8Q+r1jtFj0XC56Dr
         4s2IVbV1T4Mlfd9PlKZdB5Fado/gCfhGZLPO2a5tEWwruLI4zwlhISj5DQ8SW7m3y4mq
         e8z6cnLAjyMp3Vb1HdKyUXDH9nPCGgOejNRPBZXrnjIg9elTj9zv4fy2AjpCYvMvCxcu
         lR58zyrYdBSc5HMJPruCjL43nzjRlvCIN78PJxIOFF+VOG5kcliAO+8P0OK9g1NY9S4D
         hF4Q==
X-Gm-Message-State: AOAM532S0JaYbKRmDxKv/hHVJxvpOPTZfpghZxQ7XF6CWz77N7AsjZ5u
        rfe7tr+lS7/MlHXY9Y0/FDydTw==
X-Google-Smtp-Source: ABdhPJz0/H6VhaSxaYiFoMobAEqIMKy6r+p/NJ3edVxjTSX7edMf4m0+dOSHEEOoExU9RsAPGvhS7A==
X-Received: by 2002:a17:90a:f508:: with SMTP id cs8mr71173pjb.16.1592511185631;
        Thu, 18 Jun 2020 13:13:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y136sm3759429pfg.55.2020.06.18.13.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:13:04 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:13:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/7] fs: Add fd_install_received() wrapper for
 __fd_install_received()
Message-ID: <202006181305.01F1B08@keescook>
References: <20200617220327.3731559-1-keescook@chromium.org>
 <20200617220327.3731559-4-keescook@chromium.org>
 <20200618054918.GB18669@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618054918.GB18669@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:49:19AM +0000, Sargun Dhillon wrote:
> On Wed, Jun 17, 2020 at 03:03:23PM -0700, Kees Cook wrote:
> > [...]
> >  static inline int fd_install_received_user(struct file *file, int __user *ufd,
> >  					   unsigned int o_flags)
> >  {
> > +	if (ufd == NULL)
> > +		return -EFAULT;
> Isn't this *technically* a behvaiour change? Nonetheless, I think this is a much better
> approach than forcing everyone to do null checking, and avoids at least one error case
> where the kernel installs FDs for SCM_RIGHTS, and they're not actualy usable.

So, the only behavior change I see is that the order of sanity checks is
changed.

The loop in scm_detach_fds() is:


        for (i = 0; i < fdmax; i++) {
                err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
                if (err < 0)
                        break;
        }

Before, __scm_install_fd() does:

        error = security_file_receive(file);
        if (error)
                return error;

        new_fd = get_unused_fd_flags(o_flags);
        if (new_fd < 0)
                return new_fd;

        error = put_user(new_fd, ufd);
        if (error) {
                put_unused_fd(new_fd);
                return error;
        }
	...

After, fd_install_received_user() and __fd_install_received() does:

        if (ufd == NULL)
                return -EFAULT;
	...
        error = security_file_receive(file);
        if (error)
                return error;
	...
                new_fd = get_unused_fd_flags(o_flags);
                if (new_fd < 0)
                        return new_fd;
	...
                error = put_user(new_fd, ufd);
                if (error) {
                        put_unused_fd(new_fd);
                        return error;
                }

i.e. if a caller attempts a receive that is rejected by LSM *and*
includes a NULL userpointer destination, they will get an EFAULT now
instead of an EPERM.

I struggle to imagine a situation where this could possible matter
(both fail, neither installs files). It is only the error code that
is different. I am comfortable making this change and seeing if anyone
screams. If they do, I can restore the v4 "ufd_required" way of doing it.

> Reviewed-by: Sargun Dhillon <sargun@sargun.me>

Thanks!

-- 
Kees Cook
