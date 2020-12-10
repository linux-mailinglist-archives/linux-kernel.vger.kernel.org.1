Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881732D58CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbgLJK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388808AbgLJK6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:58:42 -0500
Date:   Thu, 10 Dec 2020 11:59:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607597882;
        bh=fbHLbzX32k54F9e34fx22c90OfpXv/w5Qrd4WvS31RM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnKAW9tf7grXVCjw+8GF3nW1skE/u6PPlB+VWVNg7m84+uPCtrgBbCJhysoyR4SXd
         qSJ4+CoNK67LAqy6Z+5uUVWLtNCOX3995RVDe1saxbqICQph5bKacSewP5CoUGHi21
         l0gKxSMWlEC1FboOCD8Snlsfv0Y3eohrnjeY0ofQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: xhci-mtk: delay association of tt and ep
Message-ID: <X9H/hFasN+8GmQwB@kroah.com>
References: <20201210104747.3416781-1-ikjn@chromium.org>
 <20201210184700.v2.2.I236cbd6fe27db5a9c776b6d14fe146748373bbce@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210184700.v2.2.I236cbd6fe27db5a9c776b6d14fe146748373bbce@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 06:47:46PM +0800, Ikjoon Jang wrote:
> xhci-mtk creates internal data structures for representing the
> relationship between endpoint and TT.
> 
> This patch simply delays its association between endpoint and TT
> when it's really loaded onto internal bandwidth table.
> 
> This is a preparation step for fixing unreleased periodic
> TT bandwidth data, no functional changes.

So the next fix requires this on?  You might want to say that in the
next patch as well :)

thanks,

greg k-h
