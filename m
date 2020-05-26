Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0D1C963E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEGQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEGQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B857C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nRNvqqpNkZTiRT2IQrXGfSLl9ddKI6Js3+fjyzp6+VE=; b=HZX+bkQrQQhdtQE8qb6WXEzsIG
        UV4V8LkJUsiby1mdJjz32CBh356RSy/mqmMn+bcr9j5i0JkcVhiCtzOtKRM6XSvnkE89uYllvV03a
        CHOFlfGiuPXpHr98ugd2lFOPhJvZVGIIf27iEA512nzooOQUIzNRw2pqsg2HYNOMKMAO0cHvo7O3n
        Jnf2a0pRDxZiB6693/RyevzDMJptNAcb1Iyy7eTWxctxDbc/8cYktvDlhpYfM3CflAuupjFCKJm2p
        mSSzBia/zZ2RqeaNowf18CYliQhL9bg4LInYQo6j5R52bhdMCC6oy+oKW+5MLgudOoljDB0XUGX3C
        l95B9djQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjEf-0003RD-QY; Thu, 07 May 2020 16:18:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D2193012DC;
        Thu,  7 May 2020 18:18:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 484562038FB66; Thu,  7 May 2020 18:18:55 +0200 (CEST)
Message-Id: <20200507161020.783541450@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 18:10:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     jpoimboe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 0/3] objtool vs irqstack swizzles
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These few patches are on top of the very latest tarball tglx gave me and do not
apply to hit posted patches or his git-tree (although I suspect that might
change at some point in the near future).

Aside from relying on tip/objtool/core, this also relies on the patch I just
pushed into tip/objtool/urgent.

