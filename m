Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B027096F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgISAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgISAYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:24:01 -0400
Received: from X1 (unknown [67.22.170.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F06D21D20;
        Sat, 19 Sep 2020 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600475041;
        bh=W6DhjlWf9ksxtATHwmOCHAkaBRTh3bp6O13nj4DoZI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ABH1vTV5+ENJgE8rzteACQvxRPK/Zyh5HxcBPNwVFzo67gDfp45X4JoVfeiYwRCbb
         aGghAQsPSoMsN+oqP9EPfsOr0TvUe8924HJWePGxNcRSE2T1j45HjFzyuyAMk1et7I
         SetD9iakdf9zViZ0UFvCok5b2gv+cbM+bfOTxzso=
Date:   Fri, 18 Sep 2020 17:23:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     osalvador@suse.de
Cc:     linux-mm@kvack.org, mhocko@kernel.org, mike.kravetz@oracle.com,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru, cai@lca.pw,
        nao.horiguchi@gmail.com, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] mm,hwpoison: Rework soft offline for in-use
 pages
Message-Id: <20200918172359.e862562a7ad22e92388ce218@linux-foundation.org>
In-Reply-To: <7e948108488864b6d9131d990d5f6c80@suse.de>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
        <20200806184923.7007-9-nao.horiguchi@gmail.com>
        <7e948108488864b6d9131d990d5f6c80@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 09:58:22 +0200 osalvador@suse.de wrote:

> I just found out yesterday that the patchset Naoya sent has diverged 
> from mine in some aspects that lead to some bugs [1].
> This was due to a misunderstanding so no blame here.
> So, patch#8 and patch#9 need a little tweak [2].
> 
> I was wondering what do you prefer?

Well.  I (and I suspect the rest of the world) have lost track of
what's going on here.

So please let's have a full resend of the whole series?
