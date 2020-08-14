Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF2244D54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHNRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:09:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42626C061384;
        Fri, 14 Aug 2020 10:09:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q9so8113638oth.5;
        Fri, 14 Aug 2020 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1aHtJ9vdI7XsBFSeGUclDrmtnit+8Tv4m9FIDwpY8w=;
        b=EEE/wkEhUVKEVEo2ubnKqQhUG1KWE91RGYn0vFOoEiRYdusd0FCJJSy1FispWE4NS5
         7Nt8JRT2zpYpBT7yyTE1eI6buiRSvXte4aOsywDcAOQqePVYU9drNZLtj14MhnMXPa1a
         jWN08yf043N3K4AyzlahauPASRe+oMeY8H88KPPqCY5qBQWXSKmCQkSiAdcY0+I9QL+q
         R/5iDC1WuZNyhFGqsTwU2uzIDOnq6H/ts2GpPQ3bnxBLOui+8EKccdTTkTQ0Y2xalyTl
         gIZa0ppIkxMBul/DzveJSy9ozfl7q2qNKSy/KZuWcqQo3EDpI5ayOen1/j9IOfMTIFuT
         F+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1aHtJ9vdI7XsBFSeGUclDrmtnit+8Tv4m9FIDwpY8w=;
        b=gItQ6efHy+UIKlh/V18O2gEP8e7XlGOC56fxLFV53MMBuygcsKtxCzXS3yk3QsJQCY
         R7LsiHXwS9/vzxhbhamA4aJFQiMI1H6N9hET8Ixe5Bx3USLPB7rrSIoffYK+ZZFHnMZv
         cWlZ1hXu16QaihYN4XbyT1ipHhA0xggtUfV8rCFR91fGBOHtaKIK1NyNchpfa6esIQp9
         oy3dISxAONO7L8Bu3S50TEAhMAjbayMuqWoRZ2fkmaiNu796ZY3p70izZRFb36B3vATf
         c0wsOyEZIpMble23Ax8X6RTGoAz0a13zhu6n0XRqZMLcKLz3sVPnimNtMt8ZsxS2vqFL
         QGDw==
X-Gm-Message-State: AOAM533bXguUM+fCelFmwSPGT1/fbGLAfik6tWqmo86EItsx3WjPwNPB
        phZgl7sRqNmdZ9QZ0VbMtTecgQfkrcuuMWmYAr8=
X-Google-Smtp-Source: ABdhPJypuyaZkUOy5B4CnU0Uk/W2NrcQ09BRptLZP/S/aqoxmapq7yOL+hT2ycf9Up36tl+OVKVakZM3VjVg8IJEg74=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr2474427otr.89.1597424979144;
 Fri, 14 Aug 2020 10:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200813144914.737306-1-tweek@google.com> <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
 <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
 <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com> <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
In-Reply-To: <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 14 Aug 2020 13:08:04 -0400
Message-ID: <CAEjxPJ67G24T1a5WitmMqL4RUpjOgQFwpQ8unO1-OXSS=35V4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 1:07 PM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/14/20 6:51 PM, Stephen Smalley wrote:
> > On Fri, Aug 14, 2020 at 9:05 AM Thi=C3=A9baud Weksteen <tweek@google.co=
m> wrote:
> >> On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>> An explanation here of how one might go about decoding audited and
> >>> tclass would be helpful to users (even better would be a script to do=
 it
> >>> for them).  Again, I know how to do that but not everyone using
> >>> perf/ftrace will.
> >> What about something along those lines:
> >>
> >> The tclass value can be mapped to a class by searching
> >> security/selinux/flask.h. The audited value is a bit field of the
> >> permissions described in security/selinux/av_permissions.h for the
> >> corresponding class.
> > Sure, I guess that works.  Would be nice if we just included the class
> > and permission name(s) in the event itself but I guess you viewed that
> > as too heavyweight?
>
> The class name is added in part 2. Im not sure how a proper format for pe=
rmission
> would look like in trace terms. It is a list, right?

Yes.  See avc_audit_pre_callback() for example code to log the permission n=
ames.
