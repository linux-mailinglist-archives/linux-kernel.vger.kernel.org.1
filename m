Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75E2909D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410849AbgJPQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409112AbgJPQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602866407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTzx20fh2RmWmuDwiEgDrjuSPGAOXTJQu22dF0nFn+Y=;
        b=CS+Y/X7wbGbiB9nZyI6BtdCCygKXZzloclexKLr36TKj4rxGX30I656d7lkAjIMxwMb23Q
        BS3LKlPs9PkOssSCwkkysTS4l4rt2p/oFEp643Xlc3nziOMzMrvy8Jdy/XD/F3SYWQz1/f
        0msj8LjAg3B8XCnO7JVd+Hn+dquXO0o=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-cwes3hiVMDy5umccu4w-Tw-1; Fri, 16 Oct 2020 12:40:06 -0400
X-MC-Unique: cwes3hiVMDy5umccu4w-Tw-1
Received: by mail-oo1-f71.google.com with SMTP id d1so1315017ooo.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WTzx20fh2RmWmuDwiEgDrjuSPGAOXTJQu22dF0nFn+Y=;
        b=F8bpTvoi5/JercfExwMJa2HHwByaSFICF/mWUzgkHjsUN6g+T9FX3G1BfghJhPTga0
         a/M8c/qiCYwXImb5pPr6rcoq3qFEZQDoeE8YiDUuEdfdUx/EIr/7pZGSzTF+bvQoHU/K
         v69nz+EkjRY25O3y3qtAvTQDAO9BmARV4O7XHJkJtnHmJ+YsttpmQYHinNsDK82tRNGE
         khnaXFn3lkkn2xWotun4lE2502KnUc93NOvHZVWF8e0NkwgrLS5p3BygiKomNQ8Ins8C
         HzO4noZD+43F3rqAeGvBTO89Uz8dHV5rhIb3jxGHEzlqSRLjerUZUgzdlr9QKscPcFpv
         1HAg==
X-Gm-Message-State: AOAM531h2H1jOhKjkuopGHWUUvbzSXelzDdY6ERLmHLoN1ytAbqtinP7
        CayT2atUPlzpV+ADM0NedenzLh5A4kwGdkrDBoThpAPgB9KqGmfqVxEkPppPzM9UsBHj/1+aPlN
        RADoPTbe/oyNwGPFRSPvNmUX/
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr3188774otq.241.1602866405289;
        Fri, 16 Oct 2020 09:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOXWQBJ8pGhLQ9tQHcD/L+ILpJ2q47rSLDwAFED6x8CKq9BHgzRR/TawziYXtyudvvel7bMg==
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr3188765otq.241.1602866405101;
        Fri, 16 Oct 2020 09:40:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t65sm1171286oib.50.2020.10.16.09.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 09:40:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] UIO support for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3dcc1b4e-d0fd-0586-ea87-eada0c557bed@redhat.com>
Date:   Fri, 16 Oct 2020 09:40:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/15/20 11:02 PM, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
>
> The usage is like:
>
>  # echo dfl_dev.1 > /sys/bus/dfl/drivers/<kernel driver>/unbind
>  # echo dfl-uio-pdev > /sys/bus/dfl/devices/dfl_dev.1/driver_override
>  # echo dfl_dev.1 > /sys/bus/dfl/drivers_probe
>
>
> Xu Yilun (2):
>   fpga: dfl: add driver_override support
>   fpga: dfl: add the userspace I/O device support for DFL devices
>
>  Documentation/ABI/testing/sysfs-bus-dfl | 28 +++++++++--
>  drivers/fpga/Kconfig                    | 10 ++++
>  drivers/fpga/Makefile                   |  1 +
>  drivers/fpga/dfl-uio-pdev.c             | 83 +++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++-
>  include/linux/dfl.h                     |  2 +
>  6 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c

This is a neat new feature.

Should something be added to Documentation/fpga/dfl.rst ?

Overall, patchset looks good.

Tom

