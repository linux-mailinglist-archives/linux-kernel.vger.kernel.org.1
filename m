Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4641C1A82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEAQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:23:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF012C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 09:23:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so7611894edy.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfkQqP4P46nAK7oHXekeHfYjV+lTMmLOA7ipwLh/Dr8=;
        b=Zvn4tyvfjCwJZ4OUXbaZPdeUosydRCUvEPtuDiMRQpLR4Lt1iBBN6upWwzblLJEBt7
         DC8Kwix4abLHUDib+LHkkSs5i7qxPasdEY0sZRZw9fareW+qLioVXXvY7J90+WTOqSCr
         KP3FzIgAp/z6w0Z2zvjoZCK4QVNc2k10LZFzL9i2qpc7qKX9lKA2mbhFHpYmEvgWAq/x
         BttAwm4H7hbo9DPXsPKU1gbl2gNZA4FrIo8F05isaYZqNS+j/gOrY02+dblEz6//nwDe
         wrOUKMMBmTF/VPdoL5ub21/7574RN3HHihWiPlLtpNk1F3ssOwvCRXE4ZnTNKz4wfMYo
         GCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfkQqP4P46nAK7oHXekeHfYjV+lTMmLOA7ipwLh/Dr8=;
        b=Uo2xOcwvmcWk2N0NJQ89zapFOFtoVRj1RcVapyjAfHnckc7U2PV4Be0LcC3x1rcDtf
         Dr7/JXkoHnM079ZPmr3/sfW6eeKMOBTLFHfFN2jAgSV8agWmRp6f6FAZJ903nikIkAAr
         D42esGledeyr92Q8vrOkUSJvJnXf/LVzpYw/YhnafSZePTxFoX6vD2zmkGR/zmVL1j8D
         4e6k1Vtjd54PJP+jIwPmq0QAPz9BC/cr0G3djmV0DIlQGiZbNUqN4FgJqw0ZyxLw2EMk
         S/i81ma8+KjCJeYzxniw+rDpiONgOodbK+poUILh7xqYu0L4cfaVVF6Z8LlXLINCvTYK
         YICw==
X-Gm-Message-State: AGi0PuZD+iVMOr2Q9aRGviG/xzeSS5KWJgMzqFqieFJ9jMtHFEVv5nmu
        Fs7D2xZAQvegLuMLH68SM8ZhDgWA/DrmrV1DnKFe
X-Google-Smtp-Source: APiQypK825QibI3Ui9tCm2G1lExv4S+wdR3Bg+ka7wXCBeYqlb2bim0M0WRbqiTf2qPAhN/AhIew2jU+IiK7WSk1z7A=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr4169202edt.164.1588350206362;
 Fri, 01 May 2020 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587500467.git.rgb@redhat.com> <CAHC9VhR9sNB58A8uQ4FNgAXOgVJ3RaWF4y5MAo=3mcTojaym0Q@mail.gmail.com>
 <20200429143146.3vlcmwvljo74ydb4@madcap2.tricolour.ca> <3348737.k9gCtgYObn@x2>
 <20200429213247.6ewxqf66i2apgyuz@madcap2.tricolour.ca>
In-Reply-To: <20200429213247.6ewxqf66i2apgyuz@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:23:15 -0400
Message-ID: <CAHC9VhRv4GdaBm5ooi5D-j4CBvoOD5L9ab+QPgxhLudtwG=Nsw@mail.gmail.com>
Subject: Re: [PATCH ghak25 v4 3/3] audit: add subj creds to NETFILTER_CFG
 record to cover async unregister
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, omosnace@redhat.com, fw@strlen.de,
        twoerner@redhat.com, Eric Paris <eparis@parisplace.org>,
        ebiederm@xmission.com, tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 5:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-29 14:47, Steve Grubb wrote:
> > On Wednesday, April 29, 2020 10:31:46 AM EDT Richard Guy Briggs wrote:
> > > On 2020-04-28 18:25, Paul Moore wrote:
> > > > On Wed, Apr 22, 2020 at 5:40 PM Richard Guy Briggs <rgb@redhat.com>
> > wrote:
> > > > > Some table unregister actions seem to be initiated by the kernel to
> > > > > garbage collect unused tables that are not initiated by any userspace
> > > > > actions.  It was found to be necessary to add the subject credentials
> > > > > to  cover this case to reveal the source of these actions.  A sample
> > > > > record:
> > > > >   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat
> > > > >   family=bridge entries=0 op=unregister pid=153 uid=root auid=unset
> > > > >   tty=(none) ses=unset subj=system_u:system_r:kernel_t:s0
> > > > >   comm=kworker/u4:2 exe=(null)>
> > > > [I'm going to comment up here instead of in the code because it is a
> > > > bit easier for everyone to see what the actual impact might be on the
> > > > records.]
> > > >
> > > > Steve wants subject info in this case, okay, but let's try to trim out
> > > > some of the fields which simply don't make sense in this record; I'm
> > > > thinking of fields that are unset/empty in the kernel case and are
> > > > duplicates of other records in the userspace/syscall case.  I think
> > > > that means we can drop "tty", "ses", "comm", and "exe" ... yes?
> > >
> > > From the ghak28 discussion, this list and order was selected due to
> > > Steve's preference for the "kernel" record convention, so deviating from
> > > this will create yet a new field list.  I'll defer to Steve on this.  It
> > > also has to do with the searchability of fields if they are missing.
> > >
> > > I do agree that some fields will be superfluous in the kernel case.
> > > The most important field would be "subj", but then "pid" and "comm", I
> > > would think.  Based on this contents of the "subj" field, I'd think that
> > > "uid", "auid", "tty", "ses" and "exe" are not needed.
> >
> > We can't be adding deleting fields based on how its triggered. If they are
> > unset, that is fine. The main issue is they have to behave the same.
>
> I don't think the intent was to have fields swing in and out depending
> on trigger.  The idea is to potentially permanently not include them in
> this record type only.  The justification is that where they aren't
> needed for the kernel trigger situation it made sense to delete them
> because if it is a user context event it will be accompanied by a
> syscall record that already has that information and there would be no
> sense in duplicating it.

Yes, exactly.

-- 
paul moore
www.paul-moore.com
