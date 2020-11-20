Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07B2BA992
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgKTLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgKTLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:50:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zI+nc36ErlTWClwueAha1W2gAtMlhwLJWOY1BMsravM=; b=HIHA92ZgX3OpfRzsmpEGGTtZHA
        MFiFkjwnrqZ7I4CvGivth3BikCapiwbdFWAEcDVCdPXrUnGqu+q+HqhcS6CBkeKTpFCpkUTHuhRnB
        TXhk6CTmxZB7XkMJxzwSP03rsML0qJILQKoV+GTSygN3cKpcJVaSUB5EOu08shMdUmkIdkPIAxHhU
        XEmzNRpj6NnBh/pDrgj5f+kOIrz2OgxjwtpQvt1F60KUsvJKs+v1tEy/B0A5R0J+3tTVo3ggDnGsF
        mSoxvu60OaiAXTqXjYKY5BZAbNwX7ae4cNMmqMeH18SL0/xAGyVbSKsDgKYpMblMfr7uMILpd2GSk
        gUgLzs/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg4vl-0003xA-VL; Fri, 20 Nov 2020 11:50:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AE5430782A;
        Fri, 20 Nov 2020 12:50:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E32EC2B06A142; Fri, 20 Nov 2020 12:50:19 +0100 (CET)
Message-ID: <20201120114145.197714127@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Nov 2020 12:41:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org
Cc:     x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 0/2] More RCU vs idle fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Both arm64 and s390 are tripping over arch_cpu_idle() RCU,tracing,lockdep
interaction. While looking at that I also found fail in inte_idle.

Please consider for this cycle.

