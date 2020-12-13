Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB22D9114
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436485AbgLMXBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbgLMXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:00:55 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262FC061793
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:00:14 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so15211733eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7XlCtFnQpWXdPLq8hdrC5r7fY/5pa4RVHpiXnxDixo=;
        b=phMwJHB9hrJuAPuoWHUETTAUr+ZXE5D8Ao7Ty3wpgc050dKNUUBoMKAXf1O7pY4AG2
         Xvk00py2QBa9gKDfoXui8tEcs2y9V79MuOSXo2ruf2ygLpdH+K/6J3L+CFCPs0Cd06zx
         LAdvXdZSbvPFKX0IuziZEm33XyeJTEhaVAT2EK+UaWO3UBeLYiHhD78GWArvt2zk4FoX
         l7qJQSQDN7srZVbqa+aqHAuVxDfPYDCfIRzSwdlyzoPLpEfHAqcRsAWKhVNvlKucQDeK
         JlCh88udcetwhUsaJi2ehJ6eQQFhsvVPgEAZCxNW+2ydC6oZD2RqcKbJKXkh/EFIFMKt
         3fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7XlCtFnQpWXdPLq8hdrC5r7fY/5pa4RVHpiXnxDixo=;
        b=l4XbQ/XxA/50oDf6+hUKRRYxWkg0cEahKAmdwIA0a6JPqdKBcAHl1vuWAEOm9/nwMG
         cDX1i96oCq9zzWY3FgDirQ3nsk7lsdYzqg0tt85PjMlBEZDfQqRFTjsVClcfG2qP14t7
         oD5gDs01YZ5gaPa/yFzYy6u/yAZd9T5S2HuQOA63mfvHvl+J/w0LZVbdPpZgEF7rqNeV
         axs+k/DECcCZB6VyHXEguSI6L4rsQ0/plfGpAZq7W/xiy8n04wOLZov5USN56DBBwQcp
         +GXOAsCbj0JX90yc5tyk1qC9iMbxfGjqFbG2Z4cRHzDrc6fU9BKRdTc++DmeOWkZPWQB
         McjA==
X-Gm-Message-State: AOAM533eCJdOMGnCkimzQFGieQZZf+JGuJetiyI7EHfKqSbGodXQY6N7
        3k0lYQclkoKS26sopeP569rpZ0IjeuhkzsdEmgqR
X-Google-Smtp-Source: ABdhPJyT8YEFTOyPKj1YPFnMWE+J+xwjmaptRDMSvik5afJSTQCXwpVgWI9ImeHlYLjJ2Ma1kD7KLF+btWLmDE7O+p4=
X-Received: by 2002:aa7:d7d8:: with SMTP id e24mr21950323eds.135.1607900413041;
 Sun, 13 Dec 2020 15:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org> <877dpln5uf.fsf@x220.int.ebiederm.org>
 <20201213162941.GG2443@casper.infradead.org>
In-Reply-To: <20201213162941.GG2443@casper.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 13 Dec 2020 18:00:01 -0500
Message-ID: <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> >
> > > On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
> > >> -void pid_update_inode(struct task_struct *task, struct inode *inode)
> > >> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
> > >> +                         unsigned int flags)
> > >
> > > I'm really nitpicking here, but this function only _updates_ the inode
> > > if flags says it should.  So I was thinking something like this
> > > (compile tested only).
> > >
> > > I'd really appreocate feedback from someone like Casey or Stephen on
> > > what they need for their security modules.
> >
> > Just so we don't have security module questions confusing things
> > can we please make this a 2 patch series?  With the first
> > patch removing security_task_to_inode?
> >
> > The justification for the removal is that all security_task_to_inode
> > appears to care about is the file type bits in inode->i_mode.  Something
> > that never changes.  Having this in a separate patch would make that
> > logical change easier to verify.
>
> I don't think that's right, which is why I keep asking Stephen & Casey
> for their thoughts.

The SELinux security_task_to_inode() implementation only cares about
inode->i_mode S_IFMT bits from the inode so that we can set the object
class correctly.  The inode's SELinux label is taken from the
associated task.

Casey would need to comment on Smack's needs.

> For example,
>
>  * Sets the smack pointer in the inode security blob
>  */
> static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
> {
>         struct inode_smack *isp = smack_inode(inode);
>         struct smack_known *skp = smk_of_task_struct(p);
>
>         isp->smk_inode = skp;
>         isp->smk_flags |= SMK_INODE_INSTANT;
> }
>
> That seems to do rather more than checking the file type bits.

-- 
paul moore
www.paul-moore.com
