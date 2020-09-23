Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C164F2764CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWXzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWXzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:55:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD4C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:55:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y1so717660pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=5cdOlJvMpCRi8OqNx1FJiV7yZHdsuMaEjEnAAzummmc=;
        b=OuN8EO9zdX47IPsru5I3GBtcUhU6usCbQHdStMP6+FM5hPKMYzuvGLTSNTFHmJaO7t
         09aY/7KVUYk3Iy6OpexDGshgOKzsGeiZumVb1SrP2pqRoolAk1Yva7a2fUiyzKi2gUHg
         qJzU49kCIuKcVYFySJLK2yV3vKGkiQelg1Q3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=5cdOlJvMpCRi8OqNx1FJiV7yZHdsuMaEjEnAAzummmc=;
        b=HK7HTNtQcpzkqf6JY/OxR1bhS/euTzyEtUDClludf52vQSKVAB3EThhwhSPTUFC2hG
         W52SpZ97L+DfCck1dVbzdQ71JeHxCfa/nKYzmoVBYd6gWeiPvSD1R9vw6dAWNJr0y424
         YfJO3nj1Thwc/QB0zP6W3E7yWjb6kkOy3E3W/dqBjV2wNcSAav1C6bWlaMJ2xLS/qCvb
         BdgahBbVNNm6IPeYwpyKkq82pDr6/oAFW0iQwXGt+DOyDTwgn+z3chAUvksTSHMM5IbG
         RUsM0JQHFRMUFp9I4pJVpq0aVsM+G2A+cENtRTBX2B2o23yCGki7+dTq0Sbcsj9/aFwL
         uing==
X-Gm-Message-State: AOAM530/aLJTlUB22bzgavsJbXZVlKydcxFr9wvclhWJHYGoZG5Psnta
        e5z/Ir73Xa0W7DjUyAAL/3N3gmLZuPvOqQLx
X-Google-Smtp-Source: ABdhPJzsLfCirVRjdtVPEHUY4MAF+7TNpmnVSw80ES608kVcxQnalhXiK13My4jzSOowObPktWbaoA==
X-Received: by 2002:a63:e813:: with SMTP id s19mr1745986pgh.33.1600905316709;
        Wed, 23 Sep 2020 16:55:16 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u22sm816649pgi.85.2020.09.23.16.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 16:55:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] bcm-vk: add bcm_vk UAPI
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-2-scott.branden@broadcom.com>
 <20200907123546.GB2371705@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d06815f8-c868-1aeb-ca9e-2181f7d00188@broadcom.com>
Date:   Wed, 23 Sep 2020 16:55:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907123546.GB2371705@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000befe6c05b003d0ea"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000befe6c05b003d0ea
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA

Hi Greg,

On 2020-09-07 5:35 a.m., Greg Kroah-Hartman wrote:
> On Tue, Aug 25, 2020 at 12:43:58PM -0700, Scott Branden wrote:
>> Add user space api for bcm-vk driver.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  include/uapi/linux/misc/bcm_vk.h | 99 ++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
>>
>> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
>> new file mode 100644
>> index 000000000000..da7848e7c438
>> --- /dev/null
>> +++ b/include/uapi/linux/misc/bcm_vk.h
>> @@ -0,0 +1,99 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
>> +#define __UAPI_LINUX_MISC_BCM_VK_H
>> +
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +#define BCM_VK_MAX_FILENAME 64
>> +
>> +struct vk_image {
>> +	__u32 type; /* Type of image */
>> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
>> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
>> +	char filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
> nit, but this should really be __u8 filename[...
> right?
Changed to __u8.  Thanks.
>
>
>
>> +};
>> +
>> +struct vk_reset {
>> +	__u32 arg1;
>> +	__u32 arg2;
>> +};
>> +
>> +#define VK_MAGIC		0x5e
>> +
>> +/* Load image to Valkyrie */
>> +#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
>> +
>> +/* Send Reset to Valkyrie */
>> +#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
>> +
>> +/*
>> + * message block - basic unit in the message where a message's size is always
>> + *		   N x sizeof(basic_block)
>> + */
>> +struct vk_msg_blk {
>> +	__u8 function_id;
>> +#define VK_FID_TRANS_BUF	5
>> +#define VK_FID_SHUTDOWN		8
>> +	__u8 size;
> Size of what?
Size is number of vk_msg_blk's.  Comment is above the struct.
Can add a comment on this line as well.
>
>> +	__u16 trans_id; /* transport id, queue & msg_id */
>> +	__u32 context_id;
>> +	__u32 args[2];
>> +#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
>> +#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
>> +#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
>> +#define VK_CMD_MASK		0x0f00 /* command mask */
>> +};
> What are these defines for?  The args?  Something else?  It's not really
> obvious here...
Agree, it's not really obvious and is confusing.
When args[0] is a command the defines apply.
Will add comments.
>
> thanks,
>
> greg k-h


--000000000000befe6c05b003d0ea
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg2YAgUgtK
qaOqGzhAe2Bc6w9fZe4hmWE94GhehG+ZXHMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTIzMjM1NTE3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEQ1VHov/VwG46HeX81VewC6ToWj
t7zzJd4YNC96VmpnPdmtPEYVHFtsfzZmgXfvxIh3PnPxNdxGclf080Ov3bz+5dAtBJCJoZ1O18ND
MQuluXml5Ad4OcmBY2qdNhmsgIhwOBE+1yfhon2z1JGZgKuBcnlxOyRcVatBTk7oaOMeUBHfY4td
RnHgoAdkPrGyRkydO3oF3135E6b7DmNncnr8XWHVa4+v6JhQOueFpzgw1ZDSOtgU8c6ihE5m9flW
+pMNciST8eXNRHDhLd754HH5ypp5OdwuHP/CYbfAp2Bbscl5e/hFbsdJ/76hxySzNZounRbG7lH8
m2GVnmvMVDY=
--000000000000befe6c05b003d0ea--
