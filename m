Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E65295826
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508117AbgJVF4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508109AbgJVF4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:56:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D4C0613CE;
        Wed, 21 Oct 2020 22:56:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f38so8890pgm.2;
        Wed, 21 Oct 2020 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWOuB16AvGHTkHw6KRpIhtSX/WjKIiIbZR5t/2RTblQ=;
        b=tQUSUi8V5OE8/U5C0n/9jTHq7ebXMsPegcM+dRWzsnTYSn9FHHzirtrt1Plk0mulTc
         ga5uUod0Si9tGY1wP49Psu62N1vCjeOkhfdujanU7KhgeppYE7b86Frqxpbqi7q69Ip/
         X4k1wiMFVLLdEbxoLvbburGYZa9mDOsMb3SmhpsNK+hMtKgOwxoV8B73nPZfXEnti0XP
         PgcWRR0qfbjm9DQheISTjJbQLKx3frinMh5vksKOy1yASvCtgZ8mowgFL43/ixyezAiA
         Xp0jXDwros3LOz3rYtdAODDm/2kvngIy1sUgtjVKEkly/vHwK8jDbir6IrM1qRED4GJp
         lWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWOuB16AvGHTkHw6KRpIhtSX/WjKIiIbZR5t/2RTblQ=;
        b=gvcdAkWagPKDRIgyhcCGzAww7XpGUy+Az25zYqDocvx1LLNI8NPFjmBbwr0bR1NUAy
         uC2PH+6MOFcPZ+FVYgYdtYY/MyVcfc/12gmjKyZ3MyhaxEO1WzCiBkuUXKiuqMfN2KA1
         36a10KbM2GZYmMa1mMZGjHxhfn1OdW9d2PG/B+xT1P56MvKsOmc8681O/rMJ/vq4Ks9C
         zKX4PvjooGzK4PNVL43Xjy1qfc8PK3JPnnB+dtkDfE1ZomVP72LArYXxgVqG6d/KysuC
         acTXAzIUQzsJ5zekBQklIPi0NaSdzbWKq0a7aTAFWGTUKodFDzXiXo3ZQzt0TtFR7gI/
         Dk6w==
X-Gm-Message-State: AOAM532MtOwuXsoB/roYwMEaCoEtc+Uq14zDKwOLJRn/j8oNVcbD4iLF
        uYZsneMq2tV0FSQJr6QT4dLjdHRGKQ==
X-Google-Smtp-Source: ABdhPJxZfFauT3BfGs3U+kT20nZ/roX+l+EaGF10Wt8pdIq0lYDnd+ybv8xfhMUczwOL7PWfnTaiAA==
X-Received: by 2002:a63:d252:: with SMTP id t18mr860263pgi.300.1603346210883;
        Wed, 21 Oct 2020 22:56:50 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm830995pgi.14.2020.10.21.22.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:56:50 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 3/3] Documentation: introduce a param "irqflood_suppress"
Date:   Thu, 22 Oct 2020 13:56:03 +0800
Message-Id: <1603346163-21645-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The param "irqflood_suppress" is helpful for capture kernel to survive irq
flood.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oliver Neukum <oneukum@suse.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a106874..0a25a05 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2009,6 +2009,9 @@
 			for it. Also check all handlers each timer
 			interrupt. Intended to get systems with badly broken
 			firmware running.
+	irqflood_suppress	[HW]
+			When a irq fully occupies a cpu in a long time, suppressing
+			it to make kernel move on. It is useful in the capture kernel.
 
 	isapnp=		[ISAPNP]
 			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
-- 
2.7.5

