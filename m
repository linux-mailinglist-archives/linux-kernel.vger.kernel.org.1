Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0461A2D6DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbgLKB70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbgLKB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:59:09 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97619C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:29 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x20so5341143pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=X3AoiKidQ6crGHD5wFDjzqhurb9cqFSlsgkfzt0x/6g=;
        b=rbpEnMrvqzGoVBNEIxdvmt42OVp8gS2HseDuthH7KFwBY5/+swso8bllcGKBG5An1L
         TUglQYQE+3XhjiQuyEFRwqrPUOujWVnEclYdpKlUp7pCuhIiFjeoYVg0XvsstAkgxC2t
         XrAVUToqYXxT+Ee0H0V50oxqPrfEDXVPSt/FXpese/7yWEuSvWHUJaMILffHwRKiy/e7
         KTaLsUDvU1rlfk6Z8Yd+82HK7spF6UWrh1Tp+GsQs8DkLR6z6+kM2m6NZpps5xetM06W
         kqzG4Jj+a5dteYxsTf6kTNEWwJJimL1bpOrMuJrlK6BE46MpknEqHgHyOuuBqwwbwHwR
         iRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=X3AoiKidQ6crGHD5wFDjzqhurb9cqFSlsgkfzt0x/6g=;
        b=F51Kjq9s+8UKzESizw80AKa0MeZLPSuEQOVakHyZt7jvz3jY/4ndHh8Pa2+T31FPTW
         VtCTGOwwuMutByDen8dwbWb2OWaGThf6Kpo+Kpa9LPunJ2glRUHSWdEZhPv7t6lP3M9a
         yuue1xH+OLUl/ZVcW2OVriCxI+qLHTYc1lCC8iq7jKXFaA5RJ6Y+auyjsB02yFf4tv4w
         8+h8gwWpSDypZXsBJLrs0KRHsrHOJSgrWO0j96haWXfM/96pYB6I05FEFxd1AKH9S6Fq
         JeQZaUDfnUY61nQCLyMKRE5pr7kz85WwZqcPi7xj+0A1EEhil6YTkMSEJHr4Fo585Cgr
         We4w==
X-Gm-Message-State: AOAM531nxa48Drvg/7z0UjUSh0aGGjEyVekyUk8Hy5UC4fuXUx9rPoaP
        niFFsQWai0ZpDOAfQ5L5l9rxvWfRK5y7
X-Google-Smtp-Source: ABdhPJybdXTxqR8G4ayNenBgynQQS10dU1MLFcc27pOkmymWS6fT/KQpiZH311OrIaDRhnBkIpfxy4Ssx2Av
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a17:902:e904:b029:db:c0d6:5823 with SMTP
 id k4-20020a170902e904b02900dbc0d65823mr8660082pld.11.1607651909009; Thu, 10
 Dec 2020 17:58:29 -0800 (PST)
Date:   Fri, 11 Dec 2020 01:58:19 +0000
Message-Id: <20201211015823.1079574-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH net-next 0/4] net: avoid indirect calls in dst functions
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: brianvv <brianvv@google.com>

Use of the indirect call wrappers in some dst related functions for the
ipv6/ipv4 case. This is a small improvent for CONFIG_RETPOLINE=y

brianvv (4):
  net: use indirect call helpers for dst_input
  net: use indirect call helpers for dst_output
  net: use indirect call helpers for dst_mtu
  net: indirect call helpers for ipv4/ipv6 dst_check functions

 include/net/dst.h   | 25 +++++++++++++++++++++----
 net/core/sock.c     | 12 ++++++++++--
 net/ipv4/route.c    | 12 ++++++++----
 net/ipv4/tcp_ipv4.c |  5 ++++-
 net/ipv6/route.c    | 12 ++++++++----
 net/ipv6/tcp_ipv6.c |  5 ++++-
 6 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

