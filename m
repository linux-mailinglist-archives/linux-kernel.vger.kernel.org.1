Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077126DACB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIQLwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIQLsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:48:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XWAGowxIglaD0BztvJoBf9d1lchkWHz/K6xKkfOqrw0=; b=a7wdR9mYS/f77fa4W1AsaXvV2X
        k9TVyVxV9+R9Va1cDnPoPostxa3LlQNK4RCJpYAc3F/xvzDGuwfG5lPCpQeEpd27BdMqnIZRywkBm
        iNs1vcupRCdfMJEMh+gGGJ14gxP/U3lCTZWxGaSDAC4OT9JXH39qkaq85iOQ5ffIk/yhTYPEgedJZ
        uGLMIdtI0n7Sb2TAGzvF1BEZbfjcv7JhqOJmeNjPulkAy/54IIr95BrvI69CJBjjZp8iuJMyGkW93
        I/UakmKVQv/EkQq9AWrW6nQuq7TAMkIucLG9aqSFOx/Hz+zf0lWUslNGO71+IytshGO6dr29AzMpS
        lP9ot2+A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIsOm-0005JM-E5; Thu, 17 Sep 2020 11:48:24 +0000
Date:   Thu, 17 Sep 2020 12:48:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid possible multiple call to swap_node()
Message-ID: <20200917114824.GS5449@casper.infradead.org>
References: <20200917114449.35285-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917114449.35285-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:44:49AM -0400, Miaohe Lin wrote:
> Cache the swap_node() in a local variable to avoid possible multiple call
> to swap_node(), though compiler may do this for us.

Why don't you find out?  Compare the assembly before and after, see what
the compiler did.
