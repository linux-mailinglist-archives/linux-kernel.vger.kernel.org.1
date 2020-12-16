Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E512DBA06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLPEXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPEXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:23:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B07C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:22:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so45021512lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7YASFKnlcK3sG06TQYkNB3ka49UIxFdtLdzqg6ByNkw=;
        b=K1ut1XauTGCezFtulNpEVyEEmsS/pp3/dhfxEargGVhmWLdDlxbWdrrniZu6bwyMTN
         IZzJnFZfdB1aRa2da2Uocqsxg+wKYHvG2Zq1HpeZK7eOUFkW2CPLtwMKAZknWNxtfF9C
         uhN5SibliHdnTSSvy1/NdU8RrQjMXUaJksRS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7YASFKnlcK3sG06TQYkNB3ka49UIxFdtLdzqg6ByNkw=;
        b=N0hyXg9++ZpBkGst6iG3thuCGOIbbTssopunwmaZybljdzPAG2A+SeuVvFYmsOGMBP
         SAarX73ktwcSp49+YrTQA8mJn8oUIG5Ati6sNwSQ0doTWZkIztFv1oXUJYzs/4QG4NQ5
         wEA4aA7uIildXaE29wuvhaBhl085Ibi8vcHHZ701kcgONXJ2ocZyZrS7YP1yo5A1czWO
         0pTReheyv1QjfVDvrWucPrSUHFkQtkIF//fd3OuUM548MuxRdRxPwo3GTrLe88bNmf2q
         ZshdLGCe2mYV3Rh00+X4IBIpK3dEz0SWFAVOrYlYmHsf/79I7Z33HRs7XIO/DuLC0Ghq
         35tA==
X-Gm-Message-State: AOAM531Q7+uJP6FRLdT+CYCiy+3ClvoYGK1kNNFGTLcb2+MkgeA+0WMG
        +XB8OuJECZDTgBannusA8mIvz4+SRrqYHg==
X-Google-Smtp-Source: ABdhPJzOFP1ITOGuHPSvSMDBXuQwBo2pMJjabPuJ7GM3ryX4i1Ut92FXP/dymgsVA1GSyAWpPbkmgw==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr10117677ljg.291.1608092560157;
        Tue, 15 Dec 2020 20:22:40 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b205sm72181lfg.218.2020.12.15.20.22.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 20:22:39 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m25so44981353lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:22:39 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr11793014lfl.41.1608092558829;
 Tue, 15 Dec 2020 20:22:38 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 20:22:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
Message-ID: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
Subject: New objtool warning..
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I only see this on my laptop, but that's probably because my desktop
is built using clang. So it's a gcc code generation interaction, I
suspect..

Anyway, the new warning is

    drivers/gpu/drm/drm_edid.o: warning: objtool: do_cvt_mode() falls
through to next function drm_mode_detailed.isra.0()

and googling around a bit I see that 0day ended up reporting it on the
linux-next lists, and blames commit 991fcb77f490 ("drm/edid: Fix
uninitialized variable in drm_cvt_modes()").

That presumably then makes gcc generate that odd code.

That "unreachable()" is because the compiler isn't smart enough to see
that yes, there really are case statements for every single possible
case. Oh well. Maybe the code should just make one of the possible
cases also be the "default:" case, and that might fix it.

But maybe this is worth looking into for objtool too?

Anyway, I see it with gcc-10.2.1 as per current F32. Holler if you
can't reproduce it, I can send the object file around.

            Linus
