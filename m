Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE91B07AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDTLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:42:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52950 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587382926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaSALkv288RXYLBI4WCs7nZ9DFDMF/MzZugHq3zt0lM=;
        b=Uu3nHUdTNX9MZ6YzX5fccQVry73OAzabjHBELpd3ILf52d2qD8W1FBQvinjyI+BckKLzJZ
        3Y8JnK4SHbE8KFU+aGk0e8Hy3TcDrdVk+yFL0P4xlgD6zJGNJHgEOQlwHGY2CvaPqbL74r
        mqLNM9K6Y62luINbz6mXdvmh4GDHUlY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-yvembTmsOlSEez0eIYxU6w-1; Mon, 20 Apr 2020 07:42:00 -0400
X-MC-Unique: yvembTmsOlSEez0eIYxU6w-1
Received: by mail-wm1-f70.google.com with SMTP id t62so4071403wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RaSALkv288RXYLBI4WCs7nZ9DFDMF/MzZugHq3zt0lM=;
        b=F/NJhI06PzpDwz0AopR6B/xb6BOCV50bTp9QLZn1RCydR6Xj4yroj9OkIlC31SELxM
         +AT5nw4gRPWw8exH1ruyP7xfnoUUrmhXYwnUwmqZxFf3p9dp/fLuMiu+gAEQON+vsn7z
         FYf/nPDlImaVvQP+i3OOqC4LLQnRAHq/LwCdsbjZqlgUi8KW0huihlk1mnyeBnOSbuhJ
         8RPXu2L7qlYGwhNJVfD5TA89WkaSaPmRt4BqLCoTmOj9vIG0wLDef1NlXxndZPGBwJrX
         vGBhiG4vMg5eRNUHGrmZpe4Vtn3v5DwA7ACTLQdOSQOEkDAVNxMcF+uNyZLF/sYzmLbd
         FLkg==
X-Gm-Message-State: AGi0PuaN2C+qUQn1HvqP6sd81B6PqBgrnV8/dxI0KlGdYDXxX0GeT5fj
        I/DFv7Y0WqeCuUVDK8HE05+en+yQxVVhMwnUmbInf8JldjNoa6xnTsWxBLXUi/qdMlu01P0Bt3F
        7w7MSjef2LCSrEJ0TXQskutcc
X-Received: by 2002:a1c:7212:: with SMTP id n18mr18176377wmc.53.1587382919085;
        Mon, 20 Apr 2020 04:41:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqDlNHMJlF9NWmfKOIMRGKyInIuywYCTbS89h6gAa9rpOj0h1WZOgcNt9hDnaKVu+UxRSztw==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr18176358wmc.53.1587382918893;
        Mon, 20 Apr 2020 04:41:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n131sm1064609wmf.35.2020.04.20.04.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 04:41:58 -0700 (PDT)
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz>
 <20200417130135.GB5053@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e02b7cdc-f29a-916c-d923-224a1b312485@redhat.com>
Date:   Mon, 20 Apr 2020 13:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417130135.GB5053@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

<A lot of context has been trimmed here before I got added to the Cc, so
  I'm assuming that we are talking about the vboxsf code here.>

On 4/17/20 3:01 PM, Christoph Hellwig wrote:
> On Fri, Apr 17, 2020 at 10:59:09AM +0200, Jan Kara wrote:
>>> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
>>> +	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
>>> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
>>>   	if (IS_ERR(dev))
>>>   		return PTR_ERR(dev);
>>>   
>>
>> This can have a sideeffect not only bdi->dev_name will be truncated to 64
>> chars (which generally doesn't matter) but possibly also kobject name will
>> be truncated in the same way.  Which may have user visible effects. E.g.
>> for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
>> other way around - i.e., let device_create_vargs() create the device name
>> and then copy to bdi->dev_name whatever fits?
> 
> I think having them mismatch is worse, as the kobject name is what
> people look for.  Hans, do you know what fc->source typicall contains
> and if there is much of a problem if it gets truncated/  Can we switch
> to something else that is guranteed to be 64 charaters or less for the
> bdi name?

It contains the name the user has given to the shared-folder when
exporting it from the host/hypervisor. Typically this will be the
last element of the directory path, e.g. if I export /home/hans/projects/linux
then the default/suggested share name and this the source name to pass to
the host when mounting the shared-folder will be "linux". But the user can
put anything there.

AFAICT for vboxsf the bdi-name can be anything as long as it is unique, hence
the "vboxsf-" prefix to make this unique vs other block-devices and the
".%d" postfix is necessary because the same export can be mounted multiple
times (without using bind mounts), see:
https://github.com/jwrdegoede/vboxsf/issues/3

The presence of the source inside the bdi-name is only for informational
purposes really, so truncating that should be fine, maybe switch to:

"vboxsf%d-%s" as format string and swap the sbi->bdi_id and fc->source
in the args, then if we truncate anything it will be the source (which
as said is only there for informational purposes) and the name will
still be guaranteed to be unique.

Regards,

Hans

