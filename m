Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B623155D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 00:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgG1WLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 18:11:52 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:33339 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729437AbgG1WLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:11:51 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7C6FE400CE3BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:11:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0Xp7kki22zOau0Xp7kRTRx; Tue, 28 Jul 2020 17:11:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jYLAzFDY/OZp8XCVPf+vqkzmrtODtg4qjPFi8kYSUlE=; b=SODMn/mYUEvmH3qmpeo7MEbtNZ
        mN2HH1/MeLkSQEayfl/SJWw+zJushqayh4pdbauGnUENM0ytsIibXMkH3V4b4B7Q7A50+2ljVt5A1
        ZpPdmC6izcYJmrVp4o7uHu/ODGDHLLo7Jc6NzvB55Pg77ncVw2Q4+VlTwjgpYNmWazecm7YdHRW8W
        Poj6qjqEBc97fXN2BCWSbYVJe0JYdKSJwGUbIj9fXxWYebCZROighkuH+9txwpxqMzxu5g8qwi0gK
        khjfMRTyRe5ew6+vNEJDU9Zzako+dLeek0bP2xBc1kWx3ILxQntlyMZ8x9oERrrV6nTEPiZQceSIh
        Wmh9IIrQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:58904 helo=[192.168.15.2])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k0Xp7-000lrx-6L; Tue, 28 Jul 2020 17:11:49 -0500
Subject: Re: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
 <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
 <8ec7601780b542c2bc0168e03749ec0e@intel.com>
 <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <c7359f57-a023-0918-e082-7f17f6c05e6e@embeddedor.com>
Date:   Tue, 28 Jul 2020 17:17:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k0Xp7-000lrx-6L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.2]) [187.162.31.110]:58904
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 17:14, Gustavo A. R. Silva wrote:
> 
> 
> On 7/28/20 17:01, Winkler, Tomas wrote:
>>
>>
>>> -----Original Message-----
>>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> Sent: Wednesday, July 29, 2020 00:57
>>> To: Winkler, Tomas <tomas.winkler@intel.com>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>
>>> Cc: Usyskin, Alexander <alexander.usyskin@intel.com>; linux-
>>> kernel@vger.kernel.org; Gustavo A . R . Silva <gustavoars@kernel.org>
>>> Subject: Re: [char-misc-next] Revert "mei: hdcp: Replace one-element array
>>> with flexible-array member"
>>>
>>> Hi Tomas,
>>>
>>> On 7/28/20 16:41, Tomas Winkler wrote:
>>>> Greg please revert, this commit it changes size of struct
>>>> wired_cmd_repeater_auth_stream_req_in, this is not what firmware is
>>>> expecting.
>>>
>>> Could you elaborate on what's the firmware expecting, exactly?
>> struct wired_cmd_repeater_auth_stream_req_in {
>>   -	struct hdcp2_streamid_type	streams[1];
>>   + 	struct hdcp2_streamid_type	streams[];
>> }
>>
>> But then you have, which you haven't changed to + 1
>> byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
>>                               sizeof(verify_mprime_in));
>>
> 
> I see, this is the kind of feedback I need from people that knows the
> code better. Thanks!
> 
>> But that's not the major point. Point is that we should be able to review
>> and test the code before it is merged.  You haven't run it, right? 
>> There is MAINTAINERS file for a reason. 
>>
> 
> I'm using this command:
> 
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
> 
> and this is the output for both files:
> 
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/misc/mei/hdcp/mei_hdcp.c
> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback drivers/misc/mei/hdcp/mei_hdcp.h
> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> 
> For some reason you don't appear on the list above. Do you see anything wrong with
> the command I'm running to get the maintainers and lists?>

Notice that if I run this command:

$ scripts/get_maintainer.pl -f drivers/misc/mei/hdcp/mei_hdcp.h
Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)
Ramalingam C <ramalingam.c@intel.com> (commit_signer:2/2=100%,authored:2/2=100%,added_lines:4/4=100%,removed_lines:13/13=100%)
Tomas Winkler <tomas.winkler@intel.com> (commit_signer:2/2=100%)
Uma Shankar <uma.shankar@intel.com> (commit_signer:2/2=100%)
Jani Nikula <jani.nikula@intel.com> (commit_signer:2/2=100%)
Shashank Sharma <shashank.sharma@intel.com> (commit_signer:2/2=100%)
linux-kernel@vger.kernel.org (open list)

You appear this time, but not as a maintainer.

Thanks
--
Gustavo

>>>
>>>> I really do not appreciate that the code is bypassing driver maintaner
>>>> review, I think this is a minimum we can ask for, this is not for a
>>>> first time.
>>>>
>>>> This reverts commit c56967d674e361ebe716e66992e3c5332b25ac1f.
>>>>
>>>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>>> ---
>>>>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>>>> drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c
>>>> b/drivers/misc/mei/hdcp/mei_hdcp.c
>>>> index d1d3e025ca0e..e6c3dc595617 100644
>>>> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
>>>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
>>>> @@ -572,7 +572,7 @@ static int mei_hdcp_verify_mprime(struct device
>>> *dev,
>>>>  	       HDCP_2_2_MPRIME_LEN);
>>>>  	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data-
>>>> seq_num_m);
>>>>  	memcpy(verify_mprime_in.streams, data->streams,
>>>> -	       array_size(data->k, sizeof(*data->streams)));
>>>> +	       (data->k * sizeof(struct hdcp2_streamid_type)));
>>>>
>>>>  	verify_mprime_in.k = cpu_to_be16(data->k);
>>>>
>>>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h
>>>> b/drivers/misc/mei/hdcp/mei_hdcp.h
>>>> index 834757f5e072..18ffc773fa18 100644
>>>> --- a/drivers/misc/mei/hdcp/mei_hdcp.h
>>>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.h
>>>> @@ -358,7 +358,7 @@ struct wired_cmd_repeater_auth_stream_req_in {
>>>>  	u8
>>> 	seq_num_m[HDCP_2_2_SEQ_NUM_LEN];
>>>>  	u8				m_prime[HDCP_2_2_MPRIME_LEN];
>>>>  	__be16				k;
>>>> -	struct hdcp2_streamid_type	streams[];
>>>> +	struct hdcp2_streamid_type	streams[1];
>>>>  } __packed;
>>>>
>>>>  struct wired_cmd_repeater_auth_stream_req_out {
>>>>
