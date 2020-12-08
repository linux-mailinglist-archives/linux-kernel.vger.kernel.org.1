Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520D22D33DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgLHUQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:06 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:39388 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbgLHUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
Received: by mail-yb1-f202.google.com with SMTP id v12so24113775ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iPNyURoyyg37PtP5buaF7be4u+mklyusgvVkQ9lf5c4=;
        b=d8kI5DC6RP4DJ49rtv3HRDmO4lX8xauTeqDg/yxTGOoLSDqV4wdfCyFv+CcWvtjldX
         4ejQ3sBafhcxKGySlAHEv1lExckfO6zdtRI3cxmx+Ps0/PWoqXlh3RLRpjVB8eeFRVTq
         5BuqliT5XjXJdQBUHIet86bv4wvG53o48LmzyhRCFmL5UfX9v3Z1Dmh5U1T2edPYRjYL
         Gq0RyizZJ+a2Das9vAKJIf17GswbLZ/KzC9s/vsYO/GA5lZko3lLclFbZ0k7yRwaHg0S
         g7jUg2MRJ7776jHriyV4cRG32UwIwgIKjnpRF2H/P7xImiQdCgVrcUHZFHZC3xzUylYD
         PfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iPNyURoyyg37PtP5buaF7be4u+mklyusgvVkQ9lf5c4=;
        b=s28ceRaJxDCt8vw74PDPairgyLz4yaUpCfpjwtanbVVt5KHqO+Cep8umFQZhf40dUy
         bYY+ZFNGYrx0Lz+H084raT3lrTQuaP1GIoG8Gwv5EKDJwa4MUA7RxMj7ncKtOtFQCc5B
         5aX2T22Hw3IKxKgHFDNLFd/kZy3jQwKsi8bBnwcE9vJXjOmEfAE1USkVU9hgBNzwrrxd
         Ni7BXY3kElTHh+RwanxrdgnN/eYFKdptv+GKCnPQtxgMf9hzLRJoLs+oVN+IDt2e3uJR
         HtJCbtuHLNUKsQCpi9lPJgA1qYuojPdxacbbRhCDaBbiXgH50L+1sYOQVqUio6+QvHC+
         9aew==
X-Gm-Message-State: AOAM530465+WwxZJIFxYgQxuYCnmvVpywE04TZIR2lD5O40Sr7l4nWJ5
        5TBC3M0mJ/TW21BJPWcG6GioO+wX426DJez6sUY=
X-Google-Smtp-Source: ABdhPJwMJgfuO061kxGkmUoA9VEBMsGmQvj/8WZA4Ev6G7KxHkHqqvemJJmaP6cJeK0oakrTQPUUr/G0FMzTPMjrftk=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a25:cb45:: with SMTP id
 b66mr27002244ybg.185.1607457914395; Tue, 08 Dec 2020 12:05:14 -0800 (PST)
Date:   Tue,  8 Dec 2020 20:05:06 +0000
In-Reply-To: <20201207153116.GA15772@linux-8ccs>
Message-Id: <20201208200508.4107399-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <20201207153116.GA15772@linux-8ccs>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v3 0/2] modules: add scmversion field
From:   Will McVicker <willmcvicker@google.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thanks Jessica for the feedback! I have updated the commit message to
include the justification and common use cases for the patch series. I
have also added the config MODULE_SCMVERSION so that this is not enabled
by default.

Please take a look and let me know of any concerns or issues found.

Thanks,
Will

Will McVicker (2):
  scripts/setlocalversion: allow running in a subdir
  modules: introduce the MODULE_SCMVERSION config

 Documentation/ABI/stable/sysfs-module | 18 ++++++++++++++++++
 include/linux/module.h                |  1 +
 init/Kconfig                          | 12 ++++++++++++
 kernel/module.c                       |  2 ++
 scripts/Makefile.modpost              | 22 ++++++++++++++++++++++
 scripts/mod/modpost.c                 | 24 +++++++++++++++++++++++-
 scripts/setlocalversion               |  5 ++---
 7 files changed, 80 insertions(+), 4 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

