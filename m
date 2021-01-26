Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70589303FED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405778AbhAZONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405753AbhAZONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FBBC22B2C;
        Tue, 26 Jan 2021 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611670343;
        bh=G8RbizNkdNhtYdbjdcp6CKdodVotlaNcKkCrkrgBOM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RebdL0YABKv/TCxvi7C2gTeM2+0QKQEemTQWlYvunvF5ClLDr0dn/6NpKVgViC+yW
         BEj0iJ9GJRY8O3yXcKbITcIeI/SidE3xJ2cbdiMgzmjbLqYZFxUWAlIvkSMOd96LqI
         rre5pS6FU1M0YjFBWfPesiGrOCmP9mjr/LE4I8ME=
Date:   Tue, 26 Jan 2021 15:12:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
Message-ID: <YBAjRUSEd/6sCl4O@kroah.com>
References: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <1611640920.3905.13.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611640920.3905.13.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:02:00PM +0800, Chunfeng Yun wrote:
> Hi Ikjoon,
> 
> Can I put this patch into my patch series about bandwidth scheduler?
> the series also include "[RFC PATCH v3 1/5] usb: xhci-mtk: improve
> bandwidth scheduling with multi-TT", put them together will help to fix
> dependence issue, meanwhile I try to build xhci-mtk-sch.c into
> xhci-mtk.ko instead of xhci-hcd.ko.

This should probably be merged now, first, as it fixes an issue that
showed up in 4.20 so this needs to be backported to older kernels.

Please rebase your future patches on top of this.

thanks,

greg k-h
