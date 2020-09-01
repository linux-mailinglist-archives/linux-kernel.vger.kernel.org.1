Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983E225984C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgIAQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbgIAPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91213C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:32:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so2269548ejl.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCVhL1ZYQZ/22NoSfVaU5SfSk2cz/Z2rvr8f2hgBXYE=;
        b=hSk2aRhaoXQzHn2L9qxNLKMKe4q2ytVWr9XD8EZBuMQvnu6eTMXe0V3J5EoiDegMzv
         nh7Vh47lF6rk5+eLg1mT8/kLFHD4WfIZYPSnveptzFnhbE0VrxtXagjjCnw1KfMtTExd
         VEz1v3zTyFk7QODgF52sMUfMKdxKbdWECSpMIVSnWAmM6K6boqfz+9Hdogf4uqvR5iPd
         2tqUjYPXzv69BmZ+Tkx4GGmJ2JjIR0JPhyDl7KhkWD+rQYnW1Xh+Ki0u63+yGtksuAjs
         1MWVIawm0T6qXF2c4YxFPjdRZ9n30E7CoIQ8sSMmku9JHy6WC+/U6Q+fxCVl2a4afBTn
         cmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCVhL1ZYQZ/22NoSfVaU5SfSk2cz/Z2rvr8f2hgBXYE=;
        b=g/hPz0tbIE5ShecctJGJSsYJvEkW64IebxtE60/LA7bdZqZCveKtByPdgnaCMkWIm8
         RRSJgktNudM6vY7GI31EFPRCaawUUZtRH+/FT48+YLJcWZnujwy529sOoy/KEXaATUFC
         jZO5E9FsxNTReTL1DdMlb9J3gdq/hwOB4iEpkj7Gh9uZCgi01QZlHQqyfRzGyszMHFa7
         ovGeMHnsyMzdsAe4Qsj/b0+BnbHcnGQw77DrM33EqC3NrbTi4z4LYUIcvEfvHapaKTze
         tY0owI5CDbSt2TKWmN0jjl1atQb0SanweBlupE0UWYq0Y0qANQkw433ubdCvdfl4wTDB
         yLpA==
X-Gm-Message-State: AOAM530KMADi6EbV0c4G4dSyUndsvCxoI73rWpA4YUPBZg0JCwZkeahX
        KNvP1Bx24apsGsCWQ8wiXVqI34vPeK+Jq35GJvf1
X-Google-Smtp-Source: ABdhPJy+Q/X9dDz5TF7cJeuAhbImPPrbr4wy997A9iOn686JZ/umRzprOdiyRWGJMjZtiOEbLIUZH+jtc3lGHsGMNFM=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr1887861ejm.488.1598974325033;
 Tue, 01 Sep 2020 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
 <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com> <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
 <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com> <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
 <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com> <CAHC9VhRi87H2GhsKQN9iMOQeSw3g5_qwok9jpx+pfFSouQ9d5w@mail.gmail.com>
 <000e6a1b-6026-5e99-9a92-6ae9aafc07d4@sony.com>
In-Reply-To: <000e6a1b-6026-5e99-9a92-6ae9aafc07d4@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Sep 2020 11:31:53 -0400
Message-ID: <CAHC9VhQiPTEarUWWA1RH8AsymhRpAa7kWTmmefTAqfouts8WGw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:34 AM peter enderborg wrote:
> On 8/31/20 4:16 PM, Paul Moore wrote:
> > On Thu, Aug 27, 2020 at 10:04 AM peter enderborg wrote:

...

> >> Im happly fine with replacing the selinux_audited with selinux_denied.  However it is the case where there are more than one denial at the same time. Im not sure how and when it might happen.
> > One thing I wondered about was why not build up a single string with
> > all of the permissions instead of generating multiple trace events?
> > In the previous discussion it was implied that this was due to
> > limitations in the tracing subsystem's filtering, and based on the
> > discussion thus far I'm guessing there is little desire for this
> > information if it can't be filtered on?
>
> The information is of course as essential as for audit messages.
> I dont see much of the problem with having as the first suggestion with
> a list. It works fine for trace_pipe. It is not failing due to that we can not
> filter with that.

I don't really have much personal experience with the kernel tracing
tools, so an example would be helpful as I'm not really following what
you are saying.  Are you talking about something like
"permission=foo,bar,baz"?

> It is cause in other tools in user-space
> that needs a plugin to parse it. It need static
> mapping for something that is not really static. Not in runtime, and it will
> change over time.

I think we've all come to the conclusion that doing the permission
bitmap-to-string translation in a plugin is not really desirable.

> A other idea based on the first one is to have multiple pairs like
>
> class=file permission=read permission=write permission=open
>
> but then you need to filter on numeric values that are not static and
> I don't know if library can make anything useful from that.

Oh, wait, is the issue that the tracing subsystem can't filter on
strings?  That doesn't seem right, but I can understand why one might
want to avoid that for performance reasons.  If the tracing subsystem
*can* filter on strings, why did you say that in the "perm=foo
perm=bar" format one would need to filter on numeric values?  I still
think I'm missing something here ...

-- 
paul moore
www.paul-moore.com
