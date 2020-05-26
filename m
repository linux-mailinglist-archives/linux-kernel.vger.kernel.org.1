Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6081E29C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgEZSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:11:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22299C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:11:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n15so122933pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XMJPsfrPwL4udIgNX9sd/5hcecE1GbPrvJExtmMB778=;
        b=XLbEotUGWPUSVr5vWk2fim05qClEhsltJrxucG9Q/iXw8jS8O4OQ0wf9/JhaHbIliE
         O8zjHXdJzq1/lwIkYGys9V9WFGRWmxNWn7wkzpEud3rHX7z5L7E6Ue3jLCWmwc0A/0p9
         Kjem93QOZwvmI9fwvMtlLeHTQeKd4jUaSB26Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XMJPsfrPwL4udIgNX9sd/5hcecE1GbPrvJExtmMB778=;
        b=qrwOrEYnA3AgmotM+JFyLuhE0j0lCEZK/MGulhA3C8PTxAMEQjcxryoc2e48fpMjXj
         aeQkL1bjgsShrt37JScjQF7zoa4uI43s7q5joo2yJGs/vxB3yeh+03tD6pdUyvkwkuR4
         KEfCbP4IwUcmLDic5PhUWMa4jTrMd7Hvd7FEuADTQCSdg1FnCDdYe4VLhIz/8TzYRlRg
         GNOZvUF2KJffU4rO0v41sxF3FtUmWaYiQ95dhp4/S2rSfKYkebD0p1jYWwNP3US7L+za
         hnPdCS4R8KpgfabI0DOcqAulKKtSZBsVsn5wvhlIa4krcLcG/qGJ3X6Nqh5kULmoeIR1
         tV0g==
X-Gm-Message-State: AOAM531e9VoQl9DquyWNFb1I7rmaVQcR6xBQZ5d0xnQU16XKLEyrvS3l
        r+1BpOQYesvfDkNR0/xTCNSyAw==
X-Google-Smtp-Source: ABdhPJwdZ8Qi45vV5nv0Y779scaCmcpVjQFUxY9Z915uZ5yPMZ26WnuvlXLfxhSr/HtBf7b7gO2bjQ==
X-Received: by 2002:a17:90a:fe97:: with SMTP id co23mr498961pjb.96.1590516716568;
        Tue, 26 May 2020 11:11:56 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y138sm214647pfb.33.2020.05.26.11.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 11:11:55 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Fix lpfc_nodelist leak when processing
 unsolicited event
To:     Daniel Wagner <dwagner@suse.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1590416184-52592-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200525151220.rtwmlobnkmhwhxn5@beryllium.lan>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <dd782e33-db86-9457-983e-59bb75b805b4@broadcom.com>
Date:   Tue, 26 May 2020 11:11:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525151220.rtwmlobnkmhwhxn5@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2020 8:12 AM, Daniel Wagner wrote:
> Hi,
>
> On Mon, May 25, 2020 at 10:16:24PM +0800, Xiyu Yang wrote:
>> In order to create or activate a new node, lpfc_els_unsol_buffer()
>> invokes lpfc_nlp_init() or lpfc_enable_node() or lpfc_nlp_get(), all of
>> them will return a reference of the specified lpfc_nodelist object to
>> "ndlp" with increased refcnt.
> lpfc_enable_node() is not changing the refcnt.
>
>> When lpfc_els_unsol_buffer() returns, local variable "ndlp" becomes
>> invalid, so the refcount should be decreased to keep refcount balanced.
>>
>> The reference counting issue happens in one exception handling path of
>> lpfc_els_unsol_buffer(). When "ndlp" in DEV_LOSS, the function forgets
>> to decrease the refcnt increased by lpfc_nlp_init() or
>> lpfc_enable_node() or lpfc_nlp_get(), causing a refcnt leak.
>>
>> Fix this issue by calling lpfc_nlp_put() when "ndlp" in DEV_LOSS.
> This sounds reasonable. At least the lpfc_nlp_init() and lpfc_nlp_get() case
> needs this. And I suppose this is also ok for the lfpc_enable_node().
>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>
> Thanks,
> Daniel

Looked at it here and it looks good.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james


