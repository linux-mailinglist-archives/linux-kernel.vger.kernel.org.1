Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D222A981
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGWHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgGWHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3024E2086A;
        Thu, 23 Jul 2020 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488902;
        bh=hzHe2/UKQtRQ+CdSuBofzo9tTWOBUKPss0cCKGiJmKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJVr2NKyXBvtwdCfd8Yq1Wt4ywBjwN/E+C1axRnl9cIUzkxPxffUdwVusYFo/o+QF
         U93If/5IcImJiN3ohhXaTVlHay9T1ljm+ECtthRpAb6T5TyWjJIU+HvGY7+KS69KNE
         mhEzgjP1dl9ovqTxdzClHVw2txplEW7HDmHBTpE4=
Date:   Thu, 23 Jul 2020 09:20:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.9-rc1
Message-ID: <20200723072057.GA1178592@kroah.com>
References: <20200723070813.GV12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723070813.GV12965@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:38:13PM +0530, Vinod Koul wrote:
> Hey Greg,
> 
> Here are the updates for soundwire subsystem for 5.9. Please pull.
> 
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.9-rc1

Pulled and pushed out, thanks.

greg k-h
