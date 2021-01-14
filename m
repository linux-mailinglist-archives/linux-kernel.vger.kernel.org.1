Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB22F5656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbhANBqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbhANA7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:59:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9426C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:58:29 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 186so5005610qkj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OMeOHI/Hl6kSNreMTXeZ4BOpfSlftMeb3sy1sw+PF0Y=;
        b=mht2VfhFYIWQFnuf8RZpLFw/43DcWuDtL19iZK/J9/83NLe3kF6zjnnY95w3XVOkN6
         2aFXF7BV+2M3d1Zx2YVX5cMokqb/KoxsJQSE1bBn/A7V5Rb538jHJWLv3GNahYzRqVSv
         AHEvNCKK0QuguhpnPZQ0bFgaG3zHJyI1lNzFIyykTL7dBdnEfFchl+MAWvEIN6d42F/l
         GwIjIucacsuUX1Ke/DsT3Z8nWCTRROG7zMyxf21d4AZKBXGJn5K0+CVjC6G9MkXMU4tx
         R9TshJAdQZ+SpMZurlYBhdfAgD+Mg/kfUxeXds4wFOSHAnbgGmNJNshsvNix3pLgperf
         wDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OMeOHI/Hl6kSNreMTXeZ4BOpfSlftMeb3sy1sw+PF0Y=;
        b=J7VbIwDTtHTyNRq8yqaQ9eC/dezhXZuM9PR78w4aS5U4plGrhpmxHAamGeyk9L0B/8
         P5JgSfvVWv+nBQKIVPkMjLN+iZNUQw9rqwvX3VJUKF/GOlkku4wq26pG3yOh44nvKmCX
         yP3Jj345olAP2Cr+hKHauS5xYd7IxSzIOhRsEu1Z7jLsg3Bwhfcp9381Jj2YWZumtrt+
         wUr9wun1W1+1mgsSAzOpWIriUoARbdJgM/4WEzTWSDU1w7k+87K4afKNz+xuVvewYpZ2
         N8NhswgvepAebUIiGvctpvQMWuSxQueSNJpgSxJDKM1HEv7LAHVXZ7/vnz1E7af0I1Z/
         bTNg==
X-Gm-Message-State: AOAM530O/2E8OEVwJ23u3UnPeHOFwput6Mm6pKJ9eFoOd5lpgzGrm3mf
        sLNXAbeinVywsO9HZHilcOdE2YU7zuroy3DuAKp0GYgCO0ckWAf2
X-Google-Smtp-Source: ABdhPJyQ73tu/PdV9cqrYqLMQz/vcGeCdQvvqwxevqisBw7XPdTw5VTPpGpOuReRk58VKyUgd3ziLzgOj7VwMU5b1jM=
X-Received: by 2002:a25:cf12:: with SMTP id f18mr7138177ybg.18.1610585908912;
 Wed, 13 Jan 2021 16:58:28 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 14 Jan 2021 08:58:02 +0800
Message-ID: <CAD-N9QUWaO0YFz1ORE4-vgGNnsJrgt50S0bPY2JcUPWaKA17Aw@mail.gmail.com>
Subject: =?UTF-8?Q?=E2=80=9CKASAN=3A_slab=2Dout=2Dof=2Dbounds_Read_in_squashfs=5Fget=5Fid?=
        =?UTF-8?Q?=E2=80=9D_should_have_the_same_root_cause_with_=22KASAN=3A_use=2Dafter=2Df?=
        =?UTF-8?Q?ree_Read_in_squashfs=5Fget=5Fid=22?=
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        phillip@squashfs.org.uk,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9CKASAN: slab-out-of-bounds Re=
ad
in squashfs_get_id=E2=80=9D
(https://syzkaller.appspot.com/bug?id=3D16a7f16e9182bbfdbd2142306a82a41d4de=
bb670)
and
"KASAN: use-after-free Read in squashfs_get_id"
(https://syzkaller.appspot.com/bug?id=3Deea996d785a0f2379bcfabaf7501329235a=
1f006)
should share the same root cause.

The reason for my above statement is that 1) their PoCs are exactly
the same as each other; 2) the stack traces are also the same;

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
