Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9B2D58BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgLJK7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389287AbgLJK6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:58:16 -0500
Date:   Thu, 10 Dec 2020 11:58:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607597855;
        bh=+yNy2/EhKij1FrxrK/M173AdxIP7Qw+piOTeN0Owbwk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqWT9A8V1/rwqj8dU+bFqO3kPDEHGzBagQ50kyDtSZqSbkS6KE1WRE95VtxK6gnbD
         JqzjKXl1JUblAc7BspaphdDpa9W7IHVld5x+e/tAF2M1DFri3qOVhfbGs/KH5nGKHp
         VBwkyzBcX2PHgiRtRNv9qddao6RrODx2jEPgFmGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: xhci-mtk: fix unreleased bandwidth data
Message-ID: <X9H/ZVpHf2Owd6rj@kroah.com>
References: <20201210104747.3416781-1-ikjn@chromium.org>
 <20201210184700.v2.3.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210184700.v2.3.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 06:47:47PM +0800, Ikjoon Jang wrote:
> xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
> to handle its own sw bandwidth managements and stores bandwidth data
> into internal table every time add_endpoint() is called,
> so when bandwidth allocation fails at one endpoint, all earlier
> allocation from the same interface could still remain at the table.
> 
> This patch adds two more hooks from check_bandwidth() and
> reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
> from reset_bandwidth().
> 
> Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

Shouldn't this be the first patch in the series?  You don't want a fix
to be dependent on code style changes, otherwise it is really really
hard to backport it to older kernels that might need this fix, right?

Can you re-order these patches please?

thanks,

greg k-h
