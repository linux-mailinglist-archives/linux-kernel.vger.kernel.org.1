Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920C2B4AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgKPQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgKPQXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:23:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12800C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9jSNlyGIwtlF+yLyE4fC/j/fuiok1x6YoEBYmu7faEM=; b=f0sAtF7SYkRCHhdCP9mnkqFqHT
        5jEyv+cHLIArUkT6ZJJtg+ym3XgsRStwm1gp0uB6WMOjx1Dy+ocwtapCyNsBWVg4b+S2WJ7Y1LOAe
        uAKd8BVG/T5TIgO0zWvHqTFZibgOHwE/y1Yvq2JrYKekQm5oJ/5ix9TMo8TZhhhz7lEv+xBaZbBmJ
        /Df/Kmp9kNJWkTfR6fmVxuBAGIymXt6H6Utd6Z6Hy3ewyVmLSG93oGz1nVWez/vNvZnKdjpHZu2Xt
        7dN5lxmq9496nW0VVZCCwNOvNxKF7P/4WK/5wmjFw9Xk3UvsiBoPPV+oFogzdMK5TP3L94BMgQPge
        BdNbbTsw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehIC-00047o-6n; Mon, 16 Nov 2020 16:23:48 +0000
Date:   Mon, 16 Nov 2020 16:23:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     pmladek@suse.com, tj@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread_worker: Add flush delayed work func
Message-ID: <20201116162348.GA15826@infradead.org>
References: <20201111091355.19476-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111091355.19476-1-qiang.zhang@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:13:55PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Add 'kthread_flush_delayed_work' func, the principle of
> this func is wait for a dwork to finish executing the
> last queueing.

Who is going to use it?  And why?  Please document this and resend it
together with the series adding the user(s).
