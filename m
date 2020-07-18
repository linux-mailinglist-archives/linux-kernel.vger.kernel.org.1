Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA38222481C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 04:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgGRCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 22:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB9C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V1obHiSV0g+I6oqpehFjebNGMQN5VUbcgwyEdo5Uo2U=; b=Xz5nrisZWwJGeSv/LuV73BNOuM
        7W+GbE1/sdTMq0wVU+M373CqJuYbYXNsWeHzhYTVoTjLeDCQ57Xm3axZ8bkI4StO+PeWHgbIp8sWG
        eMrfkC+eHxRI7iYmewPPqZ0AXboN4N5cB7946Q3LdjjwR1kYKiiABH6rw2u4a7neDHOcCi13JcY0z
        39Io9r6lbBGM67A61gFjnyvylzxonbuG0vZcxz8NNP4cpLrZKjClEnACnWR87n/R3Ms7BSqJWRlBG
        hl6mIn93mwvtIakHcsl+Oxh0czglwGzhCYo60YhHRMidRxLFfziNeWmAbfg0eSvnZUzKxoFnIWXkD
        YaF840QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcyK-0004hg-S6; Sat, 18 Jul 2020 02:53:08 +0000
Date:   Sat, 18 Jul 2020 03:53:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] highmem: linux/highmem.h: drop duplicated word in a
 comment
Message-ID: <20200718025308.GT12769@casper.infradead.org>
References: <57b70139-4f2d-c520-0882-f310c2b64b65@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b70139-4f2d-c520-0882-f310c2b64b65@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:52:07PM -0700, Randy Dunlap wrote:
>   *
> - * However when holding an atomic kmap is is not legal to sleep, so atomic
> + * However when holding an atomic kmap is not legal to sleep, so atomic

instead, s/is/it/

