Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE422A9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGWHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWHct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:32:49 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9C422CAF;
        Thu, 23 Jul 2020 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595489568;
        bh=XVKBQ2n+dgoTzei1ageyu0QpTRTK/zJAerBsCK7O3bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/dihVYRjius0eaWCfyFzwk32YlhOqIDUtxgDxUAUBYLD+rehdmZo8r8FUUJ/wSU6
         c4HBYN1AO6TnWmGqLYF8h78vFoPj4FLIEZTSQDPfmIOooZoXTApKCkYpo6wko1jLA3
         cDl7vGqfYTDFN75NgksoWdH/ehZO+BLKm0P0+DLQ=
Date:   Thu, 23 Jul 2020 13:02:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.9-rc1
Message-ID: <20200723073244.GX12965@vkoul-mobl>
References: <20200723070813.GV12965@vkoul-mobl>
 <20200723072057.GA1178592@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723072057.GA1178592@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-20, 09:20, Greg KH wrote:
> On Thu, Jul 23, 2020 at 12:38:13PM +0530, Vinod Koul wrote:
> > Hey Greg,
> > 
> > Here are the updates for soundwire subsystem for 5.9. Please pull.
> > 
> > 
> > The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> > 
> >   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.9-rc1
> 
> Pulled and pushed out, thanks.

Thanks, that was fast :)

-- 
~Vinod
