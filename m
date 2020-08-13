Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC03243409
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgHMGb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 02:31:28 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:34070 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHMGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:31:28 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 087A61177;
        Thu, 13 Aug 2020 14:31:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28892T140683746662144S1597300276100784_;
        Thu, 13 Aug 2020 14:31:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <649d06a57454f0e656e289273e1861b8>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, kever.yang@rock-chips.com,
        linux-kernel@vger.kernel.org
References: <20200707112526.18438-1-hjc@rock-chips.com>
 <3361390.LkKjKlf5PX@phil>
From:   Huang Jiachai <hjc@rock-chips.com>
Message-ID: <12d1b648-81d1-df48-4435-b7b88dd72b30@rock-chips.com>
Date:   Thu, 13 Aug 2020 14:31:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3361390.LkKjKlf5PX@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

�� 2020/7/23 3:01, Heiko St��bner д��:
> Am Dienstag, 7. Juli 2020, 13:25:26 CEST schrieb Sandy Huang:
>> don't mask possible_crtcs if remote-point is disabled.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> changes in v2:
> - drop additional of_node_put, as ep will be put with the next
>    iteration of for_each_endpoint_of_node()
>
>
> As this touches a pretty central function is there something
> to keep in mind in regards to other DRM drivers?
> [question for the broader audience ;-) ]
>
> Heiko
>
>> ---
>>   drivers/gpu/drm/drm_of.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>> index fdb05fbf72a0..565f05f5f11b 100644
>> --- a/drivers/gpu/drm/drm_of.c
>> +++ b/drivers/gpu/drm/drm_of.c
>> @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>>   	uint32_t possible_crtcs = 0;
>>   
>>   	for_each_endpoint_of_node(port, ep) {
>> +		if (!of_device_is_available(ep))
>> +			continue;
>> +
>>   		remote_port = of_graph_get_remote_port(ep);
>>   		if (!remote_port) {
>>   			of_node_put(ep);
>>
>
>
>
>
>
-- 
Best Regard

�Ƽ���
Sandy Huang
Addr: �����й�¥��ͭ��·������89�Ÿ������԰A��21��¥(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel��+86 0591-87884919  8690
E-mail��hjc@rock-chips.com



