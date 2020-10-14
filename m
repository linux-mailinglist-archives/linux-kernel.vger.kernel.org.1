Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3B28D81C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJNBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:49:04 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:56106 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJNBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:49:04 -0400
Received: from localhost (unknown [192.168.167.8])
        by regular1.263xmail.com (Postfix) with ESMTP id E9648975;
        Wed, 14 Oct 2020 09:48:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P2456T140206579640064S1602640125644670_;
        Wed, 14 Oct 2020 09:48:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c249e46a4078a52f82170955db998a8c>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
To:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     huangtao@rock-chips.com, andy.yan@rock-chips.com,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200707112526.18438-1-hjc@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <5c0cdb9d-8e35-fa0c-35b3-adfa7770fb30@rock-chips.com>
Date:   Wed, 14 Oct 2020 09:48:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707112526.18438-1-hjc@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

     Does this patch ready to merge?

On 2020/7/7 下午7:25, Sandy Huang wrote:
> don't mask possible_crtcs if remote-point is disabled.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>   drivers/gpu/drm/drm_of.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index fdb05fbf72a0..565f05f5f11b 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>   	uint32_t possible_crtcs = 0;
>   
>   	for_each_endpoint_of_node(port, ep) {
> +		if (!of_device_is_available(ep))
> +			continue;
> +
>   		remote_port = of_graph_get_remote_port(ep);
>   		if (!remote_port) {
>   			of_node_put(ep);

Looks good to me.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever


