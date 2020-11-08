Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143CC2AAC94
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKHRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:18:15 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:63776 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHRSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:18:14 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CTgnJ5d78z74;
        Sun,  8 Nov 2020 18:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604855892; bh=Fb/1j8jAG4oPFqa4Kck8vmLQUenZTSxCgjIpAXOUgSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIz5Yrc6x+uI2w6qjn7FirriMDrq23JMdiJUv+u9X8BVcdnAkXrTFSi10cll016fE
         7oUC3Hbovs5qSO4zIkka1V01/I7cyvI4g0fMsjB6Lzpw/hfMRHhHLYk1mq3DljsSJL
         qU7cYImNhKxdGqq69B99FI4X282tfG7NhgRaG/Tqk/skO9iXq7dgk9vyuIvAn8u02r
         W8z25/DMBqtT3lPRHYNEZy8pzA2s/YaLjXhpvc58JgUOPhJrfPWfX0P+23lZtxd5Yq
         Za98QfRf15SOpDMd5F5qxTS0i+nRXnikRMtVyXkNrWowlTwNtcyixFoBNhRmeO88HV
         6nnL6Lg6Vo52g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 8 Nov 2020 18:18:11 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
Message-ID: <20201108171811.GB10914@qmqm.qmqm.pl>
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
> Hi Micha³,
> 
> Recently when testing v5.10-rc2, I found my RK3399 boards failed to boot
> from NVME.
> 
> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
> creating regulator") seems to be the cause.
> 
> In RK3399 board, vpcie1v8 and vpcie0v9 of the pcie controller is
> provided by RK808 regulator.
> With that commit, now RK808 regulator fails to register:
> 
> [    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
> [    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
> [    1.419856] rk808 0-001b: failed to register 12 regulator
> [    1.422801] rk808-regulator: probe of rk808-regulator failed with
> error -22

Hi,

This looks lika the problem fixed by commit cf1ad559a20d ("regulator: defer
probe when trying to get voltage from unresolved supply") recently accepted
to regulator tree [1]. Can you verify this?

[1] git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next 
 
Best Regards
Micha³ Miros³aw
