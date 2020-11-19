Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF22B9E04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKSXQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKSXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:16:53 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7DEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:16:53 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id a18so6012941pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=7V6HW0uZuPxD4oivZNUKIuh1HcZCqZcN06gwsTMyfHY=;
        b=Nhrn61zr8B2jey4iFaGBScLhgVVLhUCA+2D/s04CbHQYpVlWyTrZwYBaZi+xx3GXgq
         58zK0gyCYbE1F01oBgy962FWG60Dqt/XejTlxq+avHqEVoCwJ9w3oh4otR4P45TfNQmc
         6rlOmTZz0d1v2AHU5dJtPz4TMblVBg4B9mQd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=7V6HW0uZuPxD4oivZNUKIuh1HcZCqZcN06gwsTMyfHY=;
        b=EIAyb4I9JZV+KGcyiaxfguDxPgW26k3JQbh9jJ8PzGPgjKntSzgzgM1qDzihBIEUIm
         Y5Evr9W6+8MWbz2Bbis8IIN2vnqcGiDr0DorRlw5fP1uHnhEe3PWsAQoP4O1KNNUbsQr
         xFxZBxBe6mGYbxz31vsXlUChHF9BOubdw2vNnOCpvEhlZQUe1T7Zy38YeyPXyshstNso
         xvVwtQ9Tm7IRkXsHkXpgrCmsfKrn5LcuRW4VKDhhaeJrZNGXIU17P/6T0clpEO+zRz0u
         xbIausmMfCBXfb6sWXjoOCl0Vg0gItcSXG60Oovstsy9uX72AOHa8uuH1uS1VMADc1SW
         Fynw==
X-Gm-Message-State: AOAM531KI70iArkyZ4CmFH9oEYWNPfK9BRVuaEuxVJQNQNE9BcA47tya
        V+gaN+uzYR+4/FxTARSUEbgA4bxYmkHsBvWY
X-Google-Smtp-Source: ABdhPJy6Js2gQTf5Eko4Ltg+SoaYQgIBw7x8TJk5knilGaUN+9ypEnLF4sczB1sK/XANhhqgNbfbSw==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr2282396pjz.151.1605827813060;
        Thu, 19 Nov 2020 15:16:53 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a18sm1055446pfa.151.2020.11.19.15.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 15:16:52 -0800 (PST)
Subject: Re: [PATCH v7 02/13] misc: bcm-vk: add Broadcom VK driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
 <20201117232320.4958-3-scott.branden@broadcom.com>
 <20201119224256.GA16032@duo.ucw.cz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <4ffc8ed7-5b35-0867-d1c3-8ea7ac66d014@broadcom.com>
Date:   Thu, 19 Nov 2020 15:16:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119224256.GA16032@duo.ucw.cz>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006416fd05b47decc0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006416fd05b47decc0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-CA

Hi Pavel,

On 2020-11-19 2:42 p.m., Pavel Machek wrote:
> Hi!
>
>> Add initial version of Broadcom VK driver to enumerate PCI device IDs
>> of Valkyrie and Viper device IDs.
>>
>> VK based cards provide real-time high performance, high throughput,
>> low latency offload compute engine operations.
>> They are used for multiple parallel offload tasks as:
>> audio, video and image processing and crypto operations.
>>
>> Further commits add additional features to driver beyond probe/remove.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> +++ b/drivers/misc/bcm-vk/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Broadcom VK device
>> +#
>> +config BCM_VK
>> +	tristate "Support for Broadcom VK Accelerators"
>> +	depends on PCI_MSI
>> +	help
>> +	  Select this option to enable support for Broadcom
>> +	  VK Accelerators.  VK is used for performing
>> +	  specific offload processing.
>> +	  This driver enables userspace programs to access these
>> +	  accelerators via /dev/bcm-vk.N devices.
>> +
>> +	  If unsure, say N.
> Could we
>
> a) align the text the usual way
Please explain what "the usual way" is?
>
> b) explain what the VK is here? What kind of offloads does it do? What
> does "VK" mean?
Sure I can add some more details to the menu.
Offloads such as many parallel crypto, video, compression, and transcode operations are some such offloads.
VK has no real meaning, it is just short for Valkyrie, the first device in the "VK" family.
>
> c) explain where such accelerators might be found.
Such accelerators won't be found in any consumer devices but in high compute data center type locations.
>
> (Is remoteproc framework unusable for this?)
remoteproc has been discussed previously [1] and doesn't suite this application.

[1] https://lore.kernel.org/lkml/CAOesGMg6f2pK4ZZ8bz=0nMgCJG-8JhLZe41prZoGsBhgGs6_jA@mail.gmail.com/

>
> Thanks,
> 									Pavel


--0000000000006416fd05b47decc0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQRQYJKoZIhvcNAQcCoIIQNjCCEDICAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2aMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFRzCCBC+gAwIBAgIMW0PXrlFB5QLwO+gIMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTIxMTQz
MTE0WhcNMjIwOTIyMTQzMTE0WjCBkDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRYwFAYDVQQDEw1TY290
dCBCcmFuZGVuMSkwJwYJKoZIhvcNAQkBFhpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALCwcSIu11LCx3EwXsMF/0Te79hG0UI3NZAsVxAh
exVD4CJDTVDgpCWOXj2j4V0eOvFYcGgMNVUKtywL4OzQgNquS8/OlHQZ3/9PCq8Ox9PNkCQ5eIv1
k2UaaN0tMDke1fX++Dn0UXst0OI08PYKYJpy1mkw5Hcw28LxU5Q2HwoW/+gyOIkdSo2ovq7a9+G3
LGyQOUxLhMvko/+qqg/KTfYQJ45p6TJPcvzwA0W453P3gPRZpm54KsEIfyZiMaUBMtXsQ7dHBAla
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgH7fSYlkx
ASl0g2C//wM66sSriZEo7OMkuPJzgaIrO1owGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMTE5MjMxNjUzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACpRAScGD8sw1jOkpnjIPZHGThP5
H6KA35R1j8D1p6mjlvtE21m6KUb6bvGtQjz9Pj6J8Lego0iyP2A9R5JerAP3GZc2+Inj/unLPJxv
tYHKZ+tKvfVhBUGSA+7qT2ESb05W5/UTbvYhaflojnfSt5idjLNjlw4GRiIpYrX1LiYa47Kh+Z/u
P7Q0V4tvLi/Bu2UlxTaD5uE2keKMgjRdbNjsDUw6olqLTT1g8bsek5/WPuTPb5taOiiLi1uVPN6H
hy4pyfnxfgVchuQE6b3PThVhgV6v3hmQ6q4JpgvJefCSefojgTpInjDm5jphjFk2QADfL+iIjQkl
3YF9OtWVI5A=
--0000000000006416fd05b47decc0--
