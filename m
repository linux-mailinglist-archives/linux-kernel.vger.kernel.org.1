Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50A62ED4F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbhAGRCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728118AbhAGRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610038870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYC79LNk2nzU1Q3GB47wy9Gu7cJ3IMZGWrzODwHrOJw=;
        b=FqXECTG5A6gri8+PGIzC/elVBefzx+3dzSJ0V5KHHCH9ao/NofS0eoR793bG8XuhXsajja
        vv5zqaamPCSO2KAPNfnKRQLXoFyyL4tvn5mX/PKjRnUdbfEzpqVrgThnX9OFd5GvWWx5ve
        2g0Q18Ta8Gd/vRJV92lIrZCfN+v6uHI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-KSowEJYuMrmsg3QS3XCVfQ-1; Thu, 07 Jan 2021 12:01:08 -0500
X-MC-Unique: KSowEJYuMrmsg3QS3XCVfQ-1
Received: by mail-pg1-f200.google.com with SMTP id 24so5184822pgt.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tYC79LNk2nzU1Q3GB47wy9Gu7cJ3IMZGWrzODwHrOJw=;
        b=fu8EZd7NcO4E4d/PyjKDA8adznYlygCZdE073ycewKa/17QUFVQbIySGmFQi2JmZgG
         +S79tZsaV4zPvar3vRqKOQmw7nZygL4OyjvHLqFdgoSgPdcri9nge1z42TAjwvvfenOk
         xfHb3NRzPxtHxZQJykYBeoYL38eOGpKFA8t68g+o3hFfR2hVvwoVu19ANtJKs0w0CZ6L
         91tBKG/Jsw38/ZNjmZdL2sSlT8WhlgPnjo7j32w0eCnfe4HO/O77fMe5bY9M15tzi0kk
         6MUBQ9aXnJSs5G4UZF186yCv9wvPi1yAPDAcsG+1qPtfFNGJz/PR19EWhW8jjJpYqBSZ
         ariA==
X-Gm-Message-State: AOAM530AgU7Lv9xaajToZzNS9mwf/5y+KyqdzwZLM/Fh+TNj4tuk6SGB
        mT3tpHjX1mpRRE5V+5UxMC3FW8dmtdYAfA/HJ6GHRH5S12pRnKZoWZPkj/kUmintVslAKtIOPm+
        HwBYAOV6zf5uKqnYv2FcHbDal
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id x7-20020a170902fe87b02900da5d3b4a84mr9876759plm.51.1610038867260;
        Thu, 07 Jan 2021 09:01:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysL4EldspCf6rNFwrd0bAyeFEK4JxLwg2+MTt3NtFgM2enXGtOwOvfdPwi2PbRwBbnrn5iAQ==
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id x7-20020a170902fe87b02900da5d3b4a84mr9876736plm.51.1610038867052;
        Thu, 07 Jan 2021 09:01:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b18sm6517233pfi.173.2021.01.07.09.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:01:06 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, moritzf@google.com
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <X/czarr9bXr849p5@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <51e3350c-00d3-b2fe-cdc5-be64b661c224@redhat.com>
Date:   Thu, 7 Jan 2021 09:01:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/czarr9bXr849p5@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/21 8:14 AM, Greg KH wrote:
> On Thu, Jan 07, 2021 at 08:09:12AM -0800, Tom Rix wrote:
>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>> This is a resend of the previous (unfortunately late) patchset of
>>> changes for FPGA DFL.
>> Is there something I can do to help ?
> This is all now merged in my tree, so there's not much left to do here
> :)

Yes this patchset is done now.

I am offering to help in an ongoing manner, something like 10hr/week would be easy as i already spend about 30hr/week doing stuff in the kernel in addition to reviewing linux-fpga.

Tom

> thanks,
>
> greg k-h
>

