Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAE267B79
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgILQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgILQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 12:56:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768CC061573;
        Sat, 12 Sep 2020 09:56:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s19so3569817ybc.5;
        Sat, 12 Sep 2020 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xbyA/GhLmm802k+NpQuEmlW1nB1YSqQcPl78ocdQUxI=;
        b=RspZVvO/1mKx6D2LOsPL+aZNZNNIC/vGR+qHNBeyJzGhQCVXJ+ituaqYg7B6v9epFy
         mxBii+UBLK/eHGxhBfLMj0Oicaky2lQvwEtY0rRD8F9BQayzMLY9Bd5Dmr8Houek4sx3
         jY5pB0knNcT9IFOzj5LfULTxvTxpHJqm9Dhpa3M6ryFIc2YItyWXGgWDj5fQMJhm32NJ
         Ek4YT7ZnFPbpIWGylaCGntLuNSwhPsY+QsxKt4mfEQKJdF1JsnYsiUxIh005g9d2xJf4
         3fFGJqNJyq2AmC++Gkzcx50VPSjrItX7zdXVJI+UWxbnA1X3HiBriROJyaiwQUQbzZlD
         cbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xbyA/GhLmm802k+NpQuEmlW1nB1YSqQcPl78ocdQUxI=;
        b=agZPtDSRZp5jB5qnXhEwRy6eCzj/ldhzYX3nXHBwSdJoa5azXv9fYOEpdkGGtFKzIw
         qhZQ5prwCem1PQRUTMNJ9i8+0Ci5UJK1ud+rg8qQPzSWts9HNT1eWVaM0r1U9QCgeuMe
         8Hk5JTuI7Hb9XcSH2OQtMP5eEeL8F3u11eh8QK5qCZAPetDcucEwLJvsiNL6xT679gke
         EHOOfxN0ihn0QGT7VvSj3tbxjhJW4lboThJwYgThijO7BTTGZW6X+CuKO+tv0hCfjfYi
         3XAjWYJsS5AqBu2G43yR1mD/B43BMEz9O1WbcW/rEelGR5NFboqlymROR8mX5LqvZcOP
         8q/g==
X-Gm-Message-State: AOAM530Fx71k/E3vBGiYCGdcWRIcBGDiUS1x4iKqdkaUi+tCKp1Y9esl
        rI/MZXsm3FihJWg5N1imZ5dUeV0/3O2B7/HUftM1o177klj8mw==
X-Google-Smtp-Source: ABdhPJyTf/Ip4GuS/Xrb3Tji3rm/XPTp+9A6BkGZjR38cCVzIGAK/BSMjzkQVTEiAIRdZFEH+zPm8hywKiqUVyYSCtM=
X-Received: by 2002:a25:d4b:: with SMTP id 72mr10009412ybn.183.1599929816545;
 Sat, 12 Sep 2020 09:56:56 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 12 Sep 2020 11:56:45 -0500
Message-ID: <CAH2r5mtri0syQbck4DG0o1t9Ri8vHmb_q3PUg0nca7nHbnLTQg@mail.gmail.com>
Subject: [GIT PULL] SMB3 DFS Fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.9-rc4-smb3-fix

for you to fetch changes up to 01ec372cef1e5afa4ab843bbaf88a6fcb64dc14c:

  cifs: fix DFS mount with cifsacl/modefromsid (2020-09-06 23:59:53 -0500)

----------------------------------------------------------------
A fix for lookup on DFS link when cifsacl or modefromsid used

Build verification test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/397
----------------------------------------------------------------
Ronnie Sahlberg (1):
      cifs: fix DFS mount with cifsacl/modefromsid

 fs/cifs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Thanks,

Steve
