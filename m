Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B11304568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbhAZRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbhAZHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:40:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BAC061794;
        Mon, 25 Jan 2021 23:25:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w18so9969184pfu.9;
        Mon, 25 Jan 2021 23:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5PII+l880JvLAxkfhvX3LNvZP6BvslBW+k7OQ9sST0=;
        b=je4p1rgUJWpMa/gR5V8yIpGwf5oBZT7F04Q/MMs8+GPumfbOUQN6D7b/BoaVGlw0vM
         IySs7mV7DvnYqoxls9D0V+OM1YjUR1K/ycIoJGiRO+x8niBLqTqxlhajqdv9yxYdrz+b
         zY9GaT910cBKPMwUcT0dZFiefnRvp8V2QUgIQ1Q2Pic6Uk9+bUuiSquFPT8cILgdpzy9
         6TM3HxlB7671Bt9bI/H9a3easEl6EGztlC6p88+QIRKVB2g7kFlanoIFsjxuzjlbOqZS
         bPjnhYdS4o9nyh6o3uHchlQlUSHjQTVSKkaT2kNr9fkXDkJboiPvNJLC1CGt9MMHmuBH
         qcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5PII+l880JvLAxkfhvX3LNvZP6BvslBW+k7OQ9sST0=;
        b=cS1cfdyvlhiSY/WajfK4B0fKQ29ar7wM/0/6JF+4jNqlb4tFs11fVWBbrTzXjLhEw8
         V0cPo8AoVGksq74xABMgNCQW8qu6LtR1Rrl28amv2mA3tk/wPSXjTZm7GGRj4VrfiMbr
         5vDuDD/9ZRSxdub/Qzx1EUBZkgjFZiZL213s+PnCtViCSit74UHf9SvTASXBmY+zjYq5
         cNsm2VydvpjKkVKQp1p/MKZ+X4WWX8RYKXViRiwbwKCASHBaxmYv97NVD2E1VcKvoo9b
         ior/BjUx7iYDpkYm3DD3BZHFpGnVaJzCtqfjqLwpwSxSiZLH/bnAh4WAuZT5fQO6y342
         YRBg==
X-Gm-Message-State: AOAM5302pm8ZBkCA8BUdfjowTVs2QBDdw0294o5JmSS20uqqZgSE51wd
        t2K4CRol8zkvd0+v2OIQWpQ=
X-Google-Smtp-Source: ABdhPJyNTDLzw55L1eyjlYdCYAAcT9e9t6gJvUSDlB5zTNc2b+7cygnQ6TfCrROKaMfqJ2x/Z5Lz5g==
X-Received: by 2002:a62:a11c:0:b029:1ba:bab6:6b02 with SMTP id b28-20020a62a11c0000b02901babab66b02mr4218858pff.51.1611645939743;
        Mon, 25 Jan 2021 23:25:39 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:39 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] docs: path-lookup: update get_link() ->follow_link description
Date:   Tue, 26 Jan 2021 15:24:42 +0800
Message-Id: <20210126072443.33066-12-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_link() is merged into pick_link(). i_op->follow_link is
replaced with i_op->get_link(). get_link() can return ERR_PTR(0)
which equals NULL.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 921779a4636f..2bb3ca486acd 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1137,10 +1137,10 @@ Symlinks with no final component
 
 A pair of special-case symlinks deserve a little further explanation.
 Both result in a new ``struct path`` (with mount and dentry) being set
-up in the ``nameidata``, and result in ``get_link()`` returning ``NULL``.
+up in the ``nameidata``, and result in ``pick_link()`` returning ``NULL``.
 
 The more obvious case is a symlink to "``/``".  All symlinks starting
-with "``/``" are detected in ``get_link()`` which resets the ``nameidata``
+with "``/``" are detected in ``pick_link()`` which resets the ``nameidata``
 to point to the effective filesystem root.  If the symlink only
 contains "``/``" then there is nothing more to do, no components at all,
 so ``NULL`` is returned to indicate that the symlink can be released and
@@ -1157,12 +1157,11 @@ something that looks like a symlink.  It is really a reference to the
 target file, not just the name of it.  When you ``readlink`` these
 objects you get a name that might refer to the same file - unless it
 has been unlinked or mounted over.  When ``walk_component()`` follows
-one of these, the ``->follow_link()`` method in "procfs" doesn't return
+one of these, the ``->get_link()`` method in "procfs" doesn't return
 a string name, but instead calls ``nd_jump_link()`` which updates the
-``nameidata`` in place to point to that target.  ``->follow_link()`` then
-returns ``NULL``.  Again there is no final component and ``get_link()``
-reports this by leaving the ``last_type`` field of ``nameidata`` as
-``LAST_BIND``.
+``nameidata`` in place to point to that target.  ``->get_link()`` then
+returns ``0``.  Again there is no final component and ``pick_link()``
+returns NULL.
 
 Following the symlink in the final component
 --------------------------------------------
-- 
2.30.0

