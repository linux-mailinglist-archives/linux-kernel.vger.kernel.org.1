Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41232FFC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbhAVFsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhAVFsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:48:18 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:47:38 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p185so4391899ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wT3ZCVbUtgRKCdJp5fWUlA+2LlDodbkjPj1r3Ub8Tt8=;
        b=KNVCmwVmBd6U/krAk7DLJHyh43VxiGM6Cto0kgagDKEL3GSgOsJmiRYKhwX6LnHceV
         s5/BSe02MFrEw8+YXwmbrSMRTVAgfEhuAiJvQhgtFtWbWtNJrtE5CFIh9nddBf26G19o
         3y0lQSSGwVSGMsgUAWZOqF+EannTFDpiTciInWIDAWSFE4hy4Y3l8sjcYAMVIU3PB2nb
         F/ihdPdMSNr+2qx3xBiRyg4q6/V2SWGCocagGWOjCLwHpBnHjPc9lMqWUSBIwPQpuDLG
         4QgD/4byoa1q7jFsXIzeo7f9TlgHEsULuCGIj9xP8kYobEEyArAaO29VhZPatT+Rz3o6
         zm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wT3ZCVbUtgRKCdJp5fWUlA+2LlDodbkjPj1r3Ub8Tt8=;
        b=j6Zr/YTloR4KHu/kIzE6ogGFcl17V7L0Oph70V/A+DfOC639rIwTuJ8npPcUGecEs4
         PG+/ztp8gJgLLpPdueYwHvMuuEVJC2krKMKPNbgcodKtLiwuHBzOhdxmX8d4JX8m1Sdn
         Q3XNBCwkc1ImV+SU60lDTjb2ogZ4vFMuNpeel1lCTXJ2zIr85S3DvQXjUPcH9KXAMBxZ
         tQFN1G2xEFmGEDemZ6rJ4ekcFTklrIS8pr7Z3GWLP7jwvK/3jguozJ9VqeF3iqR7WFXQ
         K5558QeyuHgYlA0TGnuhEqzEmNXYbhS2Uu/GqNLweG0OtScaESuG7a6/C6eV3TvSOLbX
         hTMA==
X-Gm-Message-State: AOAM533mpkhpP8OAzfYmyeiTG9oCoRlN/P7dY1GvZISVT5kn4Sfhl39K
        7z6tOMuWknzeAHfXrjkXV6aMJy3n8UiPcVhg+u0=
X-Google-Smtp-Source: ABdhPJy3FsG+5fvFYp+nAh8IoLyHfFrV/1e0ZZBkx5zVTQ1cHYOf8wn9JVtjBPV7DHPXyjHhKQvrdNW71WgEPo3DkiM=
X-Received: by 2002:a25:538a:: with SMTP id h132mr3995154ybb.247.1611294457869;
 Thu, 21 Jan 2021 21:47:37 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
 <CAKXUXMwcNqd61O2t23zyMSBrCNuHi98uym1LLZQZOZO5NOR3Jg@mail.gmail.com>
In-Reply-To: <CAKXUXMwcNqd61O2t23zyMSBrCNuHi98uym1LLZQZOZO5NOR3Jg@mail.gmail.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 22 Jan 2021 13:47:11 +0800
Message-ID: <CAD-N9QWsu8d_ubihGD0B1xf5YWv=WTw6iy4uNhV-73jA9xYbjw@mail.gmail.com>
Subject: Re: "possible deadlock in console_lock_spinning_enable" and "possible
 deadlock in console_unlock" should be duplicate crash behaviors
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 8:49 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wro=
te:
>
> On Thu, Jan 21, 2021 at 6:37 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudonglianga=
bcd@gmail.com> wrote:
> >
> > Dear kernel developers,
> >
> > I found that on the syzbot dashboard, =E2=80=9Cpossible deadlock in
> > console_lock_spinning_enable=E2=80=9D[1] and "possible deadlock in
> > console_unlock"[2] should share the same root cause.
> >
> > The reasons for the above statement:
> > 1) the stack trace is the same, and this title difference is due to
> > the inline property of "console_lock_spinning_enable";
> > 2) their PoCs are the same as each other;
> >
> > If you can have any issues with this statement or our information is
> > useful to you, please let us know. Thanks very much.
> >
> > [1] =E2=80=9Cpossible deadlock in console_lock_spinning_enable=E2=80=9D=
 -
> > https://syzkaller.appspot.com/bug?id=3D2820deb61d92a8d7ab17a56ced58e963=
e65d76d0
> > [2] =E2=80=9Cpossible deadlock in console_unlock=E2=80=9D -
> > https://syzkaller.appspot.com/bug?id=3D39ea6caa479af471183997376dc7e90b=
c7d64a6a
> >
> >
>
> Dongliang, what is the purpose of this activity?

Lukas,

We are conducting some research on the crash deduplication (or
identifying unique bugs) of kernel crash reports. We would like to
share some results from our research to facilitate the bugfix in the
syzbot dashboard.

>
> Why do inform the kernel maintainers that two issues share the root cause=
?
>
> How does this activity contribute to fixing the bugs? Why does it
> become easier to fix the issue/create a patch with the information you
> provide?

I do this for three reasons:

(1) I think the reports sharing the same root cause may expedite the
patching processing and help generate more complete patches. After
patching bugs in one case, we can close the other cases quicker.
Without these reports, one developer might be misled to develop an
incomplete patch due to a lack of understanding of the underlying bug
[1].
(2) I think it might help maintainers to better assess the severity of
the bug and thus could prioritize their effort.
(3) Multiple reports might better help maintainers diagnose the bug's
root cause.

[1]  https://groups.google.com/g/syzkaller-bugs/c/9u_hEFvNbLw/m/CO9bfF8zCQA=
J

> (Honestly, I do not see how it does. I believe if anyone becomes
> active and fixes the issue due to either one of the two reports, the
> one report would be closed by the reported-by tag and the other report
> would simply disappear after time because it could never be reproduced
> and hence, syzbot would close it.)
>
> Would it not be more reasonable to fix issues rather than identifying
> duplicates in the automatically filled and managed database?

Yes, fixing issues or bugs is the ultimate goal. However, crash
deduplication does benefit the bugfix process, and can reduce the
heavy burden on the kernel developers. To make our analysis more
useful, we will try our best to add some root cause analysis and how
to fix the underlying bug.

>
> Best regards,
>
> Lukas
