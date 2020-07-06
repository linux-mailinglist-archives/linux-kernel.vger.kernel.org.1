Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE503215DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgGFSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgGFSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:07:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74980C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:07:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id md7so2225383pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TtTy8zAxVVVpMKoPB5sObxEUTYAxQ4ESDdw3dI7IOfA=;
        b=oaJIJFgUBmb7qZXeWwHQwIJgUXFmUxHmjzR/a7ly4+R/L5J6R2D0uaBXx6qjgig7XL
         IcTfx+7t20+5Z9InaIZohd+NXxgQroM7drjaj2oeyhSmyGQyPuwslXxB08Sr1k/TFIrt
         3vjcEts6w/HrO1mJ2/Wm0DA4nXEfBdTSDzWhRgorpzUGd6iUTNwuHKtQy8qEvPBNDmEi
         I8CN9f/N0NnZkCGRw9NQPNyVWTqZX2D6NQEQh6NkVROkIEj8xEOFG1mjUJ9J9t2fTGpK
         Vs/AuIQZd8mOC96Bsi0mfi8wSoU4KUR+ozHTEGiBwRV2YYf7jrNpWFfYb83DxP4DcZJi
         NMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TtTy8zAxVVVpMKoPB5sObxEUTYAxQ4ESDdw3dI7IOfA=;
        b=oDKQitj8jGJSlN2VVCzuj5TP7l5V015fAy6kAxV3UP6pzz3tuv8Agn7eKbHT6CKHCu
         qHO8wYaHMkexdjld9XfJ//i0aYG7bKPo9/7DBcszMKRdZTz/Ub5k4hDDmMnKUSG+CzYO
         IoQPcRHvoBm0dppR2trDP8wDzmJoauFrEYeE/8hbWbB99HiPHFg+awVaMl+UiD1hiBQd
         8mo50qxISSpBpgOthCzX2fJLqc9OOxQWc7KdyQCh7j+7bg/DlrfndpvCBZlI1CgxxzE2
         aAQnRPraqT1E6lYqZIqKMUexNLyjFT4cASry2mXVE5hDh+Eb9t+elMLogcTCKfCVBZH8
         Gvsw==
X-Gm-Message-State: AOAM531fN2ZcPoHAlN3e45+73xiLwFHVYuczp+begn6dEHsbQzA5AFi+
        MhhjRqypjClb45aV2VJkSfQ=
X-Google-Smtp-Source: ABdhPJzylX3osTAYA+Y6HJUZkzAC+UoJPBxpVk5NUh8tucD8BuQqoVsDbrqW5FAUg6C5IOlbZXlbQg==
X-Received: by 2002:a17:902:c206:: with SMTP id 6mr19932000pll.30.1594058877935;
        Mon, 06 Jul 2020 11:07:57 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.43.125])
        by smtp.gmail.com with ESMTPSA id 199sm20425544pgc.79.2020.07.06.11.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:07:57 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v2 0/3] Few bug fixes and Convert to pin_user_pages*()
Date:   Mon,  6 Jul 2020 23:46:09 +0530
Message-Id: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains few clean up, minor bug fixes and
Convert get_user_pages() to pin_user_pages().

I'm compile tested this, but unable to run-time test,
so any testing help is much appriciated.

v2:
	Addressed few review comments and compile issue.
	Patch[1/2] from v1 split into 2 in v2.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>

Souptick Joarder (3):
  xen/privcmd: Corrected error handling path
  xen/privcmd: Mark pages as dirty
  xen/privcmd: Convert get_user_pages*() to      pin_user_pages*()

 drivers/xen/privcmd.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

-- 
1.9.1

