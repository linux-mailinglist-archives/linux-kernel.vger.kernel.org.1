Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAD2CFB5B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgLEKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:17:49 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47946 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgLEKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:11:50 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id EEFBD201101;
        Sat,  5 Dec 2020 09:05:29 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 31E3A20EC2; Sat,  5 Dec 2020 09:32:36 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:32:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] pcmcia: db1xxx_ss: remove unneeded semicolon
Message-ID: <X8tFpLcqFz0Ic1Pt@light.dominikbrodowski.net>
References: <20200910140524.1191003-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140524.1191003-1-yanaijie@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Sep 10, 2020 at 10:05:24PM +0800 schrieb Jason Yan:
> Eliminate the following coccicheck warning:
> 
> drivers/pcmcia/db1xxx_ss.c:455:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to pcmcia-next.

Thanks,
	Dominik
