Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D742E8EAB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhACWYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 17:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbhACWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:24:32 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193CC061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 14:23:52 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j20so24455408otq.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DIjvfsKzs5iMqSeaJZZx7EldM6uUFuWdNpPntqJHKiY=;
        b=EUvZMTttdBbFfmuAV/onlaer1LQeaY6hmHLUdtXtCj5Vqva7XiQc9Fo7rBSg9WEs1A
         9h9N/SnXg3HNEYSCy3hW3J9J19gnj1oHlTHYqkqvqE7vccP9apGtEJZ+9ktWwIBLZANl
         jDsoqJGC92bMNrYE7sFSrrp/y2VtlVaZMiJvV8fEogIlbpxH4HmTvyln9qK3etidTLFu
         rR4MjYd0MzyRaLx9DEIupWcRQHHKxqs4q0Zuv1gk53WOaB6dLekzItIEHV3OyxCG58TM
         dxJdE8E5l4MfJJJmch5OrScACa0me/mu2C+IoFgPVPoQjFo4qKKb0/Sm5VO+zQ8YEuwq
         kodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DIjvfsKzs5iMqSeaJZZx7EldM6uUFuWdNpPntqJHKiY=;
        b=SxXQn5FvgXN79s5iQHbry25yTKTH8CI5TLdtgnav0bEg8H0HHTveWGgaK4lnqzaXyP
         OJcEM2VKn5BC5cLut9iVIU3vMr5C0Bo54gzPnMal8APv+/fD84zBLsgXqcJg5vQcvDDm
         6IkmeDlRQKzCsoTkkp1jLeC3XW2IntXOurlBQDWnNkjQkSa8/hdQ+BvEkk5ERGrQke0N
         NSZcRSXWaw3V+xUkKyAoyE8+cTr6WAyDhrgqEduIYprDqCwdXWvYr/WYzEkDd2D1/hwN
         s4szMtjxqhL1A5qe1tIH+OrCcPneTxVt4nS4Y6uIWfKY3YF2R508C8XUCmuJVTM9PQDz
         pKMQ==
X-Gm-Message-State: AOAM531+jmgPlpc9tstdiU0ARwLKIj95BoYDNJ77KmOKVzyqO5T7A/zY
        q1FsHbGWIfTV5hryHUmGRY2IfuYpPFEOCb1Wp+X6+gBDitw+Hspg
X-Google-Smtp-Source: ABdhPJw5l+7M19JLTI3K3Odqdhkn+2YNV7nn8hUM+NmDgeoUwZCgtK97YqxQeKothi5aJ98pu2ysIQTz/ucGh07m66o=
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr50969301otp.233.1609712632057;
 Sun, 03 Jan 2021 14:23:52 -0800 (PST)
MIME-Version: 1.0
From:   Alex Davis <alex47794@gmail.com>
Date:   Sun, 3 Jan 2021 17:22:30 -0500
Message-ID: <CADiockAgFGCxpn6uueaL+E_sP9EsgOemJg-XydSC+rTvB1ErBg@mail.gmail.com>
Subject: [Regression] Blank screen with hang on boot with 5.10.x
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 5.10.x, My AMD RX580 based system hang with a blank screen on
boot: no SSH access possible. There are no issues with 5.9.x. I
submitted a bug report here:
https://bugzilla.kernel.org/show_bug.cgi?id=210867
