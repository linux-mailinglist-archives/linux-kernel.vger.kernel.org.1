Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8122F1E31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbhAKSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbhAKSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:44:44 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80844C061794;
        Mon, 11 Jan 2021 10:43:49 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6F5FB3E909;
        Mon, 11 Jan 2021 19:43:47 +0100 (CET)
Subject: Re: [PATCH 1/7] regulator: qcom-labibb: Implement voltage selector
 ops
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, sumit.semwal@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org
References: <20210109132921.140932-1-angelogioacchino.delregno@somainline.org>
 <20210109132921.140932-2-angelogioacchino.delregno@somainline.org>
 <20210111131642.GB4728@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <4158afa4-d28d-baf6-e26e-ef0e349d0596@somainline.org>
Date:   Mon, 11 Jan 2021 19:43:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111131642.GB4728@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/21 14:16, Mark Brown ha scritto:
> On Sat, Jan 09, 2021 at 02:29:15PM +0100, AngeloGioacchino Del Regno wrote:
> 
>> +	.linear_ranges		= (struct linear_range[]) {
>> +		REGULATOR_LINEAR_RANGE(4600000, 0, 15, 100000),
>> +	},
>> +	.n_linear_ranges	= 1,
> 
> If there's a single range that's just a simple linear mapping and should
> use regulator_map_voltage_linear().
> 

Yeah... that's.. my brain playing jokes on me, I think...
Thank you, will fix in V2!
