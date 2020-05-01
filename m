Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420B1C0FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEAIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEAIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:46:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69248C035494
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=arn/piRu3PKyj7yP3hHFFHkHZ1ALOX6EyGAfQtqWcHk=; b=nzgl7h+pCfn8LgiZxOzDyW50ff
        CrRTrwKf8LndmWwXSTnKp5gLJFKLe1CoB4zY3Dby+38R8ohnz2jcoqAi6shTvD1OLnarP9P4BPZQV
        9mrnYiedBjvFoOlINOPvBn5rvQ6Ef1euIH2spFI6qzb7j6LSL/xcCwLbtqVOSUwHjhUO6TOXnfjTJ
        faS57echPJtCvjnsIfAqy/IoX9MgyU+Sc0RpGCLldDEZjFB5wrk3NEw44tiilcAcx4AcSh25DmWqh
        Ub0QYiqFPUMRfKHiHfmGvHCjXhU2CyoEx/MBwJNaw1NsMwNVYc6AD8pPH3sQQ+t/K57+bSYf7luEN
        cnhyld5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jURJa-0002xd-99; Fri, 01 May 2020 08:46:34 +0000
Date:   Fri, 1 May 2020 01:46:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: xtensa question, was Re: [PATCH V1 00/10] Remove duplicated kmap code
Message-ID: <20200501084634.GH27858@infradead.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430203845.582900-1-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

any idea why xtensa uses PAGE_KERNEL_EXEC instead of PAGE_KERNEL
for kmap_prot?  Mapping all mapped highmem as executable seems rather
dangerous.
