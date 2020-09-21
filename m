Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970B272AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIUPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgIUPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:50:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B459C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:50:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a22so11475204ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2P/kdYRMnIJ8JXRZI/g27WFIVgCRdQkw7dhOpLGAZjU=;
        b=Uq2K6dYz9p4Py5RGxdGOJ1tM4idNwtptH7xazinqaLKiXRfEVc9UeEcE+tlgWsR+UZ
         J/gPsRqEveipYK+0JLfQ61/ltbzaEugjVV+afpvaqMEQmdh2yJ0sgPQKHe50tODIaQ3/
         l+N67n3LfyU8haxV2JJPVj/aSVw8wq5V98oxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2P/kdYRMnIJ8JXRZI/g27WFIVgCRdQkw7dhOpLGAZjU=;
        b=XaA2Xq/NmAz0/kOL4nRXkL0DMZHvpJKWLpQqfAeIpEXN8/PPCucOW5AY/FPCHOcQ2U
         By2nZ2oHYV8PqSCDe6lDidB5y/4RMiSrb3XEoIQno5eehb7f62SyzZfRgTcgBt8VmVFP
         YkxioDm3f+LFXiroYPT/CmZFSU79VcjXmQrGwjon8cltJ2iRHnvpUJX2lEN8pWsBxkAo
         zvmJcwR+sVb3IoOAbWVeGYfVGuLAclC1gDRkLGP3ip/+vpgJ3n8sayIeMzokyoMudY7x
         1gfpTaFh6SXh2nh1PczZyUxAlYusFmbtvjD6rCIpCPI+yr+67zdX9V8FPU9LDwwHpbl4
         uORQ==
X-Gm-Message-State: AOAM531uc2Lc2grtqf0yigWD+0fwCiyeo5O8GCxO3gbYcbRwoPgua7sl
        4c6nE3SpA5HZr/4ZBu+NuMK0sbBMyffALQ==
X-Google-Smtp-Source: ABdhPJy0PMCBqhv1uprk3+J6DscVlClqGzuguaL9D4iLrAOEQmsspxdlpiG60lkXiITB7rRt76J/aw==
X-Received: by 2002:a2e:5054:: with SMTP id v20mr111900ljd.345.1600703428583;
        Mon, 21 Sep 2020 08:50:28 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d24sm2650917lfn.140.2020.09.21.08.50.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 08:50:27 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d15so14555206lfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:50:27 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr171644lfp.534.1600703426975;
 Mon, 21 Sep 2020 08:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
 <bb41f8a8-3388-ddec-cb53-e801e5efb8d0@gmail.com>
In-Reply-To: <bb41f8a8-3388-ddec-cb53-e801e5efb8d0@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 08:50:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj22EmbYU3RnEBTcQMqiSCLLO_4zcRJxbNzGkKak5UYfQ@mail.gmail.com>
Message-ID: <CAHk-=wj22EmbYU3RnEBTcQMqiSCLLO_4zcRJxbNzGkKak5UYfQ@mail.gmail.com>
Subject: Re: Linux 5.9-rc6
To:     Robert Gadsdon <rhgadsdon@gmail.com>,
        Stuart Little <achirvasub@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 6:06 PM Robert Gadsdon <rhgadsdon@gmail.com> wrote:
>
> drivers/dax/super.c:325:6: error: redefinition of =E2=80=98dax_supported=
=E2=80=99

Gaah. Ok, this should hopefully be fixed in my tree now.

             Linus
