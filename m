Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6945726857B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgINHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:07:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgINHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:07:38 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 451112928CC;
        Mon, 14 Sep 2020 08:07:34 +0100 (BST)
Date:   Mon, 14 Sep 2020 09:07:30 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        mparab@cadence.com, praneeth@ti.com, linux-kernel@vger.kernel.org,
        pgaj@cadence.com, linux-i3c@lists.infradead.org
Subject: Re: [PATCH v5] i3c: master: fix for SETDASA and DAA process
Message-ID: <20200914090730.543e2c4c@collabora.com>
In-Reply-To: <1598337109-14770-1-git-send-email-pthombar@cadence.com>
References: <1598337109-14770-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 08:31:49 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> This patch fix following issue.
> Controller slots blocked for devices with static_addr
> but no init_dyn_addr may limit the number of I3C devices
> on the bus which gets dynamic address in DAA. So
> instead of attaching all the devices with static_addr,
> now we only attach the devices which successfully
> complete SETDASA. For remaining devices with init_dyn_addr,
> i3c_master_add_i3c_dev_locked() will try to set requested
> dynamic address after DAA.

Queued to i3c/next.

Thanks,

Boris
