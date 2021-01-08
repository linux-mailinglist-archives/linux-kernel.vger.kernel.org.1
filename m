Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377F62EF47C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbhAHPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbhAHPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610118269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01heFlGRaoDcUJftD8M53lD9T5to+ZsFBn4cIvRXGIA=;
        b=iTBwGRmzDl1+ifeby5e3jZwhpQfdgnIoRi4gyVIem49fVDhs7jMri8fiBV0qmpgIfGVonx
        Ls7cen8ROdPWlSL5CMjhIUQupFLF/Lg4PqEu+fFHmqLcn5CZCp07gB/BIetw219EHv4WVx
        Fdb2cf05FDepfoPiklu0jdBpa2hbUGU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-xWR2JvAkMMGSj4bL4oCVDA-1; Fri, 08 Jan 2021 10:04:27 -0500
X-MC-Unique: xWR2JvAkMMGSj4bL4oCVDA-1
Received: by mail-wr1-f72.google.com with SMTP id 4so4274033wrb.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01heFlGRaoDcUJftD8M53lD9T5to+ZsFBn4cIvRXGIA=;
        b=hBfUG1gTFFB88hsFcqWtDRdfVqOvw/7QXwCvR3muAnl0RUC7O4EdU/3ps9xtE+qH5i
         qIp5mMOxG5jo02Ek1zq9FqLplVOeYE6rz+ClTjmpLEbxnZGRyHowWSz7qX5W7RVVXhdR
         SKYQAb2TDbkctXJQclMJP/wecs12AQHlTQx3tgjVZGvRw382OiQdLJrp/7QD6cUBqk6i
         emjvg8YL/I1iYSCJ2PSDQd1QHRAT9t8jKybEFvot0CRQTTTxSk14KarCEoHJ+GeqWVp2
         UDrKk3xwlg8EuzwNzoDWgFbaMKqibiFNN3QJ/zv7SSAoxDMHJEMhwwJq/Y2KutuCmpKQ
         CiZQ==
X-Gm-Message-State: AOAM530/DHSeTodVYSrINhY+8v0esDrM6tU4hNmFsNLocHoD+/CR893O
        ahfMZbIHB+E/O9DofIFKmBeGqaYmyoOtYAGS+RMHNCG8v39YHREiGWujZa2dLcMd0F8665uZeI1
        zDJtjDrmoXo2E3qvzrwp9XCm7bQL9rrOctQyhwfnmLKKoN1moPr7QYybp10BPNN+41SQxhKnqTw
        IG
X-Received: by 2002:a05:6000:23c:: with SMTP id l28mr4104964wrz.193.1610118266074;
        Fri, 08 Jan 2021 07:04:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNXm6WNv+I3PQkV0OnoM7kHg0U814RUd7wDnpf+pOn02YAB/bkxyhwVKJGWc9/4phv/n+SwA==
X-Received: by 2002:a05:6000:23c:: with SMTP id l28mr4104926wrz.193.1610118265880;
        Fri, 08 Jan 2021 07:04:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d9sm15003430wrc.87.2021.01.08.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:04:25 -0800 (PST)
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
To:     Greg KH <gregkh@linuxfoundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
Date:   Fri, 8 Jan 2021 16:04:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/hnF0W+TMj36LDN@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 15:07, Greg KH wrote:
>>   
>>   static void __iomem *base;
>> +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>> +module_param(events, uint, 0644);
>> +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
> I do not understand you wanting a module parameter as well as a sysfs
> file.  Why is this needed?  Why are you spreading this information out
> across different apis and locations?

It can be useful to disable some functionality, for example in case you 
want to fake running on an older virtualization host.  This can be done 
for debugging reasons, or to keep uniform handling across a fleet that 
is running different versions of QEMU.

Paolo

> Again, adding module parameters is almost never a good idea anymore,
> they are a pain to manage and use.

