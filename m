Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6FB1E1D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgEZIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 04:35:11 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42973 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:35:10 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id ADCF2240017;
        Tue, 26 May 2020 08:35:03 +0000 (UTC)
Date:   Tue, 26 May 2020 01:35:01 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Vladimir Oltean <olteanv@gmail.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        heikki.krogerus@linux.intel.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, radu-andrei.bulie@nxp.com
Subject: Re: [PATCH] serial: 8250: probe all 16550A variants by default
Message-ID: <20200526083501.GA464555@localhost>
References: <20200525130238.3614179-1-olteanv@gmail.com>
 <20200525172815.GA445190@localhost>
 <d989c5fe-451d-e6b4-a2f1-f6330809af99@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d989c5fe-451d-e6b4-a2f1-f6330809af99@inbox.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:05:25AM +0300, Maxim Kochetkov wrote:
> This change breaks all my devices: OMAP-L138 (davinci based), LS1021A,
> T1040, Marvell (kirkwood2 based). Only enabling VARIANTS on all my devices
> fix the issue.

Preparing a patch right now, with the appropriate Fixes tag so it should
end up on any kernel that has the original patch.

- Josh Triplett
