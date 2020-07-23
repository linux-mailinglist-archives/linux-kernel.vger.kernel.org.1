Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65B122B4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgGWRe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgGWRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A64520714;
        Thu, 23 Jul 2020 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595525666;
        bh=Qhrjw7uyDWdXXIAvmKfEK6zrtiSur7oYHENRu1OnN3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPXjgtQfYvIUJ9CMdLnwxLE0QAOiL5hC7Q56P+XKldQdMheN6WLKo3IJtnaWlRm5h
         VrMruFbX9BCXuA9phurly9B34jULxl604wuZB13+rCleqogq1TvWwYw1Yb+dRr8Kr2
         vdIEEDAFwTgqFt3xMxpqtqyEZ9V2tKcGX5beBHsM=
Date:   Thu, 23 Jul 2020 19:34:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: Add the license identifier
Message-ID: <20200723173429.GA2907237@kroah.com>
References: <20200723163150.GA10505@musamaanjum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723163150.GA10505@musamaanjum>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:31:50PM +0500, Muhammad Usama Anjum wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: Missing or malformed SPDX-License-Identifier tag
> 
> Add a the SPDX-License-Identifier tag on line 1
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
> Other files in this folder have GPL-2.0 license. So this file should
> have the same license which was missing before and checkpatch.pl was
> giving the warning.

Why is this information not up in the changelog area?

And what changeds from v1?  ALways put that below the --- line.

v3?

thanks,

greg k-h
