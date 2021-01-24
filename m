Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485CD301972
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 05:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 23:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbhAXEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 23:08:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03289C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 20:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lh9eOrCOK7bXOzdecd6q2dREsDMbVoNPQCAm58V7l6Y=; b=lFpoumH943oCQgcXSCsz6hp9Vg
        A8tXsciyoS3o/ZjeYJBZT3wxlqR+eKL9W2vX+yOhsMIUz9F83RmCkjlMlxwU1GYzaHe8mZg42jCfC
        8o21uJxrNQWLI4UB6qU1kUNvP8xwsOG7rJr/TQS32mMJaDalZBXCDl0OuBrk5JB6S632Vn5IKfntJ
        FvrNqXtnqTAYqbR5LfpD2YDa6E7JrGZEtX/vwH2uJgsuoS6lUqDljt5rVJkf7364eKYLtLlw+8fk+
        /2nXegCxdGvZH7QgtD6DGEr6LX3hOa1qGXo6mCe7dp1gBgqlQ14iAezJ7DmDuKl7CyygxjC5FmJJj
        1FoC36PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3Wfw-002abG-77; Sun, 24 Jan 2021 04:07:14 +0000
Date:   Sun, 24 Jan 2021 04:06:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memfd: replace strcpy() by strscpy()
Message-ID: <20210124040656.GB308988@casper.infradead.org>
References: <1611455017-2210-1-git-send-email-stephenzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611455017-2210-1-git-send-email-stephenzhangzsd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 10:23:37AM +0800, Stephen Zhang wrote:
> -	strcpy(name, MFD_NAME_PREFIX);
> +	strscpy(name, MFD_NAME_PREFIX, len + MFD_NAME_PREFIX_LEN);

This is silly.  Use memcpy() if you must remove strcpy.
