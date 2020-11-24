Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC32A2C21EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgKXJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbgKXJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Gu1xP1wU7I/rfYIMvgeind8yZFCZ8tV4LGh9s+HSI0=; b=P5e8LGXhX38B78U9JG7GL8LjoQ
        d2KXGKUC/Fs9Ty19bJJwlTTiYYAcaHlwktzXnPxCw4mt278k2474H7Zp009QOace2mZuCG5/QxQEd
        GNNxv5tFPVGbs/eQ/MHjM19iNwOiL5RR9xTui7HOTl/S46njQyFb3qT44AXR6AKKAxkNMXaiAc3t6
        B7ai/tqJkARP0uH9oimWQ4wf2GytjD8nw9f8WsBZi2aADw8MvmZza8d63zqgLPhptJbGKq4MkruYq
        XkBwkoCWr/dJFoi1lrsoke1CC6P33L10PgiLox1WX20PhC8YGtj0eMF4H/1Hu7Ft7EiFnDzf2Lknp
        yrnTGL1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUqE-0000Px-Cm; Tue, 24 Nov 2020 09:42:30 +0000
Date:   Tue, 24 Nov 2020 09:42:30 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Kalle Valo <kvalo@codeaurora.org>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 6/9] ath10k: make relay callbacks const
Message-ID: <20201124094230.GF31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <85cabc6d4b0d0ca43d4e0fb94897ccd16e3b7930.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85cabc6d4b0d0ca43d4e0fb94897ccd16e3b7930.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:26PM +0200, Jani Nikula wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
