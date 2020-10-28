Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F329D90F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389489AbgJ1Wnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgJ1Wns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:43:48 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDEE20728;
        Wed, 28 Oct 2020 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603925027;
        bh=63BrwT+SKui6Vft0o9TS1cSwiWuz/qdwftnpJ2ggQPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bbvlhVIjHjdbe0ADwT3W4GA9c9q8PlHCspg/NmOPB9M2wqfVFSFmwcVF1sdIdYi/z
         XAfFtP0FnwXWr9EIu9cpfkZzKgkiDMp8NYA+YfAmA+F59QF/iADYXdbMucEA5o/C03
         nWUW/y6bQrP1rizQI1EkmwjGJMLlVHopfi4/rYyQ=
Date:   Wed, 28 Oct 2020 15:43:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: Fix a race during split THP
Message-Id: <20201028154346.d8144f8ad7040e6b17592c58@linux-foundation.org>
In-Reply-To: <20201027102519.GR20500@dhcp22.suse.cz>
References: <20201009073647.1531083-1-ying.huang@intel.com>
        <20201027102519.GR20500@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 11:25:19 +0100 Michal Hocko <mhocko@suse.com> wrote:

> I have noticed this fix and I do not see it in the mmotm tree.
> Is there anything blocking this patch or it simply fall through cracks?

It's merged into mainline.  Perhaps the grammatical fixlet in
the title tricked you...

commit c4f9c701f9b44299e6adbc58d1a4bb2c40383494
Author:     Huang Ying <ying.huang@intel.com>
AuthorDate: Thu Oct 15 20:06:07 2020 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Fri Oct 16 11:11:15 2020 -0700

    mm: fix a race during THP splitting

