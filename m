Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BA2DA34D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438659AbgLNWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388490AbgLNWVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:21:18 -0500
Date:   Mon, 14 Dec 2020 14:20:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607984437;
        bh=PRJyZ67a4idxIi4AVLyTc0cHwcEG1KvkNVoRG0c5U2c=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zn6fduMLvc5aaO12mILA+BdbJMvoycSn8ryx62HqddkgMaI7Jh7+kScQE/w8pGJb9
         u/jyN5EhAqQx8UYNWosknL/+OUQxnlUlP7l7hMVLfV1tDIQ5ZZwd8kfup+NfWsuX0h
         TYSKeNb+iatczidVKlCYHFIv3iVtDVI1PX6nFccY=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Rik van Riel <riel@surriel.com>, xuyu@linux.alibaba.com,
        mgorman@suse.de, aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, vbabka@suse.cz, mhocko@suse.com
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
Message-Id: <20201214142036.28dfa428d3713a5ebcf58a59@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com>
        <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 13:16:39 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> Andrew, please don't rush
> 
> mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
> mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
> mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch
> 
> to Linus in your first wave of mmotm->5.11 sendings.

No probs - I'll park them until all this is sorted out.  Thanks for
letting us know, and for your diligence ;)
