Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7FE29BE81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbgJ0Qte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:49:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:36635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1812855AbgJ0QqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:46:13 -0400
IronPort-SDR: LUdAjyvz5W3pMaVIpIpjvLPEAe4wfv3aV7XUkR7m3/g7rsO4Atp2Ih6OzHBrAGObO8QTT1ABHh
 wFjtr8UCT2yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="168245818"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168245818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 09:46:12 -0700
IronPort-SDR: XKsnFkV3p2HvEjd/nf7vJ4lQcPLWMdFVjaMY25oEFVkfJD/BVP/E3b9OfHmhPOrGOpywdE7r8A
 3x0Hs4jWSipA==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="318289173"
Received: from bretdavi-mobl2.amr.corp.intel.com (HELO [10.209.106.41]) ([10.209.106.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 09:46:12 -0700
Subject: Re: [PATCH v1 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
 <20201026141945.19707-4-srinivas.kandagatla@linaro.org>
 <98d3f89b-8d71-e652-504b-2bb770532a09@linux.intel.com>
 <b6ffdcf6-4f3a-f8be-422a-4de2d304fe5f@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b69a720a-4ee2-2ede-2d08-3bb800d58359@linux.intel.com>
Date:   Tue, 27 Oct 2020 11:14:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b6ffdcf6-4f3a-f8be-422a-4de2d304fe5f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/20 5:15 AM, Srinivas Kandagatla wrote:
> Thanks Pierre for review on all the patches.
> 
> On 26/10/2020 19:58, Pierre-Louis Bossart wrote:
>> Run cppcheck on this sort of code:
>>
>> cppcheck --platform=unix32 --force --max-configs=1024 --inconclusive
>> --enable=all --suppress=variableScope sound/soc/codecs/lpass-wsa-macro.c
> 
> I normally do sparse checks before sending patches, which did not catch 
> these.
> 
> thanks for the suggestion, I will keep add these checks to my future 
> patches.

Each tool has its own merits and strengths.

My routine is

export KCFLAGS="-Wall -Werror"
make W=1 sound/
  this typically catches set-but-not-used assignments, kernel-doc, etc.
make C=2 sound/
   Sparse catches big-little issues and when static should be used.
and the cppcheck last.
   this is a bit verbose and not suitable for CI/automation, but catches 
set-but-ignored assignments and differences between declarations and 
definitions. It also catches logical errors (always true, always-false, 
etc).

Hope this helps
-Pierre

