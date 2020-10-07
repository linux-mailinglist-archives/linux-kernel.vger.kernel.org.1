Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8D285C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJGJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:52:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:55780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgJGJwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:52:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602064349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9YEdyVZwCu3c28PJPIbBnmYut5XP2GLOBi1ecqX5OY=;
        b=VOO4Zd2OEcuuBxsAEhNXy3HuHnlW1KHS0EM09c25Ld3WP+Avp6xVS5wRejt2pM080TRg1h
        cLqfKxBecA2ENqliIXeqcsVhktSBxKv53lJasl1gyfhDpsjolxYoikzSzUvttgLxIfLhGb
        yHO4OUGhR92XtYkT/GNl9++IhBuz9ZI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E192AED9;
        Wed,  7 Oct 2020 09:52:29 +0000 (UTC)
Date:   Wed, 7 Oct 2020 11:52:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, npiggin@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 00/12] mm: tweak page cache migration
Message-ID: <20201007095225.GH29020@dhcp22.suse.cz>
References: <20201006205103.268F74A9@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006205103.268F74A9@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am I the only one missing patch 1-5? lore.k.o doesn't seem to link them
under this message id either.

On Tue 06-10-20 13:51:03, Dave Hansen wrote:
> First of all, I think this little slice of code is a bit
> under-documented.  Perhaps this will help clarify things.
> 
> I'm pretty confident the page_count() check in the first
> patch is right, which is why I removed it outright.  The
> xas_load() check is a bit murkier, so I just left a
> warning in for it.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

-- 
Michal Hocko
SUSE Labs
