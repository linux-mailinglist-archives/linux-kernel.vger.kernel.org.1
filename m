Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D692B8F74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKSJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:53:23 -0500
Received: from muru.com ([72.249.23.125]:48738 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgKSJxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:53:23 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EF9C180C1;
        Thu, 19 Nov 2020 09:53:28 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:53:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     gregkh@linuxfoundation.org, paul@pwsan.com, aaro.koskinen@iki.fi,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ARM: OMAP1: clock: Use IS_ERR_OR_NULL() to clean code
Message-ID: <20201119095319.GK26857@atomide.com>
References: <20200910110640.4308-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910110640.4308-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tang Bin <tangbin@cmss.chinamobile.com> [200910 14:06]:
> Use IS_ERR_OR_NULL() to make the code cleaner.

Applying into omap-for-v5.11/soc thanks.

Tony
