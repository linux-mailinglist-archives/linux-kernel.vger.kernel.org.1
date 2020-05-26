Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AED1ABF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633074AbgDPLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632881AbgDPLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:21:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXE8WU57/ob/uE0JQIhn8obGmSq2L0WMhMYM6Ggi9hs=; b=QG9hqnmQ2U6TcuHhi0YZD5a0Fc
        SKNu5+WgPPNLAm90YCfmYDZt5Ff5mO12bJtUs1YUA+8flAh6SLN5R9rKhzUbC80uNYPneRDJOPuNn
        umAZOuxsrYiIOTzl+zra/6DifnN6yDLNd8KgnFjvHs0uMTWl+ijzalG9J3UvWAMV1k2QgPEiApWWM
        C6nHXj/06VZJbr2mYOrTlx3+FErdsVxmjciu2v/8Ib8lDZaMWdVKcUKJun+B2aYcCC/xn1qsSJh5a
        p4JpMfWWy7NT74pV8OQN04TsgjhV41eQ83cHwOLdFs8ZZ4HUsw7A8cd8gG78YKNeOSP92JQyho8iP
        nAlIhNPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP2a3-0008Sa-SC; Thu, 16 Apr 2020 11:21:15 +0000
Date:   Thu, 16 Apr 2020 04:21:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, Markus.Elfring@web.de, david@redhat.com,
        ktkhai@virtuozzo.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
Message-ID: <20200416112115.GF5820@bombadil.infradead.org>
References: <20200416025034.29780-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416025034.29780-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:50:34AM +0800, Muchun Song wrote:
> +			/**
> +			 * If the vma is out of date, we do not need to
> +			 * continue.
> +			 */

This comment is not in kernel-doc format and should not start with '/**'.

