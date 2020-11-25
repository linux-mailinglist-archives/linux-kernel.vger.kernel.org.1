Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED12C360C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgKYBGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgKYBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:06:15 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDEC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 17:06:15 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x85so543366qka.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LWSBBypiCceYz/1N+OWyFHqimM37DnMC7WIdp8v8J/k=;
        b=jyGmvyKvKBnpsECtCqsQ05tvZeBdxw4pog6NJbouHvSP9CR87rizr49l1VOfFiqmJd
         lsad/3QmnSzSrs3/Kt+zprZUgGWDWkrLtyul16lu9fL2M2GHRnmx+kftXIMCU3AeYebK
         FmVV08ySI2sYobf17rPqU/Z8jf48+GAJj6qiUakYYdAu/pV7ELgHuZH+kV8SYaxLeGck
         1AHM6g+tdIbe5osN/ZYrVRHFBWkU1dEV4KJNTfnppwxfQpKSHHFPJFKTNbm9xxO3BJq6
         6D0e6qhwpLUEpl4Heuo9r4j2d/hgPbt119r2vhKfFqbVRo6BH0oSke0+DDx/tZ9JSxWe
         3Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LWSBBypiCceYz/1N+OWyFHqimM37DnMC7WIdp8v8J/k=;
        b=bg+OLM6CJb5xiwCX9Sy3z/uc5O5rFWS0Jcj5T7SkvdCCIo9fJNE+wx14wcQSlTVeJR
         u8dNB2UNw+5CMN/gDM6USOr9/dnN/zIxTlUmasA/3WCjGNDwMrAS4NZf9QUSLwDXAlB2
         XqHGV4wsrCasMvWRIxya//fffeZ3OcupKGvJry9yMkP7SVSk2PHDPu2zsvPLCChA6YF4
         ffLkEVJns7RCLW8TiqmOJiNww/7rjBxlmGcmlYO6DgOIYvm20VNDQc+YPvGy8XNnxAyC
         gjeGUON5q2vaSS5wLp8gcwjkDHA1NQUokCwE4u1mqxsDDtmig9c8KIHyaZS0C0lRgU1h
         dhNQ==
X-Gm-Message-State: AOAM530UKTz3TMzUaX0lnJjN2tlg7e47GgZUrY0U8APIJyVUSG5mMEKe
        A/ein7uaWKZq9iWULt0nJ1Ab9YqDrYY+ZLwPDKE=
X-Google-Smtp-Source: ABdhPJxvBrygdk3HdeyKFg8OiHokuZgJARvcPMf5W/jLYdLDdZrass7OjAchUIBzbGPqv7UTIiHa6r/JHP55f2N2wQo=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a05:6214:17c1:: with SMTP id
 cu1mr1033248qvb.32.1606266374502; Tue, 24 Nov 2020 17:06:14 -0800 (PST)
Date:   Wed, 25 Nov 2020 01:05:39 +0000
In-Reply-To: <CAGETcx8unBFUHxM67VdOoaWRENGXYoc4qWq2Oir=2rUyJ7F5nA@mail.gmail.com>
Message-Id: <20201125010541.309848-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <CAGETcx8unBFUHxM67VdOoaWRENGXYoc4qWq2Oir=2rUyJ7F5nA@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 0/2] Adds support to capture module's SCM version
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

I have updated the patchset to:

 *) Include Documentation.
 *) Use a consistent output pattern for the SCM version.

In my debugging, I found that the vermagic reported by modinfo can actually
vary based on how the module was loaded. For example, if you have a module in
the initramfs that is newer than the module on disk, then the initramfs module
will be loaded (not the one on disk) during boot. Then, when you run the
command:

  $ modinfo MODULENAME

The vermagic returned will actually be the vermagic of the module on disk and
not the one in the initramfs which was actually loaded. With that being said,
adding this scmversion attribute ensures that you can *always* get the correct
SCM version of the module that loaded.

Please take a look at the updated patch and provide any comments you find.

Thanks,
Will

Will McVicker (2):
  scripts/setlocalversion: allow running in a subdir
  modules: add scmversion field

 Documentation/ABI/stable/sysfs-module | 17 +++++++++++++++++
 include/linux/module.h                |  1 +
 kernel/module.c                       |  2 ++
 scripts/Makefile.modpost              | 20 ++++++++++++++++++++
 scripts/mod/modpost.c                 | 24 +++++++++++++++++++++++-
 scripts/setlocalversion               |  5 ++---
 6 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

