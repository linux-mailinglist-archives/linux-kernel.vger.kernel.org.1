Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F807277B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIXVkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIXVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:40:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:40:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so800878pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8Uh4+f4revk4RTLfSP0NZuC8A7DIb3MmHAvFb3SahkM=;
        b=Mmgxz/SGxiNgmsFIN+6pRkVTJVM8F/lnSNCAafob/RIcna95MQ6RjSsujOs/1uJK2U
         IEHfDCV5lqTEhxPJ+kN3WtvsjFjzoVG0TC+SFnM+1kzGC+dWR+hwKFb72mEGa+g1N+Wd
         5dXnY0gQ3pUwfm8yFQdr2W13uD3TIfXy/La6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=8Uh4+f4revk4RTLfSP0NZuC8A7DIb3MmHAvFb3SahkM=;
        b=Ep7LjzA+fQJuT+nSA0xuA/4RLpQhAzYfpaXgfjPusbrMsp5+STpitTdXRLsvB1MgvH
         YIPHsPqf5O7URtQg88r+xiRFdVECARmSSSOoaJqN1LzbG6DwBRL2DPmRTsyJ4v4yfhsy
         SmcYlRjF7lnWLK6bDoT0nhdQg/0X+MOD7yzywtS0xJw+cS8MZuRbSx1vhLzszeL76MCO
         UsG/cU7EkKqEFuUyK92yLQQnWTRhOY5NEqz4/xd9wuncrdZW9IQwN1T4zMUUPnXddDPR
         zMpNS0VUCYMRVoXFCptgbHXff3EEei4DnNn95lexnosWMYaQo9PM90TkrToDG0KMU4C6
         aeXQ==
X-Gm-Message-State: AOAM531veg6NerHp/iJ+KOr/Kxhq8GHIjuCRqjtiP2ThJ6duiMTPN1RP
        StKNnSe/CYb5LRbWPzp+WS58OQ==
X-Google-Smtp-Source: ABdhPJzFL3Nd9pZgfp3/g6NiAmBogg2rBOTvIUGskYqy1ly5yh7UGOzJ7Dtfpbe4uS8DA2Yw4wRJ7g==
X-Received: by 2002:a62:bd0e:0:b029:142:2501:35e7 with SMTP id a14-20020a62bd0e0000b0290142250135e7mr950352pff.71.1600983616399;
        Thu, 24 Sep 2020 14:40:16 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id cf7sm235222pjb.52.2020.09.24.14.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 14:40:15 -0700 (PDT)
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8ce85527-cb0a-7cf4-541b-b346e060e772@broadcom.com>
Date:   Thu, 24 Sep 2020 14:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924050851.GA271310@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c9904d05b0160b40"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c9904d05b0160b40
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA

Hi Greg,

Responses below.  I'll send out the split up patches hopefully today/tomorrow
which may make it a bit easier to understand/comment on.

On 2020-09-23 10:08 p.m., Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 09:43:55PM -0700, Scott Branden wrote:
>>>> +struct bcm_vk_tty {
>>>> +	struct tty_port port;
>>>> +	uint32_t to_offset;	/* bar offset to use */
>>>> +	uint32_t to_size;	/* to VK buffer size */
>>>> +	uint32_t wr;		/* write offset shadow */
>>>> +	uint32_t from_offset;	/* bar offset to use */
>>>> +	uint32_t from_size;	/* from VK buffer size */
>>>> +	uint32_t rd;		/* read offset shadow */
>>> nit, these "unit32_t" stuff really doesn't matter in the kernel, 'u32'
>>> is a better choice overall.  Same for u8 and others, for this whole
>>> driver.
>> Other than personal preference, I don't understand how 'u32' is better.
>> uint32_t follows the ANSI stdint.h.  It allows for portable code without
>> the need to define custom u32 types.
> The ANSI namespace does not work in the kernel, which is why we have our
> own types that pre-date those, and work properly everywhere in the
> kernel.
>
>> stdint types are used in many drivers in the linux kernel already.
>> We would prefer to keep our code as portable as possible and use
>> stdint types in the driver.
> You aren't porting this code to other operating systems easily, please
> use the kernel types :)
>
> And yes, these types are used in other parts, but when you have 25
> million lines of code, some crud does slip in at times...
OK, will reformat.
Seems like the stdint typedefs should not have been added to the linux/types.h
back in ancient kernel times.  If they are not to be used in the kernel, then they should be wrapped in a #ifndef __KERNEL__.
>
>>>> +	pid_t pid;
>>>> +	bool irq_enabled;
>>>> +	bool is_opened;		/* tracks tty open/close */
>>> Why do you need to track this?  Doesn't the tty core handle this for
>>> you?
>> I have tried using tty_port_kopened() and it doesn't seem to work.
>> Will need to debug some more unless you have another suggested function to use.
> You didn't answer _why_ you need to track this.  A tty driver shouldn't
> care about this type of thing.
We want to leave the data in the shared buffers coming from the card until someone is ready to read them.
So we track whether the particular tty device is open.  If the port is not open, we don't increment
our read pointer and leave the data in the buffer.  If it overflows, so be it, we'll get whatever data is in it when we open the tty device.
.
>
>>>> +	struct workqueue_struct *tty_wq_thread;
>>>> +	struct work_struct tty_wq_work;
>>>> +
>>>> +	/* Reference-counting to handle file operations */
>>>> +	struct kref kref;
>>> And a kref?
>>>
>>> What is controlling the lifetime rules of your structure?
>>>
>>> Why a kref?
>>>
>>> Why the tty ports?
>>>
>>> Why the misc device?
>>>
>>> This feels really crazy to me...
>> Comments mostly from Desmond here:
>>
>> Yes, we have created a PCIe centric driver that combines with both a misc devices on top (for the read/write/ioctrl), and also ttys.
>> The device sits on PCIe but we are using the misc device for accessing it.
>> tty is just another on top.  I don't think this is that uncommon to have a hybrid driver.
> Ugh, yes, it is uncommon because those are two different things.  Why do
> you need/want a misc driver to control a tty device?  Why do you need a
> tty device?  What really is this beast?
The beast consists of a PCI card.  The PCI card communicates to the host via shared memory in BAR space and MSIX interrupts.
The host communicates through shared memory in BAR space and generates mailbox interrupts.
In addition the PCI card has DMA access to host memory to access data for processing.
The misc driver handles these operations.  Multiple user space processes are accessing the misc device at the same time
to perform simultaenous offload operations.  Each process opens the device and sends multiple commands with write operations
and receives solicited and unsolicited responses read read operations.  In addition there are sysfs entries to collect statistics and errors.
Ioctl operations are present for loading new firmware images to the card and reset operations.

In addition, the card has multiple physical UART connections to access consoles on multi processors on the card.
But, in a real system there is no serial cable connected from the card to the server.  And, there could be 16 PCIe cards
plugged into a server so that would make it even more unrealistic to access these consoles via a UART.

Fortunately the data sent out to each physical UART exists in a circular buffer.  These circular buffer can be access via the host in BAR space.
So we added tty device nodes per UART (2 per PCIe).  These are not the misc device node, these are seperate tty device nodes that are opened
and behave like tty devices.

We are not using the misc driver to control tty.
  1) The PCI driver is the foundaton of it which provides the physical interface to the card, 2) misc driver is a presentation to user space to do its regular message - this allows user to treat it as a char-device, so its like fopen/read/write/close etc. and 3) tty is an additional debug channel which could be on or off.

Please suggest how we can access the misc device and tty device nodes other than how we have implemented it in a single driver?
>
> We got rid of the old "control path" device nodes for tty devices a long
> time ago, this feels like a return to that old model, is that why you
> are doing this?
I don't know what old "control path" you are referring to and what the "new" path is?
>
> But again, I really don't understand what this driver is trying to
> control/manage, so it's hard to review it without that knowledge.
We have circular buffers in PCI memory that contain serial data.  We need to be able to open/close tty devices in linux for console operations.
And also to be able to perform operations such as lrz/sz.  This needs to have the same ability as if a physical serial cable was connected between the server and the card.  So user is able to either plug a UART cable in or open the "virtual" UART accessed over PCIe.

For misc device, the PCI memory is the physical interface, and on top it is a queue-messaging scheme for information exchange.  This is more for the control-path operations, cmd in/out etc.
>
>> Since we have a hybrid of PCIe + misc + tty, it means that we could simultaneously have opening dev/node to read/write (multiple) + tty o going.
> That's almost always a bad idea.
The mulitple users is a must for us.  We have multiple individual user space processes opening the misc device and communicating to it.
We also have 2 tty device nodes per card that can be opened/closed at any time.
And this is all on a PCIe card with shared memory, registers, and MSIX interrupts.
The card can be reset at any time, crash, or have PCIe rescan, etc.  User space processes need to be signalled when events detected so they don't hang.
What do you suggest otherwise?
>
>> Since the struct is embedded inside the primary PCIe structure, we need a way to know when all the references are done, and then at that point we could free the primary structure.
>> That is the reason for the kref.  On PCIe device removal, we signal the user space process to stop first, but the data structure can not be freed until the ref goes to 0.
> Again, you can not have multiple reference count objects controling a
> single object.  That way is madness and buggy and will never work
> properly.
We're using this driver in systems that require a high degree of stability and reliability.
We have done extensive testing and don't see the bugs you are referring to.
It's working properly.

> You can have different objects with different lifespans, which, if you
> really really want to do this, is the correct way.  Otherwise, stick
> with one object and one reference count please.
If we draw a hierachy, bcm_vk object encaps the misc_object + pci_object + tty_object.  The kref is for the bcm_vk object or the upper layer one.  It is to guarantee that all the sub-level objects are freed that we free this upper-level one.  I guess this is a result of the hybrid design, and this is mainly to avoid issue when we say "echo 1 > pci->remove".  The global structure under PCI will be removed, but we could not do so unless all its  misc_object/pci_object/tty_object are gone.  We did observe corner case if we don't have this that some of the apps who have opened the misc_device will seg-fault as it access the datastructure after the pcie->remove is done.  Not very common but more a corner case depending on timing.
> thanks,
>
> greg k-h
Regards,
 Scott

--000000000000c9904d05b0160b40
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgwk6dcbyp
iiFZ77v7dPV58ZsQsnoKRlN0xKdA/UFrZ9EwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTI0MjE0MDE3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABPzNg7FTnpNPRlQMkSNMAcv1urT
5E3js8JC1LA4T05RZng1RCEuf5rBHazPGSm3tVQc+XLpoTXouwiGhOPvjxx0sjU3TXN+5dOeTKC4
ozqUOhm/ck0ckdxAt1R6RuGN2ihVFHpgbtSj7IGGTUqEUZpIMe+mIPgIoL4tLcpmh2YLXpx2+/Ej
yOdTcQwF8NDXAjlNLv42ut59Oah96h2knHgd3CFodM5/gTEF20gZfVYheoMQC5HAkHs3davIuYfS
IbOPXtVGPjWtZu886n3f9oTDcFqR+t8K94nrTxh8xyKVV+zKNtYwBWy9AFVWmHoQIZWCMIbIjrsV
4oGQZG1aTDw=
--000000000000c9904d05b0160b40--
