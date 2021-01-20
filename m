Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183A62FC8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbhATDXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbhATDXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:23:17 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C29C061757;
        Tue, 19 Jan 2021 19:22:37 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e67so9536517ybc.12;
        Tue, 19 Jan 2021 19:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f9pMfHMJFLWFvKkxl3fDIxRex/hLf2XjpUacI+mZUlo=;
        b=Y74qXsQE7DVaV2IaNQj6xHpHJyEOF2ivRh39VoknvHawJjTV3KMMtw2Zu26MXjH9V4
         IQl0fm9vXz29qN4pKZVPWCbn8RY79Udnhfp4q3bmpixPzX0pRYkfzjj/KdyZv8GYMwf6
         leD5Y+AS9fxDidVQ+wtTo06S5TWlTVlD/By0C4VKlj36a6aVD/6mW/j+CNyhbV3/7FZe
         uEyYsEUIqiQx/7Fr9rFoOzPlwzCl98vpGt4wMbpCbEsJOeN/vMU0BhmwqYj307cNqWEX
         vEWfkgDy2Osr3dv3yWSl2yKclvnYYY9cEovrPVbHaspDcq3EuwjfU7jS7Y69RXwI5vcK
         gsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f9pMfHMJFLWFvKkxl3fDIxRex/hLf2XjpUacI+mZUlo=;
        b=HEoDerz19yMzg5PVBLZhtOntX0HTAU6oArrkAdpOocLQvHKrYOYeBtm++Qbli58D7a
         z4fwnUUj1KIdzcEABDMJyT10Dnqt+9qk8y7w+ozxBhsGH8K4kwAlL4Luy/s+81QdI4Yf
         CNOz/Ajh5IYNElj3MRA3jcFhPxB9Neis3E6Ru1BEDthfoJAEvlTwwy0+ph5cCqRXjd35
         EQpvWP4kEE/MVTJbdlV3JXQDk4YLhJmtL/Nd4VU/lGsMSP3G6GflckIt1kgeWHl7aiJB
         jHOf0ThZft4cdUs7V0vGdTLV9XJQWRCB2lw2r+UOw8sIEZMsnLB542VbsXcVus7yIEMD
         RgvQ==
X-Gm-Message-State: AOAM5319kkuiz2OAuXaqzHMr9C+bCCjHFQof10CI51NFu+A4YcgXxk9I
        1ThVBGLJXyPefgp8xilGYymZtq0xH/4fjVMi+m0=
X-Google-Smtp-Source: ABdhPJzpBTZBCK5+V+Eko13BUTOyrdrdSVMlL6YqRHttJSTJr1LKYUuJjJUHuiZ75zl5fegkOpEfdFtTtwwqJ2/R9Pg=
X-Received: by 2002:a25:688c:: with SMTP id d134mr10841417ybc.477.1611112956721;
 Tue, 19 Jan 2021 19:22:36 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Wed, 20 Jan 2021 11:22:11 +0800
Message-ID: <CAD-N9QUVDpHjSwZa+w3Zxx_Pn5ZrBKuhGhbg9PoyR=xbrMb88g@mail.gmail.com>
Subject: =?UTF-8?Q?=E2=80=9CKASAN=3A_null=2Dptr=2Dderef_Write_in_event=5Fhandler=E2=80=9D_a?=
        =?UTF-8?Q?nd_=22KASAN=3A_null=2Dptr=2Dderef_Write_in_vhci=5Fshutdown=5Fconnection=22?=
        =?UTF-8?Q?_should_share_the_same_root_cause=2E?=
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        valentina.manea.m@gmail.com, hdanton@sina.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9CKASAN: null-ptr-deref Write =
in
event_handler=E2=80=9D[1] and
"KASAN: null-ptr-deref Write in vhci_shutdown_connection" () should
share the same root cause.


The reasons for the above statement:
1) the stack trace is the same, and this title difference is due to
the inline property of "vhci_shutdown_connection";
2) their PoCs are the same as each other.

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

[1] KASAN: null-ptr-deref Write in event_handler -
https://syzkaller.appspot.com/bug?id=3D28cccdd18b4bb8670d077937fb8d4849dca9=
6230
[2] KASAN: null-ptr-deref Write in vhci_shutdown_connection -
https://syzkaller.appspot.com/bug?id=3Dc21c07f3d51769405e8efc027bdb927515dc=
c7d6

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
