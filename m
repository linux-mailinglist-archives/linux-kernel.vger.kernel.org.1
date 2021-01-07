Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604D2ECF0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbhAGLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:50:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:6934 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbhAGLun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:50:43 -0500
IronPort-SDR: 8GVb4PyDefBNqFuW5eyRvCmKoO7fQ+3i7P5B89/nIVBhX4J82KBfVwH/3cYgOyUyPlmtFkbtVE
 nrQR2PeBuMgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="238965624"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="238965624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 03:48:57 -0800
IronPort-SDR: Vp/wh3zZhv7tbV1si8fHMXjBU0nZMi1HsmC9tCjFgdrmDWGL7Ib0sQwf2xq8S2yEg2qqO2+yUM
 yO8B8xcUuL1Q==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="379688763"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 03:48:53 -0800
Date:   Thu, 7 Jan 2021 13:45:55 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: avoid reverse module dependency
In-Reply-To: <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2101071303040.864696@eliteleevi.tm.intel.com>
References: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com> <20210105190808.613050-1-arnd@kernel.org> <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 6 Jan 2021, Arnd Bergmann wrote:

> On Tue, Jan 5, 2021 at 8:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > Change it to use the normal probe order of starting with a specific
> > device in a driver, turning the sof-acpi-dev.c driver into a library.
> 
> There were a couple of build failures introduced by this version. I have
> one that does build now, and can post that if others think this is the
> direction they want to go.

thanks for the follow-up. We have many SOF maintainers still out on 
holidays this week, so let's give some time for people to digest. This is 
certainly a big change. The version you posted is already sufficient to 
describe the idea for sure.

Br, Kai
