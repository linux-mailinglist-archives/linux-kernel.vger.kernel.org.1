Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C4251252
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 08:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHYGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgHYGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:47:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE862C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yMsVhcdm4uIPL75zrjrinoFwmad7XMD+ITiKRaneHM=; b=OL1yuYpSoSeg7b8RYZkspFpNgE
        jGHr0Jo2wtiUXQ7rpIMh5dSb0GUCyHwBlhKWoWvR5STTN8EtQ8AqFoVkgeo4gjGIBPtYwVHqG7djz
        YBGviXedA+rHXNaD2Go5H4REGoQdAM9Jm2fBSWhTWjvgaLq+f5rCttagang4GztXzIDcYFK300wOf
        P3QzQ0YTz94jJgJpowD5eOTg1iUXDUTS7JY7N8GOgivWtNWO/QXt0wT6BUp3l7ySjBoEaR1q7Qm0o
        o/hrUZ6HfhUO72v0t9324on7jY770IUJ8MWKvaNP9bfX1bYbze9XabV9l6UgJZStT2UjzkaxBhPjt
        TQuBL+lQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kASjx-0000Ao-Vh; Tue, 25 Aug 2020 06:47:30 +0000
Date:   Tue, 25 Aug 2020 07:47:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hj?nnev?g <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <20200825064729.GA30014@infradead.org>
References: <cover.1598023523.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598023523.git.tomersamara98@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:27:04PM +0300, Tomer Samara wrote:
> Remove BUG/BUG_ON from androind/ion

Please just remove ion.  It has been rejected and we have developed
proper kernel subsystens to replace it.  Don't waste your time on it.
