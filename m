Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925D92F93EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbhAQQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728732AbhAQQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610899971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKx/FKQVzh6ngVjE8Cm0vlB/PwFpFVWV9Zn99zzhx+0=;
        b=C9C/OAnE0xOgP10+CzJH5CUFijm7l9civzF96WC7oxHOkvDEH50/RHSd3nUJpJ/N3uXgX1
        CYQNccWdcUhPx2G3rNL0v1PR6jtBwi1DfphMxfoMV8fNLNaiHwn13LqWKxiOMdKgc6l0il
        uRzKkncWEXD8rdDTkX5GORjp5IPRJWk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-c5wFLeZDNaKJrpraJ4WscQ-1; Sun, 17 Jan 2021 11:12:47 -0500
X-MC-Unique: c5wFLeZDNaKJrpraJ4WscQ-1
Received: by mail-qt1-f197.google.com with SMTP id e9so4120467qtq.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 08:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mKx/FKQVzh6ngVjE8Cm0vlB/PwFpFVWV9Zn99zzhx+0=;
        b=OjlXF8g9xJVxElPVuTdz06tbjCNcLr+HCD29H8oCLcxGU1Rl6IOgDLG353SF+6cvw3
         Ryo9LSWR2OAoxDRRHviw8iJeqrPQ9TVWJDS4CgV9e6YI4zUkNyAOWJK8UWZvU7NrDr8C
         w/aqyodGj/1/sn4j178Vox2q9N2Bnfp7GEha3EAfYyKtE5DbX8OQuNtT17rMrPdHNVj1
         VR5ze3MZlZG8h9rhg/4S2dFcW1GTvReZbDuD5lV89RuvvBU1nlPMcsmj73Hkn5ZcZoiJ
         kewLvzIEn473IPXV4EUNyRqFQM19+NtMtEM1gt8BkYWbr57jb0AZ0we49gUavw8SinTW
         /0mw==
X-Gm-Message-State: AOAM533kIty5BkOL701X4zykHYvhewwpuAcDcu3n3UJ5JipVADabY9r0
        OoOEVzunHwWCJTo7DJ8OahL0c1ioOLe1Gw0+/d/+wUEmH/gsFvBfnJpgHXT2G9+MXEVU+T+Wz03
        rw2/uwBfqLz1cqCy8XKZSyjBS
X-Received: by 2002:ac8:5dc9:: with SMTP id e9mr2216157qtx.108.1610899967144;
        Sun, 17 Jan 2021 08:12:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxs9O/da/XR6f619L/ihY+ZOM9YZDpyasE8Smsw0gEX4qBGnzyHByQqNtx2cNCV4wIlRZ2aCg==
X-Received: by 2002:ac8:5dc9:: with SMTP id e9mr2216135qtx.108.1610899966824;
        Sun, 17 Jan 2021 08:12:46 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c136sm9164136qkg.71.2021.01.17.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 08:12:46 -0800 (PST)
Subject: Re: [PATCH v2] selftests: drivers: fpga: A test for interrupt support
To:     Moritz Fischer <mdf@kernel.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210116193321.385848-1-trix@redhat.com>
 <YAOyTI0PEclTUUuG@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1c8a141d-f5cb-9a96-f017-0ac5f2d90e84@redhat.com>
Date:   Sun, 17 Jan 2021 08:12:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAOyTI0PEclTUUuG@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/21 7:43 PM, Moritz Fischer wrote:
> Hi Tom,
>
> On Sat, Jan 16, 2021 at 11:33:21AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
>> an expected result.
>>
>> Tested on vf device 0xbcc1
>>
>> Sample run with
>>  # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
>>  ...
>>  TAP version 13
>>  1..1
>>  # selftests: drivers/fpga: intr
>>  # TAP version 13
>>  # 1..1
>>  # # Starting 1 tests from 1 test cases.
>>  # #  RUN           global.afu_intr ...
>>  # #            OK  global.afu_intr
>>  # ok 1 global.afu_intr
>>  # # PASSED: 1 / 1 tests passed.
>>  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>  ok 1 selftests: drivers/fpga: intr
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v1: Convert to kselftest_harness.h framework
>> ---
>>  MAINTAINERS                                   |  1 +
>>  tools/testing/selftests/Makefile              |  1 +
>>  tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
>>  tools/testing/selftests/drivers/fpga/config   |  1 +
>>  tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
>>  5 files changed, 46 insertions(+)
>>  create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
>>  create mode 100644 tools/testing/selftests/drivers/fpga/config
>>  create mode 100644 tools/testing/selftests/drivers/fpga/intr.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index de610a06cb5c..7ed3ce58d95e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6973,6 +6973,7 @@ F:	Documentation/driver-api/fpga/
>>  F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>> +F:	tools/testing/selftests/drivers/fpga/
>>  
>>  FPGA SECURITY MANAGER DRIVERS
>>  M:	Russ Weight <russell.h.weight@intel.com>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index afbab4aeef3c..aad4763ec348 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -9,6 +9,7 @@ TARGETS += core
>>  TARGETS += cpufreq
>>  TARGETS += cpu-hotplug
>>  TARGETS += drivers/dma-buf
>> +TARGETS += drivers/fpga
>>  TARGETS += efivarfs
>>  TARGETS += exec
>>  TARGETS += filesystems
>> diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
>> new file mode 100644
>> index 000000000000..eba35c405d5b
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +CFLAGS += -I../../../../../usr/include/
>> +CFLAGS += -I../../../../../include/uapi/
>> +
>> +TEST_GEN_PROGS := intr
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
>> new file mode 100644
>> index 000000000000..e2111b81d8d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/config
>> @@ -0,0 +1 @@
>> +CONFIG_FPGA_DFL_AFU=m
>> diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
>> new file mode 100644
>> index 000000000000..b362fb1f788d
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/fpga/intr.c
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdint.h>
>> +#include <string.h>
>> +#include <sys/fcntl.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/fpga-dfl.h>
>> +
>> +#include "../../kselftest_harness.h"
> Is that how it works with selftests?

I believe so, the big change over v1, is me reading the manual

https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

>> +
>> +TEST(afu_intr)
>> +{
>> +	int devfd, status;
>> +	struct dfl_fpga_port_info port_info;
>> +	uint32_t irq_num = UINT32_MAX;
> Can you order those?
>
> xxxx
> xx
> x
yes, v3 is on its way.
>> +
>> +	devfd = open("/dev/dfl-port.0", O_RDONLY);
>> +	if (devfd < 0)
>> +		SKIP(0, "no fpga afu device 0");
>> +	/*
>> +	 * From fpga-dl.h :
>> +	 * Currently hardware supports up to 1 irq.
>> +	 * Return: 0 on success, -errno on failure.
>> +	 */
>> +	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
>> +	ASSERT_EQ(0, status) {
>> +		TH_LOG("ioctl() failed to get the number irqs");
>> +	}
>> +	ASSERT_LT(irq_num, 256) {
>> +		TH_LOG("unexpeced number of irqs");
>> +	}
>> +	close(devfd);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> -- 
>> 2.27.0
>>
> Thanks for starting this, I don't know a lot about selftests (yet).
> So we probably want to get a look at this from corresponding maintainers.

Me either, that's why I am starting small.

It would be nice to have a set of smoke tests to hook into a c/i.

Tom

> - Moritz
>

