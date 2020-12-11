Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42B72D70F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405414AbgLKH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:29:55 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59136 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbgLKH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:29:33 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 96659201130;
        Fri, 11 Dec 2020 07:28:50 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id ACF52204F2; Fri, 11 Dec 2020 08:28:32 +0100 (CET)
Date:   Fri, 11 Dec 2020 08:28:32 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init:  fix msleep() is not accurate
Message-ID: <X9MfoL/GtGJjVj3a@light.dominikbrodowski.net>
References: <1607657052-17608-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607657052-17608-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Dec 11, 2020 at 11:24:12AM +0800 schrieb Yejune Deng:
> See Documentation/timers/timers-howto.rst, msleep() is not
> for (1ms - 20ms),use usleep_range() instead.

While technically correct, this branch is only taken if the "rootwait"
kernel parameter is passed -- and as the kernel is looping here, it does not
really hurt if the msleep(5) takes a bit longer than advertised.

Thanks,
	Dominik
