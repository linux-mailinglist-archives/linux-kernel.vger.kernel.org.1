Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6546F27E371
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgI3IQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3IQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:16:57 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:16:56 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u126so764953oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AKQiGQLmY10/gIWA0SDoC53W53f+kHTJ7UW7pSl7JfM=;
        b=YA/W6xVw9FbWi0Sp3dLaxoj9wD+T2dj7f/a6q8ay7aNoe80KwTLusZVdDA018dYmCP
         7td6HMS7Bb5kkQD0kMy9mUN5jDJ0lGrxUQ7n5cShVMHYDxNjiysVNNbI53dmip4K9dlE
         9MQkzFKRiwffiXYzjftbWK5W13+9pUjgN9iUF3qydNLlSV20m34cz3LgYdcMB3R/HN4I
         Cok5Bscg+p6wZo2LrR1e2SVVDZN72FaBzUJ5TJbv/rS1VCAVi+46tunvalKpT+103Ls/
         g1ATgIeFhLZdvcEkCZshOMeUT5NR4aWTmvJ390sc9v6eyO9hr45IOoeniSKT+crQC8Rg
         TePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AKQiGQLmY10/gIWA0SDoC53W53f+kHTJ7UW7pSl7JfM=;
        b=VfU+n/3Y6EkICxzFDCQtaX7aXVtJ3PFzRFrn0xhd9q8PRXxueZm1BAR9hn17+IR44G
         0VWLKCn6hf6EUKOrRQFzl+dP/pE9HFyXPTOHSvomOCDfHol/1jXizaXERaVkaNCYlisT
         HZR7FmI6CfWjJcjPSpdotU08qKFW2MxDSPfaWuCVTTKiykQ3I1P7uzk0Zr4v0MXbFyIt
         dTiB6Ib7clDV/N6VWMUn/KlIycbdXIcD4iYTlp3uCkfh0HetCts5qpc26FL+0i2BJc+H
         St7baimL/2e9s963qWjUKS62bRjZdZ1pz/3u5r3MQOAnZSiT7ZusnkAceguWHaRH277T
         OkJg==
X-Gm-Message-State: AOAM532kfEfw2+ct7pOFnLkJWM6SpIMGkvjZhv9maSzatBfOK5EZjtTr
        M/fNmmMiz8lWUKlMxikc86CKlKrhO2METTwdz+L/gQ==
X-Google-Smtp-Source: ABdhPJz1/708zpvypccyPVVTBws21KyJToPY9rQKjjUg4mtn6ZsOwkottpFEbqjg9GpU0LuekGO0ZcSSR/wm9EW5J7s=
X-Received: by 2002:aca:57c5:: with SMTP id l188mr721993oib.161.1601453815621;
 Wed, 30 Sep 2020 01:16:55 -0700 (PDT)
MIME-Version: 1.0
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 30 Sep 2020 16:15:19 +0800
Message-ID: <CAPpJ_ecS3LOYUMdrodMoxMRQ_4q4M06uyGzBBf+W8MrjP08-EA@mail.gmail.com>
Subject: [QUESTION] Enable the wireless module on Pinebook Pro
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to the preloaded system Manjaro ARM on Pinebook Pro [1], I
found the firmware files in ap6256-firmware package [2] enable the
wireless module, including WiFi and Bluetooth.
If we want to redistribute the firmware files to linux-firmware
repository or other distros, which kind of license should follow?

[1] https://www.pine64.org/pinebook-pro/
[2] https://gitlab.manjaro.org/manjaro-arm/packages/community/ap6256-firmware

Jian-Hong Pan
