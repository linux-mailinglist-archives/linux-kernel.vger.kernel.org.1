Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390302FA582
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406308AbhARQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbhARP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:59:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:59:07 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w5so8455360wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tg+3NwgpjPXKCAU0OOKW/4MEsOw9C1yX+SHheX6GzNo=;
        b=OeEk33HaH6Hbiu6I+b1Q7FWYeeSPLEzZbksFKDPfTxJvMz2iziNXp8justgb+/qOO2
         BmCttwyKayBP3uDNYOUfVlj70h4U62BnyWDdecRhbaiNKeULfiq0So6sBAE6CsF/IOtW
         Yy6TW52Hv4v0RnU27FQzOf6ha3Ey7GE/vNnDFqJaPi1WSwUEzdaiRL3OPPHrEqYbLCDN
         VK8ebVEgHFqFH7Evop0hPWI/SmRGX0JcRkqwiX6zWXcPQXSI+/ZvW6zcdlux8HW2w5KZ
         TSdj/4ofx+XLW6B5MF+TKyrhDGKP5C47CVeyVsDxLS9F2b7KXXgQ9l+V6MIxdYtetGu+
         kzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tg+3NwgpjPXKCAU0OOKW/4MEsOw9C1yX+SHheX6GzNo=;
        b=sOYNO5lQdsuyDe1tmndlTrriWeLa/dohJ9vLp5nnQz0YHjJA5ES/xPDWNDjLYr/jlI
         HBW2l4bqVGy1zDG2hU8D1wmzwQS4v/W+FIuChGV7re9oBa/j22ixIYiklGD69iTIGg6d
         uG59E2m2q4Hp+YRSJzl1mPnyib0dVgUjvypIwKUBGC+JAxmxVvNws05o5RCU7aobYNAu
         7mCeJjJv/PF3qlr1WyQy4BvsGmxk+i3Jb0vpd9H3ys7VwN3JoXkiYrIJGYhFIKZ/IIl6
         fa6lZNlocT3LrB5CXx5kSBAa3d2Nh07Fwi1fmQj0yGStLPXLMs7MOuJtZfL7ZiHpBhb1
         ZsBw==
X-Gm-Message-State: AOAM532qAFeiHQ9+4/Lb+90Hu67DyizKJRWmmM5Y2KrgMuFAAeANA0gJ
        YZBkzON2OpjbyUOTCdnfcm6HUIh2g2ji7A==
X-Google-Smtp-Source: ABdhPJzdYAbwQUMFF8aREpbLcgNopt2loRgSAlU+AdqVByyRoMPeOOxoouLImEHuyt7wAIwdpW2ivErXPiz1Gg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr54945wms.0.1610985545503; Mon, 18 Jan 2021 07:59:05 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:57:33 +0000
Message-Id: <20210118155735.532663-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v2 0/2] BPF docs fixups
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Difference from v1->v2 [1]:

 * Split into 2 patches

 * Avoided unnecessary ': ::' in .rst source

 * Tweaked wording of the -mcpu=v3 bit a little more

[1] https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t

Brendan Jackman (2):
  docs: bpf: Fixup atomics markup
  docs: bpf: Clarify -mcpu=v3 requirement for atomic ops

 Documentation/networking/filter.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


base-commit: 232164e041e925a920bfd28e63d5233cfad90b73
--
2.30.0.284.gd98b1dd5eaa7-goog

