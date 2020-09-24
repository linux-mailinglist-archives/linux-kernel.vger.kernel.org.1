Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94129277760
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgIXREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:04:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B67C0613CE;
        Thu, 24 Sep 2020 10:04:04 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 60E3C2CB;
        Thu, 24 Sep 2020 17:04:03 +0000 (UTC)
Date:   Thu, 24 Sep 2020 11:04:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix references to nommu-mmap.rst
Message-ID: <20200924110400.1cda36a6@lwn.net>
In-Reply-To: <20200812092230.27541-1-steve@sk2.org>
References: <20200812092230.27541-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 11:22:30 +0200
Stephen Kitt <steve@sk2.org> wrote:

> nommu-mmap.rst was moved to Documentation/admin-guide/mm; this patch
> updates the remaining stale references to Documentation/mm.
> 
> Fixes: 800c02f5d030 ("docs: move nommu-mmap.txt to admin-guide and rename to ReST")
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  init/Kconfig | 2 +-
>  mm/Kconfig   | 2 +-
>  mm/nommu.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

It seems nobody else wants this, so I've applied it.

Thanks,

jon
