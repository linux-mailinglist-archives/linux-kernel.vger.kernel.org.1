Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303CD248451
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgHRMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHRMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:01:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50120C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5dBVeUaGuDS9BOAjFaG0N4VE7azEDM1MpiW+1vUsN4=; b=klEZeo7xSBiKClX9F8wPdz2dsx
        Q+agj6npvKFx8VFJQlKhi0yNN7Vq3TXCAfkJDG8OzwxqVzXbJ9+qq85hr1jP/UZkssc0LVY04EKtk
        XxQQORf6keyEPSEgPViNub8R8UchKlGQKvxTGpABgaU3a+Y0tn8q1jhLH4aMgkwWYUi5ib+f49l2B
        rMVtn+SaGpiJh0LHnp050UYF0fza8ZvnMxi6PbewAHEfZiFiw9TfkLIXYS0Mq4F8wH1fye6JR2Eb3
        CBi6jDemIEpEx00RkJ7ILAzFtnTKmwvWC2rJehHq9IsG90tKsKvUtBu3DbM2EfTf9WnXWi6ILrlw+
        w9zEgI1A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k80J6-0006xe-M7; Tue, 18 Aug 2020 12:01:37 +0000
Date:   Tue, 18 Aug 2020 13:01:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yanfei.xu@windriver.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memory.c: Replace vmf->vma with variable vma
Message-ID: <20200818120136.GN17456@casper.infradead.org>
References: <20200818084607.37616-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818084607.37616-1-yanfei.xu@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:46:07PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> The code has declared a vma_struct named vma which is assigned a
> value of vmf->vma. Thus, use variable vma directly here.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
