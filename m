Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9571C77B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEFRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 13:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFRUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:20:34 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E43D20736;
        Wed,  6 May 2020 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588785634;
        bh=Wn0tr+jomtFMTPvz8k5HF5ImcB+WgcC+navwX2vkqJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kfILMepqUck4hPF2/6MNMAKLzWlIJ1HINL0RA3P00FF0XHP3USo9DxYRSUoUia9eq
         8JvZgw9/hxsrz5tCKdKN3pl0euq9stRVqiWmQqRZBL4DKLiBqYYhGYBXGLHrI4tr+B
         cv+gZ9ajVzWu4C5wFdTz3SyBRi5qZTH8twVYKx2s=
Date:   Wed, 6 May 2020 10:20:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: Wrong ordering in DYNAMIC INTERRUPT MODERATION
Message-ID: <20200506102032.32b0f9a3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <alpine.DEB.2.21.2005060749590.7719@felia>
References: <alpine.DEB.2.21.2005060749590.7719@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 07:51:36 +0200 (CEST) Lukas Bulwahn wrote:
> Hi Jakub,
> 
> with your commit 9b038086f06b ("docs: networking: convert DIM to RST"), 
> visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS 
> complains:
> 
> WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> #5966: FILE: MAINTAINERS:5966:
> +F:	lib/dim/
> +F:	Documentation/networking/net_dim.rst
> 
> This is due to wrong ordering of the entries in your submission. If you 
> would like me to send you a patch fixing that, please just let me know.

Please do, thank you!

> It is a recent addition to checkpatch.pl to report ordering problems in 
> MAINTAINERS, so you might have not seen that at submission time.
> 
> 
> Best regards,
> 
> Lukas

