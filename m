Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF1276418
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIWWrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgIWWrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600901239;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH9LeP2g6hfwvoldu17IhkbITvXvGtTCNmXxEdiTZI4=;
        b=YIxI3Yt/zIcpsQEW2DMBFnVe4611iTgftbXBp5aMwo53DlUCceVy8tX1VrCt8QZVFnCxVW
        CMZrV27A/MBPBrr8UFwmYfTTIp4fLiojGNmk9yPflr9oNn4OvwHp5zvc1bSN2sEBcTLIAA
        dlREEoLqVQGqrFigW4fSDNotbVDNlGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-XWtntuIIOsW-2ajFPIagdg-1; Wed, 23 Sep 2020 18:47:17 -0400
X-MC-Unique: XWtntuIIOsW-2ajFPIagdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB673100748A;
        Wed, 23 Sep 2020 22:47:15 +0000 (UTC)
Received: from [10.64.54.94] (vpn2-54-94.bne.redhat.com [10.64.54.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C287978823;
        Wed, 23 Sep 2020 22:47:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 0/2] arm64/mm: Enable color zero pages
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        robin.murphy@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200923053721.28873-1-gshan@redhat.com>
 <20200923084317.GA13434@gaia>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2047fb91-da03-7774-ef5e-d194b92813c3@redhat.com>
Date:   Thu, 24 Sep 2020 08:47:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200923084317.GA13434@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 9/23/20 6:43 PM, Catalin Marinas wrote:
> On Wed, Sep 23, 2020 at 03:37:19PM +1000, Gavin Shan wrote:
>> The feature of color zero pages isn't enabled on arm64, meaning all
>> read-only (anonymous) VM areas are backed up by same zero page. It
>> leads pressure to L1 (data) cache on reading data from them. This
>> tries to enable color zero pages.
>>
>> PATCH[1/2] decouples the zero PGD table from zero page
>> PATCH[2/2] allocates the needed zero pages according to L1 cache size
> 
> To save you (and potential reviewers) some time, please include in the
> cover letter details of a realistic workload/benchmark that is improved
> by this patchset, backed by numbers. Just because it's doable and the
> patches aren't too complex is not a good enough reason for merging.
> 

Sure, Please ignore this (v2) series for now. I'll try to provide
performance data in v3 even I'm not positive about that because
it depends on CPU's L1 dCache size :)

Cheers,
Gavin

