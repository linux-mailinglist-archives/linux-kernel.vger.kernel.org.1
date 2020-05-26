Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0A1A538B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDKTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 15:32:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKTcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDveQtz8LBA7O0hohk+4xbnecEKc9mf+kKuouXv5pWA=; b=uGCaxafSWS6FGQeliVXGrbhRoI
        kPw35u5Br87q647Ed/ry2CMKvNwnGVT4d5HAYfp5H7YkciYwtUaYjOMwHvLYSFWarcuD6YLP75IrL
        HMrjZC87v4+0yTJS9UtaN17l6n/Evw8W7PaIFDTf/H3fCoICqqDuXLmY9xxG8zln/B7X/39yMx7Wg
        tUSy/CEiUc4PfOalL58VLBnA4tci68dDzG11VWKeF7AmOr0eCqcUur/yYmt0B8UWnuykULsq4Nc/L
        pVV6QzbTFtZ4ZHP6665tOgyI+OyNlaxsRsLjmhRW7ZSH3QSszJ/vSkkqt8GA2YJ/oTbEugSjk2Bf/
        TOiYkFkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNLrO-0005gB-MT; Sat, 11 Apr 2020 19:32:10 +0000
Date:   Sat, 11 Apr 2020 12:32:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ethon Paul <ethp@qq.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix a typo in comment
 "unneccssary"->"unnecessary"
Message-ID: <20200411193210.GF21484@bombadil.infradead.org>
References: <20200411065141.15936-1-ethp@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411065141.15936-1-ethp@qq.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 02:51:41PM +0800, Ethon Paul wrote:
> @@ -1259,7 +1259,7 @@ EXPORT_SYMBOL_GPL(add_page_wait_queue);
>   * instead.
>   *
>   * The read of PG_waiters has to be after (or concurrently with) PG_locked
> - * being cleared, but a memory barrier should be unneccssary since it is
> + * being cleared, but a memory barrier should be unnecessary since it is
>   * in the same byte as PG_locked.
>   */
>  static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)

This will conflict with the patch series I sent here:
<20200326122429.20710-1-willy@infradead.org>

which deletes the entire comment.
