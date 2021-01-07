Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B972ED34E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbhAGPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:12:48 -0500
Received: from comms.puri.sm ([159.203.221.185]:54144 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbhAGPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:12:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5F2A5E20F5;
        Thu,  7 Jan 2021 07:12:06 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pw4j1bP4qm-t; Thu,  7 Jan 2021 07:12:05 -0800 (PST)
Subject: Re: [PATCH] Revert "clk: imx: fix composite peripheral flags"
To:     Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201231142149.26062-1-martin.kepplinger@puri.sm>
 <CAOMZO5Bq5Qs90iZQTpouv5wW_xf0CQcP-i-+c-Jp-_Ftvhknnw@mail.gmail.com>
 <20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <805de301-29e0-72d4-05dd-c2873d26213b@puri.sm>
Date:   Thu, 7 Jan 2021 16:11:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 13:05, Abel Vesa wrote:
> On 20-12-31 17:33:40, Fabio Estevam wrote:
>> Hi Martin,
>>
>> On Thu, Dec 31, 2020 at 11:22 AM Martin Kepplinger
>> <martin.kepplinger@puri.sm> wrote:
>>>
>>> This reverts commit 936c383673b9e3007432f17140ac62de53d87db9.
>>>
>>> It breaks clock reparenting via devfreq on the imx8mq used in the
>>> Librem 5 phone. When switching dram frequency (which worked before)
>>> the system now hangs after this where the dram_apb clock cannot be
>>> set:
>>>
>>> [  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
>>> set dram_apb parent: -16
>>> [  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc
>>> failed freq switch to 25000000 from 800000000: error -16. now at 25000000
>>> [  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
>>> update frequency from PM QoS (-16)
>>
>> I am wondering whether IMX8MQ_CLK_DRAM_ALT should also be marked as
>> CLK_IS_CRITICAL.
>>
> 
> Hmm, the way the DRAM clocks are right registered right now is a real mess.
> The DRAM clocks on i.MX8M are changed in TF-A, but the kernel still needs to
> register them to keep track of the clock tree.
> 
> Martin, I already have a patchset waiting to be shipped which doesn't
> only fix the 8MQ, but all the 8M platforms. Unfortunately, I haven't had the time
> to work on that in the last couple of weeks but I intend to switch back to it soon.
> 
> Fabio, marking the DRAM clocks as critical will not allow the set_parent to be done,
> as CLK_IS_CRITICAL flag and set_parent do not go together. As of now the devfreq
> tries to reparent to be consistent with TF-A configuration.
> 
> My approach here was to make the DRAM clocks read-only. This means adding some
> stuff in the clock core subsystem too.

Hi Abel, thanks a lot for the update. I'm looking forward to seeing your 
patchset.

                               martin
