Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE3278F10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgIYQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgIYQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:50:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EBEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:50:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so3746722pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=9w3SKfSxdz1zKGOtSbFuB6Xf1MbPvoZXYDQf0LS9PVU=;
        b=Xfa7DSqvt2XAZB/xJ4mFCuLk5JANRf9JnbNavlwyGjWeop3I2nCcjRwloG7ZLW0+iY
         3O4PtcjygHtDj3UUc5/ZxC3nq5yy3cYj4hZp9nTY4CpKSFQ7ze1ix+TK1VoQwO+yA2L9
         6lJvNC+i6oehZFgu0NW/Tsc8NxVWTDtfVsxwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=9w3SKfSxdz1zKGOtSbFuB6Xf1MbPvoZXYDQf0LS9PVU=;
        b=MjjqqrM83Y24tagdbIknCbe18lej8i27EiEpaVI9FOS0J+0dArewSACv5YxeiebtKc
         +v5+AqqURjnGHkwwAWPbAv5ufbWvobImEnxetnL2GvtI8pE+hMN9VgRN1ZHkZz0Vxuub
         b8VaY4VTKJ69+Peu0yBXr/JWVo0yGuzKy9vsAplsunPVR2Du21VDs4EGLDS+TbsjMkrd
         7D5RwqjeZG5JLIML9MOQtyVTRrOm9x4Tbo+fEl/allqUcCktxunbf62xZkRklaVk/bUE
         /6sU5pk4wal2r4EeyVv2x/20epU8wuAyog/nrLsu+JlBw/arEYdmbd/eCAQxkNPXT5zy
         SW5g==
X-Gm-Message-State: AOAM530lQG/nZYTtDI3gGxqs8UXpmNDUC1YCwn4FCXroIrIIUBNmUews
        eL1kVkNPWhuBYSIOX8FkYsMQ3w==
X-Google-Smtp-Source: ABdhPJxL5bgOj9iyyrZxN6aviQlmZ+lfUVwFTAqYKqrba9rxsqUDklYvjunTmi0ou9vae76VQzwb0A==
X-Received: by 2002:a63:d155:: with SMTP id c21mr775177pgj.55.1601052624137;
        Fri, 25 Sep 2020 09:50:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y195sm3266531pfc.137.2020.09.25.09.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:50:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] misc: bcm-vk: add Broadcom VK driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-3-scott.branden@broadcom.com>
 <20200907125530.GC2371705@kroah.com>
 <767f6b6a-07fc-f1b6-f43c-b974761f1505@broadcom.com>
 <20200924050851.GA271310@kroah.com>
 <8ce85527-cb0a-7cf4-541b-b346e060e772@broadcom.com>
 <20200925051031.GA603947@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <720994f2-51b5-944e-bc35-716f571687e3@broadcom.com>
Date:   Fri, 25 Sep 2020 09:50:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925051031.GA603947@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f57a0a05b0261ccb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f57a0a05b0261ccb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA

Hi Greg,

On 2020-09-24 10:10 p.m., Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2020 at 02:40:08PM -0700, Scott Branden wrote:
>>> Ugh, yes, it is uncommon because those are two different things.  Why do
>>> you need/want a misc driver to control a tty device?  Why do you need a
>>> tty device?  What really is this beast?
>> The beast consists of a PCI card.  The PCI card communicates to the host via shared memory in BAR space and MSIX interrupts.
>> The host communicates through shared memory in BAR space and generates mailbox interrupts.
> That describes any PCI card :)
>
>> In addition the PCI card has DMA access to host memory to access data for processing.
>> The misc driver handles these operations.  Multiple user space processes are accessing the misc device at the same time
>> to perform simultaenous offload operations.  Each process opens the device and sends multiple commands with write operations
>> and receives solicited and unsolicited responses read read operations.  In addition there are sysfs entries to collect statistics and errors.
>> Ioctl operations are present for loading new firmware images to the card and reset operations.
>>
>> In addition, the card has multiple physical UART connections to access consoles on multi processors on the card.
>> But, in a real system there is no serial cable connected from the card to the server.  And, there could be 16 PCIe cards
>> plugged into a server so that would make it even more unrealistic to access these consoles via a UART.
>>
>> Fortunately the data sent out to each physical UART exists in a circular buffer.  These circular buffer can be access via the host in BAR space.
>> So we added tty device nodes per UART (2 per PCIe).  These are not the misc device node, these are seperate tty device nodes that are opened
>> and behave like tty devices.
>>
>> We are not using the misc driver to control tty.
>>   1) The PCI driver is the foundaton of it which provides the physical interface to the card, 2) misc driver is a presentation to user space to do its regular message - this allows user to treat it as a char-device, so its like fopen/read/write/close etc. and 3) tty is an additional debug channel which could be on or off.
>>
>> Please suggest how we can access the misc device and tty device nodes other than how we have implemented it in a single driver?
> You haven't described what the card actually is for.  You describe how
> you have tried to hook it up to userspace, but what is the use-case
> here?
The driver is used for real-time high performance, high throughput, low latency offload compute engine operations.
These operations are used to offload tasks that take up far too much of a CPU to be run on a host which would only be able to run a few of these tasks.
It is used for such tasks as: video and image processing and crypto.
The card is capable of performing many of these task in parallel.  And, many of these cards can be plugged into the same system (say 16 cards).
So instead of a host taking all its time running a single one of these tasks, 100's of these tasks can be performed instead.
Of course, future cards will be able to perform even more operations, host memory bandwidth becoming a bottleneck.

The main operation of the card is to receive commands from various user space operations to offload processing of data.
This usually involves a sequence of offload operations.  The card will DMA the data from host memory and act upon it, signalling appropriate
events back to the host.  At some point the card will typically write the data back to host memory via DMA.  Various statistics and events can also
be queried via sysfs entries.  Crash and real time logs can also be retrieved.  User space processes need to be killed when the card resets or crashes so those tasks do not hang.  Console access to the card's processors is also required.

Most of this could be done differently with uio and daemons and ipc mechanisms.
The linux kernel already provides all the mechanisms that would need to be reinvented in user space.
User space data would also need to be passed from individual processes to a shared daemon, which is not desirable for security purposes vs. keeping it in the individual user space and passed to the kernel driver.
The scatter gather list creation would need to somehow be done.  I don't know if this could be added to a uio driver or if we would need another driver to do such operation.
I guess you would need a custom app to replace every standard app accessing the tty device.
It is just a better model to have kernel operations in the linux kernel and a user space library that opens the device and handles the higher level message through read/write operations.  And then control and debug handled via ioctl and sysfs.

A generic linux model should exist for the offload compute performance and features we are looking for, but doesn't right now.
It would need to have the same reliability and scalability we have and could be tuned as needed to maximize performance, security, and memory usage for the particular use case as needed.
>   Why even have a kernel driver at all and not do everything in a
> uio driver?
>
> Creating random misc devices and tty devices implies that the device
> does not fit into any of the different existing kernel apis, so you need
> to write your own "special" one, which is always worrying.
>
> Without actually knowing what this device is, it's hard to judge if you
> really should be using something existing or not.
Hopefully this helps explain why we have made the design decision to use a kernel module plus user space library to integrate with customer
applications and systems.
>
> thanks,
>
> greg k-h


--000000000000f57a0a05b0261ccb
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgxoLWctS2
8Tt8Mlj9HjkDGyrYv2T/zjPV9Tv5o8y7J3kwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTI1MTY1MDI0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABT973X9snJ1vHtaGqujmVNImb2l
/sYkplUx6sL3fgqd7DQqVZloBXbY5GTrDaBxWeo9XWSqmMkuCh27n/Th8PM1ewiqwjpAeV090feh
rryYsdUBwhBuE3N2ugqrg+k9Y+bjR3zs9J0ecDQkGXIT2TJs1S8o2D4M6cdxX0tLTageKkS9pycF
CkYZwT5j5PT40D7bK1BUg2rxghALwaEcohFB4iXSuxLpcLzjAnQs7peFEned9625i78BxzC6XVPj
bJvLubnMrtkY3XcBrFItdG5x3pGy55OSdo6cncve/DHCiklVz1pMzsiy9z7u1otRRilO4iDq/8iv
OgjfHU1rfr4=
--000000000000f57a0a05b0261ccb--
