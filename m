Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722912FE232
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbhAUGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAUGAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:00:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:59:24 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b11so965251ybj.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RAwQ3f/drnpP6XT80kBEqSV7iw2D3W05baQeYgmRFTk=;
        b=hXAjtQJjP+Ukk3nvZ6FJOkxXH9+24Wskxuvc+U3n5/H7M9yVYvgpNfwn9WuGq5bkCc
         a4QdTe3iXSRBwl/aShwNCjkeHpaP+2FeYRTSkUDbeJYAXet/OPVy+aXFIJnowoWmHQbt
         YV+C7OWt89RvUjLhG1dxpsfREWBgokE3CLg0wtUvDGzf+lwEFKb85chQt4t627THJ7sf
         fHcUouVLVdqYCoqNFD6EMMaJFePhSBNZEmr8+pi16GYxMsr+Q8Vl747oTydsQ8A2Gims
         Yi2cDQBX6Z5k7pjbh2LbUGiXFP6PTySYdcS/YHWGrpdDo9gxS1+CN2XD13WxJjmlfGkh
         3ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RAwQ3f/drnpP6XT80kBEqSV7iw2D3W05baQeYgmRFTk=;
        b=UMyAR/ohfarUBKKtwM+xFaJdFQH9+elW7jIFl1GZIK7BMIv13pZHBke/R3xqjkP2lz
         IEVv9r7jHXdGCbthAb81IViui7Z2UHdew9SaOTbXVPIq04Nc8EqsR3ok5l6mr1dl8SiD
         3akzsr5Vc92ECguiSe3BYa/0RH0wTS24dxYXm8xnKWgmD5RRBBSIVwPUhREZYvAjioho
         uheE4IcSqTl81K0fjwcQydM84bhzOZThEfE01gvsSknf68w9pTWblzKm8b/nBU7VMLtk
         hD1wQeXxx45x/9zdQ7l5kGvUW5mhx4V5748ZsHIwerWsAXTamF9iSa1sc+nXJGAz512O
         mRxg==
X-Gm-Message-State: AOAM533tB/z91Kk/zcRRPU86H/e8lqVofbAS6+dAb00/UZng0o4HVguL
        8nCxpUkO7NQX5a2E30eTJW0Bz+LbXKruJ8SU+vg=
X-Google-Smtp-Source: ABdhPJxzAtJqqxJIhsCnoTrZ53BLm8DnOm7cWTUyFAcZy+YjcICGgkhKyDfsjODwIadBrSfEOfyL15do8ahQNTwKEuU=
X-Received: by 2002:a25:ea53:: with SMTP id o19mr8007050ybe.94.1611208764152;
 Wed, 20 Jan 2021 21:59:24 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 21 Jan 2021 13:58:58 +0800
Message-ID: <CAD-N9QXHkGkwihX=E7HAnDs3L90=Q5FerLb0mJhdXMb+pH-tew@mail.gmail.com>
Subject: "INFO: task hung in exit_mm" and "INFO: task hung in do_exit" should
 be duplicate crash reports
To:     aarcange@redhat.com, akpm@linux-foundation.org, avagin@gmail.com,
        davem@davemloft.net, ebiederm@xmission.com,
        linux-kernel <linux-kernel@vger.kernel.org>, oleg@redhat.com,
        prsood@codeaurora.org, tj@kernel.org
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9CINFO: task hung in exit_mm=
=E2=80=9D[1]
and "INFO: task hung in do_exit"[2] should share the same root cause.

The reasons for the above statement:
1) the stack trace is the same, and this title difference is due to
the inline property of "exit_mm";
2) their PoCs are the same as each other;

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

[1] =E2=80=9CINFO: task hung in exit_mm=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3Ddd115babf1498c3370fab8758d58940b7c6b=
ffa4

[2] =E2=80=9CINFO: task hung in do_exit=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3D3e6c42e24155e5f0125368e609bee32f2b73=
94fe

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
