Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513F21EE777
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgFDPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 11:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgFDPP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:15:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06382206DC;
        Thu,  4 Jun 2020 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591283725;
        bh=vmUe0q6MS+48pyYzLhEE/pA7G37y0gnmaKMXxb1Nay4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGJ6LxCECbRycWLLamd5unS5vHGmOEfBBbZNV697BsfOwAUnUjyVWgbu+cBQ/AnxK
         ON2bOg2vAA8K4Q2UmLSNCgHaZzXl3bNNGPKfeYPEsVRTfURa7KZkM6hSu9CaJMlAdC
         Gs2Qb81O6mURXsXXEqLM+DrRVDtkRTUta9J6SYPg=
Date:   Thu, 4 Jun 2020 16:15:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] scs: Report SCS usage in bytes rather than number of
 entries
Message-ID: <20200604151520.GB3650@willie-the-truck>
References: <20200603151218.11659-1-will@kernel.org>
 <202006031006.2E6B4367@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006031006.2E6B4367@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:06:13AM -0700, Kees Cook wrote:
> On Wed, Jun 03, 2020 at 04:12:17PM +0100, Will Deacon wrote:
> > Fix the SCS debug usage check so that we report the number of bytes
> > usedm, rather than the number of entries.
> 
> typo: used
> 
> > 
> > Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Cheers, Kees!

Will
