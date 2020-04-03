Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FCE19DB05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbgDCQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 12:15:26 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64884 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgDCQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:15:26 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4lv0bP8z89;
        Fri,  3 Apr 2020 18:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585930524; bh=6g7iJNczJ+RujVMMOls/tTDBKftqdAux6ZbhdBsuAqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bxa1h7A6L5OKDbYxVL2Nb8rbQ9d0wGbMiOjnSrtrP8SesOAF5FJFQnuxNbDCSgb2A
         GG625Y5XsMMGqEK8E2ABBEG+F1l5ssbc8grvFyzpbn4pRJDWZRoUznsl1MZ7SoVOvz
         FDDjJbxUjMraBihHwVKfPU56dvEYNyhHag6JWvtGRBUVkNpu7mK39rjFhtphEGDjV4
         IQLZ2I7J44oOLSUQKbLOP0gvUXiDnoc+ILLLk5Cws9hixgWmd6/Hho0ic2b9aaXNe7
         9gbiBpanUb6Hl6urJpy4HS/4XKJVCEnY6PphUm0cOMXF8sTRO8fdgua2LOxy6oyCrA
         Iqr8Nia5s9HJA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 3 Apr 2020 18:15:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/7] mmc: sdhci: simplify clock frequency calculation
Message-ID: <20200403161521.GA15061@qmqm.qmqm.pl>
References: <1a7f7f0941314da66acda3c60f44b3d2417133e6.1585827904.git.mirq-linux@rere.qmqm.pl>
 <202004032014.Gm57FzHK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202004032014.Gm57FzHK%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:02:35PM +0800, kbuild test robot wrote:
[...]
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/mmc/host/sdhci.o: warning: objtool: sdhci_calc_clk() falls through to next function sdhci_set_clock()

This looks like false positive, as there is 'return clk;' at the
function's end untouched by the patches.

Best Regards,
Micha³ Miros³aw
