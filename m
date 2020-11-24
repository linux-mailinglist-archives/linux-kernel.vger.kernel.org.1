Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A912C21A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgKXJhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbgKXJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:37:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ZJSAndn+5qtPYlK0pS4YJ2j8jQ
        ci2kO4FHy3MiwNhvslulEAEqrmyHuVX9Z/vY1RFqPrfIOEfirMxf9iH/P3Ts4ozdcxroYeeuHqqLZ
        3+Gvife8Djda1MauEz2ZU5CEt9mDxMauQIm5ct7WojA6HKSFIePbBydkypTW8D4v9bB3+4UndEA44
        ZLqXNOD6rHwb5sPSOhfcrsvwK0DNnsjGFHgvHKEdSIem0T++Oek78o/WT4nFFhHBmwfgF6AMrPvJ6
        2Jctr6bHMgIhGPVmhffdBjDyalP5aE3JIXEHOWXreT7cFHhm5bgZjpGG/+xHP/BBl1+4duKHFZFlM
        Oehq27ig==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUlB-0008PK-1S; Tue, 24 Nov 2020 09:37:17 +0000
Date:   Tue, 24 Nov 2020 09:37:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/9] relay: remove unused buf_mapped and buf_unmapped
 callbacks
Message-ID: <20201124093716.GA31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <c69fff6e0cd485563604240bbfcc028434983bec.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69fff6e0cd485563604240bbfcc028434983bec.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
