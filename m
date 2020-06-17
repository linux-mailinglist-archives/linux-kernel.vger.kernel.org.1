Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0A1FC2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 02:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgFQAp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 20:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFQApY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:45:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3MBm7WMB0H7CjQ2iwLE0so+VVrKy1QQzygXiwshRKms=; b=H4VsMaXhl94mrmF1Esg6PoO8tD
        CYFRqh7FzyMwKICyQruEqENp0EKzIzhYc0aGi0Y/gao6TL3sx4Wh0dmlDfjr/P+lCyd13S7x+1UDk
        RYyEsRa7k4QhsPrs4Zj8VSBUJFuSqeVSyKE7wTgggJN/TWAAtZWG6BgGqJRKjwLgs9iB4oio2WD/U
        gY9bcwg3QFj4UStMGNrMxmnMFo4jC/UOVlSBrNC42FEp5GIbAhm8V4sZYfdFhvOcZDhQGBZLU92xP
        eQ9PY7MOdfcqGE7IA99wnoKTPL5kYVtCYxNol5D/gvZ7KvAxrlRmMwzGXPS8FwDuCYlsbtnbYUgba
        QLZw6dUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlMCf-0003h4-PY; Wed, 17 Jun 2020 00:45:21 +0000
Date:   Tue, 16 Jun 2020 17:45:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: ksize() should silently accept a NULL pointer
Message-ID: <20200617004521.GE8681@bombadil.infradead.org>
References: <20200616225409.4670-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616225409.4670-1-william.kucharski@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:54:09PM -0600, William Kucharski wrote:
> Other mm routines such as kfree() and kzfree() silently do the right
> thing if passed a NULL pointer, so ksize() should do the same.
> 
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Nice simplification.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
