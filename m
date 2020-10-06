Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F702850E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgJFRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgJFRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602005711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRg0GJHVofMir4bUhfVjc9yEZQKs/9hfnaxI5B7+zds=;
        b=WTYBfnSAfZSiyVCXP9c+tlHO5CJu/pQXWamifpFRwFKpD//Ot8HsJMB/gXankOJAZ6dIcf
        8t7O1rMtufMx8a7Wagstt5XK0WPwEJH3jda4BI5+doNfUtg8D7/9VCW/4cxDXuatIJZg+l
        TpKeoeGxPzPEMO6K292qcuFT9XjQtz0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-Bi-55OjxOLCbx1-UbQ1AOg-1; Tue, 06 Oct 2020 13:35:09 -0400
X-MC-Unique: Bi-55OjxOLCbx1-UbQ1AOg-1
Received: by mail-qv1-f69.google.com with SMTP id de12so8544016qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iRg0GJHVofMir4bUhfVjc9yEZQKs/9hfnaxI5B7+zds=;
        b=iojYX7W5cB07mm/9pBNqxcMHyHfis+j+S2x3z9+5onHR72LGJH3ooxLpbitV4WcEhu
         LA5/G3rzN+fVMSVrExPgsuJS1pGg1HkjGJpR/Pd2OASwBv+KHkRXALDNNhcz/gNMwfDk
         wRg1wRgExSkGQmHxUo530TLbJnqMJFn8zi09DxkWwQcncF2KvmAa/D2aW/2v9DFfBAlu
         69CrQbQFrlSYL773zia0Gp92MvFwxuxDuVBRVJzamxiWJbix7iIMRvv/QAF0a1YnW4f6
         mICS8QgddexkunsmrdhsWw3YNZ8ywHOZmGPcCqVMaXj1GHq7PhJwXQKJzjGq8hwFEcDv
         5CjA==
X-Gm-Message-State: AOAM5315fpNPlWO5uWLf4T4Hm9ugDAdKLm1R9CqWfd3qfA6Cj+Qtj69I
        bzZ+BOdscIQtVCjdw8WfPZjZ+LprVzOyEh2vggrJi0xOxdYbtmSqP0SyiJ1mAJc7D1+d4Ocgrhq
        gJCBOOex+sxBpYSaHhH0HCo+q
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr6021086qvy.32.1602005709097;
        Tue, 06 Oct 2020 10:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzRnQpbyOrNXUS055K41hsMO7RJdIiY4zHjkZi7NHkqShF3RvFMy8E0WWJoYdq4xMXjpIASQ==
X-Received: by 2002:a05:6214:1852:: with SMTP id d18mr6021067qvy.32.1602005708880;
        Tue, 06 Oct 2020 10:35:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l13sm2936891qtv.82.2020.10.06.10.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 10:35:08 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] fpga: m10bmc-sec: expose max10 flash update counts
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <465d98a3-2e24-caf0-02f8-54e8505ab803@redhat.com>
Date:   Tue, 6 Oct 2020 10:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the flash update count for the FPGA user
> image in sysfs.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>   - Minor code cleanup per review comments
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


