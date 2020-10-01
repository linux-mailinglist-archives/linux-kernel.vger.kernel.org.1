Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC712809EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgJAWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:17:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9AC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 15:17:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so82143pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=zNBioc9au2FN32gSUtQIl+PstrDKp7ae6VWeRmTxDnI=;
        b=caRteDmLebATOiRYm+Sos7/XaOBApiilb5FyQY7GzVC4/T9N2tDGLj7jXmz96JR96Q
         qAzJ4oieN2a75m0ME0hq6gwEKfj2JOOXEBbzvBiMmzhyKp0+ZaAakBBupdOm83iIFhvK
         jk5SymuWYJGaj5VXL59idg7atlOW5zBILp8O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zNBioc9au2FN32gSUtQIl+PstrDKp7ae6VWeRmTxDnI=;
        b=QjyrxoJ+QzcaHw2LGEFogRFCL3nwv9zZZcp5nKjztH15BEUKbIJxfMyriXRmFuQkSR
         1/E+DML2MTQ69MLfHYpNDqtHY+U0MBpOHF92SuhmRy2xDGrgee0bM6DHw5tockZSu42C
         46jwHKvZyL7Ahe7ak3nGk3YKJ48QTb7gxJ5xiS+7OIEUyL/lzhp+Jm0SxifDhGcgFCoc
         Q3DlHIYB7zM6Rg9/uEYoNC43oIPkycdd6yC2FpQid2yTj/wW1bHX9TLQ+FtVlQchT0NT
         Pq0y0LR/S107gNQYBts5JtZ7XUlqPtXN7E+JkuLbzaQEl1aSqUu30R4pFrE1PNOQ05/j
         yeZw==
X-Gm-Message-State: AOAM533K+61SMbJYkqWUIsZYrb+x+pjREGzwegYKGSlxgXHDD7YK7+zG
        ee28nf0UAYgU/lwt3dhRntsRPQ==
X-Google-Smtp-Source: ABdhPJy6yNZRosGcjtuP4qlySOIUuPDDTwxiPSQI1xzXA8q5aBoEI06l1X7LVLw80Iip9+aM8rS4Vw==
X-Received: by 2002:a17:902:9a06:b029:d0:cb2d:f276 with SMTP id v6-20020a1709029a06b02900d0cb2df276mr9227181plp.15.1601590629307;
        Thu, 01 Oct 2020 15:17:09 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x5sm782333pfr.83.2020.10.01.15.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:17:08 -0700 (PDT)
Subject: Re: [PATCH v5 12/15] misc: bcm-vk: add sysfs interface
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-13-scott.branden@broadcom.com>
 <16725022-b967-deae-1223-f86a543f9f9d@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b835d5a6-2ece-01c1-3911-050e06a1115f@broadcom.com>
Date:   Thu, 1 Oct 2020 15:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16725022-b967-deae-1223-f86a543f9f9d@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008f113a05b0a3606d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008f113a05b0a3606d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA



On 2020-09-30 7:30 p.m., Florian Fainelli wrote:
>
>
> On 9/30/2020 6:28 PM, Scott Branden wrote:
>> Add sysfs support to query the VK card status and monitor sense points.
>> The vk-card-status and vk-card-mon details are provided in the README
>> file in the bcm-vk driver directory.
>>
>> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
>> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>
> [snip]
>
>> +vk-card-status/
>> +    bus            ---> device PCIe bus
>> +    card_state        ---> summary of current card states
>> +    chip_id
>> +    firmware_status        ---> summary of all firmware status
>> +    firmware_version    ---> summary of all firmware versions
>> +    freq_core_mhz        ---> running frequency in mHz
>> +    freq_mem_mhz        ---> memory frequency in mHz
>> +    mem_size_mb        ---> memory size in MByte
>> +    os_state        ---> current running state
>> +    reset_reason        ---> last reset reason
>> +    rev_boot1        ---> boot1 firmware revision
>> +    rev_boot2        ---> boot2 firmware revision
>> +    rev_driver        ---> host driver revision
>> +    rev_flash_rom        ---> Flash ROM revision
>> +    sotp_boot1_rev_id    ---> minimum boot1 revision required
>> +    sotp_boot2_rev_id    ---> minimum boot2 revision required
>> +    sotp_dauth_1        ---> authentication key hash
>> +    sotp_dauth_1_valid    ---> authentication key validity
>> +    sotp_dauth_1_active_status -> authentication key active or not
>> +    sotp_dauth_2
>> +    sotp_dauth_2_valid
>> +    sotp_dauth_2_active_status
>> +    sotp_dauth_3
>> +    sotp_dauth_3_valid
>> +    sotp_dauth_3_active_status
>> +    sotp_dauth_4
>> +    sotp_dauth_4_valid
>> +    sotp_dauth_4_active_status
>> +    temp_threshold_lower_c    ---> thermal low threshold in Celsius
>> +    temp_threshold_upper_c    ---> thermal high threshold in Celsius
>> +    uptime_s        ---> os up time in seconds
>> +
>> +vk-card-mon/
>> +    alert_afbc_busy        ---> AFBC block stuck
>> +    alert_ecc        ---> uncorrectable ECC error(s) occurred
>> +    alert_ecc_warn        ---> correctable ECC error(s) occurred
>> +    alert_heartbeat_fail    ---> host detects heartbeat discontinuation
>> +                     from card
>> +    alert_high_temp        ---> high temperature threshold crossed
>> +    alert_intf_ver_fail    ---> interface not compatible based on version
>> +    alert_low_temp_warn    ---> low temperature threshold crossed
>> +    alert_malloc_fail_warn    ---> mem allocation failure(s) occurred
>> +    alert_pcie_down        ---> host detect pcie intf going down
>> +    alert_ssim_busy        ---> ssim block busy
>> +    alert_sys_fault        ---> system fault
>> +    alert_wdog_timeout    ---> watchdog timeout
>
> Almost all of these should be supported using the HWMON framework instead of custom attributes that do not follow the HWMON naming conventions.
Makes sense - we'll look at hwmon framework.
>
>> +    firmware_status_reg
>> +    mem_ecc            ---> correctable ECC error count
>> +    mem_uecc        ---> uncorrectable ECC error count
>
> Implementing an EDAC driver would be a bit overkill unless you have a way to signal ECC errors towards the host?
Yes, EDAC driver would be overkill here.
>
>
>> +    boot_status_reg        ---> boot status of card
>> +    pwr_state        ---> power state, 1-full, 2-reduced, 3-lowest
>> +    temperature_sensor_1_c    ---> CPU die temperature in Celsius
>> +    temperature_sensor_2_c    ---> DDR0 temperature in Celsius
>> +    temperature_sensor_3_c    ---> DDR1 temperature in Celsius
>
> Likewise.
>
>> +    utilization        ---> runtime video transcoding consumption summary
>> +    utilization_pix     ---> percentage of pixel processing used
>> +    utilization_pix_used    ---> pixel processing used
>> +    utilization_pix_max    ---> max pixel processing value which maps 100% load
>> +    utilization_codec     ---> percentage of codec sessions used
>> +    utilization_codec_used    ---> codec sessions currently used
>> +    utilization_codec_max    ---> max codec sessions allowed
>> +    voltage_18_mv        ---> 1.8v voltage rail in mv
>> +    voltage_33_mv        ---> 3.3v voltage rail in mv
>
> Likewise
>
>> +
>> +The sysfs entry supports only the read operation.
>
> entries.


--0000000000008f113a05b0a3606d
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgHXEryHPS
4pu8nDkTbfdwleu4BidUDMcxV+9bV7LK4VIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMDAxMjIxNzA5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIRWUUiKm8oPOLUJ3lJSjaOiwAES
wPHyfiN3UjRo2Q4lu3u6DOZP68MSJNmSRon5UDNVHCwdYMQGBGHtjXVSeqXxTwoCDfk3bBWf4jyO
cIRdD5t0VQB3kqzTz08XiESW7UyCkNUEnZ66iZKMMxi9MQkLKVanwbxUD+2f4Zy2kWslPbyI5swI
wWXti0eSNTpmZ4f2jWqeBSohhz6NGLY2czDKyXfH9najACCQ9lTVLctnjk5b8hDQDkGDOb79xvW5
H6kDlPyXKYy8g5kwzwPSnXyYBRFp4ZyY3Z8IFjDwGEIz+QpRyQpQDLo0ywzmvKCsLKB3h0CBXqzC
Css+t9D2HwE=
--0000000000008f113a05b0a3606d--
