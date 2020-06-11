Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E71F6440
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFKJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 05:05:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51988 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:05:40 -0400
Received: from p5b127c64.dip0.t-ipconnect.de ([91.18.124.100] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jjJ9W-0006it-Li; Thu, 11 Jun 2020 11:05:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: Re: [PATCH 1/2] panfrost: Make sure GPU is powered on when reading GPU_LATEST_FLUSH_ID
Date:   Thu, 11 Jun 2020 11:05:37 +0200
Message-ID: <4351778.0rgn4tIXvQ@phil>
In-Reply-To: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Juni 2020, 10:58:43 CEST schrieb Tomeu Vizoso:
> Bifrost devices do support the flush reduction feature, so on first job
> submit we were trying to read the register while still powered off.
> 
> If the GPU is powered off, the feature doesn't bring any benefit, so
> don't try to read.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

on a PX30-board (sibling of rk3326) with a 720x1280 panel and
glmark2 running all tests

Tested-by: Heiko Stuebner <heiko@sntech.de>


