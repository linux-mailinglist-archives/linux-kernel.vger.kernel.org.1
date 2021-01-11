Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA72F1C47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbhAKR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728844AbhAKR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610385889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWos6wwkUpA6YfuQI0uj2Gas5WM8ywmCf9F0bcaCUXM=;
        b=izLji0Ksf+zH4e/zKM2PimXblmVvm0x8goa5IsAwTi2gvqfn2EZ8/ajFPEk4vgmVSlJz8o
        EGXIOmZHGJ7+41EsQEc0UYqUT4UMpNAIeb/Kx2cPWpq02hWfKB7i4qfyV5U2A/C54cuWZ9
        JvttCiL+EOZQQIy8QQG16RQfk+RZDQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-a0tiaJbXP_iV7T0nJPbSog-1; Mon, 11 Jan 2021 12:24:47 -0500
X-MC-Unique: a0tiaJbXP_iV7T0nJPbSog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20C94107ACF9;
        Mon, 11 Jan 2021 17:24:44 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D11DE19D9F;
        Mon, 11 Jan 2021 17:24:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] resource: Make it possible to reserve memory on 64bit
 platform
To:     Wesley Zhao <zhaowei1102@thundersoft.com>,
        akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        guohanjun@huawei.com, mchehab+huawei@kernel.org
References: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
 <1610382798-4528-2-git-send-email-zhaowei1102@thundersoft.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0043f2fe-d936-0db6-7b12-25a5026cb106@redhat.com>
Date:   Mon, 11 Jan 2021 18:24:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610382798-4528-2-git-send-email-zhaowei1102@thundersoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.21 17:33, Wesley Zhao wrote:
> From: "Wesley.Zhao" <zhaowei1102@thundersoft.com>
> 
> For now "reserve=" is limitied to 32bit,not available on 64bit
> platform,so we change the get_option() to get_option_ull(added in
> patch: commit 4b6bfe96265e ("lib/cmdline: add new function
> get_option_ull()"))

Curious, what's the target use case? (did not receive a cover letter,
maybe it's buried in there)

-- 
Thanks,

David / dhildenb

