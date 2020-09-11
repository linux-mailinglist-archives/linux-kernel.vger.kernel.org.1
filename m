Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE5265CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:46:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E1C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eQGIXewYuZCpvpK/BaFE4MPXbzOB2uby5RwCvTyE0K4=; b=JezV4WEpeyDx1MRHT4Nk9NCoz6
        OzsVLqzywI32ojX8hcVXBfNwOG0GBkzCNiJJ8uR9WIe4736K+NIlj0jhdPCdnJecHsWpok97/Py6Q
        XU6iFIbvR1KJyqquIk0kKPDgECSFEAal4DUtbh3KaNJCufdOevI8FlqO3FO6tWyJVIdVwkzyy9SJl
        aA19ahTCCIx8X+Pi1Q9hBG6s2ohEZW5cUh3nK56YC7+KvQ5ZHyNwqtva9O7ovbG7bWTVJumSvZm7z
        9ZpE1bTNfpJU0CWG3CAzOOBBuU7i/bhrjnmo4mZV3ghZqdYd1RrC6hEzAML/Y5YhcKzy+lNxDv+yt
        s75jY8iQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfdT-0003wV-VU; Fri, 11 Sep 2020 09:46:28 +0000
Date:   Fri, 11 Sep 2020 10:46:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: MAINTAINERS: Marking internal distribution lists
Message-ID: <20200911094627.GA14158@infradead.org>
References: <alpine.DEB.2.21.2009110811520.9220@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2009110811520.9220@felia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 08:37:54AM +0200, Lukas Bulwahn wrote:
>   - ocfs2-devel.oss.oracle.com

This is a normal mailing list, and I subscribed to it normally.  It
might howerever be brken in various ways as oss.oracle.com seems
pretty much unmaintained.

>   - rds-devel.oss.oracle.com

The same probably applies here.

Adding marting who might be able to find a contact at oracle to help
with issues with it.
