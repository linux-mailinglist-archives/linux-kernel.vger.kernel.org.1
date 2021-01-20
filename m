Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4E2FCABD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbhATFbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbhATF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:28:56 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79309C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 21:28:16 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x78so13864394ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 21:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WOXazTlgJn75qx9XSNWOX4yBA/rtUatc3Pb6WtW/aGE=;
        b=bBxz99PoNbOWtlD1FvKtFeYNjxKTC1xqi4Dd5KNmh4RfQVPao1vPPWGtbF8w3wuuBa
         1SaIcXfp0/4erPSujsYR4aJeL96KagYl547WAmwjenKno9Glq1nhyaF/TIY5H5tvGIpx
         kBRe0xSYRQceTj7xvjA2GI2ILJx800IuCdd02nv+hRYmN+h05YCajI8iUx26dRvlTsG2
         Kc1BognLC7aUOAuwjW8ywn087PUTxnEezEPK9GnnPwfmndHVT86pRN4KWcXPaptDtx9V
         KIy+RGMQfyReBd0ESYosm3nbSM+1SNFq0xmg+bUkxjPcROBlE/A5Li1Ph76OjfSmWTgE
         8syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WOXazTlgJn75qx9XSNWOX4yBA/rtUatc3Pb6WtW/aGE=;
        b=NfIOWWUEfC5O2E2R1yrBwrNVaFOi1MMos7Fini33WjS79pc1MuYLcS8mbMnL2Klv9A
         F8NykFaoInkCeNVO4gffizHdsL/gL2CrtuOZ+SxQ9ES1IIz21gJEs/HwEND+Suxus/Cl
         jaMkKqOZ6OocBO9QgrBEcZY+Soj1FX7Abke76EsId6azpEr/9LvEorunLpb2m+2GP0pI
         cOTjWUA927YqBFK1hCvjtZbNOwMTMd+6KAqJzQPhatRj35SvXsuMkXhA7hXLuMpEQ6ct
         L99/fHk95f5PJk8lru2zBpEz4aAaNQuWkKGUtfzVcf6oDIq6BPYd2tthB3xeagV2mzML
         QrWw==
X-Gm-Message-State: AOAM532DLM2+Rj6Q0+HhgEbcTR6rUyYs5GUfB63wXkAZjvDrNTlPFfIp
        7YzHmQ+iqc3v9suVRXLBAq+V0blSuq8K9KDP/qQ=
X-Google-Smtp-Source: ABdhPJwA98AvF7v3sMHotlIq7ZPCEUWfzyVZRfjK0rXAOlxMabHZF31tQA+at6TMR3LL91uGYAsW/onaFyMXqa25KLQ=
X-Received: by 2002:a25:e7c2:: with SMTP id e185mr12011722ybh.94.1611120495684;
 Tue, 19 Jan 2021 21:28:15 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Wed, 20 Jan 2021 13:27:49 +0800
Message-ID: <CAD-N9QWyfAgVRcgOoWtR87_VqYvMNZxxBpFSxYQ+ME7tEHv_Rw@mail.gmail.com>
Subject: "possible deadlock in static_key_slow_dec" and "possible deadlock in
 __static_key_slow_dec" should share the same root cause
To:     bristot@redhat.com, kuba@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        peterz@infradead.org, simon.horman@netronome.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I found that on the syzbot dashboard, =E2=80=9Cpossible deadlock in
static_key_slow_dec=E2=80=9D [1] and "possible deadlock in
__static_key_slow_dec" [2] should share the same root cause.

The reasons for the above statement:
1) the stack trace is the same, and this title difference is due to
the inline property of "__static_key_slow_dec";
2) their PoCs are the same as each other;

If you can have any issues with this statement or our information is
useful to you, please let us know. Thanks very much.

[1] =E2=80=9Cpossible deadlock in static_key_slow_dec=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3D4671e8c8f5cf5d23a81facabdc4f26ed63f0=
3fc4

[2] =E2=80=9Cpossible deadlock in __static_key_slow_dec=E2=80=9D -
https://syzkaller.appspot.com/bug?id=3Debc482d3e3ddaa62726a73e0123acef411df=
13e3

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
