Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A322C571F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbgKZO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:28:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389606AbgKZO2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606400912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVu3B75nitNrQbGb0VNkttik9wWLapdR6+icCVXpoc8=;
        b=gCbdhyfVzAy8pTHOBprduuuBgSLYAYjs3oYZoajSOPk1lb+v/eXEwzEuTMqEmoTElRxkxL
        5wXBQ7WX6QPYOGGYZS/Nizt6D0FpWYUE3wsssZBLNpq2ZYsKqN8tOpF3/bsrzlCXs1C3DY
        Xn9UphCv18RYAJKHmEj2iSLDeMNPgDk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-S8Z-B2AeMXqcMebGdloQgg-1; Thu, 26 Nov 2020 09:28:30 -0500
X-MC-Unique: S8Z-B2AeMXqcMebGdloQgg-1
Received: by mail-ej1-f70.google.com with SMTP id 2so934374ejv.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVu3B75nitNrQbGb0VNkttik9wWLapdR6+icCVXpoc8=;
        b=OynqxhXKEvQiucohbhU7cG6j/wYyVpKlyFDzVs4+opIX84NdG1n9f+CcfLh67gBVfK
         D+jedPZv1ELJc6VBaAfcjtGoSLZ+mIgL45yRuUfUytB7tfxZAAtaqD5WlK2tX6b9roOi
         yqKb6WsLMJRywCsotndpxqWrGbG/V7VCRh0IqeCCtdvH9ns6lXfe9W+l45R2TWPgi54E
         Ju39IeftDOnVpGI9rWQzykdbVgLlbm8P0kbuZDRfk+t7LSmU2pe3ifUcEu74CeOjjE2k
         3D+PTe8XBTPycDkCvmo05ffxsa/4HljugeR52mxZNRIZc6Kjxc4w2YJBEmU5o5C0MvQZ
         EkPQ==
X-Gm-Message-State: AOAM533EGDeFS1+rnRR73u4S9B+H4rCSzBWkC/PCPnmOLP6rltMlZLg4
        TLOF562hMtSsIX5Gto85BTyBlAg8B8bUbzWP84Otb/rhQKfS8LgvIb9pJGx9GKJWSvC5HKYADEl
        yML5jKryk/ugN9T45uqcinOBc8Vr0cRPz0ORMgZuhHnSTfG1Cy+a9Q7aD3xV9oTK/tNofB5n7hH
        rH
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr2893209eds.41.1606400908952;
        Thu, 26 Nov 2020 06:28:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAmkD6Jl8VPfHLuK9ob/oKbSpy43wrhhffWo2LKoRhoXvGymEwOD6XcD+RHHITmdBeul3Zqw==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr2893189eds.41.1606400908783;
        Thu, 26 Nov 2020 06:28:28 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n15sm3302152eje.112.2020.11.26.06.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 06:28:28 -0800 (PST)
Subject: Re: [PATCH platform 0/2] platform/x86: mlx-platform: Remove PSU
 EEPROM configuration
To:     Vadim Pasternak <vadimp@nvidia.com>, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201125101056.174708-1-vadimp@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <82e98646-1269-ce44-e573-67f2b852f822@redhat.com>
Date:   Thu, 26 Nov 2020 15:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125101056.174708-1-vadimp@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/20 11:10 AM, Vadim Pasternak wrote:
> Remove PSU EEPROM configuration for systems MSN2700, MSN2100, MSN274x
> to support the requirement of power unit replacement by "off the shelf"
> device, matching electrical required parameters. Such device can be
> equipped with different EEPROM types or even could be not equipped with
> EEPROM.
> 
> Patch set contains two bug fixes:
> - For MSN2700 and MSN2100 system types.
> - For MSN274x system types.
> 
> Vadim Pasternak (2):
>   platform/x86: mlx-platform: Remove PSU EEPROM from default platform
>     configuration
>   platform/x86: mlx-platform: Remove PSU EEPROM from MSN274x platform
>     configuration

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

