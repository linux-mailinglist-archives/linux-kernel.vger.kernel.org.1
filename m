Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A929D728
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgJ1WVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:21:44 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:23547 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbgJ1WUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:20:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603923608; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7BMfmsYB8bIIUbksItYBO32nFJ/O4cpAMIZY7yaeMf4=; b=uVPO6zbAp81uKB3LOEJUVVVfQUe4Ai5+dTE5Ok8PQhYF23PA/ajPAYHSzNCykNWR7Ele+rEg
 OAYrqyvXz7LwTcsPPUwupvZuAkMlRmhoRz1xcRNMtwOpGCAPLJN7I17AvHSZUbn7fan8ytqc
 9a198MrYDt+QBNUD5DeG/61grIE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f997f1f2ef825cbc222eba4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 14:24:31
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9E3DC433FF; Wed, 28 Oct 2020 14:24:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.0
Received: from [10.226.59.216] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67260C433FE;
        Wed, 28 Oct 2020 14:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67260C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBidXM6IG1oaTogY29yZTogQWRkIHN1?=
 =?UTF-8?Q?pport_MHI_EE_FP_for_download_firmware?=
To:     =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Cc:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naveen Kumar <naveen.kumar@quectel.com>
References: <a9d5117e4c6647a5e6c3ed3e2fb049a3@sslemail.net>
 <322cf3df-86f1-7614-62b1-db8594a8062a@codeaurora.org>
 <HK2PR06MB35079165F7A51A3D995AA46A86170@HK2PR06MB3507.apcprd06.prod.outlook.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <45c9497e-4186-8c5f-431b-ad5eb003f505@codeaurora.org>
Date:   Wed, 28 Oct 2020 08:24:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <HK2PR06MB35079165F7A51A3D995AA46A86170@HK2PR06MB3507.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2020 7:39 PM, Carl Yin(殷张成) wrote:
> Hi Hemant and Jeffery:
> 
> On Wednesday, October 28, 2020 7:02 AM, hemantk wrote:
>> Hi Jeff,
>>
>> On 10/27/20 8:11 AM, Jeffrey Hugo wrote:
>>> On 10/27/2020 3:43 AM, carl.yin@quectel.com wrote:
>>>> From: "carl.yin" <carl.yin@quectel.com>
>>>>
>>>> MHI wwan modems support download firmware to nand or emmc by firehose
>>>> protocol, process as next:
>>>> 1. wwan modem normal bootup and enter EE AMSS, create mhi DIAG chan
>>>> device 2. send EDL cmd via DIAG chan, then modem enter EE EDL 3.
>>>> boot.c download 'firehose/prog_firehose_sdx55.mbn' via BHI interface
>>>> 4. modem enter EE FP, and create mhi EDL chan device 5. user space
>>>> tool download FW to modem via EDL chan by firehose protocol
>>>>
>>>> Signed-off-by: carl.yin <carl.yin@quectel.com>
>>>> ---
>>>>    drivers/bus/mhi/core/boot.c     |  4 +++-
>>>>    drivers/bus/mhi/core/init.c     |  2 ++
>>>>    drivers/bus/mhi/core/internal.h |  1 +
>>>>    drivers/bus/mhi/core/main.c     |  3 +++
>>>>    drivers/bus/mhi/core/pm.c       | 16 +++++++++++++++-
>>>>    include/linux/mhi.h             |  4 +++-
>>>>    6 files changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/core/boot.c
>>>> b/drivers/bus/mhi/core/boot.c index 24422f5..ab39ad6 100644
>>>> --- a/drivers/bus/mhi/core/boot.c
>>>> +++ b/drivers/bus/mhi/core/boot.c
>>>> @@ -460,8 +460,10 @@ void mhi_fw_load_handler(struct mhi_controller
>>>> *mhi_cntrl)
>>>>            return;
>>>>        }
>>>> -    if (mhi_cntrl->ee == MHI_EE_EDL)
>>>> +    if (mhi_cntrl->ee == MHI_EE_EDL) {
>>>> +        mhi_ready_state_transition(mhi_cntrl);
>>>>            return;
>>>> +    }
>>>>        write_lock_irq(&mhi_cntrl->pm_lock);
>>>>        mhi_cntrl->dev_state = MHI_STATE_RESET; diff --git
>>>> a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c index
>>>> ac4aa5c..9c2c2f3 100644
>>>> --- a/drivers/bus/mhi/core/init.c
>>>> +++ b/drivers/bus/mhi/core/init.c
>>>> @@ -26,6 +26,7 @@ const char * const mhi_ee_str[MHI_EE_MAX] = {
>>>>        [MHI_EE_WFW] = "WFW",
>>>>        [MHI_EE_PTHRU] = "PASS THRU",
>>>>        [MHI_EE_EDL] = "EDL",
>>>> +    [MHI_EE_FP] = "FP",
>>>>        [MHI_EE_DISABLE_TRANSITION] = "DISABLE",
>>>>        [MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
>>>>    };
>>>> @@ -35,6 +36,7 @@ const char * const
>>>> dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>>>>        [DEV_ST_TRANSITION_READY] = "READY",
>>>>        [DEV_ST_TRANSITION_SBL] = "SBL",
>>>>        [DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
>>>> +    [DEV_ST_TRANSITION_FP] = "FP",
>>>>        [DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
>>>>        [DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>>>>    };
>>>> diff --git a/drivers/bus/mhi/core/internal.h
>>>> b/drivers/bus/mhi/core/internal.h index 4abf0cf..6ae897a 100644
>>>> --- a/drivers/bus/mhi/core/internal.h
>>>> +++ b/drivers/bus/mhi/core/internal.h
>>>> @@ -386,6 +386,7 @@ enum dev_st_transition {
>>>>        DEV_ST_TRANSITION_READY,
>>>>        DEV_ST_TRANSITION_SBL,
>>>>        DEV_ST_TRANSITION_MISSION_MODE,
>>>> +    DEV_ST_TRANSITION_FP,
>>>>        DEV_ST_TRANSITION_SYS_ERR,
>>>>        DEV_ST_TRANSITION_DISABLE,
>>>>        DEV_ST_TRANSITION_MAX,
>>>> diff --git a/drivers/bus/mhi/core/main.c
>>>> b/drivers/bus/mhi/core/main.c index 3950792..e307b58 100644
>>>> --- a/drivers/bus/mhi/core/main.c
>>>> +++ b/drivers/bus/mhi/core/main.c
>>>> @@ -782,6 +782,9 @@ int mhi_process_ctrl_ev_ring(struct
>>>> mhi_controller *mhi_cntrl,
>>>>                case MHI_EE_SBL:
>>>>                    st = DEV_ST_TRANSITION_SBL;
>>>>                    break;
>>>> +            case MHI_EE_FP:
>>>> +                st = DEV_ST_TRANSITION_FP;
>>>> +                break;
>>>>                case MHI_EE_WFW:
>>>>                case MHI_EE_AMSS:
>>>>                    st = DEV_ST_TRANSITION_MISSION_MODE; diff
>> --git
>>>> a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c index
>>>> 3de7b16..3c95a5d 100644
>>>> --- a/drivers/bus/mhi/core/pm.c
>>>> +++ b/drivers/bus/mhi/core/pm.c
>>>> @@ -563,7 +563,15 @@ static void mhi_pm_disable_transition(struct
>>>> mhi_controller *mhi_cntrl,
>>>>        }
>>>>        if (cur_state == MHI_PM_SYS_ERR_PROCESS) {
>>>> -        mhi_ready_state_transition(mhi_cntrl);
>>>> +        if (mhi_get_exec_env(mhi_cntrl) == MHI_EE_EDL
>>>> +            && mhi_get_mhi_state(mhi_cntrl) == MHI_STATE_RESET) {
>>>> +            write_lock_irq(&mhi_cntrl->pm_lock);
>>>> +            cur_state = mhi_tryset_pm_state(mhi_cntrl,
>> MHI_PM_POR);
>>>> +            write_unlock_irq(&mhi_cntrl->pm_lock);
>>>> +            mhi_queue_state_transition(mhi_cntrl,
>>>> DEV_ST_TRANSITION_PBL);
>>>> +        } else {
>>>> +            mhi_ready_state_transition(mhi_cntrl);
>>>> +        }
>>>>        } else {
>>>>            /* Move to disable state */
>>>>            write_lock_irq(&mhi_cntrl->pm_lock);
>>>> @@ -658,6 +666,12 @@ void mhi_pm_st_worker(struct work_struct *work)
>>>>            case DEV_ST_TRANSITION_MISSION_MODE:
>>>>                mhi_pm_mission_mode_transition(mhi_cntrl);
>>>>                break;
>>>> +        case DEV_ST_TRANSITION_FP:
>>>> +            write_lock_irq(&mhi_cntrl->pm_lock);
>>>> +            mhi_cntrl->ee = MHI_EE_FP;
>>>> +            write_unlock_irq(&mhi_cntrl->pm_lock);
>>>> +            mhi_create_devices(mhi_cntrl);
>>>> +            break;
>>>>            case DEV_ST_TRANSITION_READY:
>>>>                mhi_ready_state_transition(mhi_cntrl);
>>>>                break;
>>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h index
>>>> 6e1122c..4620af8 100644
>>>> --- a/include/linux/mhi.h
>>>> +++ b/include/linux/mhi.h
>>>> @@ -120,6 +120,7 @@ struct mhi_link_info {
>>>>     * @MHI_EE_WFW: WLAN firmware mode
>>>>     * @MHI_EE_PTHRU: Passthrough
>>>>     * @MHI_EE_EDL: Embedded downloader
>>>> + * @MHI_EE_FP, Flash Programmer Environment
>>>>     */
>>>>    enum mhi_ee_type {
>>>>        MHI_EE_PBL,
>>>> @@ -129,7 +130,8 @@ enum mhi_ee_type {
>>>>        MHI_EE_WFW,
>>>>        MHI_EE_PTHRU,
>>>>        MHI_EE_EDL,
>>>> -    MHI_EE_MAX_SUPPORTED = MHI_EE_EDL,
>>>> +    MHI_EE_FP,
>>>> +    MHI_EE_MAX_SUPPORTED = MHI_EE_FP,
>>>>        MHI_EE_DISABLE_TRANSITION, /* local EE, not related to mhi spec
>>>> */
>>>>        MHI_EE_NOT_SUPPORTED,
>>>>        MHI_EE_MAX,
>>>>
>>>
>>> This gets a NACK from me.  I don't see the FP_EE that this patch
>>> introduces defined in the spec.  Where did it come from?
>>>
>> There is indeed a FP EE, BHI spec will be updated with this EE next month.
>>
>> Basically, once device goes to EDL, flash programmer image is downloaded using
>> BHI protocol (same as we download SBL image using BHI from PBL in current use
>> case). Once it is downloaded intvec sends EE change event for FP. Also event is
>> generated for the same which is used to create EDL channels (34, 35) which is
>> used by flash programmer to flash image for AMSS.
>>
> [carl.yin] I am refer to QUALLCOMM's windows MHI driver.
> And the patch work well on my SDX24&SDX55 modems.
> I can use it to upgrade my modems.

Linaro has an opensource utility that implements firehose - 
https://github.com/andersson/qdl

Did you test with that?

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
