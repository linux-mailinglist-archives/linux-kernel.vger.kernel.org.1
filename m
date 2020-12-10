Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF52D5F65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391306AbgLJPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389991AbgLJPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:20:17 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD16C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 07:19:31 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id l187so1294281vki.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MkRqt104RVsv5N+YB6WxXi+teVxnu9MbnHIdbKaCUs=;
        b=d2WuHo1tCik0k3Fg5z/lUis7T2/Ee7ntUJkrfJIDMKNZFR0sI4ru2CJ8lp2K0L7thL
         jZxi5N4bJ1s++KgIpr23I6EHVZ5gSxWGuSZq3q+LaV+kgYt49JkqZpHxxuTzgW6fP6X+
         43DjTtxU7TEbsPKG5fNlTQ3WBI2Ih02t2E7Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MkRqt104RVsv5N+YB6WxXi+teVxnu9MbnHIdbKaCUs=;
        b=snvy/PHaKV+mhkalV71jNwmn2xYTGufXfBd7p1A4SPAr8HAuvE4XIVlnu/R4eiYhUM
         yDcPxGg9j5GLufVGnSr6NKKGgvKQDejmkqCI/mcv6ruD3rKJPOJhHQn4q2sxlvFERSLZ
         txyPpNV1grZ8ObibOc4m62xaXaTyL3gHuxvbyAF+w0kBATcFXjMQHrWeO2YKLty7DsJ5
         8AYvy7xidEbDXAFSQvaVVdv/7Ehz47cM+vFMk+erC29hcMJp27feMKQoyScJvEuTLdfR
         U2iC63IGKNeRgoyWVakmi0c8AD78X7FvFtTai+51TaIlwYAkFpp8Ys8cpHSGpowUGOak
         Fbrg==
X-Gm-Message-State: AOAM530u4XNwJ3lpLr3Hl7gWNrBFLi+UsaP8xMzLzRKCJPUZF7ZXTKBp
        gqVzsTispDoHlWn3jeAgmh7b1nFREW12J+P9rzxmwg==
X-Google-Smtp-Source: ABdhPJwvjRSAI1kxVXNit/fyHFyd319loOtIx2YFfsD0fjD4NxOYqVS5hiDeAbWdDM8beKfUnfhU76Wfa2EXqxGrHHY=
X-Received: by 2002:a1f:b245:: with SMTP id b66mr9258645vkf.3.1607613570896;
 Thu, 10 Dec 2020 07:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
 <e5876ecc-1cce-76d0-528-40b9bc54d0c2@namei.org>
In-Reply-To: <e5876ecc-1cce-76d0-528-40b9bc54d0c2@namei.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Dec 2020 16:19:19 +0100
Message-ID: <CAJfpeguHYNK7G23u+3v34pzrP0N3xw5cpFT3n2ktgjvntvfABQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     James Morris <jmorris@namei.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:01 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 7 Dec 2020, Miklos Szeredi wrote:
>
> > ovl_ioctl_set_flags() does a capability check using flags, but then the
> > real ioctl double-fetches flags and uses potentially different value.
> >
> > The "Check the capability before cred override" comment misleading: user
> > can skip this check by presenting benign flags first and then overwriting
> > them to non-benign flags.
>
> Is this a security bug which should be fixed in stable?

Yes, good point.  Added Cc: stable@...

Thanks,
Miklos
