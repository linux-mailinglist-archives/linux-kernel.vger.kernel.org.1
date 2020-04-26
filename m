Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814231B8F96
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgDZL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 07:58:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDZL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:58:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B6DEAA55;
        Sun, 26 Apr 2020 11:58:12 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] ARM: dts: Add Caninos Loucos Labrador
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-4-matheus@castello.eng.br>
 <20200405065137.GC8912@Mani-XPS-13-9360>
 <df32c750-a097-9210-6e13-db7db49836b5@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <2dca5a4e-933c-0a43-e86f-21b55d75a586@suse.de>
Date:   Sun, 26 Apr 2020 13:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <df32c750-a097-9210-6e13-db7db49836b5@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

Am 23.04.20 um 17:20 schrieb Matheus Castello:
> Em 4/5/20 3:51 AM, Manivannan Sadhasivam escreveu:
>> On Fri, Mar 20, 2020 at 12:51:04AM -0300, Matheus Castello wrote:
>>> Add Device Trees for Caninos Loucos Labrador CoM and base board.
>>> Based on the work of Andreas Färber on Lemaker Guitar device tree.
>>>
>>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Will queue the series for v5.8 once Andreas is happy with it.
> 
> do you have any more concerns about these patches? Let me know.

I've reviewed the preceding two patches. This one here looks okay,

Reviewed-by: Andreas Färber <afaerber@suse.de>

but see 2/3 - model here does contain M and your .dtsi is named -v2 - 
what's the difference to v1? If it's big enough to warrant a separate 
.dtsi, you should consider whether a versioned compatible string may be 
needed, too (likely in addition to, not instead of a generic one). No v1 
info on the website.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
