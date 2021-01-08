Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30B2EF5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAHQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:26:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbhAHQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:26:23 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxua4-000422-SY
        for linux-kernel@vger.kernel.org; Fri, 08 Jan 2021 16:25:40 +0000
Received: by mail-lf1-f71.google.com with SMTP id a19so8534518lfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 08:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ysF699gum20ke/f8RjKaFSvgbRhAZM2ouyRt7X4Sec=;
        b=WFmeJZwtT+qxx4L+WxJZOOwB3yAT7XGjezfBMMeyRjQpXYAnTJpCqW8yh/cHdOl2kt
         O+8TqhtBr1ZYMYdxT2JuKvUs4fgjZfwMaXL3YUW1nYD1i69k0iy/lTDnzUW0QQ/wYqXh
         JlpO3ALYdT1wOBQ7I8zEPHdQopGY6aYM2bDH2mNMisBswB5i7IxkGKGt2V9l2U4USv+C
         aCPsRgHGf5EbSrvg99ZXXzYvQGWdVbiT2SDCxZmvSX1s1Lk98qwbgYIJhv09CLIPMhfV
         Ktf8DpJ6ANd0xXc7VtAstkFYlp3f3ha7bzMoEDRWkrNSZ3nb3zGIKMFSn2IjzfRO8nzw
         qiXA==
X-Gm-Message-State: AOAM531OQVh0rOM5XiOgi5O02jX7+xQG6T4J7s+IVpyB8uALdFo4OsY4
        ljxi7wMCtDpe/j4QcOE3D9VaJDoLHkWtvr4cvhHiNFAtMIsxnwgvDUnoYoxX8MYxCTLAkDhWzKJ
        s1S8US9bKSxB+zdWyKTocWxkKAQqoNW9vubytB9P8FjSVpIGh1wrpOgFOUw==
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr1936317ljc.149.1610123140339;
        Fri, 08 Jan 2021 08:25:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKx6HpdNkM3sZ0PdAhD2aJSAg9xbk+QEeabuLyBIv/0NMYrhLvBkVH1TueHAuvhIV8BPYPhzkdpLT7hrF+25Y=
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr1936310ljc.149.1610123140107;
 Fri, 08 Jan 2021 08:25:40 -0800 (PST)
MIME-Version: 1.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 9 Jan 2021 00:25:28 +0800
Message-ID: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
Subject: Multiple MODALIAS= in uevent file confuses userspace
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
"compatible" is present") creates two modaliases for certain ACPI
devices. However userspace (systemd-udevd in this case) assumes uevent
file doesn't have duplicated keys, so two "MODALIAS=" breaks the
assumption.

Based on the assumption, systemd-udevd internally uses hashmap to
store each line of uevent file, so the second modalias always replaces
the first modalias.

My attempt [1] is to add a new key, "MODALIAS1" for the second
modalias. This brings up the question of whether each key in uevent
file is unique. If it's no unique, this may break may userspace.

[1] https://github.com/systemd/systemd/pull/18163

Kai-Heng
