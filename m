Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D104C2EBFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhAFOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbhAFOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:45:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3FC061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rgGPVOkF2KxjpmEVeg268qciPrWVOBYG39Qj7KEGYUY=; b=CGuLMcUmD3T3q5phsqroPB2I+D
        EzpJlYs4/AT1inZsCQC+OUE96h77g9TJQQQnDUEDZZ52uK2BFGpoIsYnvjn/mrb7M/xSFVnt/AqiS
        noae1qik8saIPSvQojjwXCToneZiVbDVvVW1re1kUoY/Oplu1SSLZ5gbqQI/SDfPk6fgRJ/HSKHgY
        ByrA59FrlZtrGTa1PJP+Vy8Gq+Fm38aJ22k7DEyxC0dEWswMkYa9XTb0QiM/HnVNblZmPWT/O/42J
        j/+I8PJstwut47Cq4P7ZhEltoWqA5MGj43oWAYpfb86HFqiufZohLQOh6FB3X1N+EtXsm4p28/JeD
        gRfKfHzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxA3J-00085P-VO; Wed, 06 Jan 2021 14:44:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC8AE307936;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A09E2029F4C3; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106143619.479313782@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 0/6] x86 noinstr fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With exception of patch #6 (which I'm really not sure about), this series cures
all noinstr warnings I found today after looking at a report from Randy.

Please consider...

