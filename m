Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB12D28AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgLHKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728966AbgLHKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607422641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7ghnr94M4oyTTLnAUgx22ge58iAEYBvxpJ10jqNm3Y=;
        b=ZGBoNJ4oKdqXq+u9wiRzSAPtXTdqT8LgvwG8Zl5o9Fqf1mVqone5KMSLnFeLC+to8bXtTK
        snaOTU8yFbpSFxciag5cnv0s9/wIkU+qBLkCyxIls1Pl5uP3VNwmbUfB7sauexAotxyxSr
        G3EQ1VcPgNc6OUISond3TIT4q9GvpN0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-_BPhb-FcN7GmTDiYJD0m7w-1; Tue, 08 Dec 2020 05:17:19 -0500
X-MC-Unique: _BPhb-FcN7GmTDiYJD0m7w-1
Received: by mail-ed1-f71.google.com with SMTP id f19so7190991edq.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7ghnr94M4oyTTLnAUgx22ge58iAEYBvxpJ10jqNm3Y=;
        b=H+LQA1trMRGFdBWf7nNsRFbWodX74oRc5GvsAvM+FLx4Dv0dbC74XVjnrhWBUcuS7f
         QXPobDHIdvmp0G7EuWPtAVnoq5sWUFLp7xdBdWc3dS8nfY/j3+KZMh+SBvFvxJZCwI3L
         WiHNk78PwVbT3LQQTFmQSEi7Xqi2Leev3Aq+Z5YGywiBlGIUAuE1UnEPJZOkTI8SkhLb
         /ItEZ5l7DC6ybFjQp0Pf7Lk2xykwZUQiv3YCxZpzeKhDx8c2Ng0Mn/NArbDwwKCUiNmI
         0zh8Ql8CKi4ew12UagaOB3AHkQELmhoA42v6mgCj4Ngw6DjGUO2sGvSR6TqEGmh7gP74
         DuLA==
X-Gm-Message-State: AOAM531FHMtymqwWvTf/w+7kqszJ0cXFI6WRibqhK8Cy1ul2tCv8D2lx
        M+F/XCpNgQkN7D53nMpZs75MM8Kpm/5kmeJQTu1LXvUoC1zCAvv5QsJj8gxB0K6kT4nk5ivInCE
        O/dz8o/bHcmXX/1KtOlQ1u8n8k9I5zcpbqyrQKUpFxBJEQCWblVrFPzCzIRPosHDjlDdsbXpOX8
        hp
X-Received: by 2002:a05:6402:22ea:: with SMTP id dn10mr23620099edb.67.1607422638496;
        Tue, 08 Dec 2020 02:17:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMgz2p79ATKIl5ou8LZsSdM2IsgZ5zLI7QxR6nFDwa+9zzS3kserBJqfTfNEHiZekytu5vqA==
X-Received: by 2002:a05:6402:22ea:: with SMTP id dn10mr23620079edb.67.1607422638268;
        Tue, 08 Dec 2020 02:17:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id qn4sm4333537ejb.50.2020.12.08.02.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:17:17 -0800 (PST)
Subject: Re: [PATCH platform 0/2] platform/x86: mlx-platform: Fix item counter
 assignment
To:     Vadim Pasternak <vadimp@nvidia.com>, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201207174745.22889-1-vadimp@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5491c65-8783-a2d8-1fce-a46fa9a718b7@redhat.com>
Date:   Tue, 8 Dec 2020 11:17:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207174745.22889-1-vadimp@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 6:47 PM, Vadim Pasternak wrote:
> Fix array names to match assignments for data items and data items
> counter for power and fan attributes.
> 
> Patch #1: Provide fixes for system types MSN2700, MSN24xx.
> Patch #1: Provide fixes for system type MSN2700/ComEx.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> 
> Vadim Pasternak (2):
>   platform/x86: mlx-platform: Fix item counter assignment for MSN2700,
>     MSN24xx systems
>   platform/x86: mlx-platform: Fix item counter assignment for
>     MSN2700/ComEx system
> 
>  drivers/platform/x86/mlx-platform.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

