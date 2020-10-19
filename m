Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9829217F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgJSDoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:44:10 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:39572 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgJSDoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:44:10 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id E2E2B2BA;
        Mon, 19 Oct 2020 11:43:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1665T140084967511808S1603079033410318_;
        Mon, 19 Oct 2020 11:43:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f99b6cdefa6c3a4763585ece9ed9a3cc>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
To:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200707112526.18438-1-hjc@rock-chips.com>
 <5c0cdb9d-8e35-fa0c-35b3-adfa7770fb30@rock-chips.com>
 <20201015152301.GE438822@phenom.ffwll.local>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <e016801a-61aa-de6c-cb90-c62e03bdd067@rock-chips.com>
Date:   Mon, 19 Oct 2020 11:43:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015152301.GE438822@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2020/10/15 下午11:23, Daniel Vetter wrote:
> On Wed, Oct 14, 2020 at 09:48:43AM +0800, Kever Yang wrote:
>> Hi Maintainers,
>>
>>      Does this patch ready to merge?
> Would maybe be good to get some acks from other drivers using this, then
> Sandy can push to drm-misc-next.

Thanks for your reply, I can understand more 'acks' will be better, but 
there is no comments object to this patch

or any 'NAK' common for more then 3 months, maintainers should move to 
next step.


Thanks,

- Kever

> -Daniel
>> On 2020/7/7 下午7:25, Sandy Huang wrote:
>>> don't mask possible_crtcs if remote-point is disabled.
>>>
>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>> ---
>>>    drivers/gpu/drm/drm_of.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>>> index fdb05fbf72a0..565f05f5f11b 100644
>>> --- a/drivers/gpu/drm/drm_of.c
>>> +++ b/drivers/gpu/drm/drm_of.c
>>> @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>>>    	uint32_t possible_crtcs = 0;
>>>    	for_each_endpoint_of_node(port, ep) {
>>> +		if (!of_device_is_available(ep))
>>> +			continue;
>>> +
>>>    		remote_port = of_graph_get_remote_port(ep);
>>>    		if (!remote_port) {
>>>    			of_node_put(ep);
>> Looks good to me.
>>
>>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


