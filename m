Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3882ED183
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbhAGOOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:14:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76558C0612F4;
        Thu,  7 Jan 2021 06:13:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq13so1537954pjb.3;
        Thu, 07 Jan 2021 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8KQjDPhISIzSyLBDTkOXvkJNOnLb//j0j00T7o4MgxE=;
        b=Ceg9w/sUSD3qvx5BnYc8euP+QYq4ByLULjkiMUbfUKOPv9xvbExJiJaC0YQvOUIXrb
         sbtdzprZJa+q3XF6kCo7R7muv53FrhH7Y0SyqtSC5pWml2uyvXXQGTvwaVgPkcEPFDeC
         GuygtxvpLraqXZP47LFTXI9tFu4RkcMQbCqaTs4fwXk4IykFNqmRwJcbOPvbEvs7bZpj
         RPRh2M33CIDQ3+x5oES+Ey7o5AosCcW7xaytjpveQycs/AE1uvlBy2ny0KdZH/NePtzA
         UJWLyVocHfcdcLvel98xOpcJA9HqIu+YS5j3OHR6VcCjSeN2XmjxR9JjF26cOzjfuupV
         bLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8KQjDPhISIzSyLBDTkOXvkJNOnLb//j0j00T7o4MgxE=;
        b=XNH6pL2tMzu8JvsPBGeE90IaSGimVEL1IeRj30sjEQA9jbOXJbHMCxk8gqyNMRrzeQ
         dTCO7mY49LPROO9P8RrPyWOWCLaBsBXCry7VgAaDEluGT3yCj7TlZdq/LMg8mhjG5a+B
         oxqnFB7LjuOfLhGentl4xQLzEg3CwREYfl7+Mn3s0Rs2IM+wsSYlJbkHvW0Lz+qas8MU
         007UmipX+6v5//mkwJobgS3jEkgbsN06vQq+VS+JdxioraKi0NlImbxMyKEXc2Hx6y9z
         5NjcYoWRmVHtMKMLtX3sUqeRZ29hDVE/MfkR830ooXAtK+bKEiJMReKeP7KzL6GKwCKU
         FY+g==
X-Gm-Message-State: AOAM531hPemD0twNNjQ5u8QLQq9H7LgY4Lpjob1EGmLcJ6Onb0CkrLMv
        58C8LLnlJMCNbPPjNl+34ozsqW5ooDjo/d9x
X-Google-Smtp-Source: ABdhPJwVFeI6e7qT1LWBz0K59xmj1PjTYjsgPaS49JY6LJfIfRPiupttXLY//VFhtErWQa5iRU3EBA==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr9680670pjt.104.1610028838445;
        Thu, 07 Jan 2021 06:13:58 -0800 (PST)
Received: from [192.168.0.104] ([49.207.197.164])
        by smtp.gmail.com with ESMTPSA id 193sm6228358pfz.36.2021.01.07.06.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:13:57 -0800 (PST)
Subject: Re: [PATCH v2 05/15] usb: misc: emi26: update to use
 usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130012847.2579463-1-anant.thazhemadam@gmail.com>
 <X8pKmmdvO0cIQXnL@localhost>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <6806f8e4-c2f7-3c6a-b855-3f87ab8d9e22@gmail.com>
Date:   Thu, 7 Jan 2021 19:43:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8pKmmdvO0cIQXnL@localhost>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/12/20 8:11 pm, Johan Hovold wrote:
> On Mon, Nov 30, 2020 at 06:58:47AM +0530, Anant Thazhemadam wrote:
>> The newer usb_control_msg_{send|recv}() API are an improvement on the
>> existing usb_control_msg() as it ensures that a short read/write is treated
>> as an error,
> Short writes have always been treated as an error. The new send helper
> only changes the return value from the transfer size to 0.
>
> And this driver never reads.
>
> Try to describe the motivation for changing this driver which is to
> avoid the explicit kmemdup().
>
Thank you. I will try and put a more appropriate commit message.
>> data can be used off the stack, and raw usb pipes need not be
>> created in the calling functions.
>> For this reason, the instance of usb_control_msg() has been replaced with
>> usb_control_msg_send() appropriately.
>>
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>>  drivers/usb/misc/emi26.c | 31 ++++++++-----------------------
>>  1 file changed, 8 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/usb/misc/emi26.c b/drivers/usb/misc/emi26.c
>> index 24d841850e05..1dd024507f40 100644
>> --- a/drivers/usb/misc/emi26.c
>> +++ b/drivers/usb/misc/emi26.c
>> @@ -27,7 +27,7 @@
>>  #define INTERNAL_RAM(address)   (address <= MAX_INTERNAL_ADDRESS)
>>  
>>  static int emi26_writememory( struct usb_device *dev, int address,
>> -			      const unsigned char *data, int length,
>> +			      const void *data, int length,
> Why is this needed?
>
>>  			      __u8 bRequest);
>>  static int emi26_set_reset(struct usb_device *dev, unsigned char reset_bit);
>>  static int emi26_load_firmware (struct usb_device *dev);
>> @@ -35,22 +35,12 @@ static int emi26_probe(struct usb_interface *intf, const struct usb_device_id *i
>>  static void emi26_disconnect(struct usb_interface *intf);
>>  
>>  /* thanks to drivers/usb/serial/keyspan_pda.c code */
>> -static int emi26_writememory (struct usb_device *dev, int address,
>> -			      const unsigned char *data, int length,
>> +static int emi26_writememory(struct usb_device *dev, int address,
>> +			      const void *data, int length,
>>  			      __u8 request)
>>  {
>> -	int result;
>> -	unsigned char *buffer =  kmemdup(data, length, GFP_KERNEL);
>> -
>> -	if (!buffer) {
>> -		dev_err(&dev->dev, "kmalloc(%d) failed.\n", length);
>> -		return -ENOMEM;
>> -	}
>> -	/* Note: usb_control_msg returns negative value on error or length of the
>> -	 * 		 data that was written! */
>> -	result = usb_control_msg (dev, usb_sndctrlpipe(dev, 0), request, 0x40, address, 0, buffer, length, 300);
>> -	kfree (buffer);
>> -	return result;
>> +	return usb_control_msg_send(dev, 0, request, 0x40, address, 0,
>> +				    data, length, 300, GFP_KERNEL);
> So you're changing the return value on success from length to 0 here.
> Did you make sure that all callers can handle that?

All the callers presently contain only an error checking condition for a return value < 0,
which still applies even with this change. So this wouldn't raise any issues.

>>  }
>>  
>>  /* thanks to drivers/usb/serial/keyspan_pda.c code */
>> @@ -77,11 +67,7 @@ static int emi26_load_firmware (struct usb_device *dev)
>>  	int err = -ENOMEM;
>>  	int i;
>>  	__u32 addr;	/* Address to write */
>> -	__u8 *buf;
>> -
>> -	buf = kmalloc(FW_LOAD_SIZE, GFP_KERNEL);
>> -	if (!buf)
>> -		goto wraperr;
>> +	__u8 buf[FW_LOAD_SIZE];
> As the build bots reported, you must not put large structures like this
> on the stack.

Understood. 
But I'm considering dropping this change (and the one proposed for emi62)
altogether in v3 - since these would end up requiring memory to dynamically allocated
twice for the same purpose.
However, if you still think the pros of updating this (and emi62) outweigh the cons,
please let me know, and I'll make sure to send in another version fixing it.


>>  
>>  	err = request_ihex_firmware(&loader_fw, "emi26/loader.fw", &dev->dev);
>>  	if (err)
>> @@ -133,11 +119,11 @@ static int emi26_load_firmware (struct usb_device *dev)
>>  
>>  		/* intel hex records are terminated with type 0 element */
>>  		while (rec && (i + be16_to_cpu(rec->len) < FW_LOAD_SIZE)) {
>> -			memcpy(buf + i, rec->data, be16_to_cpu(rec->len));
>> +			memcpy(&buf[i], rec->data, be16_to_cpu(rec->len));
>>  			i += be16_to_cpu(rec->len);
>>  			rec = ihex_next_binrec(rec);
>>  		}
>> -		err = emi26_writememory(dev, addr, buf, i, ANCHOR_LOAD_FPGA);
>> +		err = emi26_writememory(dev, addr, &buf, i, ANCHOR_LOAD_FPGA);
>>  		if (err < 0)
>>  			goto wraperr;
>>  	} while (rec);
>> @@ -211,7 +197,6 @@ static int emi26_load_firmware (struct usb_device *dev)
>>  	release_firmware(bitstream_fw);
>>  	release_firmware(firmware_fw);
>>  
>> -	kfree(buf);
>>  	return err;
>>  }
> Looks good otherwise.
>
> Johan

Thanks,
Anant

