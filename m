Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE52FCBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbhATHlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbhATHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:40:31 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD12C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:39:51 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id k9so5459723vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUaAld+7PlVuBg6y2NQxllJPdU7rN5fhUZHbRArJm2Y=;
        b=ahvlTktyt5QECQ7ao3XTiHPAajLjWlC1X23RksKxj9quUyIyi6ILEaGj+Zez2VgIEk
         FxQFC+jSl1dmJmwQSp8sO/qEnB5YwxKwK5rAJQL7HsFgpP3rkvOEM6/pDSzuVwyo1f1y
         N27jXlR6oEBpfbksqHzmNNRDHk2ZprG03G5b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUaAld+7PlVuBg6y2NQxllJPdU7rN5fhUZHbRArJm2Y=;
        b=sARuNPEafHDwNc8/vhLLJ7jaS+NAuDODeoS6cbZo3v8rYhJ4a6SeGsamC8nOO/46Ux
         yFaykRH4tXOs1l6IynILaN1DMYtvemg5fgFye0aVlE+J5iJH2CQzZOvzafBhwLmH3tEu
         53mKpsBJXb1QBOOWOfVPx32ycq6yk6/HE6RsReKBa4FX7+DDEhf2xgwQgiqVsTBjHVgL
         /Rj4s8wLHITfUB65x30S/R2OCtEJaPZ2lTB2K8+ndCRN1GV6IViecvg6rX7Djgq/2kN8
         YZGgIjbXxc2QyzWFPnd37wERGg4dcyo5IndU1HHtAKx94MWkN9K7fuZlPyi4kyqSSCoU
         CGuw==
X-Gm-Message-State: AOAM530gATwcyiCoU7bNP0FKAVtm0IKiS2qPHhPx+fig71ynJDO7RHFi
        gaHE3VO1tZ10yPD4WhZ8zPBzD2ddEFqNkoI+9hNoew==
X-Google-Smtp-Source: ABdhPJxShMDCebz+BhaZwQUtaF/FMwTNyrAirvhIZqreLahBtuMVI+fIoCzbuAkc9Jh3F6ZuZLnKT+5lMhMhECOWtS8=
X-Received: by 2002:a1f:410c:: with SMTP id o12mr5750549vka.19.1611128390259;
 Tue, 19 Jan 2021 23:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <87y2go8wg9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87y2go8wg9.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:39:39 +0100
Message-ID: <CAJfpegvY1ckAfR0c-RtzeBSaR8_dM2CV1MD_xJr=A6+MkSXi9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] capability conversion fixes
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

On Tue, Jan 19, 2021 at 10:15 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > It turns out overlayfs is actually okay wrt. mutliple conversions, because
> > it uses the right context for lower operations.  I.e. before calling
> > vfs_{set,get}xattr() on underlying fs, it overrides creds with that of the
> > mounter, so the current user ns will now match that of
> > overlay_sb->s_user_ns, meaning that the caps will be converted to just the
> > right format for the next layer
> >
> > OTOH ecryptfs, which is the only other one affected by commit 7c03e2cda4a5
> > ("vfs: move cap_convert_nscap() call into vfs_setxattr()") needs to be
> > fixed up, since it doesn't do the cap override thing that overlayfs does.
> >
> > I don't have an ecryptfs setup, so untested, but it's a fairly trivial
> > change.
> >
> > My other observation was that cap_inode_getsecurity() messes up conversion
> > of caps in more than one case.  This is independent of the overlayfs user
> > ns enablement but affects it as well.
> >
> > Maybe we can revisit the infrastructure improvements we discussed, but I
> > think these fixes are more appropriate for the current cycle.
>
> I mostly agree.  Fixing the bugs in a back-portable way is important.
>
> However we need to sort out the infrastructure, and implementation.
>
> As far as I can tell it is only the fact that overlayfs does not support
> the new mount api aka fs_context that allows this fix to work and be
> correct.
>
> I believe the new mount api would allow specifying a different userns
> thatn curent_user_ns for the overlay filesystem and that would break
> this.

This is a valid concern.   I'll add a WARN_ON() to make sure that
whenever this changes it doesn't go unnoticed.

Fixing it would also be easy:  just update creds->user_ns field to
that of sb->s_user_ns in ovl_fill_super().   For now I'll go with the
WARNING though, since this cannot be tested.

Thanks,
Miklos
