Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB90285947
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgJGHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgJGHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:20:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:20:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gm14so606850pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=AKIEEcKeE8/9i9HUsSzlMQgzbQ/bmUdgtBYl5wmpO0Q=;
        b=tLsGziNKPTqjyqaZhoPQxWKDGkRg42i7n+a7StQGVjqHPk/18+jFYQcN+JtvcUdbjg
         FdhRn0cyZrF0iXzbvUZmtSxc0o6QPL0BiUpt1/Frl3880Qs3MEtWXXFqGZKtQnwqFqdA
         U4hLtU5vhQupIsWWl6bh3i3VUMDzvs5Na9UmCREAXxAI4gH157cnhFtJDhJDDyoKh46n
         WJfICHSuMPvP+4HDvUIQEbot1X0Pw+XR6atyNBnCiJYuuNilrzk02NXt22ojv/9KllSq
         XjMfeq36Myv4E6og/vUgow2v2D53qDyu3Ue9QLYx6DHmACoisCj50x9RhFZMfXMiAoGJ
         vltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=AKIEEcKeE8/9i9HUsSzlMQgzbQ/bmUdgtBYl5wmpO0Q=;
        b=rxvpZvZSeCWO7KrxW+IS2xTh24u2vFdMAp5ybBaXKZP7aWyIicAU4SA3RCasQIhtHl
         jQDejYXh/m2d+DaN+od8qfVHrM2k7wm0DkdafGmFN8WzDH36tgoFfUmZ3yVLLkD9WRY0
         h7+xr4HbaqOpZqLlttSDbjlOtBrbvLYujMVwwtPooEkGpmzTgZ5uSt6zCthmBc3nW625
         U6lNOAD/AU7Mayn6Z5Lm5TlWbIDJsERsMjRlr1TPZgtGBq0skCP0tNp4roYVVDT4DJJK
         wyxsxsD0xpDUHUREbB5W1jjoA+nsHcdlXL3ckRhImMeF+Zeg+wh9BsI7zRDcmkwLR+P/
         3IRg==
X-Gm-Message-State: AOAM533S4V3MXYlHa3Wdqa7c67u2HMmb3MBkDvghut85t66gJuXb73/H
        CBvc/+3Ammicoh+t27gj/bNHSM62wUYHWQ==
X-Google-Smtp-Source: ABdhPJxRe1m0UNaavWieph1r3PU8iks0BQhqTlr68cM2slQKW2iaOusuqgrYJDTQeR1a+o7C+fGl1g==
X-Received: by 2002:a17:90a:e697:: with SMTP id s23mr1683200pjy.16.1602055216182;
        Wed, 07 Oct 2020 00:20:16 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id o1sm1662676pgi.41.2020.10.07.00.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 00:20:15 -0700 (PDT)
Message-ID: <9846b9ef4f8dcdac543270c3268d1ebb31aad6a7.camel@areca.com.tw>
Subject: [PATCH v3 0/2] scsi: arcmsr: use upper_32_bits() instead of
 dma_addr_hi32()
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 15:20:14 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.10/scsi-staging.

1. Use upper_32_bits() instead of dma_addr_hi32().
2. Use round_up() instead of logical operation.
---


