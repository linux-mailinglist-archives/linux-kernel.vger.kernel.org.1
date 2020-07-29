Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7769523184E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 05:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgG2Dvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 23:51:49 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:41307 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgG2Dvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:51:49 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 6418B2ECD3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:51:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0d85kjmoeBb5d0d85kONgS; Tue, 28 Jul 2020 22:51:45 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:References:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7ussQbKjWAE3jac6ZnQJpyAa/4HACISV3jjrEApZQNc=; b=EJg6hTGcxZwCALGc1STXI5/FWa
        QMqnEcqWY0dcpRzT6v0HrZwdBdZXOJf7SJYL6kJSuHjP1+I92u6LAm1CbQ259AziBlGSDfkndjQUB
        o5y6URa7u8FpfjBJHBGNn9pTLem+J+hFyGA7a+T+MGnPEWVWSjrglxrzvKqGeS1Q3R0T7E2U5+KC/
        p3cRiBgf42I7eFmNTOA9P50YX2lkUIIQQPjLo+ul9BllczS9+QDvHhyidqY2pxOCRN5CH6YupwCQ5
        TzwYkThiIDylyTmUxuxq48aaVe82Ah2UpQ5XMnq4/kSs+SlwAtVVjjqa2EgAJjqbTcSPvbDSd7Wf9
        8C4MmxzQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:35894 helo=[192.168.15.2])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k0d85-003qkV-1R; Tue, 28 Jul 2020 22:51:45 -0500
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
 <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
 <6736aefa05e84b30bcc91003b55c7644@intel.com>
 <c4a93287-6010-8ea4-cab2-09efa49e3391@embeddedor.com>
 <fe8f4b91-c65e-0664-c5df-52d4a93734b5@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Message-ID: <e2a00deb-831c-83a6-2580-2ec65076f7e3@embeddedor.com>
Date:   Tue, 28 Jul 2020 22:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fe8f4b91-c65e-0664-c5df-52d4a93734b5@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k0d85-003qkV-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.2]) [187.162.31.110]:35894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 18:16, Gustavo A. R. Silva wrote:
> 
> 
> On 7/28/20 18:04, Gustavo A. R. Silva wrote:
>> Tomas,
>>
>> Please, see some comments below...
>>
>> On 7/28/20 17:29, Winkler, Tomas wrote:
>>>>>>>
>>>>>>> Hi Tomas,
>>>>>>>
>>>>>>> On 7/28/20 16:41, Tomas Winkler wrote:
>>>>>>>> Greg please revert, this commit it changes size of struct
>>>>>>>> wired_cmd_repeater_auth_stream_req_in, this is not what firmware
>>>>>>>> is expecting.
>>>>>>>

Instead of reverting that commit, I think this patch should be applied
to fix it, if Tomas consider this is the appropiate solution:

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index d1d3e025ca0e..852374565cba 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -572,12 +572,12 @@ static int mei_hdcp_verify_mprime(struct device *dev,
               HDCP_2_2_MPRIME_LEN);
        drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
        memcpy(verify_mprime_in.streams, data->streams,
-              array_size(data->k, sizeof(*data->streams)));
+              flex_array_size(&verify_mprime_in, streams, data->k));

        verify_mprime_in.k = cpu_to_be16(data->k);

        byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
-                             sizeof(verify_mprime_in));
+                             struct_size(&verify_mprime_in, streams, data->k));
        if (byte < 0) {
                dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
                return byte;

I'll write up a proper patch after getting some feedback.

Thanks
--
Gustavo

>>>>>>> Could you elaborate on what's the firmware expecting, exactly?
>>>>>> struct wired_cmd_repeater_auth_stream_req_in {
>>>>>>   -	struct hdcp2_streamid_type	streams[1];
>>>>>>   + 	struct hdcp2_streamid_type	streams[];
>>>>>> }
>>>>>>
>>>>>> But then you have, which you haven't changed to + 1 byte =
>>>>>> mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
>>>>>>                               sizeof(verify_mprime_in));
>>>>>>
>>
>> I don't think the fix for this is to add 1 byte, if any, it seems
>> to be sizeof(*data->streams), or sizeof(struct hdcp2_streamid_type)
>> what needs to be added.
>>
>> But it might be better to code something like this, instead:
>>
>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
>> index e6c3dc595617..7fe63c915548 100644
>> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
>> @@ -572,12 +572,12 @@ static int mei_hdcp_verify_mprime(struct device *dev,
>>                HDCP_2_2_MPRIME_LEN);
>>         drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
>>         memcpy(verify_mprime_in.streams, data->streams,
>> -              (data->k * sizeof(struct hdcp2_streamid_type)));
>> +              (data->k * sizeof(*data->streams)));
>>
>>         verify_mprime_in.k = cpu_to_be16(data->k);
>>
>>         byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
>> -                             sizeof(verify_mprime_in));
>> +                             struct_size(&verify_mprime_in, streams, data->k));
>>         if (byte < 0) {
>>                 dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
>>                 return byte;
>>
>> struct_size(&verify_mprime_in, streams, data->k) will give us the size, in bytes,
>> of struct wired_cmd_repeater_auth_stream_req_in plus the size in bytes for
>> the streams[] flexible-array, which is determined by struct hdcp2_streamid_type and
>> data->k.
>>
>> What do you think?
>>
> 
> This is even better:
> 
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index e6c3dc595617..852374565cba 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -572,12 +572,12 @@ static int mei_hdcp_verify_mprime(struct device *dev,
>                HDCP_2_2_MPRIME_LEN);
>         drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
>         memcpy(verify_mprime_in.streams, data->streams,
> -              (data->k * sizeof(struct hdcp2_streamid_type)));
> +              flex_array_size(&verify_mprime_in, streams, data->k));
> 
>         verify_mprime_in.k = cpu_to_be16(data->k);
> 
>         byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
> -                             sizeof(verify_mprime_in));
> +                             struct_size(&verify_mprime_in, streams, data->k));
>         if (byte < 0) {
>                 dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
>                 return byte;
> 
> the flex_array_size() is a new helper that was designed for this situations. :)
> It calculates the size of a flexible array member within an enclosing structure,
> which is exactly the case.
> 
> Thanks
> --
> Gustavo
> 
>> See more comments below...
>>
>>>>>
>>>>> I see, this is the kind of feedback I need from people that knows the
>>>>> code better. Thanks!
>>>>>
>>>>>> But that's not the major point. Point is that we should be able to
>>>>>> review and test the code before it is merged.  You haven't run it, right?
>>>>>> There is MAINTAINERS file for a reason.
>>>>>>
>>>>>
>>>>> I'm using this command:
>>>>>
>>>>> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
>>>>>
>>>>> and this is the output for both files:
>>>>>
>>>>> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback
>>>>> drivers/misc/mei/hdcp/mei_hdcp.c Arnd Bergmann <arnd@arndb.de>
>>>>> (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS) linux-
>>>>> kernel@vger.kernel.org (open list) $ scripts/get_maintainer.pl
>>>>> --nokeywords -- nogit --nogit-fallback
>>>>> drivers/misc/mei/hdcp/mei_hdcp.h Arnd Bergmann <arnd@arndb.de>
>>>>> (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS) linux-
>>>>> kernel@vger.kernel.org (open list)
>>>>
>>>>
>>>>> For some reason you don't appear on the list above. Do you see
>>>>> anything wrong with the command I'm running to get the maintainers and
>>>> lists?
>>>>
>>>> Not sure, it should be caught by drivers/misc/mei/* ?
>>>> Maybe it is not recursive? Need to check the script, frankly I usually check this
>>>> manually.
>>>>
>>>> INTEL MANAGEMENT ENGINE (mei)
>>>> M:      Tomas Winkler <tomas.winkler@intel.com>
>>>> L:      linux-kernel@vger.kernel.org
>>>> S:      Supported
>>>> F:      Documentation/driver-api/mei/*
>>>> F:      drivers/misc/mei/*
>>>> F:      drivers/watchdog/mei_wdt.c
>>>> F:      include/linux/mei_cl_bus.h
>>>> F:      include/uapi/linux/mei.h
>>>> F:      samples/mei/*
>>>>
>>>
>>> It's not recursive, when I add drivers/misc/mei/hdcp/* . It works correctly 
>>> I will post a patch.
>>>
>>
>> Great. I'm glad we got to the root cause of this issue. :)
>>
>> Thanks
>> --
>> Gustavo
>>
>>> Thanks
>>> Tomas
>>>
>>>
>>>>
>>>>>
>>>>> Thanks
>>>>> --
>>>>> Gustavo
>>>>>
>>>>>>>
>>>>>>>> I really do not appreciate that the code is bypassing driver
>>>>>>>> maintaner review, I think this is a minimum we can ask for, this
>>>>>>>> is not for a first time.
>>>>>>>>
>>>>>>>> This reverts commit c56967d674e361ebe716e66992e3c5332b25ac1f.
>>>>>>>>
>>>>>>>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>>>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>>>>>>> ---
>>>>>>>>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>>>>>>>> drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
>>>>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c
>>>>>>>> b/drivers/misc/mei/hdcp/mei_hdcp.c
>>>>>>>> index d1d3e025ca0e..e6c3dc595617 100644
>>>>>>>> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
>>>>>>>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
>>>>>>>> @@ -572,7 +572,7 @@ static int mei_hdcp_verify_mprime(struct
>>>>>>>> device
>>>>>>> *dev,
>>>>>>>>  	       HDCP_2_2_MPRIME_LEN);
>>>>>>>>  	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data-
>>>>> seq_num_m);
>>>>>>>>  	memcpy(verify_mprime_in.streams, data->streams,
>>>>>>>> -	       array_size(data->k, sizeof(*data->streams)));
>>>>>>>> +	       (data->k * sizeof(struct hdcp2_streamid_type)));
>>>>>>>>
>>>>>>>>  	verify_mprime_in.k = cpu_to_be16(data->k);
>>>>>>>>
>>>>>>>> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h
>>>>>>>> b/drivers/misc/mei/hdcp/mei_hdcp.h
>>>>>>>> index 834757f5e072..18ffc773fa18 100644
>>>>>>>> --- a/drivers/misc/mei/hdcp/mei_hdcp.h
>>>>>>>> +++ b/drivers/misc/mei/hdcp/mei_hdcp.h
>>>>>>>> @@ -358,7 +358,7 @@ struct
>>>> wired_cmd_repeater_auth_stream_req_in
>>>>> {
>>>>>>>>  	u8
>>>>>>> 	seq_num_m[HDCP_2_2_SEQ_NUM_LEN];
>>>>>>>>  	u8				m_prime[HDCP_2_2_MPRIME_LEN];
>>>>>>>>  	__be16				k;
>>>>>>>> -	struct hdcp2_streamid_type	streams[];
>>>>>>>> +	struct hdcp2_streamid_type	streams[1];
>>>>>>>>  } __packed;
>>>>>>>>
>>>>>>>>  struct wired_cmd_repeater_auth_stream_req_out {
>>>>>>>>
