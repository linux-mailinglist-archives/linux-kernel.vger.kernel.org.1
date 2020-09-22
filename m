Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718D727471C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVRDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:03:16 -0400
Received: from X1 (unknown [216.241.194.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9DE23A9C;
        Tue, 22 Sep 2020 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600794195;
        bh=i5buRdRXnwWI0LnRovp/PjB4N73TIz/1CqNCKVaNQAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RlVCP0k5vlPan4n6VPH8nEGIeDj70MetdJL077r4li85V4XXFIYdcqR6JEVk1ZlB5
         q8aJx8lXd4vpcKLVvyh6nVfTVFZSaDaE6mr1lq0qx+/Y/GgLnPnsiEBW0KbI8YDr/X
         FIykoudH/MEfnKIGo0nQTquR8pLOrtf+LDBxECXs=
Date:   Tue, 22 Sep 2020 10:03:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 00/14] HWPOISON: soft offline rework
Message-Id: <20200922100314.1871b38a24289f32508c48a0@linux-foundation.org>
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 15:56:36 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> This patchset is the latest version of soft offline rework patchset
> targetted for v5.9.

Thanks.

Where do we now stand with the followon patches:

mmhwpoison-take-free-pages-off-the-buddy-freelists.patch
mmhwpoison-drain-pcplists-before-bailing-out-for-non-buddy-zero-refcount-page.patch
mmhwpoison-drop-unneeded-pcplist-draining.patch
mmhwpoison-drop-unneeded-pcplist-draining-fix.patch
mmhwpoison-remove-stale-code.patch

I don't have a record of these having been reviewed?
