Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4624ED98
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHWOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 10:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHWOLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 10:11:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6736C206C0;
        Sun, 23 Aug 2020 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598191901;
        bh=Usgdzl1uD0oEX2VR3PfxExbFB8j8TRdFUWdsp8O2joU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRFjyVcyEsxwJ+5W3CwlLCYMbnXg69wsn2db5K5ykghKnlQ/Vl4tYw2qI+BM2k06i
         rNygS+B1Nc1ngdj5Qy0ezftk1F137NUrGHZP9xLUQSKapl1ZlstXcIwBLFnInVQi00
         qvpY6Ro7Z/jFZTX141ELX6ht8azrL5mzXpQdTa44=
Date:   Sun, 23 Aug 2020 19:41:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] phy: ti: am654: improve PCIe enumeration
 performance
Message-ID: <20200823141137.GR2639@vkoul-mobl>
References: <20200727194603.44636-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727194603.44636-1-nsekhar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-20, 01:16, Sekhar Nori wrote:
> This patch series updates AM654x PCIe serdes settings to
> latest recommended by hardware. This fixes Gen2 enumeration
> issues seen previously.

Applied after fixing typo 'threshold' in last patch, thanks
-- 
~Vinod
