Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3075A2FEAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbhAUMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbhAUMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:50:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:49:52 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q2so3589425iow.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XtJzgKzVRJpARygSVTsNyuHH5dLSN0DrMqlgv5UOqDc=;
        b=RLqBM9veRRKlB4rylFHd7Swdy4CvbRNJjmVI8wM8bnYJYMbGIWZ5tZGlQNhcUottyq
         vHdpT/4mttMKyZ5RAxM3AikpJ3EwGrswUKw4FWw5mjuz5uIzcsEDiOBX9Rdjv8gReTqm
         7snQhjCLzTzKCIA0ZBOYMxJpYa3zIcdMLsPTbagNVvsSrYNGna8p5+UUvOcaz/Rqs5Qv
         H8Qj1YYCk+ChuiLkJSBdrUquzvVvgCuiEDmj1N8Cbs6LrztdkeSPVsnWElnd38bbfVZe
         MFrMMtIn3KxqHZIPKrEziK06Tkl8jemC4WeGhLiY1oRc9TmqKm3YMVqA+ZPdrl6PlhAi
         /84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XtJzgKzVRJpARygSVTsNyuHH5dLSN0DrMqlgv5UOqDc=;
        b=MTKsxvxllsocP3qFvxkDqH0UZvd5KGBKrBYIdCYR7cL64u8Nl8oxyzX6vOGSpSF24G
         EYnm0N7x/IxxkBotM0ORcf6JkrWXFA3x6KqI2gZbUPfCSAcxGxpikRtMgyJ8wvbw5o02
         zwtJNV1Ij51flsrO3UI2qftm2c0SyZnDNQIcNTZECuiiBJ7XgJXfFy2N7O2n9VNIbiOy
         +KUpGHJbD0ftqN62eFL9Hink6gi/zWOi19zZfwI3O/f3lM7px63t8tyVn/44Ya6H21IC
         aQmrp+IWfZXRZq92Z7yKrVzWFJA9vVKqaVAqCfVv0h6a5FYtn32FHou9keehvFPzrswV
         rxLQ==
X-Gm-Message-State: AOAM531GlCbpIybYKTgyDSHjh2vjM04FK/O4mSwjw/sZ6RlwHPS/wyFG
        4p12G9S/zTFC1i3/JXATsWVWqryrMWc3bhC7fUnUsvCIKjzRDA==
X-Google-Smtp-Source: ABdhPJwZTiCZN3giTtWGBStHjP+xWxJpS0IrKvCmpoXVA5rQ9jAt2zsEQvXLTxfDpATV+oBFYqyKFQnYyFme6d1LiUU=
X-Received: by 2002:a5e:8d15:: with SMTP id m21mr10401165ioj.114.1611233391723;
 Thu, 21 Jan 2021 04:49:51 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
In-Reply-To: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 21 Jan 2021 13:49:43 +0100
Message-ID: <CAKXUXMwcNqd61O2t23zyMSBrCNuHi98uym1LLZQZOZO5NOR3Jg@mail.gmail.com>
Subject: Re: "possible deadlock in console_lock_spinning_enable" and "possible
 deadlock in console_unlock" should be duplicate crash behaviors
To:     =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 6:37 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudongliangabc=
d@gmail.com> wrote:
>
> Dear kernel developers,
>
> I found that on the syzbot dashboard, =E2=80=9Cpossible deadlock in
> console_lock_spinning_enable=E2=80=9D[1] and "possible deadlock in
> console_unlock"[2] should share the same root cause.
>
> The reasons for the above statement:
> 1) the stack trace is the same, and this title difference is due to
> the inline property of "console_lock_spinning_enable";
> 2) their PoCs are the same as each other;
>
> If you can have any issues with this statement or our information is
> useful to you, please let us know. Thanks very much.
>
> [1] =E2=80=9Cpossible deadlock in console_lock_spinning_enable=E2=80=9D -
> https://syzkaller.appspot.com/bug?id=3D2820deb61d92a8d7ab17a56ced58e963e6=
5d76d0
> [2] =E2=80=9Cpossible deadlock in console_unlock=E2=80=9D -
> https://syzkaller.appspot.com/bug?id=3D39ea6caa479af471183997376dc7e90bc7=
d64a6a
>
>

Dongliang, what is the purpose of this activity?

Why do inform the kernel maintainers that two issues share the root cause?

How does this activity contribute to fixing the bugs? Why does it
become easier to fix the issue/create a patch with the information you
provide?
(Honestly, I do not see how it does. I believe if anyone becomes
active and fixes the issue due to either one of the two reports, the
one report would be closed by the reported-by tag and the other report
would simply disappear after time because it could never be reproduced
and hence, syzbot would close it.)

Would it not be more reasonable to fix issues rather than identifying
duplicates in the automatically filled and managed database?

Best regards,

Lukas
