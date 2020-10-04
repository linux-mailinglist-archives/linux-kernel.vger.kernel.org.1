Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6942282DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgJDVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDVBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601845264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J20BiFc6m3RHcFdesFRsBwhx7Lh/GICUTgu5OMkGdFI=;
        b=fjCuPqreo5Vw/oq1Ldt/Ncuew3qM/cEntIaIy897pEsAwoOFQBb85fbqszZJEI8QRRQECr
        qcb50iE+fTdL7x4Dn9geBJ7/hcnagnryULv+PdzH+vv27HVXbNcgGcZvulbO1+K6zvj5zn
        t9NzNFh1PlxkSLEFvmaBtJ/hV5vHh5w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-_E21Ts6aNaOELSnXYTeEXQ-1; Sun, 04 Oct 2020 17:01:03 -0400
X-MC-Unique: _E21Ts6aNaOELSnXYTeEXQ-1
Received: by mail-qv1-f71.google.com with SMTP id t7so4626562qvz.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J20BiFc6m3RHcFdesFRsBwhx7Lh/GICUTgu5OMkGdFI=;
        b=coowKQpJ9kcfMVrVrO1rvX/XRw872CZ3FX2w6fW+lHzYozZy+pNM7nkJ058wdN9CeO
         xx1FMGuJwPXWxNTd+sIFYwshqBtFpmdnJPCM3rQm3oHhUtSzaValDMhlC1nYfiFYgb4X
         bHxAbQI0eu6wvui6jTQUhNq4W6xfa8Cp7ZLKxOD6FZMCt3tOdwGOY8INJyIoie3g/BGD
         DfFKYu5D93blx9v44+BuCiny1lSEwxITwF8+b3i42gu0spA4f/4of9I6RMa2tQ6UiiNp
         Nrg1rRVViIjHpvCNhTWT/E+Z8/pchrlU1QBR2OePE0qwPXivWCrnLD29V7atBUsDO/re
         sKDw==
X-Gm-Message-State: AOAM532AxeZdkVah7Bt7SmrLg992cxSm1EQSekH3NsaVFTPnC+TgWdSP
        wwK957WyxmRB5GXTLfgJJm+GaqXqCdWCV0FuJc0ZhdymOqKw3yN1AVTj9+nJla8kKMw1LhTc0EX
        V4yfIoxbGcDbSyoPlfr0hcbcN
X-Received: by 2002:a37:a781:: with SMTP id q123mr11774906qke.436.1601845262552;
        Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNC0a6jG7B0KHTvPPbYripQO92zGYHKX73STLYgV86g8TeaQOP4sV5T+Rijk9WqQfead8nZw==
X-Received: by 2002:a37:a781:: with SMTP id q123mr11774890qke.436.1601845262322;
        Sun, 04 Oct 2020 14:01:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q7sm3632843qtd.49.2020.10.04.14.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 14:01:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ee0408f4-fef4-53b9-1e64-76e2a6b634d5@redhat.com>
Date:   Sun, 4 Oct 2020 14:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to
> include an update/status sysfs node that can be polled
> and read to monitor the progress of an ongoing secure
> update. Sysfs_notify() is used to signal transitions
> between different phases of the update process.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Changed progress state "read_file" to "reading"
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 +++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 40 +++++++++++++++++--
>  2 files changed, 47 insertions(+), 4 deletions(-)

This was 07/12 in the old patchset.

Also looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


