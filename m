Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6F29E174
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgJ2CBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:01:12 -0400
Received: from z5.mailgun.us ([104.130.96.5]:20991 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgJ2CBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:01:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603936871; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OY5Nx8k3+elJDqG8wO1WAHt4XhnVppU+ilRqg8xPj/c=; b=xOsj3bpwlv+Cfp3rYu6JnhiCiu4YrYBnOC1AavpBmyKI0kKD2RE1518p93nwGzQwKUNM0V+h
 rueKa/0fHx1iPFaP3RncKqvOU3zhzz7yl1ru74UknfmZdq9K0mkmwpxb7adBE9hYdDbaaGtq
 ZCKrEfInmN8tb1yM8JqbzL7vBi4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f9a226020b52b32d78a4a7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 02:01:04
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B229C433FF; Thu, 29 Oct 2020 02:01:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.110.82.132] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B0EDC4339C;
        Thu, 29 Oct 2020 02:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B0EDC4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-3-wcheng@codeaurora.org>
 <e6faade6-7c4c-5966-3afd-63be2deefa01@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <6748f727-db76-b51c-4333-57467ae3013f@codeaurora.org>
Date:   Wed, 28 Oct 2020 19:00:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <e6faade6-7c4c-5966-3afd-63be2deefa01@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2020 5:43 PM, Thinh Nguyen wrote:
> Hi,
> 
> Wesley Cheng wrote:
>> The USB gadget/UDC driver can restrict the DWC3 controller speed using
>> dwc3_gadget_set_speed().  Store this setting into a variable, in order for
>> this setting to persist across controller resets due to runtime PM.
> 
> Why do we need to do this? DCFG should persist unless we overwrite it.
> The current PM shouldn't update the current speed setting.
> 
> BR,
> Thinh
> 

Hi Thinh,

During runtime PM suspend, the dwc3_suspend_common() will call
dwc3_core_exit().  On some platforms they register the DWC3 reset
control to the DWC3 core driver (otherwise could be handled in the DWC3
glue drivers), which will be asserted here:

static void dwc3_core_exit(struct dwc3 *dwc)
{
...
	reset_control_assert(dwc->reset);

From the SNPS databook (Table 2-2 Resets for Registers) it mentions that
assertion of the reset signal will reset the DCFG register.

In addition to the above, with the change to allow runtime PM suspend
during UDC unbind, we need a way to avoid writing to the DCFG during the
UDC bind path. (if we entered suspend before re-binding the UDC)  If we
add an early exit based on the PM state (in
dwc3_gadget_set_udc_speed()), then we basically ignore the max speed
request from the UDC/gadget layer.

Since it looks like the DWC3 gadget driver doesn't like using
synchronous PM runtime resumes, by going this route, we can allow the
async runtime resume handler to do everything, such as writing the speed
config and re-enabling the controller.

Thanks

Regards,
Wesley Cheng
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
