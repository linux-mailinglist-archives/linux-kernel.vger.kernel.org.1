Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6701EFF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgFERx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFERx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:53:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDAC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+QnXaMz57xwj0NODCVYjNuNi6VwkgyJsQIni21eyp+s=; b=FJ+bU8H1LfWLnDEtQ5FrvIzWoZ
        c7AM2eqwjaM3/C5ao6ltr9fd+fjc0ZdFVagyaVKZMjgL2ENAnvIpzmVYeqRZNpZETsK1NHQBNs1mS
        m7qxHh8jREdVozl7kStag4ZKi1FCRIZIz/3KIXTml6KlDByz49rye3bEURTNk0kbllxVbqgglXg/4
        rQBYMwfduxfL+ZP1YKYK4qBz3gtqKtg0ZGek88AJmgAfgbTHk4MArLp/eRARdWsFdLqmVOlX45vbg
        6BeBWlK0Tyt/TGXyoisnqIMmvSLXp4HM/EbLHexxzEE2Mn4VvroHXtpx/c2H/N4v1tCMeBYXmWMFz
        3eFhbk7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhGWr-0001Pb-Bd; Fri, 05 Jun 2020 17:53:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAC6630067C;
        Fri,  5 Jun 2020 19:53:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9843821A74B32; Fri,  5 Jun 2020 19:53:14 +0200 (CEST)
Date:   Fri, 5 Jun 2020 19:53:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     alexander.antonov@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, lkp@intel.com
Subject: Re: [PATCH v10 0/3] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
Message-ID: <20200605175314.GQ2750@hirez.programming.kicks-ass.net>
References: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:35:40AM +0300, alexander.antonov@linux.intel.com wrote:

Didn't GregKH have comments on earlier versions of these patches? I
don't see him on Cc anymore. Were all his comments addressed?
