Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945543010A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbhAVXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbhAVXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:08:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:08:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e22so14619909iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOAiIQQzWIRBqigP7SxGzShtxZ6luIw9S5UDFVDRsSw=;
        b=dWCFJsjxy6k11dCsqCHOJQMfd9qqttOMlV6Nu0sLjgFODHubEU5d/YvuGLzZLp2PYO
         zWddmTeCFAWa7ii0nfhAvrmKlaKo1ASUn8wPNFy6ox6IC/i8nMXO2LLUjkRLM2C+JcgX
         XEr2T0QR6rAO2Qp6yU7w6munBk6DrMI1BXpozZNYsHYPumR+NZ9srlvqoMBBF9llka80
         yKTm8kyd+svHyopNps7fLa8xTREX4ewy9QIlxpPcqTEVGCcqZ7PjpbFrw5EPxXyz5QkP
         23odO1Fa0zbMZWXp7EyZbFrvUFVVnT3RBjf7Ildd7R1SY7Fy/z02WMsoWWIZkYw/981D
         kpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOAiIQQzWIRBqigP7SxGzShtxZ6luIw9S5UDFVDRsSw=;
        b=IOyNdz/UQeXtvIVlNOCn0Wxjg0EnikqqoU3yGpptUNKBucETYlGVIZq39M9xU/+7AE
         a9JvCVI7bKFBTv/bC82+CYPUueAbjhuBE+jx1QDOfhH94ZfMhLeE3gERlR+9gUM9g8fD
         PlsSo/+BQDv5I4cQsqUSbweYJSAQbf6TH4ySZwuhrmE7umvj9FP0v67fVIEC9LtTDc/C
         rdGi5dBNIJlKrSltXVARGDcFhMoP5vS4xcvS0oQflRUaJ0r4w4Thrj5Q32Io6OuJOiVU
         amS3xebt54IrNU6OU/hWrKdPT4+nkkKEkk57svplFMmk2L1ld7ESL9ehiiDDhILCQL5y
         tbHw==
X-Gm-Message-State: AOAM531ilDyWOgc9NYq+UA8uigN9mO9pqJ0ZnFS30K5j+8WDt5IWFxJM
        +PwpPrJ5oWBDPgvT09kMQIw3OgpbZ7ZFDQwaCmQWiimMPF6ujg==
X-Google-Smtp-Source: ABdhPJyTBeNYaYS1+3pgEaMVB7fK2UTmKkBm5rNlnPQnVQ8a65Vrei22IkmOsdJPC5TS52EOBvTUYGRq6Q/AFNPh4Ag=
X-Received: by 2002:a05:6638:1344:: with SMTP id u4mr4176943jad.86.1611356895177;
 Fri, 22 Jan 2021 15:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
 <20210121223355.59780-4-paul.gortmaker@windriver.com> <CAAH8bW8GYYsHy7c8KD3EL+a1mR+wCrj7WFS+Gp5=4CJbz7GpgA@mail.gmail.com>
 <20210122044357.GS16838@windriver.com>
In-Reply-To: <20210122044357.GS16838@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 22 Jan 2021 15:08:04 -0800
Message-ID: <CAAH8bW9UZZwnyXu5vFbxr4OpU8s-+61NzS0yg6gMGmH9Zty_mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 8:44 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> [Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()] On 21/01/2021 (Thu 16:29) Yury Norov wrote:
>
> > On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> > >
> > > While this is done for all bitmaps, the original use case in mind was
> > > for CPU masks and cpulist_parse().  Credit to Yury who suggested to
> > > push it down from CPU subsys to bitmap - it simplified things a lot.
> >
> > Can you convert your credit to Suggested-by or Reviewed-by? :)
>
> Sure, of course.
>
> [...]
>
> > > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > > index a1010646fbe5..d498ea9d526b 100644
> > > --- a/lib/bitmap.c
> > > +++ b/lib/bitmap.c
> > > @@ -571,7 +571,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
> > >         return end;
> > >  }
> > >
> > > -static const char *bitmap_parse_region(const char *str, struct region *r)
> > > +static const char *bitmap_parse_region(const char *str, struct region *r, int nmaskbits)
> > >  {
> >
> > in bitmap_parselist() you can store nmaskbits in the struct region, and avoid
> > passing nmaskbits as a parameter.
>
> OK.   FWIW, I considered that and went with the param so as to not open
> the door to someone possibly using an uninitialized struct value later.
>
> > >         str = bitmap_getnum(str, &r->start);
> > >         if (IS_ERR(str))
> > > @@ -583,9 +583,15 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > >         if (*str != '-')
> > >                 return ERR_PTR(-EINVAL);
> > >
> > > -       str = bitmap_getnum(str + 1, &r->end);
> > > -       if (IS_ERR(str))
> > > -               return str;
> > > +       str++;
> > > +       if (*str == 'N') {
> > > +               r->end = nmaskbits - 1;
> > > +               str++;
> > > +       } else {
> > > +               str = bitmap_getnum(str, &r->end);
> > > +               if (IS_ERR(str))
> > > +                       return str;
> > > +       }
> >
> > Indeed it's much simpler. But I don't like that you increase the nesting level.
> > Can you keep bitmap_parse_region() a single-tab style function?
>
> Rather a strict coding style, but we can replace with:
>
>        if (*str == 'N') {
>                r->end = nmaskbits - 1;
>                str++;
>        } else {
>                str = bitmap_getnum(str, &r->end);
>        }
>
>        if (IS_ERR(str))
>                return str;
>
> Is that what you were after?
>
> > What about group size? Are you going to support N there, like "0-N:5/N"?
>
> No.  I would think that the group size has to be less than 1/2 of
> the nmaskbits or you get the rather pointless case of just one group.
> Plus conflating "end of range" with "group size" just adds confusion.
> So it is currently not legal:
>
> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/4 > cpuset.cpus
> root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 4-5,8-9,12-13
> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/N > cpuset.cpus
> /bin/echo: write error: Invalid argument
> root@hackbox:/sys/fs/cgroup/cpuset/foo#
>
> > What about "N-N"? Is it legal? Maybe hide new logic in bitmap_getnum()?
>
> The "N-N" is also not supported/legal.  The allowed use is listed as
> being for the end of a range only.  The code enforces this by ensuring
> the char previous is a '-'  ; hence a leading N is invalid:
>
> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N > cpuset.cpus
> /bin/echo: write error: Invalid argument
> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 0-N > cpuset.cpus
> root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 0-15
> root@hackbox:/sys/fs/cgroup/cpuset/foo#
>
> I think "use for end of range only" makes sense in the mathematical
> sense most of us have seen during school:  {0, 1, 2, ...  N-1, N} as
> used in the end point of a range of numbers.  I could make the "only"
> part more explicit and concrete in the comments/docs if desired.
>
> I'm not sure I see the value in complicating things in order to add
> or extend support to non-intuitive use cases beyond that - to me that
> seems to just make things more confusing for end users.  But again
> if you've something in mind that I'm simply missing, then by all
> means please elaborate.

OK, let me share my view on this. As you said in the patch description,
N is substitution to the number of the last CPU, in your example sort of
#define N (15).

So, when I do echo N-N > cpuset.cpus, I want it to work as if I do
echo 15-15 > cpuset.cpus. Why? Because in my terribly huge config
I just want to do s/15/N.

Now let's check how it works .

root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 15-15>cpuset.cpus
root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
15
root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 0-0>cpuset.cpus
root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
0

OK, works as expected. And what about N?

> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 0-N > cpuset.cpus
> root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 0-15

OK, looks good.

> root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N > cpuset.cpus
> /bin/echo: write error: Invalid argument

Why? If N is 15, it should work exactly as 15-15, but it doesn't...
This is the source
of confusion and unneeded refactoring of user scripts. (In practice of course
nobody will use "N" because it's broken.) Documentation says nothing about
this limitation, and this is a real example of "complicating things".

You can do better - parse "N" in bitmap_getnum() and avoid all that confusion.

Same logic regarding all/none: all is the equivalent of 0-15, none is something
like ", ,". Now let's try with "0-15,0-3, ," (imagine it's a result of
merging configs).

root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 0-15,0-3, , >cpuset.cpus
root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
0-15

OK, works. But if I do 's/0-15/all' and 's/ /none', things get broken. This
again brings a special case where it can be avoided - just  parse all/none
at the beginning of bitmap_parse_region().

After reading the description, one can think that you introduce simple and
convenient extensions to existing interface. In fact this is a new interface
which is mostly incompatible with the existing one.

> > I would also like to see tests covering new functionality. As a user of "N",
> > I want to be 100% sure that this "N" is a full equivalent of NR_CPUS, including
> > error codes that the parser returns. Otherwise it will be hard to maintain the
> > transition.
>
> That is a reasonable request.  I will look into adding "N" based type
> tests to the existing bitmap test cases in a separate commit.
>
> Thanks,
> Paul.
> --
>
> >
> > >         if (end_of_region(*str))
> > >                 goto no_pattern;
> > > @@ -628,6 +634,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > >   * Syntax: range:used_size/group_size
> > >   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> > >   * Optionally the self-descriptive "all" or "none" can be used.
> > > + * The value 'N' can be used as the end of a range to indicate the maximum
> > > + * allowed value; i.e (nmaskbits - 1).
> > >   *
> > >   * Returns: 0 on success, -errno on invalid input strings. Error values:
> > >   *
> > > @@ -656,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> > >                 if (buf == NULL)
> > >                         return 0;
> > >
> > > -               buf = bitmap_parse_region(buf, &r);
> > > +               buf = bitmap_parse_region(buf, &r, nmaskbits);
> > >                 if (IS_ERR(buf))
> > >                         return PTR_ERR(buf);
> > >
> > > --
> > > 2.17.1
> > >
