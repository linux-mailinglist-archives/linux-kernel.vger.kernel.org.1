Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41428C687
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgJMA63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgJMA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:58:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:58:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so19090948edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqFFBvtE1qeWxzZ4YXFzIC5jeC2s6YKrrSNxDkFYOXo=;
        b=lwIfJweJJybrhy0rcoSuXCETT0GsAVTChI0nzm1HyN1ZXqSC0DvtpzyG6DiO0W40Zi
         bRCxmY8RQyG4G/FJhtlCa5mBfSQ+XZT91Qh+9vHpym46xWv+EQBS+Sb2NDFveR6BjBD0
         8UCGFLFsTgcrxAuGsbR/tzb98tHpBTpmA5cfbRepDqFATI3I71PTvV6xC8D/jFbJQncn
         wTjlJrZoB8NOgImVUz3qdZk+pOAbDCGcrQDCy9WkdcIlc1pgUny90MNyultrBuyjHP5O
         kvVIFi1YfJ7GIWbkz/1WlWid4zpYOOa4z5peeMVg6FhRiNkQskl1Kuo/if/BLmnsao/5
         Z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqFFBvtE1qeWxzZ4YXFzIC5jeC2s6YKrrSNxDkFYOXo=;
        b=MQVPek8gSLxqoUrwYfYF+IfvpVxi/RwNTIB0B29kqZXij3JgfpFi70T9+cNE9zOCMr
         N4ap3WkVLniCiccuX4UtG1Uz4FxzdrFuIH0Z6FypYNvnwyZvzksNjVeXIfjsu9faHsIE
         UzGBZXaZoART+iIeGfS6KRqNxuCJ8YtSwwcjBnU9ANr3Vz2QnA0BGF3Bu1yPAgaEjp1a
         gJScrXjsfDbsg2SpbThx1XtrmpjC0sM+wkIJm9cTrgM8ImST8JB+XSYNQc4u7b70uoD/
         FtcAT1HJ3X9J7k8SRiuy/m36twwOHKrxu04f0dFFuwh5jNg8lNYRvlYz4dcC2ZckSaxw
         c1Cw==
X-Gm-Message-State: AOAM533ocOECpfxsgE5zJIBc9KAB786OMtj+aLb1XpNFV+xqHf9syywi
        YfpI1N0Teik6yvdGrW0xAFxXlABcIagC6IeLENTg
X-Google-Smtp-Source: ABdhPJz1Zpk7P/UOqJYfTTtstqAeO/iB6SdqqzrmgxdkdBlf8iB371HEZtZ2+JT17/PT0wipA5Z2LwQg2WPSfnQW7LI=
X-Received: by 2002:a05:6402:94f:: with SMTP id h15mr16871460edz.12.1602550705600;
 Mon, 12 Oct 2020 17:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
 <CAHC9VhQrBHr00Lxeocv9FkWP5svcEF1=y_9KTRf7Q0-P2ZZJkg@mail.gmail.com>
In-Reply-To: <CAHC9VhQrBHr00Lxeocv9FkWP5svcEF1=y_9KTRf7Q0-P2ZZJkg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Oct 2020 20:58:14 -0400
Message-ID: <CAHC9VhTp+XaWou6=hQQzuG3DjKLn-x2irQZcjiAACy+ziEPTtg@mail.gmail.com>
Subject: Re: [GIT PULL] Audit patches for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:54 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 12, 2020 at 8:51 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Hi Linus,
> >
> > A small set of audit patches for v5.10.  There are only three patches
> > in total, and all three are trivial fixes that don't really warrant
> > any explanations beyond their descriptions.  As usual, all three
> > patches pass our test suite and as of a few minutes ago they applied
> > cleanly to your tree.  Please merge for v5.10.
> >
> > Thanks,
> > -Paul
> >
> > --
> > The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> >
> >  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> >
> > are available in the Git repository at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> >    stable-5.10
>
> My apologies, I mistakenly sent the branch and not the signed tag, the
> proper PR tag is below:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> audit-pr-20201012

Today is just not my day, of course the tag reference above is missing
the "tags/" prefix.  Sorry for all the noise.

> > for you to fetch changes up to c07203516439b9cd9f7b3cbed82a77164de5af40:
> >
> >  audit: Remove redundant null check (2020-08-26 09:10:39 -0400)
> >
> > ----------------------------------------------------------------
> > Jules Irenge (2):
> >      audit: change unnecessary globals into statics
> >      audit: uninitialize variable audit_sig_sid
> >
> > Xu Wang (1):
> >      audit: Remove redundant null check
> >
> > kernel/audit.c | 9 ++++-----
> > kernel/audit.h | 4 ----
> > 2 files changed, 4 insertions(+), 9 deletions(-)
> >
> > --
> > paul moore
> > www.paul-moore.com
>
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
