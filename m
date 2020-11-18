Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED50E2B8406
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgKRSpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKRSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:45:53 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:45:51 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so4412338lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ug/4t0fM3pIpIAub0llFf/8Xaf+lcT8t0V5wPmfAso=;
        b=gozNiFyAIAeRymxxB2sVP7pZY8eXn6i0bdSQC8BcSw0/V9sD0rco8VOu8rAfHq856s
         FS7XgqgNE5LAUWeqGVJ1kyBw+Rx60wcQWaM4w95Ezodmdv8I9fCy6cCnCJu4IY2U6dYM
         lTIff9uLe3QqN7HOVkX7br/nHmMdzFZrP4qxGlDsPulFA6SSmKj8l1B29++6FFJDIQ6K
         NejhrhI/QP18FDOC4UryKrGgY+nZV/HxNjfxI1mlQMB8Szo+EQ9/l4Xur+JKDVYs6FJB
         AthANSgXoOf0jTu6kB4dgM4W1i9Nq76zmxJikCxqTML0qTijsecgIpw34B1i+oYPWPqJ
         yNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ug/4t0fM3pIpIAub0llFf/8Xaf+lcT8t0V5wPmfAso=;
        b=udBdZvkMJZPfZh7UO6VYINey5DrKptoPCeUsSmxU0UrKXc4jgQoYCIqmLsEl2kHoi9
         yg2S8qVOM8vGvNZb5uddrmbtM0Qm27eCCNEKspbe/I56z6VCyddJDtMJu8OWk0OxNzqQ
         8brhVXMZLwGrX18nusm3DU3fcLzcJWPQO0+YX3v9zNMOW+FU7Tjk5ScC1iBAgEA0YdKD
         845QBerOz6xCCUdD1U9XVEFMRnBRhUHIn0BLGdRJqluFnMheIdQQdkm7lJYE/6Qv7uFu
         7QUhysYHCS0CI4oKCNpnsqRjo/2l3Dqw9prZL15A6/xT5zSZ425L34q5O9HG78dSpo9v
         yy9A==
X-Gm-Message-State: AOAM533k5R52teE3iiQLGHoLGhxchK1n+AInpcghPd5PlxqaG9GG9jGn
        xH691PBye8pDJMhZcGEv/5elxYaGW4yJYbMYNUQ=
X-Google-Smtp-Source: ABdhPJypgN7nclvX8BPdMcWzPn6z4X/5N660ZKeA+awwd0+ULJzwVj2KkHQCcdQihNEuiqmOxl1AaV78nbNmHuOXWhU=
X-Received: by 2002:a19:4147:: with SMTP id o68mr4454498lfa.365.1605725149965;
 Wed, 18 Nov 2020 10:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20201118124035.96976-1-dwaipayanray1@gmail.com>
 <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
 <CABJPP5CqKjY3_mfkJEsHX_8Zc7q1TRCgA4T54sTEZBiKgPS+OQ@mail.gmail.com> <754e240d1c88274ce2d94a5b6dbcfff1cc8c9508.camel@perches.com>
In-Reply-To: <754e240d1c88274ce2d94a5b6dbcfff1cc8c9508.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 19 Nov 2020 00:15:19 +0530
Message-ID: <CABJPP5CHofzA46FHe3eJrgjQBTcaoCkR=dc29xxK80oFZJVfoQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:09 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-11-19 at 00:03 +0530, Dwaipayan Ray wrote:
> > On Wed, Nov 18, 2020 at 11:44 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Wed, 2020-11-18 at 18:10 +0530, Dwaipayan Ray wrote:
> > > > Brace style misuses of the following types are now
> > > > corrected:
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -3937,9 +3937,23 @@ sub process {
> > > >                       #print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
> > > >
> > > >
> > > >                       if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
> > > > -                             ERROR("OPEN_BRACE",
> > > > -                                   "that open brace { should be on the previous line\n" .
> > > > -                                     "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
> > > > +                             if (ERROR("OPEN_BRACE",
> > > > +                                       "that open brace { should be on the previous line\n" .
> > > > +                                             "$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
> > > > +                                 $fix) {
> > > > +                                     my $line1 = $rawlines[$ctx_ln - 2];
> > >
> > > How are you sure that in a patch context this line always starts with /^\+/ ?
> >
> > Hi,
> > I followed it from the other fixes for OPEN_BRACE which were already
> > there. In the patch context if the lines are added then only I think the fix
> > should be triggered. Other instances should not be modified.
>
> As far as I know there are no existing uses of --fix with OPEN_BRACE.
>

I think you added it via 8d1824780f2f1 ("checkpatch: add --fix option
for a couple OPEN_BRACE misuses")

Thanks,
Dwaipayan.
