Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756811B06A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTKav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 06:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:30:51 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BvN7RLIcpSybBv1y35pdwDqup1KO/lx80cy/owfczXc=; b=hG44Nr7nPMFdbwohdRdRqsqd4O
        KPfyFOaQnj6Nd/qTgJrlYLRL8/HMJH3pPoegG3D+s2e1PBGuAwLQcwLclGvUyztN+I7aBv/50YMLb
        3L5BSE7FyjJVNMJtfXRrXxUk20eDLemhhEGtFvfv6oKGiJVwWQrvOOuuRdZ5DO65gC1cHvkJGBE+h
        2Jwgsuo6P9Twcs4/Z5S+MCAQemg+qHiWJtAS5+j10i3r/7eZiYaY3KIxpiRaj/ay350z7/EYgoqY1
        ckVSh0trQXh3Rm0vgvulQ0MuuIoPsv1iXzU4Z+zHwemozCc8BUz/zkLUJqRTTBESdJKR5p8pD6Wj5
        GzAX0AIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQTh9-0002yc-MO; Mon, 20 Apr 2020 10:30:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49A763010BC;
        Mon, 20 Apr 2020 12:30:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33BAB2B8DAF29; Mon, 20 Apr 2020 12:30:28 +0200 (CEST)
Date:   Mon, 20 Apr 2020 12:30:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: hide __pte2cachemode_tbl and __cachemode2pte_tbl
Message-ID: <20200420103028.GC20696@hirez.programming.kicks-ass.net>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:27:41PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series avoids pointlessly exposing the cachemode to pte bit
> translation tables to modules.

Nice!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
