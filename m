Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03AA281855
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgJBQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:52:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6459C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:52:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so1098754pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=uZZJOopqjn2TAWfWSbfnm0nS9WoykfT5gKQuiWxSrtM=;
        b=L59OvAOWIIonGDiCWJpTI5y10i2sSyAthxkxzMjkDsWKw9FG1jblTmiQoD8UhKlHBr
         vygK53W8RnVvjH0SV7LdfQH3BhTlMN30Te5jp8IVqijTBZOhrsDRePjjuixJ5NnvfLMp
         t6PaJDzRn5/e2c2QaVdsIfnh9W4yNBe8PmrtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=uZZJOopqjn2TAWfWSbfnm0nS9WoykfT5gKQuiWxSrtM=;
        b=fpB9znvGXDYZlX9eggFLkMS7QwgN7C57icDcXMHbVosjQa498Rw3cLvM3NnJfpAADp
         0pHsNzdO/Jnp9DAfVsBVSjCFAPDEhIGTDRoqSRSYAd4HOuriKTQUzUKNtBTs1PEEskuT
         MhL66ZiJ5YiVqQ0kp7cw2Nd0Bb4WUsKtInKVcSFcpoRFxEEKvW2FG+xtI4GfrJXR/BK1
         AdVCLgdHtPz2wpwvau70D4m9g+78ioUcCnrxIZzexSMk9MRnZtVcNf1sQcqYKcirNlxx
         t318eseqhyTnijAS5S/dSDdEotFyZr8Y9+8zvmLCLzeDFqlCEO3XHOqsOQTNSXwN565P
         3l9g==
X-Gm-Message-State: AOAM533/uovYxNOg4NDCUn32gY1BYxbVaOcycaftTz6PyigVwJsOh+B5
        gOU8W4hYjh8211BtLeylwFI4hZ+j3fAMAAvN
X-Google-Smtp-Source: ABdhPJy9o7KJl3vXeZdywHw4rxEFEgOnj5ORhKaBztF5W69UsNC0+qeXYXky07qxJTQJiyrAAeimxw==
X-Received: by 2002:aa7:94a4:0:b029:151:d786:d5c2 with SMTP id a4-20020aa794a40000b0290151d786d5c2mr3667509pfl.50.1601657539350;
        Fri, 02 Oct 2020 09:52:19 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f4sm2353620pfj.147.2020.10.02.09.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:52:18 -0700 (PDT)
Subject: Re: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-12-scott.branden@broadcom.com>
 <e7b3a4b6-0662-6ead-8ddb-0cf6324a9bd2@gmail.com>
 <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
 <20201002045531.GB34005@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <de8a5748-1dc6-5a5b-6ab9-a40dc273d86e@broadcom.com>
Date:   Fri, 2 Oct 2020 09:52:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002045531.GB34005@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b544c605b0b2f452"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b544c605b0b2f452
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA



On 2020-10-01 9:55 p.m., Greg Kroah-Hartman wrote:
> On Thu, Oct 01, 2020 at 03:12:11PM -0700, Scott Branden wrote:
>>
>> On 2020-09-30 7:33 p.m., Florian Fainelli wrote:
>>>
>>> On 9/30/2020 6:28 PM, Scott Branden wrote:
>>>> Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
>>>> queue statistics.
>>>>
>>>> These statistics keep track of max, abs_max, and average for the
>>>> messages queues.
>>>>
>>>> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
>>>> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>> [snip]
>>>
>>>> +#if defined(CONFIG_BCM_VK_QSTATS)
>>>> +    /* clear qstats */
>>>> +    for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
>>>> +        memset(&vk->to_v_msg_chan.qstats[i].qcnts, 0,
>>>> +               sizeof(vk->to_v_msg_chan.qstats[i].qcnts));
>>>> +        memset(&vk->to_h_msg_chan.qstats[i].qcnts, 0,
>>>> +               sizeof(vk->to_h_msg_chan.qstats[i].qcnts));
>>>> +    }
>>>> +#endif
>>>>       /* clear 4096 bits of bitmap */
>>>>       bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
>>> It was not clear from looking at this patch how are the statistics exposed and how does one actually get them?
>> The QSTATS, since it is only for debug purpose, it will dump out periodically based on processed_num.
>> Nothing fancy as we only compile it in in extreme case for recreating a scenario.
>>
>> The following is the part:
>>
>> +       if (++qcnts->cnt >= BCM_VK_QSTATS_ACC_CNT) {
>> +               /* log average and clear counters */
>> +               dev_info(&vk->pdev->dev,
>> +                        "%s[%d]: Max: [%3d/%3d] Acc %d num %d, Aver %d\n",
>> +                        tag, qstats->q_num,
>> +                        qcnts->max_occ, qcnts->max_abs,
>> +                        qcnts->acc_sum,
>> +                        qcnts->cnt,
>> +                        qcnts->acc_sum / qcnts->cnt);
> Ah, that's not ok, don't flood the kernel log for non-error things
> please.  If you need to "report" stuff, when all is going well, use the
> other common interfaces for that.
>
> Again, drivers, when all is working, are quiet.
Will change to dev_dbg.
>
> thanks,
>
> greg k-h


--000000000000b544c605b0b2f452
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I/3RRboOeC9M13VNr5feU91O0iDoMreAgPQJ0Lo7YrodKYug0Tt/fFDjkW3v3VIbEr2liUN69U0C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUWOK7
qiyDSt/IDm/SRcNi/sTEiyswDQYJKoZIhvcNAQELBQADggEBAEe2edd4F9tpp0GPmrFrQ+xp9kY7
uxBzPdCw588bgVrPemjLwiwV37XTT4iWJtNhPfEpaguM6jeLm58LCvHq5/IBjcyHyf4URQVwAg7B
pqkH8/M+IBstu4/D+znPHB59X+c+au3Q8D+xoNFd7I30kaE+oJuBuFsGXRBc0Ci+FM86x9k7SF8U
aui1E7Y9wDfsRSCL2TSwU773f09WkrvVdlKxNqQZj2z7bQUUn+yfXdFfBz0LqlYNfn7xJOpQE3HI
H4jq6U9+b0Qf+J0n0wyysjXPSeQ7EKXVkT8dM2KSpIN86v5dd9LkAz3C1dmjuPRGEC8ZhI1IjMBt
0itrn6C23NsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgebtG7ULb
t+iDOQCqb+tDSTE30jUvkGkR5ixBNo7MGTUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMDAyMTY1MjE5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABX1xyFH4NCUG4c9m8dzcB9P/O1o
miTjXonK5fnwhlABSNXBtx+i00PsFG8CpeuZWq8y0/FE9kog9IGTUyC/D5X09b97nCpD1kYEKbUM
rmQsPgvCgp5JYYvVohE3juIr7LuBW5ueCzwHm7LMav2/GClNmq9lkGZIBKDJAT8KUBAaImGqRcZ6
qopvnpvPpqBHtfU5hSAfG+Ik1FbWrvAvgCPVokSfnxca5D+M8R7PANaVbVlOqKMRTM+3koJwz35w
aKMnc4KeqHptw6i/U5xKk1rUuCpIq5xxVCkOb83KZjzkrhmSWMO/LyCiI1ax92ELKC97jyGzi7Jb
4lUqkkvrq9E=
--000000000000b544c605b0b2f452--
