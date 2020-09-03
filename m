Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6725C6D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgICQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 12:30:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:58538 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICQa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:30:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 93B047DA;
        Thu,  3 Sep 2020 16:30:28 +0000 (UTC)
Date:   Thu, 3 Sep 2020 10:30:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: Documentation edits/fixes
Message-ID: <20200903103027.4c8d0b07@lwn.net>
In-Reply-To: <96f99afb-c54e-8f46-ebac-80a62f65b876@infradead.org>
References: <96f99afb-c54e-8f46-ebac-80a62f65b876@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 17:08:31 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Correct grammar and spelling.
> 
> Drop duplicate section for resize.f2fs.
> 
> Change one occurrence of F2fs to F2FS for consistency.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> ---
>  Documentation/filesystems/f2fs.rst |   53 +++++++++++----------------
>  1 file changed, 23 insertions(+), 30 deletions(-)

So this, I guess, needs to go through the f2fs tree since it doesn't apply
to docs-next currently.

Thanks,

jon
