Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A02175C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGSA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:00:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E20C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:00:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a8so38113961edy.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W8TPM5bdyg71dTiB8jNn7OZEEqQzG0GKM7OFFwfgiDw=;
        b=K/h94cUGQRAnMGuxd+caPCyuOVecpYq7lkiqe12dXivDNYSIS2W7nA/6d6xHUVwqHW
         L0PTHHjzgf/6x454ljLlcwPu0r2lI3MgpXuxkH6BNaHcONuq1rfWJwYKAQwYU8bpq7il
         WXS+iwx+ItTrJoS+D5ot8XXBigRVFMazQS/joqhV+4FbhyvFNBe2ix1LFu1+XP+hwIaU
         cw5Ma9+cM1/gO2BQrWp5LOrvxuphyExhv94teqkL2hjjdjDMwJxKVfwbsZQXhotZ8E3Y
         Grfny+Lv4W13MiVJBUEWg4sqUMPeHNyGCe/ZSjBCv9DHDPRxgiJWMr8Hl5V7WeQ4j5/r
         q+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W8TPM5bdyg71dTiB8jNn7OZEEqQzG0GKM7OFFwfgiDw=;
        b=K4BztGqZhsZuCy3XwbFioViktyf6NUFwd3vnTdxmV9FAdfYYbEz/qjElLpiNprbvUr
         axiQnFr2UNe/D0XGgn3qNJpYwe3UeftIt7Luc2YcZ8niq9b2b/lXjr8vSdRYOhDEwOcN
         r7MZ65sWW4nX4PDJAzVt8raJjvD6EELf6KuDNZxnG0/++HDpML67+Y0wd4zr0D6D1rQ+
         /e0XJytQOUcX5pAVJ0o7fOpOriaamfHp1KZDBDEVdtaVyyNgSW7POd64KV9oTI+RAb+5
         5l8C6QMFjtxIvUzE6rjIJn9n1ecEBEyUY+H2c5G3f8dteYyYi9GCV+lvyH82lJkil/ia
         bS7g==
X-Gm-Message-State: AOAM530Xg08A0wAHXiWPckNsQ8+KyiBgjGCFzY3rpybMkOx0ZOmbiAWB
        BI064aYaTQ9XQJqedFv/JhfRZ0izjrQsntWNLTtBuMTGPOA=
X-Google-Smtp-Source: ABdhPJykMRStnd4trilBtj5i4D4gaKZ5GcjXdYTfXEawrY7dsNiAXwuo1XMh/Xr0OoySQVDWaF1ZZzJ+glTAoiYu2/4=
X-Received: by 2002:a05:6402:377:: with SMTP id s23mr63936839edw.200.1594144856588;
 Tue, 07 Jul 2020 11:00:56 -0700 (PDT)
MIME-Version: 1.0
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Jul 2020 11:00:16 -0700
Message-ID: <CAHbLzkq5rSHUSbHegM5mURytS7nEDyHHbxOYn8DaBwYB0qGocw@mail.gmail.com>
Subject: [RFC] Kill THP deferred split queue?
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

The THP deferred split queue is used to store PTE mapped THP (i.e.
partial unmapped THP) then they will get split by deferred split
shrinker when memory pressure kicks in.

Now the page reclaim could handle such cases nicely without calling
the shrinker. Since the THPs on deferred split queue is not PMD mapped
so they will be split unconditionally, then the unmapped sub pages
would get freed. Please see the below code snippet:

                             if (PageTransHuge(page)) {
                                        /* cannot split THP, skip it */
                                        if (!can_split_huge_page(page, NULL=
))
                                                goto activate_locked;
                                        /*
                                         * Split pages without a PMD map ri=
ght
                                         * away. Chances are some or all of=
 the
                                         * tail pages can be freed without =
IO.
                                         */
                                        if (!compound_mapcount(page) &&
                                            split_huge_page_to_list(page,
                                                                    page_li=
st))
                                                goto activate_locked;
                                }

Then the unmapped pages will be moved to free_list by
move_pages_to_lru() called by shrink_inactive_list(). The mapped sub
pages will be kept on LRU. So, it does exactly the same thing as
deferred split shrinker and at the exact same timing.

The only benefit of shrinker is they can be split and freed via "echo
2 > /proc/sys/vm/drop_caches=E2=80=9D, but I'm not sure how many people rel=
y
on this?

The benefit of killing deferred split queue is code simplification.

Any comment is welcome.

Thanks,
Yang
