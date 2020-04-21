Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46C81B25CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgDUMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:20:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DCC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bpBcKuAgIYfgQ4FyaroZarYwkDjHE6HzTznag/1ANmI=; b=og7LIzFeZPiA4dTzE9I7SVCkbR
        UgnQvFgfrSghqhwcWLFIf1nwqoZU++Af7ih9TwIcko/BO8VjNbJST72mzB7n995VJfvvzso/1QUXl
        V4X1OQIZE5v3f28PSewGOAtcDeJqoIoF9Q06E99t2J8hNar7IIOh59ee6xaqCMWgA4yZGYAX2asjP
        2ckyAjW88xno6D1ZBQSZUENqmU6v/0ygfALPrDkNAhdR0X+Zym8Jw1/1/Yx4v/rsJf930S0zhRKta
        qSR+EaLhmH43+uQSwB7C2pt7WJeo5kanBjdbfnRJz8oXUvsbKdWys7UWXOhPyyCQBRaIwAu1EUQeg
        f+9WKfzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQrtV-0000qz-8M; Tue, 21 Apr 2020 12:20:53 +0000
Date:   Tue, 21 Apr 2020 05:20:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND]block: remove unused header
Message-ID: <20200421122053.GA2944@infradead.org>
References: <6AA21C22F0A5DA478922644AD2EC308C73C54781@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C73C54781@SHSMSX101.ccr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:48:08AM +0000, Ma, Jianpeng wrote:
> Dax related code already removed from this file.
> 
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
