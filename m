Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99822A13C5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgJaGMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJaGMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:12:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8769C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 23:12:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so10637128lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 23:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lw9IBPwD6UA8+sXIszLv+xk3rxKusVwEy/lP2/Hfj6M=;
        b=NI/7yTyrTgRXkf+rfoKJmLTFr8+qqskXY7A5OeZ07Hrb3porpvrtNmDrBddMfVvVGQ
         ZLIVlT9PglUbYx0mERdkZasymPAYeHarAofsDw/TcbJ3WdlF4hqtEnOfr7UVJr5eHI6y
         NaS1uKKQgHOpcPTXWuDIaZVkiU8dKUcXFIt8m3CGflenhUdJ7Q8id6C1Vzvhp+nQD2nv
         wM5XGGpvVig6zRKTkPqLtF3UUP0mdreuISYskHJlEdUT+dqHNZBwJ61mFW0UDT5N0Qaj
         1t6zFeMEfMlhJXWok2zMH5onYwA52bMthALVG+PvrGIyofKxwS+pDTWw6ToFbo6OnQnO
         9w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lw9IBPwD6UA8+sXIszLv+xk3rxKusVwEy/lP2/Hfj6M=;
        b=M0EeqsAiNeAhczBAB/LsvgYphwf0k8Lx7aQ7F1u/yAU1+noLLB4s3QKLfssR6nJNA7
         vfRiL2vaOor7hvBQbqxASY7qB66+6XguviQUX8fGG+NP3KbNrqj6g6HRZNDl/T8/e/Kr
         DpHhyfcdTYeiRvFVMQFckwFyHPegquRO12y5fa56BrKDBcKcBlrJmHFfd2IsbmOHOOAL
         bcFx8NzIwNEGRXqU+BI8O2Qzn3ftTHW2+axG5i3ri7phuUNR55Am7vBgwpAHp9bAqU+k
         lIP42UdVeXdNZ9UMyFo2kdcGpjRme1NVM4rQi0/U2ZVQPfPx4wLF8t6nja+MSIhAMwP/
         Oo3w==
X-Gm-Message-State: AOAM531S9NxTMtWfO5MS5/vPlGxLW60wft5sQ65R08rErVCaR8D81hCP
        IdcTkmaFeIe2tZTs+G2z6sPzF/JO3AUs6AEW5bY=
X-Google-Smtp-Source: ABdhPJzW2Q8JjYSKdODkKmS/GO/NUd6i2BWCpQ4SmJfuWS6J1d9UsovK814D3b3j3jE853xR62fUOhoScazfJAlHM7c=
X-Received: by 2002:a19:83c9:: with SMTP id f192mr2105673lfd.148.1604124742121;
 Fri, 30 Oct 2020 23:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030090704.40533-1-dwaipayanray1@gmail.com>
 <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
 <alpine.DEB.2.21.2010301255460.16621@felia> <8b9beccf81735f2e042447026a1043f8d21c2566.camel@perches.com>
In-Reply-To: <8b9beccf81735f2e042447026a1043f8d21c2566.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 31 Oct 2020 11:41:51 +0530
Message-ID: <CABJPP5Ca8SNGmoE7GVc0OBotFhA6mLuX46QQETiVcQwTKHRosA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: improve handling of email comments
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-10-30 at 12:58 +0100, Lukas Bulwahn wrote:
> >
> > On Fri, 30 Oct 2020, Joe Perches wrote:
> >
> > > On Fri, 2020-10-30 at 14:37 +0530, Dwaipayan Ray wrote:
> > > > checkpatch has limited support for parsing email comments. It only
> > > > support single name comments or single after address comments.
> > > > Whereas, RFC 5322 specifies that comments can be inserted in
> > > > between any tokens of the email fields.
> > > >
> > > > Improve comment parsing mechanism in checkpatch.
> > > >
> > > > What is handled now:
> > > >
> > > > - Multiple name/address comments
> > > > - Comments anywhere in between name/address
> > > > - Nested comments like (John (Doe))
> > > >
> > > > A brief analysis of checkpatch output on v5.0..v5.7 showed that
> > > > after these modifications, the number of BAD_SIGN_OFF warnings
> > > > came down from 2944 to 1424, and FROM_SIGN_OFF_MISMATCH came
> > > > down from 2366 to 2330.
> > > >
> > > > So, a total of 1556 false positives were resolved in total.
> > >
> > > A mere reduction in messages emitted isn't necessarily good.
> > >
> >
> > Agree. That is why I also went through the list of those warnings.
> >
> > I could not spot any obvious true positive among the reduced ones.
> >
> >
> > > Please send me privately a complete list of these nominally
> > > false positive messages that are no longer emitted.
> > >
> > > I believe one of the relatively common incorrect messages is
> > > for the cc: <stable@vger.kernel.org> where a version number is
> > > continued on the same line after a #.
> > >
> > > CC: stable@vger.kernel.org # for versions x.y.z and above
> > >
> >
> > That was one,
>
> It's not just one, it's ~90% of the list that Dwaipayan sent me.
>
> $ wc -l mismatches
> 831 mismatches
>
> $ grep -v -i stable mismatches | wc -l
> 98
>
> > another common pattern was just quotes put inconsistently at
> > different places.
>
> Yes, there are some defects there.
> But there are also now false negatives.
>
> For instance, this is not appropriate to ignore:
>
> WARNING:BAD_SIGN_OFF: email address 'jacek.anaszewski@gmail.com, linux-le=
ds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com' might be =
better as 'jacek.anaszewski@gmail.com,linux-leds@vger.kernel.org, linux-ker=
nel@vger.kernel.org, dmurphy@ti.com'
>
> From the file that Dwaipayan sent me, all the rest not including the
> stable variants, which IMO should be handled separately, are below.
>
> Of these 98 in total, 60+% are unicode which IMO should always be quoted
> and most are doubled with BAD_SIGN_OFF doubling FROM_SIGN_OFF_MISMATCH
> (and I don't quite understand why it's "From:/" then "Signed-off-by:"
>
> $ grep -v -i stable dwai | sort | uniq -c | sort -rn
>      31 WARNING:BAD_SIGN_OFF: email address '=E5=91=A8=E7=90=B0=E6=9D=B0 =
(Zhou Yanjie) <zhouyanjie@wanyeetech.com>' might be better as '"=E5=91=A8=
=E7=90=B0=E6=9D=B0"(Zhou Yanjie) <zhouyanjie@wanyeetech.com>'
>      30 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name m=
ismatch: 'From: "=E5=91=A8=E7=90=B0=E6=9D=B0"(Zhou Yanjie) <zhouyanjie@wany=
eetech.com>' !=3D 'Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=
 <zhouyanjie@wanyeetech.com>'
>
> These 29 in total would be better stripping any bits in parentheses from
> the name portion only when _not_ inside quotes.
>
>      20 WARNING:BAD_SIGN_OFF: email address 'Thomas Hellstr=C3=B6m (VMwar=
e) <thomas_os@shipmail.org>' might be better as '"Thomas Hellstr=C3=B6m"(VM=
ware) <thomas_os@shipmail.org>'
>       5 WARNING:BAD_SIGN_OFF: email address 'H. Peter Anvin (Intel) <hpa@=
zytor.com>' might be better as '"H. Peter Anvin"(Intel) <hpa@zytor.com>'
>
>
>       1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name m=
ismatch: 'From: "Thomas Hellstr=C3=B6m"(VMware) <thomas_os@shipmail.org>' !=
=3D 'Signed-off-by: Thomas Hellstr=C3=B6m (VMware) <thomas_os@shipmail.org>=
'
>
>       1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name m=
ismatch: 'From: "Srivatsa S. Bhat"(VMware) <srivatsa@csail.mit.edu>' !=3D '=
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>'
>       1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name m=
ismatch: 'From: JanNieuwenhuizen(janneke) <janneke@gnu.org>' !=3D 'Signed-o=
ff-by: Jan Nieuwenhuizen <janneke@gnu.org>'
>       1 WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name m=
ismatch: 'From: "Fr=C3=A9d=C3=A9ric Pierret"(fepitre) <frederic.pierret@qub=
es-os.org>' !=3D 'Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <fred=
eric.pierret@qubes-os.org>'
>
> So these 8 others are ones where quotes are either oddly placed
> or perhaps should always exist and the comment in parentheses
> is suggested poorly.  7 of these should be fixed and one should
> still be reported.
>
>       1 WARNING:BAD_SIGN_OFF: email address '"Thomas Hellstr=C3=B6m (VMwa=
re)" <thomas_os@shipmail.org>' might be better as '"Thomas Hellstr=C3=B6m"(=
VMware) <thomas_os@shipmail.org>'
>       1 WARNING:BAD_SIGN_OFF: email address 'Srivatsa S. Bhat (VMware) <s=
rivatsa@csail.mit.edu>' might be better as '"Srivatsa S. Bhat"(VMware) <sri=
vatsa@csail.mit.edu>'
>       1 WARNING:BAD_SIGN_OFF: email address '"Rantala, Tommi T. (Nokia - =
FI/Espoo)" <tommi.t.rantala@nokia.com>' might be better as '"Rantala, Tommi=
 T."(Nokia - FI/Espoo) <tommi.t.rantala@nokia.com>'
>       1 WARNING:BAD_SIGN_OFF: email address '"Kai M=C3=A4kisara (Kolumbus=
)" <kai.makisara@kolumbus.fi>' might be better as '"Kai M=C3=A4kisara"(Kolu=
mbus) <kai.makisara@kolumbus.fi>'
>       1 WARNING:BAD_SIGN_OFF: email address 'jacek.anaszewski@gmail.com, =
linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, dmurphy@ti.com' m=
ight be better as 'jacek.anaszewski@gmail.com,linux-leds@vger.kernel.org, l=
inux-kernel@vger.kernel.org, dmurphy@ti.com'
>       1 WARNING:BAD_SIGN_OFF: email address 'Fr=C3=A9d=C3=A9ric Pierret (=
fepitre) <frederic.pierret@qubes-os.org>' might be better as '"Fr=C3=A9d=C3=
=A9ric Pierret"(fepitre) <frederic.pierret@qubes-os.org>'
>       1 WARNING:BAD_SIGN_OFF: email address 'David.Laight@aculab.com (big=
 endian system concerns)' might be better as 'David.Laight@aculab.com(big e=
ndian system concerns)'
>       1 WARNING:BAD_SIGN_OFF: email address 'apenwarr@foxnet.net (Avery P=
ennarun)' might be better as 'apenwarr@foxnet.net(Avery Pennarun)'
>
>
Hi,
Thanks for the review.

So I get that the parentheses from within quotes should not
be extracted. I will do that.

But for the names which should be quoted, I think the errors appeared
because of a parsing bug. There is no separate mechanism
to distinguish quoted and unquoted names currently.

Names which have must quote characters without any comments are
not warned about right now:

D. Ray <dwaipayanray1@gmail.com> doesn't throw any warning, while
D. Ray (Dwai) <dwaipayanray1@gmail.com> does.

Do you think this should be dealt separately from this patch?
Perhaps as another warning?

Thanks,
Dwaipayan.
