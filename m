Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29128185A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgJBQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:54:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA8C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:54:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so498299pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=AKTCHqUg+jG7b3R6CgDxi3mdnkEznsm3XomFEbn9QyU=;
        b=a05eeSiPN7gEY3q1DAV9eJasDtGvS+6SNDTarUhnQ7Rl8cYUeGIoGEmdSYlsG7cFTN
         khtVzxe1BJVMkzSYfiNQ+qMoCg2XJYlW8zPeP0ic8bJle2Hxlgs6pRBcW3RSnS8NPAMs
         2WisKyIm1iSyn2ZNl4R3wCcYFI6aic/mIu7K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=AKTCHqUg+jG7b3R6CgDxi3mdnkEznsm3XomFEbn9QyU=;
        b=INVG1Ka08fbzfqgDB5svurVuE5jzwzUJIrXwzHMTKSCSrC0PH4mR27adeNgU79m+hE
         NluAyYtUd2Ep9AO/VSw368q8Ou400gdm3Vcdrf3GrcVbfWCICQD69kA/QNrzNcugcFwA
         5Qr2PKzH9IiFyjeXlSs23Ipg+GfsFKSgkwpRXrFWN8sIP/neaV34GdPH59paEzzHLmDv
         +Ph1SwPka2OxO1W/kHZ+oY57clcU4aEkn/U0atbpOp2iWfgbZYk1Taff7Nk9Xf00jYu4
         ssBWsSicq1/JVMRtz8dLUqdlp+0EQOnL+WAtZN4KOc6KZL4Ow51ZY0trrE5z0bNFRjYm
         MHhg==
X-Gm-Message-State: AOAM532p7l1OJNH2qjLZUctJE3XicPelnM1vD92+xfSPdM+ctJaU+pW9
        1QRsYdo3SIMmn77jgkYQJeIfQA==
X-Google-Smtp-Source: ABdhPJz/9ZFqpWiTbJRu+QzQBV9lmcplldqCv9xVmwL4Rs979psw4ttJmdCKdZuzBCN3ZVhJnNO5Jg==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr3594269pjv.56.1601657650018;
        Fri, 02 Oct 2020 09:54:10 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z6sm2249377pgz.87.2020.10.02.09.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:54:09 -0700 (PDT)
Subject: Re: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-12-scott.branden@broadcom.com>
 <e7b3a4b6-0662-6ead-8ddb-0cf6324a9bd2@gmail.com>
 <5d76c89d-f53a-be22-dcd7-7854a3e1e034@broadcom.com>
 <0fb4556e-91bf-d364-c7bb-c876136b3991@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <15206a8d-81f5-f63a-6d0b-178112bf6380@broadcom.com>
Date:   Fri, 2 Oct 2020 09:54:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fb4556e-91bf-d364-c7bb-c876136b3991@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004dd37605b0b2fb83"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004dd37605b0b2fb83
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA



On 2020-10-01 3:13 p.m., Florian Fainelli wrote:
>
>
> On 10/1/2020 3:12 PM, Scott Branden wrote:
>>
>>
>> On 2020-09-30 7:33 p.m., Florian Fainelli wrote:
>>>
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
>>>
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
>>>>        /* clear 4096 bits of bitmap */
>>>>        bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
>>>
>>> It was not clear from looking at this patch how are the statistics exposed and how does one actually get them?
>> The QSTATS, since it is only for debug purpose, it will dump out periodically based on processed_num.
>> Nothing fancy as we only compile it in in extreme case for recreating a scenario.
>
> But what kind of interface is that? Cannot you at least expose those through sysfs if nothing else?
A sysfs interface would not be as useful as we want the dmesg timestamp information.
QSTATS are purely for development/debug issues and enabled via a CONFIG option that won't be turned on by normal users.
 Will change to dev_dbg.


--0000000000004dd37605b0b2fb83
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgDSLAVYpi
Dhq00hyNkS3Vwtr1YTal7+K5pQVN09XWdfwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMDAyMTY1NDEwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIHpjPdeaeOvAQB4RzObQdy8iA4L
g2Ex/RAl5/ZA+gPR4vqnFqftZ7npL2xkcCVsv6kehBSDyed1yeidPzUVeVnjry95fmemK5907hVQ
Nhj3FWuU4faeNrq1vEMIevbTqcj5wuKMoa3Voc9KnvhpEAdFTfTDIO8/TSlBoZiIJa1aHOrF8sgx
Y4wJWd3MygG6F3A7d8bHoMSw6e27QeiUzg3C8NLcZudP1aIMiJJfLurz1n7ceWwMD8ExQHRT2ZqD
K1jIy47xqNaf62pqa143KKM5ydFrtbLP7AzgdOhbphrJHGX23JQQhogcreu75AaKKW6aqagvx9el
WM/2ITJOfxw=
--0000000000004dd37605b0b2fb83--
