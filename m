Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2262FE1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbhAUFkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbhAUFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:38:12 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA2C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:37:31 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id z1so947170ybr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7zu8GUqZprm/GlryywXSearLwZoSZ1S/MZLkgUPCsQ4=;
        b=sRBBM2xhd97UbqcxnVW6yJlyVyg9lS1erTS769tAqdcoUAWJGY12Rum5Xqdi5S/Hi7
         hjcFI3gDy9/1OBAMdXO3sECdk0eq44tRIOTEe9zpBnhImV6VY+htXFo83cXrBHqfTi3B
         X0xj0Y6eMvUMBz5W9H9MdLLehuFzzTzdKgi64Qs/nCGnsuB0fttclqlsSZXNm03/bJEd
         kfOy9F3174leF8KlBOPYuAFuoB5nvYy2Z2PQYcUQY5Ptv9Jr2sQVqyYmG5k4fiqf7syv
         hmlsZ1gk1J3z1LMQ4LkYe4Civxq+XOAnHbBGSzeHp12XDpmWHyIXoQgxFQmjcs//zzuJ
         D5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7zu8GUqZprm/GlryywXSearLwZoSZ1S/MZLkgUPCsQ4=;
        b=qBwhVvmMiyQ3pTxbgpsNjheHC1GZ8j6Xyh/u75HcYE9mINlmzRmU7A8gU+mbdRowAI
         UdfMMecSvl/F6kHCwx7ix7KkS3unvfsT82fjBT02Ed/3veoagRCBgtO9JSIP8Akh8b4l
         5mcXL/oh7d0Yqqx4kiOniEnt92RaWzE48mA7IvPew6hsMxPZF+E/cBQeBp67pyZqrxgP
         tLf6X5UCzpVb0CwGk7RnyhJgLWXHAhK0v+aTakV2hJrmNuGdHe1saMmvrii1KISuJV5j
         0/N9vnSAVQDZNdiCNybZAnu76VdDGAWsDiVWqmznO61/nVhV2jRX3S+1weijlHyKV0W4
         UomA==
X-Gm-Message-State: AOAM531F1OU4Q9mnuFs0Eg1YBH2UD1UD0czCAZbkuJwkN5GnQRkIU4pu
        G46kvMZzJ2zMYw2K67hRZaH0VA1al1V6U+08LiQ=
X-Google-Smtp-Source: ABdhPJy32zQ2r5eOLK5p91IMfeoLxKAMN2BiCh9Tz+JVsAlr98znTPJec7YbtpnZAchmZJEDFeJ/+gNq7Yk3mLL9wkg=
X-Received: by 2002:a25:538a:: with SMTP id h132mr18132366ybb.247.1611207451064;
 Wed, 20 Jan 2021 21:37:31 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 21 Jan 2021 13:37:05 +0800
Message-ID: <CAD-N9QV7H8cRUAbnrU9KuXvKbtwL6tLk8-p6HcGpwHn3NeqHJA@mail.gmail.com>
Subject: "possible deadlock in console_lock_spinning_enable" and "possible
 deadlock in console_unlock" should be duplicate crash behaviors
To:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9Cpossible deadlock in
console_lock_spinning_enable=E2=80=9D[1] and "possible deadlock in
console_unlock"[2] should share the same root cause.

The reasons for the above statement:
1) the stack trace is the same, and this title difference is due to
the inline property of "console_lock_spinning_enable";
2) their PoCs are the same as each other;

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

[1] =E2=80=9Cpossible deadlock in console_lock_spinning_enable=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3D2820deb61d92a8d7ab17a56ced58e963e65d=
76d0
[2] =E2=80=9Cpossible deadlock in console_unlock=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3D39ea6caa479af471183997376dc7e90bc7d6=
4a6a



--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
