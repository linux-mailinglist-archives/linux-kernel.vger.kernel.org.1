Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D581CA107
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEHCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 22:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHCqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:46:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F63C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 19:46:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so90928ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQ2gUFI81zeg1a5zdsIjwtK5Rb6dwen8h/jBk+vpiRo=;
        b=thmctl2tnfb55tMvoUj4iqwSzlune1NNCamMl9ihr5NChIswxK9DOOcIOxxSDoTfDv
         pwOqrWSujzaKyF9VwYz2KvkJ1om0R3EE0Mr2QCspF52m4O5cs45e0hBylb+bcSvxC6J/
         Cu3rA/W3BHpFP9CKeGQpqpwPPo98TSVjGZUFOnfZihvEgNfGRj+RqisIQt4LZo5tq1bl
         9Q3rI17fV3uLkPUJXInzWgdg2eCuRy/B7GrxtA5Bee1sA8nsCecGy2EEb0i5BAp1h3Vn
         lIshQOFqmEEgrl26r141mvYf1O5X/ZMZuPgE5APVim0l78GD8uR4OTRNV6K+g9+vWsRj
         Q7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQ2gUFI81zeg1a5zdsIjwtK5Rb6dwen8h/jBk+vpiRo=;
        b=NBj98ltCbCEW4RCqipr5gB/+6O1B0exnngq8aKO8C/LG9fjCLGinDqTO6PAkfd0nVb
         biyYvgnTR3zYjISAuu54JbUmkosVkHJjuCKSzWpe9gKGtT/Hd6WnYH7uwm5eoWkD0dd7
         S5O1sxlvypAhcjb/jB0SNbm7w3uTblvv6iEc+zyjNHf5A0QFHYeoltxkUmGsTeYax3Nx
         zdZp1b7g8xNKoM4MIQXt0Q3IO9hOPC3iu2DXtjyBWQbYnzhQ4HeJ/aodt9eKm3drCpYT
         GD3pvE0mcvoQoTmmdL12P5whUfIzVdXFwigBcdb498ou07l8qy5Na8XHu1yICmJWDCsH
         1Tqg==
X-Gm-Message-State: AGi0PuYJTo4v/lXvQJy1qNvBq3W7fPcEkkf4h6v1rpVl0QU3es7obgNL
        tWL2DHnMz5PEP/8Z23g5bZbPqFw4lnTsWtewOaZg
X-Google-Smtp-Source: APiQypKBWRGQwD/uc5JAkuFDrcSqR2UWelW7Dr/hOdDJa+TxQZq0gB42kyMFgxPvFYbL+Yt1dZQwE7YU8IFhMIsZExc=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr92903ejb.271.1588905967163;
 Thu, 07 May 2020 19:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587500467.git.rgb@redhat.com> <3348737.k9gCtgYObn@x2>
 <20200429213247.6ewxqf66i2apgyuz@madcap2.tricolour.ca> <3250272.v6NOfJhyum@x2>
 <20200506224233.najv6ltb5gzcicqb@madcap2.tricolour.ca>
In-Reply-To: <20200506224233.najv6ltb5gzcicqb@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 May 2020 22:45:56 -0400
Message-ID: <CAHC9VhQyzqw_c8b4v1eby59hP_UM8tn=4yUBoMv9Td6UYdEQsw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 6:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-05-06 17:26, Steve Grubb wrote:
> > On Wednesday, April 29, 2020 5:32:47 PM EDT Richard Guy Briggs wrote:
> > > On 2020-04-29 14:47, Steve Grubb wrote:
> > > > On Wednesday, April 29, 2020 10:31:46 AM EDT Richard Guy Briggs wro=
te:
> > > > > On 2020-04-28 18:25, Paul Moore wrote:
> > > > > > On Wed, Apr 22, 2020 at 5:40 PM Richard Guy Briggs <rgb@redhat.=
com>
> > > >
> > > > wrote:
> > > > > > > Some table unregister actions seem to be initiated by the ker=
nel to
> > > > > > > garbage collect unused tables that are not initiated by any
> > > > > > > userspace
> > > > > > > actions.  It was found to be necessary to add the subject
> > > > > > > credentials
> > > > > > > to  cover this case to reveal the source of these actions.  A
> > > > > > > sample
> > > > > > > record:
> > > > > > > type=3DNETFILTER_CFG msg=3Daudit(2020-03-11 21:25:21.491:269)=
 :
> > > > > > > table=3Dnat
> > > > > > > family=3Dbridge entries=3D0 op=3Dunregister pid=3D153 uid=3Dr=
oot auid=3Dunset
> > > > > > > tty=3D(none) ses=3Dunset subj=3Dsystem_u:system_r:kernel_t:s0
> > > > > > > comm=3Dkworker/u4:2 exe=3D(null)>
> > > > > >
> > > > > > [I'm going to comment up here instead of in the code because it=
 is a
> > > > > > bit easier for everyone to see what the actual impact might be =
on the
> > > > > > records.]
> > > > > >
> > > > > > Steve wants subject info in this case, okay, but let's try to t=
rim
> > > > > > out
> > > > > > some of the fields which simply don't make sense in this record=
; I'm
> > > > > > thinking of fields that are unset/empty in the kernel case and =
are
> > > > > > duplicates of other records in the userspace/syscall case.  I t=
hink
> > > > > > that means we can drop "tty", "ses", "comm", and "exe" ... yes?
> > > > >
> > > > > From the ghak28 discussion, this list and order was selected due =
to
> > > > > Steve's preference for the "kernel" record convention, so deviati=
ng
> > > > > from this will create yet a new field list.  I'll defer to Steve =
on
> > > > > this. It also has to do with the searchability of fields if they =
are
> > > > > missing.
> > > > >
> > > > > I do agree that some fields will be superfluous in the kernel cas=
e.
> > > > > The most important field would be "subj", but then "pid" and "com=
m", I
> > > > > would think.  Based on this contents of the "subj" field, I'd thi=
nk
> > > > > that "uid", "auid", "tty", "ses" and "exe" are not needed.
> > > >
> > > > We can't be adding deleting fields based on how its triggered. If t=
hey
> > > > are unset, that is fine. The main issue is they have to behave the =
same.
> > >
> > > I don't think the intent was to have fields swing in and out dependin=
g
> > > on trigger.  The idea is to potentially permanently not include them =
in
> > > this record type only.  The justification is that where they aren't
> > > needed for the kernel trigger situation it made sense to delete them
> > > because if it is a user context event it will be accompanied by a
> > > syscall record that already has that information and there would be n=
o
> > > sense in duplicating it.
> >
> > We should not be adding syscall records to anything that does not resul=
t from
> > a syscall rule triggering the event. Its very wasteful. More wasteful t=
han
> > just adding the necessary fields.
>
> So what you are saying is you want all the fields that are being
> proposed to be added to this record?
>
> If the records are all from one event, they all should all have the same
> timestamp/serial number so that the records are kept together and not
> mistaken for multiple events.  One reason for having information in
> seperate records is to be able to filter them either in kernel or in
> userspace if you don't need certain records.

Yes, I'm opposed to duplicating fields across records in a single
event.  If there are cases where we have a standalone record, such as
with "unregister", then there is an argument to be made about
duplicating some fields that are important in the standalone
unregister case.  However, this is *only* for those fields which make
sense in the standalone kernel unregister event; if the field isn't
useful in this unregister corner case *and* it is duplicated in
another record type which normally accompanies this record in an event
there is no reason it needs to be in this record.

> > I also wished we had a coding specification that put this in writing so=
 that
> > every event is not a committee decision. That anyone can look at the do=
cument
> > and Do The Right Thing =E2=84=A2.
> >
> > If I add a section to Writing-Good-Events outlining the expected orderi=
ng of
> > fields, would that be enough that we do not have long discussions about=
 event
> > format? I'm thinking this would also help new people that want to contr=
ibute.

To be clear, we are not changing any existing record formats; they are
part of the kernel/userspace ABI and changing them would break the
ABI.

In a perfect world both the audit kernel and userspace would have been
designed, implemented, and documented better.  Unfortunately it wasn't
and we have to live with what we have.

--=20
paul moore
www.paul-moore.com
