Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD042FAF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbhASDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbhASDtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:49:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:48:27 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 15so19855373oix.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHqCvnJUy5Q32bJt5hFC+hJi6pepUhrDRSpgqxJk9aA=;
        b=OJdf2DN21i11/iEop4VOnXVKlpEHK8yNF0JZKdSEUQMqb0K5PymcHeuColC+sQeYLS
         y4aHMZVLTSwjAJubCA6KVpfvSeBz9y9LBwv4NCzAnDmN9E2TRSAiG7TJyUNKTzhXfRCb
         ivXA+ymNcv+qig+LNGeQRySaNjjtUBu0xXtJwWenBPdiAW3ZlG0UeG1HaZuU4TcarDty
         6gZyXzGmf1STZR6e3z78lPEIM6GA0meXir1nRXZxZHXizWr3Fo5+hq/WkH3UUd9tBdsR
         4m6Bi++ANPGUjAvMuNQkAoEc/DrGtwR43Oqy1XIT7TXhgt/q7nAKy0JwCwQqQkQ+YYYS
         R18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FHqCvnJUy5Q32bJt5hFC+hJi6pepUhrDRSpgqxJk9aA=;
        b=IJR39DnziQUJhKtz69uokpC8OXLzy0FFFfrkX8RzpX+g3fxUcif8KgxM0GoLRLA9tD
         Qe8MtXnhfbEqSKWfA0kA9JtAS+LpmgIHmQAGHse0iRDqk7BzTWocO7VhNsWc80bt5+uW
         3fnQabETI8gcIxbrCuiyZexKiTANyxVKRtuL4x9axZ8wCtI9BIuPZKQWEf0PAeV9A5I4
         zEAjv83kgGZ3PGm18IVBD1aJv5qXfEnnj+eEOd1QPsi1bVr8myHzKuohO9WPy4EVBs6j
         cf3eBEAuyCFsjf/Iwe6vdWG1Nn8NgwVysw2rjZqqky1gLG07rSuPOiHmeC5NaFTtZpDj
         yB1w==
X-Gm-Message-State: AOAM530fE1i4Wef7yiVbYIpyYIIcv6nzEwHQUboT/qs/o5B/jgX+phEg
        03eRS/GzKzs0m1QdxUMaorc=
X-Google-Smtp-Source: ABdhPJxGzJ3rLJJqMy4tf/4jxoygQ1ln0J7NSXklD8NzonZrjMbe8W4itQDvtukZiPZAZSAJqR+gDQ==
X-Received: by 2002:aca:be09:: with SMTP id o9mr1399089oif.9.1611028106760;
        Mon, 18 Jan 2021 19:48:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11sm4155592ooj.36.2021.01.18.19.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 19:48:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.11-rc4
To:     Paul Zimmerman <pauldzim@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <20210118223520.GA193902@roeck-us.net>
 <20210119033553.39607-1-pauldzim@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <235609f8-f66d-ab4d-94b5-d858ee8e43d3@roeck-us.net>
Date:   Mon, 18 Jan 2021 19:48:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119033553.39607-1-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 7:35 PM, Paul Zimmerman wrote:
> On Mon, Jan 18, 2021 at 14:35:20 -0800, Guenter Roeck wrote:
>> On Sun, Jan 17, 2021 at 04:56:46PM -0800, Linus Torvalds wrote:
>>> Things continue to look fairly normal for this release: 5.11-rc4 is
>>> solidly average in size, and nothing particularly scary stands out.
>>>
>>> In the diff itself, the new ampere modesetting support shows up fairly
>>> clearly - it's one of those hardware enablement things that should be
>>> entirely invisible to people who don't have that hardware, but it does
>>> end up being about a fifth of the whole rc4 patch.
>>>
>>> If you ignore that oddity, the rest looks pretty normal, with random
>>> patches all over, and a lot of it being quite small. All the usual
>>> suspects: drivers (gpu, sound, rdma, md, networking..) arch updates
>>> (arm64, risc-v, x86), fiesystems (ext4, nfs, btrfs), core networking,
>>> documentation and tooling. And just random fixes.
>>>
>>
>> Here are the test results:
>>
>> Build results:
>> 	total: 153 pass: 151 fail: 2
>> Failed builds:
>> 	arm64:allmodconfig
>> 	ia64:defconfig
>> Qemu test results:
>> 	total: 430 pass: 428 fail: 2
>> Failed tests:
>> 	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
>> 	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs
>>
>> Same old ...
> 
> Hi Guenter,
> 
> Can you give a link to the problem that Qemu is having with RPI2?
> Maybe I can take a look at it.
> 

The fix is pending in -next (and has been there for a while).
Look for "irqchip/bcm2836: Fix IPI acknowledgement after
conversion to handle_percpu_devid_irq" (commit d7f39c40ebb6
in next-20210118).

Guenter
