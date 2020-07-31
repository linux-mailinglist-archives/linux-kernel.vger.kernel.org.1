Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329102343B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgGaJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbgGaJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:50:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7845C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:50:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so24453177wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsUj5dJ1FR2Bc9ImoyfwbG4Ha/qrqBvHQTZOtQzXmEk=;
        b=zQwULhusTy+cAQlBYSM6YJcuw0u7QQdy/mS/rEln7H4F5XYn5Ri2B14cJaiqx34Izg
         KbMCoSDi7PFisiwB5jQrrZLMT55+icTw4nWJ9otveFZOuFb5z7yoyvJ8+4WVwrzgJSYt
         GWuNsdc8VOhzT/Z9M8bjtpZI0Nzvpst0Fa4SbiuFbiHSJa+azq51qrXtxkrG4Gf0On6W
         jAmNCcX+0mkaPZYVSE5f6ipC9t9WAAArRV9nl28gYNeAl42xus3+PT61QDPDlodT6FcV
         nAw9WrmEDqAVzUaoWfuC6ApD3SaRjA13mmZskwskQ4/bvpBtIKXDG5b0xBM6iAOd1LMC
         GmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsUj5dJ1FR2Bc9ImoyfwbG4Ha/qrqBvHQTZOtQzXmEk=;
        b=TtbaGEcKCGvUdmY5XjY3EwP7zAVVM/iQduWYz5EJY41mv7P7oZmwNbf6BuchIz/lfv
         Hpd09qawZLQtaU5Xagj84BuSN6IlSCCILUK3VIayyFFm3eYTSSJy15TbwpJR0t9k0dlh
         mWupOQCVzFJeAAJKo7V8e1jBsrQKgQbQdGQ8bya3x5va+jApS6PeVMi4whKvq4twD9O6
         heg/EkzHrLorp6n2QMt0k1o5f7lNaQArpxxwC87VlKhNt5mqREmToMx02TrpufnMrR5n
         UnpxUevojtI8nA6Lr0+90qnllufVMVUneHqtHefjiInksr8OEval9vAPeLAmNMYnTclE
         RH1w==
X-Gm-Message-State: AOAM533R1oaWFwPjztACt8a1av49yLDDupQs4BhsKN/pKGbu2zFCCID4
        iIXAht6PNy5R9jhO6ftzr9l98w==
X-Google-Smtp-Source: ABdhPJySMoScYKBGOYCUQxI4+2uSPanbl2NvXCIiS2eiXzkTOaPcme6XAPVzHmhBksVISONvp3UQfA==
X-Received: by 2002:a5d:6641:: with SMTP id f1mr2733793wrw.307.1596188999660;
        Fri, 31 Jul 2020 02:49:59 -0700 (PDT)
Received: from [192.168.1.9] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id z127sm12754152wme.44.2020.07.31.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 02:49:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] firmware: qcom_scm: Add memory protect virtual
 address ranges
To:     Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20200709115829.8194-1-stanimir.varbanov@linaro.org>
 <20200709115829.8194-2-stanimir.varbanov@linaro.org>
 <33a63665-2f75-1b58-8a0c-3b0a8979fb85@linaro.org>
 <46632fb9-e07e-fa40-5f13-fb45b4014e03@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <08538e8e-8558-66af-8120-279530ab158c@linaro.org>
Date:   Fri, 31 Jul 2020 12:49:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46632fb9-e07e-fa40-5f13-fb45b4014e03@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thanks for the comments!

On 7/29/20 8:15 PM, Elliot Berman wrote:
> ++
> 
> On 7/24/2020 8:04 AM, Stanimir Varbanov wrote:
>> Hi,
>>
>> Gentle ping for review.
>>
>> On 7/9/20 2:58 PM, Stanimir Varbanov wrote:
>>> This adds a new SCM memprotect command to set virtual address ranges.
>>>
>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>> ---
>>>  drivers/firmware/qcom_scm.c | 24 ++++++++++++++++++++++++
>>>  drivers/firmware/qcom_scm.h |  1 +
>>>  include/linux/qcom_scm.h    |  8 +++++++-
>>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 0e7233a20f34..a73870255c2e 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -864,6 +864,30 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>  }
>>>  EXPORT_SYMBOL(qcom_scm_assign_mem);
>>>  
>>> +int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>> +				   u32 cp_nonpixel_start,
>>> +				   u32 cp_nonpixel_size)
>>> +{
>>> +	int ret;
>>> +	struct qcom_scm_desc desc = {
>>> +		.svc = QCOM_SCM_SVC_MP,
>>> +		.cmd = QCOM_SCM_MP_VIDEO_VAR,
>>> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
>>> +					 QCOM_SCM_VAL, QCOM_SCM_VAL),
>>> +		.args[0] = cp_start,
>>> +		.args[1] = cp_size,
>>> +		.args[2] = cp_nonpixel_start,
>>> +		.args[3] = cp_nonpixel_size,
>>> +		.owner = ARM_SMCCC_OWNER_SIP,
>>> +	};
>>> +	struct qcom_scm_res res;
>>> +
>>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>>> +
>>> +	return ret ? : res.result[0];
>>> +}
>>> +EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
>>> +
> 
> Small nit, can you bump the function above assign_mem? It would keep order aligned with
> the macros in qcom_scm.h

Sure, I will do that.

> 
>>>  /**
>>>   * qcom_scm_ocmem_lock_available() - is OCMEM lock/unlock interface available
>>>   */
>>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>>> index d9ed670da222..14da834ac593 100644
>>> --- a/drivers/firmware/qcom_scm.h
>>> +++ b/drivers/firmware/qcom_scm.h
>>> @@ -97,6 +97,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>>>  #define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
>>>  #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
>>>  #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
>>> +#define QCOM_SCM_MP_VIDEO_VAR			0x08
>>>  #define QCOM_SCM_MP_ASSIGN			0x16
>>>  
>>>  #define QCOM_SCM_SVC_OCMEM		0x0f
>>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>>> index 3d6a24697761..19b5188d17f4 100644
>>> --- a/include/linux/qcom_scm.h
>>> +++ b/include/linux/qcom_scm.h
>>> @@ -81,7 +81,9 @@ extern int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>  			       unsigned int *src,
>>>  			       const struct qcom_scm_vmperm *newvm,
>>>  			       unsigned int dest_cnt);
>>> -
>>> +extern int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>> +					  u32 cp_nonpixel_start,
>>> +					  u32 cp_nonpixel_size);
> 
> Same here.
> 
>>>  extern bool qcom_scm_ocmem_lock_available(void);
>>>  extern int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
>>>  			       u32 size, u32 mode);
>>> @@ -131,6 +133,10 @@ static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>>>  static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>  		unsigned int *src, const struct qcom_scm_vmperm *newvm,
>>>  		unsigned int dest_cnt) { return -ENODEV; }
>>> +extern inline int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>> +						 u32 cp_nonpixel_start,
>>> +						 u32 cp_nonpixel_size)
>>> +		{ return -ENODEV; }
> 
> Same here.
> 
>>>  
>>>  static inline bool qcom_scm_ocmem_lock_available(void) { return false; }
>>>  static inline int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
>>>
>>
> 

-- 
regards,
Stan
