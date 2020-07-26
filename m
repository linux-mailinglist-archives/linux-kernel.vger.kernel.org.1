Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1122DAEA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgGZAkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGZAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D8C08C5C0;
        Sat, 25 Jul 2020 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sQTU7EiSbF6nuRz5kddGWR7FHrJ/c2mknsP6KeJX8nw=; b=TJ6enFMzLeV5zQlaa0wsQaR6x9
        EVn+qds6ObDxyRp5091mg7rlwdeLV721xl8V6FU6q33bnkQnWQrT3dyU1wl6urHeHTVhHcuVTtVcq
        WQTc5IbdqAx/18f/aEyLhUUPDzBQIijc/gdgDxxjxg9iWHnLCRcx3Va3n4XbQJBINdmlFyOwhWHeI
        wWGPzdGICsh6Mbb6cy8qi78rCybrgs8iK5MVwQk1QYoA8/cIwwvicyyjP7tU4KhIZYRtyoq6VY1tg
        ROM0bJb631sdQj4diQSaTN/r7GNjXX14JtWiYhJARf5M07xNY32fs5WQd3cfz78pnyszwqBmOTMh+
        FV/xk62w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUi8-0003NC-OQ; Sun, 26 Jul 2020 00:40:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 0/5] ia64: delete duplicated words
Date:   Sat, 25 Jul 2020 17:40:08 -0700
Message-Id: <20200726004013.20534-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in arch/ia64/ header files.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org

 arch/ia64/include/asm/pal.h          |    2 +-
 arch/ia64/include/asm/perfmon.h      |    2 +-
 arch/ia64/include/asm/spinlock.h     |    2 +-
 arch/ia64/include/asm/uv/uv_hub.h    |    2 +-
 arch/ia64/kernel/perfmon_mckinley.h  |    2 +-
 arch/ia64/kernel/perfmon_montecito.h |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
