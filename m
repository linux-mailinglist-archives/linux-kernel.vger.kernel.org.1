Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC02B5B86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKQJIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:08:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:08:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so22355909wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=w4Av8T9OgZxILV3isMPmRrxqdKu7Tuh1cAL0mq8mBiU=;
        b=Qm8eSJXpVHyK0GoS3uaTFKUko/kZd1MB/Tvo5Uxpp6gO5IMidrLd0ZMwqOvyHjZKv9
         AlcKBA36beh7hH79K4O92dIK26+LCsBgE0y0pOoMxj+tUwn38NF790xKgM6g3zLqaFZs
         5Qfjip8IEMsvvxWc/XRRZdQjMw4Dl3C7GKfzZwpD6RmyHkBRY+r8kb8kuRZYvExrvuvl
         3XKnRcXRvnBTfBsB69euXURlsFkmUb/MJ2mLcpJHMwl2XqLqcOAvEEXKkRNO/SQit2Ev
         twGgd+SDGDVI5M3stawM3oOiZ/GFPtPYLopgrB9cv4tns4p7SNOjqDBdp1zPTAq42pKN
         Lqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=w4Av8T9OgZxILV3isMPmRrxqdKu7Tuh1cAL0mq8mBiU=;
        b=iqibjjXs1gIZ7Z9SRIN4TASJLWwLntnuecE22266jYxq6lPnO06GvM/W0SJH7c8aY8
         YsyN0t+AZR0MH2n7NAXJSsKjGMeQrOnUPs++meIrO0CsWLRNfICX/AU4i+4dbaDAo2Wf
         FPittOIKIpFgFE0vHwi30sWPqJa4/FSycHIs3Bc7vSjb5+in9nrxfh8/TLeW7rAir5AI
         Ri4odKINSb0zYE4K3HLY4OMPoZN1dZGG9kRgYc76h6Kh+DzTyYQs3VDmc+W0+q6+qIAB
         pQBUIqPb3n5kPjV345EQxGvHWGf4LsrXvwxaoxeJ9FNlPfBNiWT5BptxJlhzCixd4xj6
         4GGg==
X-Gm-Message-State: AOAM533UBTQzdZrLZa+GwrlEb0KNsIkpbK7nEyiQQpIXZkJ1rFPIGnd1
        uSP8Bahw/Atjwm3HZq/FLogsSUoGCxChIKhdC9zgvelld60vag==
X-Google-Smtp-Source: ABdhPJwTcK4+jOvTYrTPM9Ty5MwsiI5oKqG8Az0D/agKuzCvLa4r/SODKLSdJzuCcGcDv104VXt4yhHrA+2a+zpZ4U8=
X-Received: by 2002:a05:6000:1606:: with SMTP id u6mr24715611wrb.9.1605604089321;
 Tue, 17 Nov 2020 01:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20201115202928.81955-1-dwaipayanray1@gmail.com>
 <d3d6b68178b4193f04c35863163ce811a1571c0a.camel@perches.com> <67332536788cefbc39c7f87129adca462bb42fa5.camel@perches.com>
In-Reply-To: <67332536788cefbc39c7f87129adca462bb42fa5.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 17 Nov 2020 14:37:38 +0530
Message-ID: <CABJPP5CBccqvLVpzahMXhkuTt5Z+Gz-HaEGWgJdc4aMi4JsMEA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix unescaped left brace
To:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 4:32 AM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-11-15 at 19:43 -0800, Joe Perches wrote:
> > On Mon, 2020-11-16 at 01:59 +0530, Dwaipayan Ray wrote:
> > > There is an unescaped left brace in a regex in OPEN_BRACE
> > > check. This throws a runtime error when checkpatch is run
> > > with --fix flag and the OPEN_BRACE check is executed.
> > >
> > > Fix it by escaping the left brace.
> > >
> > > Fixes: 8d1824780f2f ("checkpatch: add --fix option for a couple OPEN_BRACE misuses")
> > > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> >
> > Thanks Dwaipayan.
> >
> > Obviously that code path hasn't been tested in awhile.
> >
> > I think the notice to require an escape for a { was added back in
> > perl 5.16 or so.
>
> Just fyi:  it seems the requirement was actually implemented in perl 5.22
> and this code predates the release of perl 5.22
>
> https://github.com/Perl/perl5/blob/blead/pod/perl5220delta.pod
>
That's pretty interesting. Apart from that I have seen that
the perl_version_ok check mandates perl 5.10 which was
released more than 10 years back.

Do you think that check could be removed completely?
Maybe sometime in the future or just have it lay around
for backward compatibility?

Thanks,
Dwaipayan.
