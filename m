Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7640319F672
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgDFNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:09:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d8z40dNKaPY2tTRvNqVh/Hg7COGe6Xus2Dj2Co5njCA=; b=qaF9jgqXRIEeKu2Y2Dr7vB13TD
        KAolynoC5eVhhwajk0M4cxtVWIE6G7MpqOI8nrq6w21TdsRfaf03cgNCb4ztaP5X1jrRsvGzGvCHP
        dIPR3oBv+MDsPAvpd6u9p+//LYaetf5LYB3R+VCJKwXq4rzAswlBPGdVBHYyNAWmgGL3HMKYMi+Mo
        6ril3DjTx0HIsB0ky0W/jYQ9Uu2uAUq5Q9KbXwQYip2ADF/2/AFKAK+s44RVAnQGeL9QfqYpAgRB5
        hawKVDzbjNyucsIwbKpLvr/mplANc239iPxGKmzma4N1lDRPRvDZNkoWDCnV6AVw7MDt6TIpGyl++
        jpQc4UJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLRVH-0000Ci-KN; Mon, 06 Apr 2020 13:09:27 +0000
Date:   Mon, 6 Apr 2020 06:09:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Message-ID: <20200406130927.GA20291@infradead.org>
References: <20200405081355.2870-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pleae just drop the code - we should not add new drivers with custom
DMA ops.
