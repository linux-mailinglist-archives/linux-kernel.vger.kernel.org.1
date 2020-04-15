Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF411AAE99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410410AbgDOQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:45:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:15261 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404537AbgDOQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:45:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492Ss61qB1zCQ;
        Wed, 15 Apr 2020 18:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586969130; bh=kAIJPE2ZZL/Q6yulReDpgbbwC0zEf9C+u6NXWrMTpRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkXq7rUHGtnXk/ohqLXvs9ytSE/gzc73Boks+663ZixJN1dMGTSWWli0CiDzpkIKC
         X5CpCCp+xIv5b2JMM5WbyW6xmnTIOiEJlM7mx5yPE0UxlDT84AI/SiAWGjPk46HQXD
         rSl3QyaOnzD/YQG04ZoI4k8ap0ITw4LhM2OaxYrPWz387tgGcy0XTbYr+jBMgQDzrl
         csq+a2LG9WNH9gtIuOMU6YW9LTUDFksuXEDRweTzgAEUEjWZk2OrWVwExdfIDFiPVk
         PTWeULgOUbLGw6S5h5WjRLthT1aC0RovdQzMegHmSZIU0RPynZkPfGfFwLhJ9kKqBZ
         K9HAMBtPCxxnQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 18:45:28 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/7] mmc: sdhci: simplify clock frequency calculation
Message-ID: <20200415164528.GE19897@qmqm.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <1a7f7f0941314da66acda3c60f44b3d2417133e6.1585827904.git.mirq-linux@rere.qmqm.pl>
 <7967c035-52e3-1ce7-a82f-47d28a3cf484@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7967c035-52e3-1ce7-a82f-47d28a3cf484@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:54:33PM +0300, Adrian Hunter wrote:
> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
> > Make clock frequency calculations simpler by replacing loops
> > with divide-and-clamp.
> 
> I am sorry, but I am not really sure the simplification is worth the code
> churn, risk of introducing new bugs, or validation effort.
> 
> IMO, the loops, while perhaps inefficient, are not hard to understand.

I guess this is a kind of religious subject. ;-)
I tend to prefer shorter and less-branchy code.

Best Regards,
Micha³ Miros³aw
