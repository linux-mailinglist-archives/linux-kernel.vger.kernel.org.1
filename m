Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F82C8B53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgK3RiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:38:04 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40710 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgK3RiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:38:04 -0500
Received: by mail-ej1-f68.google.com with SMTP id x16so16212204ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UBT6fTEWtUd9R49XUDZESBBRbGj/Jw1ncjUui20BQ8=;
        b=oxMjuJQEClanxQTeroqWQtajf3nSETQvB1Vg8dWBMR+n+jZBpfvgmkdljY8z0HHMn4
         sq8neUNMKx9bYStVOYENSlCfuMfq6kENJRLSRlTi+9er4wuoOlkEa97LFLGZWTaV21If
         5udlnhXqjkqXgPu0DP9eNgmUHOy491f5uq48GalqjSmxUnhapLY2wKlQrcVDocGyAz50
         8SL3nuAwFszhenDKshMgiAcsZzKmgrmvWmOQfl2t+bAQGjwAlo2nz971NPs+d/3xGUAM
         K9MmW10IGv6KP+o6AQZeXDdnvnzr1G7mfnXNUMkEQX47su2XEIgAp74YLE3O6U6i+lDr
         9SkA==
X-Gm-Message-State: AOAM5300VnvH+KfhfBtByMyLu82AJnNItxW2wH7WqwFaBj3//d636HdE
        Lz9e4O6IwLbkzz46j7yIfKFmWi9o7xYbE3R5
X-Google-Smtp-Source: ABdhPJw/xNkXfBaVZm4xbpMfpktw186S9rtVhUJ7Nhjb1L2akPuQJekszImvLa8EsUzdk8KJgERnBA==
X-Received: by 2002:a17:906:7813:: with SMTP id u19mr21999777ejm.153.1606757842646;
        Mon, 30 Nov 2020 09:37:22 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id qu21sm4959856ejb.95.2020.11.30.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:37:21 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] reboot: sysfs improvements
Date:   Mon, 30 Nov 2020 18:37:15 +0100
Message-Id: <20201130173717.198952-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Some improvements to the sysfs reboot interface: hide not
working settings and support machines with known reboot quirks.

Matteo Croce (2):
  reboot: allow to override reboot type if quirks are found
  reboot: hide from sysfs not applicable settings

 kernel/reboot.c | 58 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

-- 
2.28.0

