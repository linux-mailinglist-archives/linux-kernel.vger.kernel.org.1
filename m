Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6117E1E4AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbgE0QrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:47:00 -0400
Received: from muru.com ([72.249.23.125]:55884 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391543AbgE0Qq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:46:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2E7F080DB;
        Wed, 27 May 2020 16:47:49 +0000 (UTC)
Date:   Wed, 27 May 2020 09:46:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        kernel@pyra-handheld.com, letux-kernel@openphoenux.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 4/4] w1: omap-hdq: print dev_err if irq flags are not
 cleared
Message-ID: <20200527164656.GK37466@atomide.com>
References: <cover.1590255176.git.hns@goldelico.com>
 <2de305d3046c7281a7123347899abbaa64c54fb8.1590255176.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de305d3046c7281a7123347899abbaa64c54fb8.1590255176.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [200523 17:34]:
> If irq flags are not cleared for certain operations we
> print an error message.
> 
> Since this should never occur in normal operation, this
> patch is an optional safety-net and debugging tool.

Acked-by: Tony Lindgren <tony@atomide.com>
