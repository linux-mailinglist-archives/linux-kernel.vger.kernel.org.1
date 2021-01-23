Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD564301622
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbhAWPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbhAWPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611414090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBK6oap91uhZBFVpWQoFUbolQ0lmTHn7hju0oED3gIY=;
        b=bVBeUDcOlHI/xa6rO7wSb1e2zsJ71XxzRLL9xM3FigTJ4D3PeZWQVJrDKZYJNC+u0m4ZAx
        u20KxMmFcA6UuW0rR+hIIWxSQ9OcNMgZFmsb3cOPB3r6KZSLV+HlPDJzVLqElB0BEp51I4
        aSRoaJ8nRswXsoGEBMNdibJxfGjcJkk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-4DSGgH-fOuK-CUxb-hr-Zw-1; Sat, 23 Jan 2021 10:01:28 -0500
X-MC-Unique: 4DSGgH-fOuK-CUxb-hr-Zw-1
Received: by mail-qt1-f198.google.com with SMTP id t20so5258412qtq.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UBK6oap91uhZBFVpWQoFUbolQ0lmTHn7hju0oED3gIY=;
        b=tMP1wgQFvpnBLNNbygmCJwyU5t56pTV0lxEmWOsOPXqDip9l2Dt9uq/rCRZKRIKM3N
         i3QRV+34/ZV8TAa45NSxO+/eZui9T6qoPuhujyFvRmkPr0YU45NKnIFSYb8sow6N0Q3U
         JfsGYeNQdBYs+GqqcooMYEi68ztm+vJZNiklme3mUoawC61Wt9RMUsIW2NKDIRgf7Vis
         N5DhkCjlkXc8qXgZGMqjSYKL2Zvkd3jlhKYTfaWottpzKSTGlYYLqvN/FJrPEMhStAhN
         YeXVhlZe2io/vfQ1h1K0JWI15iFk5VTGGgnRofY/cf4zdqw4JxhUbWi1aAX78usxIU+x
         ROPA==
X-Gm-Message-State: AOAM533g0Bxn2cjMsStjKURpTw59wl5FYpKeNi3w31LBarmKW5wwueKj
        aFoXSD5+j9LlXBOOzZjCkDU+ykJxC8D2WN+0+hSOduvS/3ZrXpMhM3m/OmxNxLeQRIagci01EM1
        rixCQYADycQDup7tk5fjw9nA3
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr472701qte.239.1611414087470;
        Sat, 23 Jan 2021 07:01:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcV80cstVcywKxotrua0pjQkoaHznaZMMplTdLX0CgSnWV8PURgH6Vc4WqaiCjDvbd3By6gQ==
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr472642qte.239.1611414086697;
        Sat, 23 Jan 2021 07:01:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x49sm8245172qtx.6.2021.01.23.07.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:01:26 -0800 (PST)
Subject: Re: [PATCH v2] MAINTAINERS: Add FPGA SUBDEVICES
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
References: <20210122192928.1651254-1-trix@redhat.com>
 <YAtlRV+0FWrVoaRc@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <96a9d3d9-6091-47c9-21f9-0cfdd9464732@redhat.com>
Date:   Sat, 23 Jan 2021 07:01:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAtlRV+0FWrVoaRc@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/21 3:52 PM, Moritz Fischer wrote:
> On Fri, Jan 22, 2021 at 11:29:28AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Every FPGA has several subdevices in other subsystems.
>> The new FPGA subdevices section is necessary to ensure changes to
>> the subdevices files get reviewed within the context of the FPGA
>> subsystem.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v1: Add several more subdevices
>> ---
>>  MAINTAINERS | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 17ac5bdce521..96d6f00b0584 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6975,6 +6975,17 @@ F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  F:	tools/testing/selftests/drivers/fpga/
>>  
>> +FPGA SUBDEVICES
>> +R:	Tom Rix <trix@redhat.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>> +F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
>> +F:	drivers/hwmon/intel-m10-bmc-hwmon.c
>> +F:	drivers/memory/dfl-emif.c
>> +F:	drivers/mfd/intel-m10-bmc.c
>> +F:	include/linux/mfd/intel-m10-bmc.h
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> -- 
>> 2.27.0
>>
> All these subsystems have maintainers, I think that's up to them.
> Ideally each of those drivers behaves like a normal device in the
> corresponding subsystem and the way it's implemented doesn't matter.
>
> Plenty of other examples for that
>
> drivers/net/ethernet/xilinx/*

This device has a specific maintainer, the files listed above to do not.

So any review or maintenance falls to the subsystem maintainer who likely is not be aware of it fitting within an fpga card.  They certainly will not have the hardware to test if the changes effect the card.

So until they have specific maintainers, I would like to help fill that gap by making sure they at least have a review.  Sending the changes to the linux-fpga mailing list will allow others interested in their specific fpga card to also weigh in.

The specific reason for doing this now is several in-flight changes are being made to

include/linux/mfd/intel-m10-bmc.h

That effected a couple of fpga subdevices and conflicted with Russ' security manager patchset.  To help resolve the conflict I had to track down all the in flight changes.  If I had been on the reviewer list for the file or the patch had been mirrored to linux-fpga, I would have been notified of the changes earlier and finding the conflict would have not been as difficult.

Since we are pushing subdevices to the subsystem, I think we should also be encouraging subdevices to be maintained by the submitter and if they are not, they get added to the subdevices list so all the work is not done by the subsystem maintainers.

Tom

>
> for example.
>
> - Moritz
>

