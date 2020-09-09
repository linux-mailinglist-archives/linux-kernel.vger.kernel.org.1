Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22432262BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIIJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 05:35:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIJfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:35:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87B94ADBD;
        Wed,  9 Sep 2020 09:35:03 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] arm: dts: mt7623: move display nodes to separate
 mt7623n.dtsi
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-7-linux@fw-web.de>
 <57085883-5044-aec2-021b-3b0880da70bc@gmail.com>
Message-ID: <3b3ef297-a3cf-6a3f-3118-9cc8b4ccc1f4@gmail.com>
Date:   Wed, 9 Sep 2020 11:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <57085883-5044-aec2-021b-3b0880da70bc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2020 11:29, Matthias Brugger wrote:
> 
> 
> On 19/08/2020 10:17, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> mt7623a has no graphics support so move nodes from generic mt7623.dtsi
>> to mt7623n.dtsi
>>
>> Fixes: 1f6ed224594 ("arm: dts: mt7623: add Mali-450 device node")
>> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Applied to v5.9-next/dts32
> 

Realized that there is a v6, so I pull out this and 7/7.

Regards,
Matthias
