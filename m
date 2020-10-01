Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D0280687
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgJAS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJAS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:27:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92BAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:27:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so5350128pfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8rXHFfObqhLoq2ZqEtkEi6dqHHW5gN8KlBd5AumG0XA=;
        b=LPPJkTS6+Pl33B56DLW8CAQzzZY0Uju48DbCpQxA49bnSstMxj5HS1JzoT55Zc9AuJ
         ejSMblGSu/xGSyLmUqIBmnBhegCYdVZH/d6JNWBWe26Zl+Dwf3vyYFjcWwmJa6QgvplG
         hx6It2vEmbqFBMj7BHYazT5pV2Qmx6Y60sv0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=8rXHFfObqhLoq2ZqEtkEi6dqHHW5gN8KlBd5AumG0XA=;
        b=qcIpGoUn7X94J0Mr+ZA8b09QVdjJnsN7XVm+avox7V+Dot7GaPLaBO0RC0To275gmN
         r9Jq9Yd7DxLaquhNdHlUAPZfkp3SAOzE9UogYic4joDZUvWKcw+XXgplecdMutPVylgv
         AQY/+29f87KWlqZgWEgjMUEqnNPHZdiOsZL5PcGmliOV2jGxjAFEqurIV7QMGjv5dVjs
         1CTkb15xoXXOiuh9YpI39PR//8ohGZ3xYnGIJIPmfKc7JTtqD9GTNUF1DCNs6C8vgr11
         BE+P8BUCl0yDHLfb2lppNl1lg9xEwbpeM1VHCFKVGIwAea0It2uV/v80GQthzA5CKrkw
         nEZw==
X-Gm-Message-State: AOAM531NtJhMTF9+JQdetTwRI+Q/b/xo+nVZjRfIusc+YjM07d6iAszf
        G+Sm0ccS1OjjJMfzWk9lEWQByw==
X-Google-Smtp-Source: ABdhPJzsHBLBacKj1gXTp9L5y8F8hHw0+9QtLEMDWsUP3T5zavUKKfL964xqKora9+J1gftibnj1ww==
X-Received: by 2002:a62:1410:0:b029:13e:d13d:a129 with SMTP id 16-20020a6214100000b029013ed13da129mr8639483pfu.17.1601576871102;
        Thu, 01 Oct 2020 11:27:51 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y1sm6335732pgy.0.2020.10.01.11.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 11:27:50 -0700 (PDT)
Subject: Re: [PATCH v5 09/15] misc: bcm-vk: add VK messaging support
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-10-scott.branden@broadcom.com>
 <6cbd011cef2e52f39812bc8f6505fdd95f98d14d.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <69a3c3f7-52de-11aa-1040-b0557f16c489@broadcom.com>
Date:   Thu, 1 Oct 2020 11:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6cbd011cef2e52f39812bc8f6505fdd95f98d14d.camel@perches.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000824ab805b0a02ce7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000824ab805b0a02ce7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA



On 2020-09-30 6:43 p.m., Joe Perches wrote:
> On Wed, 2020-09-30 at 18:28 -0700, Scott Branden wrote:
>> Add message support in order to be able to communicate
>> to VK card via message queues.
> trivia:
will remove comment below.
>
>> +/* structure that is used to faciliate displaying of register content */
>> +struct bcm_vk_entry {
>> +	const u32 mask;
>> +	const u32 exp_val;
>> +	const char *str;
>> +};
> []
I think you want a newline added here.
>> +/*
>> + * alerts that could be generated from peer
>> + */
>> +struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM] = {
> const struct bcm_vk_entry
will add the const's
>
>> +	{ERR_LOG_UECC, ERR_LOG_UECC, "uecc"},
>> +	{ERR_LOG_SSIM_BUSY, ERR_LOG_SSIM_BUSY, "ssim_busy"},
>> +	{ERR_LOG_AFBC_BUSY, ERR_LOG_AFBC_BUSY, "afbc_busy"},
>> +	{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR, "high_temp"},
>> +	{ERR_LOG_WDOG_TIMEOUT, ERR_LOG_WDOG_TIMEOUT, "wdog_timeout"},
>> +	{ERR_LOG_SYS_FAULT, ERR_LOG_SYS_FAULT, "sys_fault"},
>> +	{ERR_LOG_RAMDUMP, ERR_LOG_RAMDUMP, "ramdump"},
>> +	{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL, "malloc_fail warn"},
>> +	{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN, "low_temp warn"},
>> +	{ERR_LOG_ECC, ERR_LOG_ECC, "ecc"},
>> +};
>> +
>> +/* alerts detected by the host */
>> +struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM] = {
> here too
thanks.
>
>> +	{ERR_LOG_HOST_PCIE_DWN, ERR_LOG_HOST_PCIE_DWN, "PCIe_down"},
>> +	{ERR_LOG_HOST_HB_FAIL, ERR_LOG_HOST_HB_FAIL, "hb_fail"},
>> +	{ERR_LOG_HOST_INTF_V_FAIL, ERR_LOG_HOST_INTF_V_FAIL, "intf_ver_fail"},
>> +};
> []
>> @@ -970,6 +1251,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  		}
>>  	}
>>  
>> +	/* enable hb */
>> +	bcm_vk_hb_init(vk);
>> +
>>  	dev_dbg(dev, "BCM-VK:%u created, 0x%p\n", id, vk);
> Not much purpose in displaying the pointer.
ok.
>
>
thanks for the review.

--000000000000824ab805b0a02ce7
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgr72dqlSv
BAtsvE6wp3CfttOXBqOT9fn0EWqKOXjqzeMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMDAxMTgyNzUxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACtsGDIH3kpm/orF9kKUd4piAdva
vOETUzaseWaeLXCJnZx0Lpl1an97i94c5F5ovfr2aaIdFnL2BYp+XcOylb5uAobYmQdNtlU9VmXn
fIIlwgfJW2PgZn9WUYCToOabofB5KbOypt5pKhWE42KCmV+Q4zwTrHtrCqU5JNwVpXmWIGyWcsyg
QsmMN0+qCoAwzPYXeKD2TntYFi5u+2F3I5JM1DPvPJf6ZO7CFcJNqClgola4d0R8Lj/fKQZSDAE1
2xXlpxzhySVdhcoQKg1iSlGOWqy524K4/F2NQmWhMsuwdnGzHFi3us+T0o6fnVudWvatisEjWI+Z
rmQJbAQAnLo=
--000000000000824ab805b0a02ce7--
