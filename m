Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170D11BE2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgD2PiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgD2Ph5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:57 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1302C035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=APwIRecRnjGUH2eb3CGxLwLNtFCkNs/Jq94banB90BQ=; b=0BobqBKFTaTIIPk45Fsf/h1XUV
        lwCgKshooE5fbFDmJWtsIyKOnomC5S/AMfgnwmxtDdeWngwrb3+ckHe0VXZyswI/11lMNZ5/Q1xLx
        PcjzbGmZEmkYkwHWX4wqOGVLkLaVLdFDGVEyJqV6MuUgYDNqYZx38ghAInmQWaaKmEuj2wuoQ6SMr
        BPStBSofuGk9dtcX/xcUOlJn1WM9faneSeV/hJzBY6PvSHPjo94MXVxrWVvZi5Flh9IjJDX6bEHWw
        tAEagzdn3cIS3HDaqqKxGwVlaR8KScDZcXCB2ZOewrMQmaHEUR/Qzu79pEJdJi7jAwaWmU/ydmPHH
        vojWK0+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomG-00028Z-2q; Wed, 29 Apr 2020 15:37:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13A55303F45;
        Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD4DE236D79EE; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153258.563269446@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:32:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 0/7] Generic RB-tree helpers
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An attempt to reduce the rb-tree boiler place..

