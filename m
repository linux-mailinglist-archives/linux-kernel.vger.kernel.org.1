Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55951299AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408006AbgJZXpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38216 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407993AbgJZXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:44:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id c141so14672111lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=;
        b=AiXZUswtdTYC3oZ4+GUHPWtVP9jG18MnP79xWB/+b5a0T/FWq6q/+HReapl8Mjdyta
         AC3tnFDBxmu2mNZBS5h3nlUUY/L+X8ndPHc0sVuYATjf3U+cHkR/7sCAcQEcHsDmZkX0
         8F0y9YI7Mti9Up+dZ8Wq4KqMaSxOLeteiaLDLw91zaDQyys/tVyzaRlkrWTLRwyzLC+T
         FQje7c7Mn6OTXDhLi4l1IJoI9Ufe7yZ27TDH5OxywgPzx82BfrnJGbiaeCnwbhHRQoXw
         B9f+8raORPERSnfpRA8CP0S0JcnRgtXKSDhzM8ENJL3hGK3P7DazLlzc3BnGJDOk/jmj
         ssaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U+ci8HfK0Jx/bpDWJmMVdhckawMI3McUJ3Muf62Y3os=;
        b=H0oHQ0FLOpLLqA2BviGWZCLFeQ+IRns0OFVFkqkTswDqZ39sb+GIOvq+K7iW8nTKgM
         jWO7iWwTUd46rDX34aHnNCrwRNCdnn9ulFRLLZuYAwG5R0XYlcIrbKN7Y9j2uH+XFZUR
         7hwI3mXBe/Btxzdz7uwKZ5rGOJ3xtk9PXa97UwtGGbuFhHF68gZyUPi7KX/0usXQ51x+
         1BV46K4/KQ9Ev4AWHjnYIsNExgTpSNh4WfNNNn7Fwuqinee1IvVM8rdtmBzVhd/ewODC
         qk6miRbAJpz92R22hzQm8g2UoghpjneiiIitjhslE0aM031Ls4I+lA07ET6eIGQNAiZG
         huUA==
X-Gm-Message-State: AOAM5311Tqvw1ymYsLLGj4CoWiTliK/nwcNG9/7JqqMw2VOfreuqch/Z
        IgWWSIshah7h8o0L7X3r9gltvVRxBhxyePt5n8I=
X-Google-Smtp-Source: ABdhPJy7g9BoxTMajgkhgTXmYywo57QYN/3JVTnSY/v2Anbz2XwZHF5bXTKb/yYHnp+DPltcJ7Qhsnpzm62OdfT5o1c=
X-Received: by 2002:a19:f71a:: with SMTP id z26mr5752205lfe.90.1603755897185;
 Mon, 26 Oct 2020 16:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201026041656.2785980-1-daeho43@gmail.com> <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
 <20201026230555.GB1947033@gmail.com> <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
 <20201026232712.GC1947033@gmail.com> <CABdZyew=D=S7MmitF55K8Jd6QiVzdJzFuQ2JkJ6x_T_a=AVMvQ@mail.gmail.com>
In-Reply-To: <CABdZyew=D=S7MmitF55K8Jd6QiVzdJzFuQ2JkJ6x_T_a=AVMvQ@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 27 Oct 2020 08:44:46 +0900
Message-ID: <CACOAw_xYHr7YY_e-cLYUurh07T-T=CNTM6gKUv5VKjYp9=h9nw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Daeho Jeong <daehojeong@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, typos...

2020=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:43, =
Daeho Jeong <daehojeong@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Oops, typos...
>
> On Tue, Oct 27, 2020 at 8:27 AM Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> On Tue, Oct 27, 2020 at 08:18:44AM +0900, Daeho Jeong wrote:
>> > I checked that. We seem to need to complement missing parts including
>> > other ioctls in Documentation/filesystems/fscrypt.rst.
>> >
>> > Thanks~
>> >
>>
>> Well, the f2fs-specific ioctls should probably be documented in
>> Documentation/filesystems/f2fs.rst.
>>
>> - Eric
