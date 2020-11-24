Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3D2C21A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgKXJh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbgKXJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:37:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F056C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=erVBEbSZXU0xKU0/OCceptXO8BMpPV2CdOs+DwG0M+s=; b=TbCvdo4FiP+XH83lk1czbsUuEA
        OTyCX3rCda0+ppk1biGGK9vHwCEtdw2l5r2hzwbfQhNDIHJfR0sCwpLA+DoNaxYDvK6qe6xCnfHPb
        lKBJM+WQ0UHQrhWZKyhLKrcjXbpI9XjAeY5gIN0QlLi+NG9OOZuJuwPCke5RBSUW/z6TFkSEg0FAD
        1wizpRmJ3u2zDT81oClpAEsX5u7AOH1Aq2STW23L7gdlFx3bFtYO/gq3e5Hya0qvaFalo/KeRZTP7
        UipqfF9bjU9WbEdfaDI0epSlOQx+reUs5Ob/Mnc0fP3t0jV+v5S1CDzWs1EZUqNYemD6JBN0tgf52
        hmtJmLDg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUlm-0008Q5-Dm; Tue, 24 Nov 2020 09:37:54 +0000
Date:   Tue, 24 Nov 2020 09:37:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/9] relay: make create_buf_file and remove_buf_file
 callbacks mandatory
Message-ID: <20201124093754.GC31963@infradead.org>
References: <cover.1606153547.git.jani.nikula@intel.com>
 <88003c1527386b93036e286e7917f1e33aec84ac.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88003c1527386b93036e286e7917f1e33aec84ac.1606153547.git.jani.nikula@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:59:23PM +0200, Jani Nikula wrote:
> All clients provide create_buf_file and remove_buf_file callbacks, and
> they're required for relay to make sense. There is no point in them
> being optional.
> 
> Also document whether each callback is mandatory/optional.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
