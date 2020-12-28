Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4455E2E3EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505286AbgL1OfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505254AbgL1OfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:35:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 450D7223E8;
        Mon, 28 Dec 2020 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166062;
        bh=Is9XbTyMnMpitr/me80eTOa4UNjGDk+Wd80fgtYldQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPoiBHW7srGkxORxbM7TK7a5ex8WPPKpJrx4I5G7I2z40mOwgIhNk8NhDN62iw7+5
         v34g7D3GJPQlvh5OptOaGxZLvXWvOjS8mLnWL5+zER/kgmto4vPFHS6U/+YVrmFA3Q
         22CgJMOdfhwQoDYFYKhUnBWI3klip+UBoOAGn0vg=
Date:   Mon, 28 Dec 2020 15:30:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: xhci-mtk: fix unreleased bandwidth data
Message-ID: <X+nr65vhINCw8fCL@kroah.com>
References: <20201214131640.v3.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <20201214163945.v4.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214163945.v4.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 04:39:53PM +0800, Ikjoon Jang wrote:
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
> Fixes: 4b0f7a77fb3c ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")

This is not a git commit id that is in Linus's tree :(

