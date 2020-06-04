Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC41EE26B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgFDKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgFDKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDACC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mArLRZM2rhn2tsk3MmdLOGj2f8ZPcyzKUmaO03kjRtI=; b=E1ja0y8TjbGhXVql2tI7qUV3DM
        A23QwT0REI46wybtTRxyq+CMyVXLWvduJVqY8NCK3CE41P2dfPbVmiiLQBZQaO1sFUK3WjQoD7MPq
        k3Y/oy0qRnLJ1ZJpp/gP+XL6DzLXau/TqJlwpO14WKvW+rAlbxb/+fbReHZSbaLkmjvWpwo0/a6DU
        UZm9cq4IqLiQXH9jAjGQojni0GqlnaeothLXuzs3iKJClpPQIwyJvuaTp1BwlHS/3tmfKGvMt/1Pa
        sYMFwQuU+bzTizDFTKq6+XUyt/YbcS7Y8X/0hEv2culXwDPYNZkwz/MjEHMYZH96FCfESQW7GPsPx
        K1uD7B9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3d-0003ta-4b; Thu, 04 Jun 2020 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBD5D304D28;
        Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D312B20C23590; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102241.466509982@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 0/8] x86/entry: KCSAN/KASAN/UBSAN vs noinstr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,

Here's the remaining few patches to make KCSAN/KASAN and UBSAN work with noinstr.


